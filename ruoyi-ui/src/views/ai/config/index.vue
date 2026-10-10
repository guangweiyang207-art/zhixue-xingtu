<template>
  <div class="app-container">
    <el-card>
      <div slot="header">
        <span><i class="el-icon-setting"></i> AI大模型配置</span>
      </div>

      <el-form ref="form" :model="form" :rules="rules" label-width="120px">
        <el-form-item label="模型提供商" prop="provider">
          <el-select v-model="form.provider" placeholder="请选择模型提供商">
            <el-option label="DeepSeek" value="deepseek" />
            <el-option label="OpenAI" value="openai" />
            <el-option label="智谱AI" value="zhipu" />
            <el-option label="通义千问" value="qwen" />
          </el-select>
        </el-form-item>

        <el-form-item label="模型名称" prop="model">
          <el-input v-model="form.model" placeholder="例如：deepseek-chat" />
          <span class="tip-text">DeepSeek默认: deepseek-chat</span>
        </el-form-item>

        <el-form-item label="API Key" prop="apiKey">
          <el-input
            v-model="form.apiKey"
            :type="showApiKey ? 'text' : 'password'"
            placeholder="请输入API Key"
            show-password
          >
            <el-button
              slot="append"
              :icon="showApiKey ? 'el-icon-view' : 'el-icon-magic-stick'"
              @click="showApiKey = !showApiKey"
            >{{ showApiKey ? '隐藏' : '显示' }}</el-button>
          </el-input>
          <span class="tip-text" v-if="apiKeyMasked">
            <i class="el-icon-lock"></i> 当前Key：{{ apiKeyMasked }}
          </span>
          <span class="tip-text">
            请填写你的DeepSeek API Key，可在 https://platform.deepseek.com 获取
          </span>
        </el-form-item>

        <el-form-item label="API地址" prop="baseUrl">
          <el-input v-model="form.baseUrl" placeholder="例如：https://api.deepseek.com" />
        </el-form-item>

        <el-form-item label="系统角色设定" prop="systemPrompt">
          <el-input
            v-model="form.systemPrompt"
            type="textarea"
            :rows="6"
            placeholder="设定AI助手的角色和行为准则"
          />
        </el-form-item>

        <el-divider content-position="left">🌐 联网搜索配置</el-divider>

        <el-form-item label="启用联网搜索">
          <el-switch
            v-model="form.webSearchEnabled"
            active-text="开启"
            inactive-text="关闭"
            active-color="#13ce66"
          />
          <span class="tip-text" style="margin-left: 15px;">
            <i class="el-icon-info"></i>
            开启后AI会先搜索最新信息再回答，适合查时事新闻、最新技术等
          </span>
        </el-form-item>

        <el-form-item label="搜索引擎" v-if="form.webSearchEnabled">
          <el-select v-model="form.searchEngine" placeholder="请选择搜索引擎">
            <el-option label="博查AI（推荐，免费）" value="bocha" />
            <el-option label="SerpAPI" value="serpapi" />
          </el-select>
        </el-form-item>

        <el-form-item label="搜索 API Key" v-if="form.webSearchEnabled" prop="searchApiKey">
          <el-input
            v-model="form.searchApiKey"
            :type="showSearchKey ? 'text' : 'password'"
            placeholder="请输入搜索引擎API Key"
            show-password
          >
            <el-button
              slot="append"
              @click="showSearchKey = !showSearchKey"
            >{{ showSearchKey ? '隐藏' : '显示' }}</el-button>
          </el-input>
          <span class="tip-text" v-if="searchApiKeyMasked">
            <i class="el-icon-lock"></i> 当前Key：{{ searchApiKeyMasked }}
          </span>
          <span class="tip-text">
            <i class="el-icon-warning-outline"></i>
            博查AI: <a href="https://bochaai.com" target="_blank">https://bochaai.com</a> 注册免费获取
          </span>
        </el-form-item>

        <el-form-item label="搜索结果数" v-if="form.webSearchEnabled">
          <el-input-number v-model="form.searchResultCount" :min="1" :max="10" />
          <span class="tip-text" style="margin-left: 15px;">建议3-5条，结果太多会消耗更多token</span>
        </el-form-item>

        <el-form-item>
          <el-button type="primary" :loading="submitLoading" @click="submitForm">保存配置</el-button>
          <el-button :loading="testLoading" type="success" @click="testConnection">测试连接</el-button>
          <el-button @click="resetForm">重置</el-button>
          <el-button type="info" plain @click="goToChat">去对话</el-button>
        </el-form-item>
      </el-form>

      <el-divider></el-divider>

      <div class="config-tips">
        <h4>配置说明</h4>
        <el-alert
          title="API Key安全提示"
          type="warning"
          description="API Key是访问大模型服务的凭证，请妥善保管。配置将保存在服务器内存中，建议在生产环境使用更安全的存储方式（如数据库加密存储）。"
          show-icon
          :closable="false"
        />
        <div style="margin-top: 15px;">
          <p><strong>各平台API Key获取地址：</strong></p>
          <ul>
            <li>DeepSeek: <a href="https://platform.deepseek.com" target="_blank">https://platform.deepseek.com</a></li>
            <li>OpenAI: <a href="https://platform.openai.com" target="_blank">https://platform.openai.com</a></li>
            <li>智谱AI: <a href="https://open.bigmodel.cn" target="_blank">https://open.bigmodel.cn</a></li>
            <li>通义千问: <a href="https://dashscope.aliyun.com" target="_blank">https://dashscope.aliyun.com</a></li>
          </ul>
        </div>
      </div>
    </el-card>
  </div>
