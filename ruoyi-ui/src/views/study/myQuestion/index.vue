<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="题型" prop="questionType">
        <el-select v-model="queryParams.questionType" placeholder="请选择题型" clearable>
          <el-option label="单选" value="1" />
          <el-option label="多选" value="2" />
          <el-option label="判断" value="3" />
          <el-option label="填空" value="4" />
          <el-option label="简答" value="5" />
        </el-select>
      </el-form-item>
      <el-form-item label="题目内容" prop="questionContent">
        <el-input
          v-model="queryParams.questionContent"
          placeholder="请输入题目内容"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="难度" prop="difficulty">
        <el-select v-model="queryParams.difficulty" placeholder="请选择难度" clearable>
          <el-option label="简单" value="1" />
          <el-option label="中等" value="2" />
          <el-option label="困难" value="3" />
        </el-select>
      </el-form-item>
      <el-form-item label="所属作业" prop="homeworkTitle">
        <el-input
          v-model="queryParams.homeworkTitle"
          placeholder="请输入所属作业标题"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="所属题库" prop="bankName">
        <el-input
          v-model="queryParams.bankName"
          placeholder="请输入所属题库名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
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
          v-hasPermi="['study:myQuestion:add']"
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
          v-hasPermi="['study:myQuestion:edit']"
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
          v-hasPermi="['study:myQuestion:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['study:myQuestion:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="myQuestionList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="题目ID" align="center" prop="qId" />
      <el-table-column label="题型" align="center" prop="questionType">
        <template slot-scope="scope">
          <span v-if="scope.row.questionType == 1">单选</span>
          <span v-else-if="scope.row.questionType == 2">多选</span>
          <span v-else-if="scope.row.questionType == 3">判断</span>
          <span v-else-if="scope.row.questionType == 4">填空</span>
          <span v-else-if="scope.row.questionType == 5">简答</span>
          <span v-else>{{ scope.row.questionType }}</span>
        </template>
      </el-table-column>
      <el-table-column label="题目内容" align="center" prop="questionContent" show-overflow-tooltip />
      <el-table-column label="选项" align="center" prop="options" show-overflow-tooltip />
      <el-table-column label="正确答案" align="center" prop="correctAnswer" show-overflow-tooltip />
      <el-table-column label="分值" align="center" prop="score" />
      <el-table-column label="难度" align="center" prop="difficulty">
        <template slot-scope="scope">
          <span v-if="scope.row.difficulty == 1">简单</span>
          <span v-else-if="scope.row.difficulty == 2">中等</span>
          <span v-else-if="scope.row.difficulty == 3">困难</span>
          <span v-else>{{ scope.row.difficulty }}</span>
        </template>
      </el-table-column>
      <el-table-column label="排序" align="center" prop="sortOrder" />
      <el-table-column label="所属作业" align="center" prop="homeworkTitle" />
      <el-table-column label="所属题库" align="center" prop="bankName" />
      <el-table-column label="所属课程" align="center" prop="courseName" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['study:myQuestion:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['study:myQuestion:remove']"
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

    <!-- 添加或修改题目对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="700px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="题型" prop="questionType">
          <el-select v-model="form.questionType" placeholder="请选择题型">
            <el-option label="单选" value="1" />
            <el-option label="多选" value="2" />
            <el-option label="判断" value="3" />
            <el-option label="填空" value="4" />
            <el-option label="简答" value="5" />
          </el-select>
        </el-form-item>
        <el-form-item label="题目内容" prop="questionContent">
          <el-input v-model="form.questionContent" type="textarea" placeholder="请输入题目内容" />
        </el-form-item>
        <el-form-item label="选项" prop="options">
          <el-input v-model="form.options" type="textarea" placeholder='请输入选项JSON格式，如：{"A":"选项A","B":"选项B"}' />
        </el-form-item>
        <el-form-item label="正确答案" prop="correctAnswer">
          <el-input v-model="form.correctAnswer" placeholder="请输入正确答案" />
        </el-form-item>
        <el-form-item label="分值" prop="score">
          <el-input-number v-model="form.score" :min="1" placeholder="请输入分值" />
        </el-form-item>
        <el-form-item label="难度" prop="difficulty">
          <el-radio-group v-model="form.difficulty">
            <el-radio label="1">简单</el-radio>
            <el-radio label="2">中等</el-radio>
            <el-radio label="3">困难</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="排序" prop="sortOrder">
          <el-input-number v-model="form.sortOrder" :min="0" placeholder="请输入排序" />
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
import { listMyQuestion, getMyQuestion, delMyQuestion, addMyQuestion, updateMyQuestion } from "@/api/study/myQuestion"

export default {
  name: "MyQuestion",
  data() {
    return {
      loading: true,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      myQuestionList: [],
      title: "",
      open: false,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        questionType: null,
        questionContent: null,
        difficulty: null,
        homeworkTitle: null,
        bankName: null,
      },
      form: {},
      rules: {
        questionType: [
          { required: true, message: "题型不能为空", trigger: "change" }
        ],
        questionContent: [
          { required: true, message: "题目内容不能为空", trigger: "blur" }
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
      listMyQuestion(this.queryParams).then(response => {
        this.myQuestionList = response.rows
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
        qId: null,
        questionType: null,
        questionContent: null,
        options: null,
        correctAnswer: null,
        score: 10,
        difficulty: "2",
        sortOrder: 0,
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
      this.ids = selection.map(item => item.qId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加题目"
    },
    handleUpdate(row) {
      this.reset()
      const qId = row.qId || this.ids
      getMyQuestion(qId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改题目"
      })
    },
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.qId != null) {
            updateMyQuestion(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addMyQuestion(this.form).then(response => {
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    handleDelete(row) {
      const qIds = row.qId || this.ids
      this.$modal.confirm('是否确认删除题目编号为"' + qIds + '"的数据项？').then(function() {
        return delMyQuestion(qIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    handleExport() {
      this.download('study/myQuestion/export', {
        ...this.queryParams
      }, `myQuestion_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
