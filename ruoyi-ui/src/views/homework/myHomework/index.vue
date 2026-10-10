<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="作业标题" prop="title">
        <el-input
          v-model="queryParams.title"
          placeholder="请输入作业标题"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="作业类型" prop="type">
        <el-select v-model="queryParams.type" placeholder="请选择作业类型" clearable>
          <el-option label="客观题" value="1" />
          <el-option label="主观题" value="2" />
          <el-option label="混合" value="3" />
        </el-select>
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable>
          <el-option label="草稿" value="0" />
          <el-option label="已发布" value="1" />
          <el-option label="已截止" value="2" />
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
          v-hasPermi="['homework:myHomework:add']"
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
          v-hasPermi="['homework:myHomework:edit']"
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
          v-hasPermi="['homework:myHomework:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['homework:myHomework:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="myHomeworkList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="作业ID" align="center" prop="hwId" />
      <el-table-column label="课程名称" align="center" prop="courseName" />
      <el-table-column label="教师姓名" align="center" prop="teacherName" />
      <el-table-column label="作业标题" align="center" prop="title" />
      <el-table-column label="作业类型" align="center" prop="type">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.homework_type" :value="scope.row.type"/>
        </template>
      </el-table-column>
      <el-table-column label="总分" align="center" prop="totalScore" />
      <el-table-column label="题目数量" align="center" prop="questionCount" />
      <el-table-column label="提交人数" align="center" prop="submitCount" />
      <el-table-column label="截止时间" align="center" prop="deadline" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.deadline, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="状态" align="center" prop="status">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.homework_status" :value="scope.row.status"/>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['homework:myHomework:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['homework:myHomework:remove']"
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

    <!-- 添加或修改作业对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="课程ID" prop="cId">
          <el-input v-model="form.cId" placeholder="请输入课程ID" />
        </el-form-item>
        <el-form-item label="发布教师ID" prop="teacherId">
          <el-input v-model="form.teacherId" placeholder="请输入发布教师ID" />
        </el-form-item>
        <el-form-item label="作业标题" prop="title">
          <el-input v-model="form.title" placeholder="请输入作业标题" />
        </el-form-item>
        <el-form-item label="作业内容" prop="content">
          <el-input v-model="form.content" type="textarea" placeholder="请输入作业内容" />
        </el-form-item>
        <el-form-item label="作业类型" prop="type">
          <el-select v-model="form.type" placeholder="请选择作业类型">
            <el-option label="客观题" value="1" />
            <el-option label="主观题" value="2" />
            <el-option label="混合" value="3" />
          </el-select>
        </el-form-item>
        <el-form-item label="总分" prop="totalScore">
          <el-input v-model="form.totalScore" placeholder="请输入总分" />
        </el-form-item>
        <el-form-item label="截止时间" prop="deadline">
          <el-date-picker clearable
            v-model="form.deadline"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择截止时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio label="0">草稿</el-radio>
            <el-radio label="1">已发布</el-radio>
            <el-radio label="2">已截止</el-radio>
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
import { listMyHomework, getMyHomework, delMyHomework, addMyHomework, updateMyHomework } from "@/api/homework/myHomework"

export default {
  name: "MyHomework",
  dicts: ['homework_type', 'homework_status'],
  data() {
    return {
      loading: true,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      myHomeworkList: [],
      title: "",
      open: false,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        title: null,
        type: null,
        status: null,
      },
      form: {},
      rules: {
        title: [
          { required: true, message: "作业标题不能为空", trigger: "blur" }
        ],
        teacherId: [
          { required: true, message: "发布教师ID不能为空", trigger: "blur" }
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
      listMyHomework(this.queryParams).then(response => {
        this.myHomeworkList = response.rows
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
        hwId: null,
        cId: null,
        teacherId: null,
        title: null,
        content: null,
        type: null,
        totalScore: null,
        deadline: null,
        status: "0",
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
      this.ids = selection.map(item => item.hwId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加作业"
    },
    handleUpdate(row) {
      this.reset()
      const hwId = row.hwId || this.ids
      getMyHomework(hwId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改作业"
      })
    },
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.hwId != null) {
            updateMyHomework(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addMyHomework(this.form).then(response => {
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    handleDelete(row) {
      const hwIds = row.hwId || this.ids
      this.$modal.confirm('是否确认删除作业编号为"' + hwIds + '"的数据项？').then(function() {
        return delMyHomework(hwIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    handleExport() {
      this.download('homework/myHomework/export', {
        ...this.queryParams
      }, `myHomework_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
