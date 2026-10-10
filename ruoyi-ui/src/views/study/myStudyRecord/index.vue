<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="80px">
      <el-form-item label="学生姓名" prop="studentName">
        <el-input
          v-model="queryParams.studentName"
          placeholder="请输入学生姓名"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="课程名称" prop="courseName">
        <el-input
          v-model="queryParams.courseName"
          placeholder="请输入课程名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="学习类型" prop="studyType">
        <el-select v-model="queryParams.studyType" placeholder="请选择学习类型" clearable>
          <el-option label="视频" value="1" />
          <el-option label="文档" value="2" />
          <el-option label="做题" value="3" />
          <el-option label="其他" value="4" />
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
          v-hasPermi="['study:myStudyRecord:add']"
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
          v-hasPermi="['study:myStudyRecord:edit']"
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
          v-hasPermi="['study:myStudyRecord:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['study:myStudyRecord:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="myStudyRecordList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="记录ID" align="center" prop="srId" />
      <el-table-column label="学生姓名" align="center" prop="studentName" />
      <el-table-column label="课程名称" align="center" prop="courseName" />
      <el-table-column label="学习类型" align="center" prop="studyType">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.studyType === 1" type="primary" size="small">视频</el-tag>
          <el-tag v-else-if="scope.row.studyType === 2" type="success" size="small">文档</el-tag>
          <el-tag v-else-if="scope.row.studyType === 3" type="warning" size="small">做题</el-tag>
          <el-tag v-else-if="scope.row.studyType === 4" type="info" size="small">其他</el-tag>
          <span v-else>{{ scope.row.studyType }}</span>
        </template>
      </el-table-column>
      <el-table-column label="学习时长(分钟)" align="center" prop="studyDuration" />
      <el-table-column label="学习日期" align="center" prop="studyDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.studyDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="进度百分比" align="center" prop="progress" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['study:myStudyRecord:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['study:myStudyRecord:remove']"
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

    <!-- 添加或修改学习记录对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="120px">
        <el-form-item label="学生ID" prop="stuId">
          <el-input v-model="form.stuId" placeholder="请输入学生ID" />
        </el-form-item>
        <el-form-item label="课程ID" prop="cId">
          <el-input v-model="form.cId" placeholder="请输入课程ID" />
        </el-form-item>
        <el-form-item label="学习类型" prop="studyType">
          <el-select v-model="form.studyType" placeholder="请选择学习类型">
            <el-option label="视频" value="1" />
            <el-option label="文档" value="2" />
            <el-option label="做题" value="3" />
            <el-option label="其他" value="4" />
          </el-select>
        </el-form-item>
        <el-form-item label="学习时长(分钟)" prop="studyDuration">
          <el-input v-model="form.studyDuration" placeholder="请输入学习时长" />
        </el-form-item>
        <el-form-item label="学习日期" prop="studyDate">
          <el-date-picker clearable
            v-model="form.studyDate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择学习日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="进度百分比" prop="progress">
          <el-input v-model="form.progress" placeholder="请输入进度百分比" />
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
import { listMyStudyRecord, getMyStudyRecord, delMyStudyRecord, addMyStudyRecord, updateMyStudyRecord } from "@/api/study/myStudyRecord"

export default {
  name: "MyStudyRecord",
  dicts: ['study_type'],
  data() {
    return {
      loading: true,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      myStudyRecordList: [],
      title: "",
      open: false,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        studentName: null,
        courseName: null,
        studyType: null,
      },
      form: {},
      rules: {
        stuId: [
          { required: true, message: "学生ID不能为空", trigger: "blur" }
        ],
        cId: [
          { required: true, message: "课程ID不能为空", trigger: "blur" }
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
      listMyStudyRecord(this.queryParams).then(response => {
        this.myStudyRecordList = response.rows
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
        srId: null,
        stuId: null,
        studentName: null,
        cId: null,
        courseName: null,
        studyType: null,
        studyDuration: null,
        studyDate: null,
        progress: null,
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
      this.ids = selection.map(item => item.srId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加学习记录"
    },
    handleUpdate(row) {
      this.reset()
      const srId = row.srId || this.ids
      getMyStudyRecord(srId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改学习记录"
      })
    },
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.srId != null) {
            updateMyStudyRecord(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addMyStudyRecord(this.form).then(response => {
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    handleDelete(row) {
      const srIds = row.srId || this.ids
      this.$modal.confirm('是否确认删除学习记录编号为"' + srIds + '"的数据项？').then(function() {
        return delMyStudyRecord(srIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    handleExport() {
      this.download('study/myStudyRecord/export', {
        ...this.queryParams
      }, `myStudyRecord_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