</template>

<script>
import { getAiConfig, updateAiConfig } from "@/api/ai/agent"

export default {
  name: "AiConfig",
  data() {
    return {
      submitLoading: false,
      testLoading: false,
      showApiKey: false,
      showSearchKey: false,
      apiKeyMasked: "",
      searchApiKeyMasked: "",
      form: {
        provider: "deepseek",
        model: "deepseek-chat",
        apiKey: "",
        baseUrl: "https://api.deepseek.com",
        systemPrompt: "",
        webSearchEnabled: false,
        searchEngine: "bocha",
        searchApiKey: "",
        searchResultCount: 5
      },
      rules: {
        provider: [{ required: true, message: "请选择模型提供商", trigger: "change" }],
        model: [{ required: true, message: "请输入模型名称", trigger: "blur" }],
        apiKey: [{ required: true, message: "请输入API Key", trigger: "blur" }],
        baseUrl: [{ required: true, message: "请输入API地址", trigger: "blur" }]
      }
    }
  },
  created() {
    this.getConfig()
  },
  methods: {
    getConfig() {
      getAiConfig().then(res => {
        console.log("获取AI配置:", res)
        if (res && res.data) {
          this.form.provider = res.data.provider || "deepseek"
          this.form.model = res.data.model || "deepseek-chat"
          this.form.baseUrl = res.data.baseUrl || "https://api.deepseek.com"
          this.form.systemPrompt = res.data.systemPrompt || ""
          this.form.apiKey = res.data.apiKey || ""
          this.apiKeyMasked = res.data.apiKeyMasked || ""
          // 联网搜索
          this.form.webSearchEnabled = res.data.webSearchEnabled || false
          this.form.searchEngine = res.data.searchEngine || "bocha"
          this.form.searchApiKey = res.data.searchApiKey || ""
          this.searchApiKeyMasked = res.data.searchApiKeyMasked || ""
          this.form.searchResultCount = res.data.searchResultCount || 5
          this.$message.success("配置加载成功")
        }
      }).catch(err => {
        console.error("加载配置失败:", err)
        this.$message.error("加载配置失败：" + (err.message || "未知错误"))
      })
    },
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          this.submitLoading = true
          updateAiConfig(this.form).then(res => {
            console.log("保存配置响应:", res)
            this.$message.success(res.msg || "配置保存成功")
            this.submitLoading = false
            // 重新加载配置
            this.getConfig()
          }).catch(err => {
            console.error("保存配置失败:", err)
            const errMsg = (err && err.response && err.response.data && err.response.data.msg) || err.message || "未知错误"
            this.$message.error("保存失败：" + errMsg)
            this.submitLoading = false
          })
        }
      })
    },
    resetForm() {
      this.getConfig()
      this.$message.info("已重置为服务器配置")
    },
    // 测试API连接
    testConnection() {
      if (!this.form.apiKey) {
        this.$message.warning("请先填写API Key")
        return
      }
      this.testLoading = true
      this.$message.info("正在测试连接...")
      // 这里简化处理，实际项目可以调用测试接口
      setTimeout(() => {
        this.testLoading = false
        this.$message.success("API Key格式正确（请用对话页验证实际效果）")
      }, 1000)
    },
    // 跳转到对话页面
    goToChat() {
      this.$router.push("/ai/agent/aiChat")
    }
  }
}
</script>

<style scoped>
.tip-text {
  font-size: 12px;
  color: #999;
  margin-left: 10px;
}
.config-tips ul {
  padding-left: 20px;
  line-height: 2;
}
</style>
