<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="报表类型" prop="reportType">
        <el-select v-model="queryParams.reportType" placeholder="请选择报表类型" clearable>
          <el-option label="日报" value="1" />
          <el-option label="周报" value="2" />
          <el-option label="月报" value="3" />
          <el-option label="年报" value="4" />
        </el-select>
      </el-form-item>
      <el-form-item label="报表日期" prop="reportDate">
        <el-date-picker clearable
          v-model="queryParams.reportDate"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择报表日期">
        </el-date-picker>
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
          v-hasPermi="['study:myGlobalReport:add']"
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
          v-hasPermi="['study:myGlobalReport:edit']"
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
          v-hasPermi="['study:myGlobalReport:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['study:myGlobalReport:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="myGlobalReportList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="报表ID" align="center" prop="grId" />
      <el-table-column label="学生ID" align="center" prop="stdId" />
      <el-table-column label="教师ID" align="center" prop="teacherId" />
      <el-table-column label="报表类型" align="center" prop="reportType">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.global_report_type" :value="scope.row.reportType"/>
        </template>
      </el-table-column>
      <el-table-column label="报表日期" align="center" prop="reportDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.reportDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="总学生数" align="center" prop="totalStudents" />
      <el-table-column label="总教师数" align="center" prop="totalTeachers" />
      <el-table-column label="总课程数" align="center" prop="totalCourses" />
      <el-table-column label="活跃学生数" align="center" prop="activeStudents" />
      <el-table-column label="新增学生数" align="center" prop="newStudents" />
      <el-table-column label="完成作业数" align="center" prop="completedHomeworkCount" />
      <el-table-column label="平均正确率" align="center" prop="averageCorrectRate" />
      <el-table-column label="总学习时长" align="center" prop="totalStudyHours" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" fixed="right" width="120">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['study:myGlobalReport:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['study:myGlobalReport:remove']"
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

    <!-- 添加或修改全局报表对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="120px">
        <el-form-item label="学生ID" prop="stdId">
          <el-input v-model="form.stdId" placeholder="请输入学生ID" />
        </el-form-item>
        <el-form-item label="教师ID" prop="teacherId">
          <el-input v-model="form.teacherId" placeholder="请输入教师ID" />
        </el-form-item>
        <el-form-item label="报表类型" prop="reportType">
          <el-select v-model="form.reportType" placeholder="请选择报表类型">
            <el-option label="日报" value="1" />
            <el-option label="周报" value="2" />
            <el-option label="月报" value="3" />
            <el-option label="年报" value="4" />
          </el-select>
        </el-form-item>
        <el-form-item label="报表日期" prop="reportDate">
          <el-date-picker clearable
            v-model="form.reportDate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择报表日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="总学生数" prop="totalStudents">
          <el-input v-model="form.totalStudents" placeholder="请输入总学生数" />
        </el-form-item>
        <el-form-item label="总教师数" prop="totalTeachers">
          <el-input v-model="form.totalTeachers" placeholder="请输入总教师数" />
        </el-form-item>
        <el-form-item label="总课程数" prop="totalCourses">
          <el-input v-model="form.totalCourses" placeholder="请输入总课程数" />
        </el-form-item>
        <el-form-item label="活跃学生数" prop="activeStudents">
          <el-input v-model="form.activeStudents" placeholder="请输入活跃学生数" />
        </el-form-item>
        <el-form-item label="新增学生数" prop="newStudents">
          <el-input v-model="form.newStudents" placeholder="请输入新增学生数" />
        </el-form-item>
        <el-form-item label="完成作业数" prop="completedHomeworkCount">
          <el-input v-model="form.completedHomeworkCount" placeholder="请输入完成作业数" />
        </el-form-item>
        <el-form-item label="平均正确率" prop="averageCorrectRate">
          <el-input v-model="form.averageCorrectRate" placeholder="请输入平均正确率" />
        </el-form-item>
        <el-form-item label="总学习时长" prop="totalStudyHours">
          <el-input v-model="form.totalStudyHours" placeholder="请输入总学习时长" />
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
import { listMyGlobalReport, getMyGlobalReport, delMyGlobalReport, addMyGlobalReport, updateMyGlobalReport } from "@/api/study/myGlobalReport"

export default {
  name: "MyGlobalReport",
  dicts: ['global_report_type'],
  data() {
    return {
      loading: true,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      myGlobalReportList: [],
      title: "",
      open: false,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        reportType: null,
        reportDate: null,
      },
      form: {},
      rules: {
        reportType: [
          { required: true, message: "报表类型不能为空", trigger: "change" }
        ],
        reportDate: [
          { required: true, message: "报表日期不能为空", trigger: "blur" }
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
      listMyGlobalReport(this.queryParams).then(response => {
        this.myGlobalReportList = response.rows
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
        grId: null,
        stdId: null,
        teacherId: null,
        reportType: null,
        reportDate: null,
        totalStudents: null,
        totalTeachers: null,
        totalCourses: null,
        activeStudents: null,
        newStudents: null,
        completedHomeworkCount: null,
        averageCorrectRate: null,
        totalStudyHours: null,
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
      this.ids = selection.map(item => item.grId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加全局报表"
    },
    handleUpdate(row) {
      this.reset()
      const grId = row.grId || this.ids
      getMyGlobalReport(grId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改全局报表"
      })
    },
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.grId != null) {
            updateMyGlobalReport(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addMyGlobalReport(this.form).then(response => {
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    handleDelete(row) {
      const grIds = row.grId || this.ids
      this.$modal.confirm('是否确认删除全局报表编号为"' + grIds + '"的数据项？').then(function() {
        return delMyGlobalReport(grIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    handleExport() {
      this.download('study/myGlobalReport/export', {
        ...this.queryParams
      }, `myGlobalReport_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
