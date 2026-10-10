<template>
  <div class="app-container ai-chat-container">
    <el-card class="chat-card">
      <div slot="header" class="chat-header">
        <span><i class="el-icon-chat-dot-round"></i> 智学星途 AI学习助手</span>
        <el-tag size="small" type="success">{{ aiConfig.provider }} - {{ aiConfig.model }}</el-tag>
      </div>

      <!-- 对话区域 -->
      <div class="chat-messages" ref="messageContainer">
        <div v-for="(msg, index) in messages" :key="index" :class="['message', msg.role]">
          <div class="avatar">
            <el-avatar :size="40" :icon="msg.role === 'user' ? 'el-icon-user' : 'el-icon-s-opportunity'"
                       :style="{ backgroundColor: msg.role === 'user' ? '#409EFF' : '#67C23A' }"></el-avatar>
          </div>
          <div class="content">
            <div class="name">{{ msg.role === 'user' ? '我' : '智学星途AI' }}</div>
            <div class="text" v-html="formatMessage(msg.content)"></div>
            <div class="time">{{ msg.time }}</div>
          </div>
        </div>

        <!-- AI正在输入提示 -->
        <div v-if="loading" class="message ai">
          <div class="avatar">
            <el-avatar :size="40" icon="el-icon-s-opportunity" style="background-color: #67C23A"></el-avatar>
          </div>
          <div class="content">
            <div class="name">智学星途AI</div>
            <div class="text">
              <i class="el-icon-loading"></i> 正在思考中...
            </div>
          </div>
        </div>
      </div>

      <!-- 快捷选项（在用户开始自由输入前一直展示，方便连续点击不同问题） -->
      <div class="quick-tags" v-if="!hasUserInput">
        <div
          v-for="(tag, idx) in quickTags"
          :key="idx"
          class="quick-tag"
          @click="sendQuick(tag)"
        >
          <i class="el-icon-magic-stick"></i>
          <span>{{ tag }}</span>
        </div>
      </div>

      <!-- 输入区域 -->
      <div class="chat-input">
        <el-input
          v-model="inputMessage"
          type="textarea"
          :rows="3"
          placeholder="请输入您想了解的内容，例如：分析学生整体情况、统计教师院系分布、查询近期学习数据等..."
          @keyup.enter.native="handleEnter"
        ></el-input>
        <el-button
          type="primary"
          icon="el-icon-s-promotion"
          :loading="loading"
          @click="sendMessage"
          style="margin-top: 10px; float: right;"
        >发送</el-button>
      </div>
    </el-card>

    <!-- 历史会话侧边栏 -->
    <el-card class="history-card">
      <div slot="header">
        <span><i class="el-icon-time"></i> 当前会话</span>
      </div>
      <div class="session-info">
        <el-tag>会话ID: {{ sessionId }}</el-tag>
        <el-button type="text" @click="newSession" style="margin-left: 10px;">
          <i class="el-icon-refresh"></i> 新会话
        </el-button>
      </div>
      <el-divider></el-divider>
      <div class="tips">
        <h4>使用提示</h4>
        <ul>
          <li>可分析学生整体情况（段位、年级、专业）</li>
          <li>可统计教师院系与职称分布</li>
          <li>可查询平台整体业务数据概览</li>
          <li>可基于数据库生成管理员视角的运营建议</li>
        </ul>
      </div>
    </el-card>
  </div>
</template>

<script>
import { sendMessage, getAiConfig } from "@/api/ai/agent"

