<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="80px">
      <el-form-item label="学生姓名" prop="userName">
        <el-input
          v-model="queryParams.userName"
          placeholder="请输入学生姓名"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="会话ID" prop="sessionId">
        <el-input
          v-model="queryParams.sessionId"
          placeholder="请输入会话ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="问题类型" prop="questionType">
        <el-select v-model="queryParams.questionType" placeholder="请选择问题类型" clearable>
          <el-option label="学习" value="1" />
          <el-option label="作业" value="2" />
          <el-option label="其他" value="3" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['study:myAiChat:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['study:myAiChat:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['study:myAiChat:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['study:myAiChat:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="myAiChatList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="对话ID" align="center" prop="chatId" />
      <el-table-column label="学生姓名" align="center" prop="userName" />
      <el-table-column label="会话ID" align="center" prop="sessionId" />
      <el-table-column label="问题内容" align="center" prop="question" show-overflow-tooltip />
      <el-table-column label="回答内容" align="center" prop="answer" show-overflow-tooltip />
      <el-table-column label="问题类型" align="center" prop="questionType">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.ai_question_type" :value="scope.row.questionType"/>
        </template>
      </el-table-column>
      <el-table-column label="是否满意" align="center" prop="isSatisfied">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.yes_no" :value="scope.row.isSatisfied"/>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['study:myAiChat:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['study:myAiChat:remove']"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改AI问答记录对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="学生ID" prop="stuId">
          <el-input v-model="form.stuId" placeholder="请输入学生ID" />
        </el-form-item>
        <el-form-item label="教师ID" prop="teacherId">
          <el-input v-model="form.teacherId" placeholder="请输入教师ID" />
        </el-form-item>
        <el-form-item label="会话ID" prop="sessionId">
          <el-input v-model="form.sessionId" placeholder="请输入会话ID" />
        </el-form-item>
        <el-form-item label="问题内容" prop="question">
          <el-input v-model="form.question" type="textarea" placeholder="请输入问题内容" />
        </el-form-item>
        <el-form-item label="回答内容" prop="answer">
          <el-input v-model="form.answer" type="textarea" placeholder="请输入回答内容" />
        </el-form-item>
        <el-form-item label="问题类型" prop="questionType">
          <el-select v-model="form.questionType" placeholder="请选择问题类型">
            <el-option label="学习" value="1" />
            <el-option label="作业" value="2" />
            <el-option label="其他" value="3" />
          </el-select>
        </el-form-item>
        <el-form-item label="是否满意" prop="isSatisfied">
          <el-radio-group v-model="form.isSatisfied">
            <el-radio label="0">否</el-radio>
            <el-radio label="1">是</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listMyAiChat, getMyAiChat, delMyAiChat, addMyAiChat, updateMyAiChat } from "@/api/study/myAiChat"

export default {
  name: "MyAiChat",
  dicts: ['ai_question_type', 'yes_no'],
  data() {
    return {
      loading: true,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      myAiChatList: [],
      title: "",
      open: false,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        userName: null,
        sessionId: null,
        questionType: null,
      },
      form: {},
      rules: {
        stuId: [
          { required: true, message: "学生ID不能为空", trigger: "blur" }
        ],
        question: [
          { required: true, message: "问题内容不能为空", trigger: "blur" }
        ],
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    getList() {
      this.loading = true
      listMyAiChat(this.queryParams).then(response => {
        this.myAiChatList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    cancel() {
      this.open = false
      this.reset()
    },
    reset() {
      this.form = {
        chatId: null,
        stuId: null,
        teacherId: null,
        sessionId: null,
        question: null,
        answer: null,
        questionType: null,
        isSatisfied: "0",
      }
      this.resetForm("form")
    },
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    resetQuery() {
      this.resetForm("queryForm")
      this.handleQuery()
    },
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.chatId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加AI问答记录"
    },
    handleUpdate(row) {
      this.reset()
      const chatId = row.chatId || this.ids
      getMyAiChat(chatId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改AI问答记录"
      })
    },
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.chatId != null) {
            updateMyAiChat(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addMyAiChat(this.form).then(response => {
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    handleDelete(row) {
      const chatIds = row.chatId || this.ids
      this.$modal.confirm('是否确认删除AI问答记录编号为"' + chatIds + '"的数据项？').then(function() {
        return delMyAiChat(chatIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    handleExport() {
      this.download('study/myAiChat/export', {
        ...this.queryParams
      }, `myAiChat_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