export default {
  name: "AiAgentChat",
  data() {
    return {
      inputMessage: "",
      messages: [
        {
          role: "ai",
          content: "您好！我是智学星途AI管理助手，专注于平台数据洞察，可帮您分析学生/教师情况、统计段位与院系分布、提供运营建议。请直接提问或点击下方快捷选项开始。",
          time: this.getCurrentTime()
        }
      ],
      loading: false,
      sessionId: this.generateSessionId(),
      aiConfig: {
        provider: "deepseek",
        model: "deepseek-chat"
      },
      // 管理端快捷选项（点击即发送给AI；关键词匹配后端会自动拉取数据库学生/教师汇总）
      quickTags: [
        "分析学生整体情况",
        "分析教师整体情况",
        "整体数据概览",
        "学生段位分布",
        "教师院系分布",
        "学习数据统计"
      ]
    }
  },
  created() {
    this.getConfig()
  },
  computed: {
    // 是否曾手动输入过内容（点击快捷选项不算）；用于控制快捷标签的展示
    hasUserInput() {
      return this.messages.some(m => m.role === 'user' && m.fromQuick !== true)
    }
  },
  methods: {
    // 快捷选项点击：填入输入框后直接发送
    sendQuick(text) {
      if (this.loading) return
      this.inputMessage = text
      this.sendMessage(true)
    },

    // 获取AI配置
    getConfig() {
      getAiConfig().then(res => {
        if (res.data) {
          this.aiConfig = res.data
        }
      })
    },

    // 发送消息
    sendMessage(fromQuick) {
      if (!this.inputMessage.trim()) {
        this.$message.warning("请输入问题内容")
        return
      }

      const userMessage = this.inputMessage.trim()

      // 添加用户消息到列表
      this.messages.push({
        role: "user",
        content: userMessage,
        time: this.getCurrentTime(),
        fromQuick: !!fromQuick
      })

      this.inputMessage = ""
      this.loading = true
      this.scrollToBottom()

      // 调用后端API
      sendMessage({
        question: userMessage,
        stuId: this.getUserId(),
        sessionId: this.sessionId
      }).then(res => {
        console.log("AI响应:", res)
        // RuoYi统一返回格式: {code, msg, data}
        let aiContent = ""
        if (res && res.data !== undefined && res.data !== null) {
          aiContent = res.data
        } else if (res && res.msg) {
          aiContent = res.msg
        } else if (typeof res === "string") {
          aiContent = res
        } else {
          aiContent = JSON.stringify(res)
        }

        // 如果内容为空，显示提示
        if (!aiContent || aiContent === "操作成功") {
          aiContent = "AI返回了空内容，请检查后端日志或API Key"
        }

        this.messages.push({
          role: "ai",
          content: aiContent,
          time: this.getCurrentTime()
        })
        this.loading = false
        this.scrollToBottom()
      }).catch(err => {
        console.error("AI调用错误:", err)
        let errMsg = (err && err.response && err.response.data && err.response.data.msg) || err.message || "服务异常"
        // 友好化超时错误（AI 调用偶尔会超过 10s 默认超时）
        if (typeof errMsg === 'string' && errMsg.toLowerCase().includes('timeout')) {
          errMsg = 'AI 思考时间较长（已超过 120 秒），请稍后重试或换个简短问题试试~'
        }
        this.messages.push({
          role: "ai",
          content: "抱歉，服务暂时不可用，请稍后重试。错误：" + errMsg,
          time: this.getCurrentTime()
        })
        this.loading = false
        this.scrollToBottom()
      })
    },

    // 处理回车键
    handleEnter(e) {
      if (!e.shiftKey) {
        e.preventDefault()
        this.sendMessage()
      }
    },

    // 获取当前用户ID
    getUserId() {
      // 从Vuex或localStorage获取当前用户ID
      const user = this.$store.state.user
      return user ? user.userId : null
    },

    // 生成会话ID
    generateSessionId() {
      return "SESSION_" + new Date().getTime()
    },

    // 新会话
    newSession() {
      this.sessionId = this.generateSessionId()
      this.messages = [
        {
          role: "ai",
          content: "你好！我是智学星途AI学习助手，专门为你提供学习辅导服务。有什么学习上的问题，随时可以问我哦！",
          time: this.getCurrentTime()
        }
      ]
      this.$message.success("已开启新会话")
    },
    // 获取当前时间
    getCurrentTime() {
      const now = new Date()
      return now.getHours() + ":" + String(now.getMinutes()).padStart(2, "0")
    },

    // 滚动到底部
    scrollToBottom() {
      this.$nextTick(() => {
        const container = this.$refs.messageContainer
        if (container) {
          container.scrollTop = container.scrollHeight
        }
      })
    },

    // 格式化消息内容（简单换行处理）
    formatMessage(content) {
      if (!content) return ""
      return content.replace(/\n/g, "<br>")
    }
  }
}
</script>

<style scoped>
.ai-chat-container {
  display: flex;
  gap: 20px;
  height: calc(100vh - 120px);
}

/* 让el-card的body区域充满剩余高度 */
.chat-card {
  flex: 1;
  display: flex;
  flex-direction: column;
  height: 100%;
}
.chat-card >>> .el-card__body {
  flex: 1;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  padding: 10px;
}
.history-card {
  width: 280px;
  display: flex;
  flex-direction: column;
}
.history-card >>> .el-card__body {
  flex: 1;
  overflow-y: auto;
}

.chat-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.chat-messages {
  flex: 1;
  overflow-y: auto;
  overflow-x: hidden;
  padding: 20px;
  background-color: #f5f5f5;
  border-radius: 4px;
  margin-bottom: 15px;
  min-height: 0;
}

/* 自定义滚动条样式 */
.chat-messages::-webkit-scrollbar {
  width: 8px;
}
.chat-messages::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 4px;
}
.chat-messages::-webkit-scrollbar-thumb {
  background: #c1c1c1;
  border-radius: 4px;
}
.chat-messages::-webkit-scrollbar-thumb:hover {
  background: #a8a8a8;
}

.chat-input {
  flex-shrink: 0;
  padding: 0 5px;
}

/* 快捷选项样式（参考学生端红框里的快捷入口） */
.quick-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  margin-bottom: 12px;
  padding: 4px 5px 0;
}

.quick-tag {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  padding: 6px 14px;
  font-size: 13px;
  color: #6B5AED;
  background: #f3f0ff;
  border: 1px solid #e3dcfc;
  border-radius: 18px;
  cursor: pointer;
  transition: all 0.2s;
  user-select: none;
}

.quick-tag:hover {
  background: #6B5AED;
  color: #fff;
  border-color: #6B5AED;
  transform: translateY(-1px);
  box-shadow: 0 4px 10px rgba(107, 90, 237, 0.25);
}

.quick-tag i {
  font-size: 12px;
}

.message {
  display: flex;
  margin-bottom: 20px;
}

.message.user {
  flex-direction: row-reverse;
}

.message .avatar {
  margin: 0 10px;
}

.message .content {
  max-width: 70%;
  padding: 10px 15px;
  border-radius: 8px;
  background-color: #fff;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.message.user .content {
  background-color: #409EFF;
  color: #fff;
}

.message .name {
  font-size: 12px;
  color: #999;
  margin-bottom: 5px;
}

.message.user .name {
  color: #e0e0e0;
}

.message .text {
  line-height: 1.6;
  word-wrap: break-word;
}

.message .time {
  font-size: 11px;
  color: #ccc;
  margin-top: 5px;
  text-align: right;
}

.history-card {
  width: 280px;
}

.session-info {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
}

.tips ul {
  padding-left: 20px;
  color: #666;
}

.tips li {
  margin-bottom: 8px;
}
</style>
