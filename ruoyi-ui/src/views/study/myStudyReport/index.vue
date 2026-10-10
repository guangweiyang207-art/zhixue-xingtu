<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="学生ID" prop="stuId">
        <el-input
          v-model="queryParams.stuId"
          placeholder="请输入学生ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="报表类型" prop="reportType">
        <el-select v-model="queryParams.reportType" placeholder="请选择报表类型" clearable>
          <el-option label="日报" value="1" />
          <el-option label="周报" value="2" />
          <el-option label="月报" value="3" />
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
          v-hasPermi="['study:myStudyReport:add']"
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
          v-hasPermi="['study:myStudyReport:edit']"
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
          v-hasPermi="['study:myStudyReport:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['study:myStudyReport:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="myStudyReportList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="报表ID" align="center" prop="reportId" />
      <el-table-column label="学生ID" align="center" prop="stuId" />
      <el-table-column label="报表类型" align="center" prop="reportType">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.report_type" :value="scope.row.reportType"/>
        </template>
      </el-table-column>
      <el-table-column label="报表日期" align="center" prop="reportDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.reportDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="学习时长(分钟)" align="center" prop="studyDuration" />
      <el-table-column label="完成课程数" align="center" prop="completedCourses" />
      <el-table-column label="完成作业数" align="center" prop="completedHomework" />
      <el-table-column label="正确率" align="center" prop="correctRate" />
      <el-table-column label="积分变化" align="center" prop="rankScoreChange" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['study:myStudyReport:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['study:myStudyReport:remove']"
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

    <!-- 添加或修改学情报表对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="120px">
        <el-form-item label="学生ID" prop="stuId">
          <el-input v-model="form.stuId" placeholder="请输入学生ID" />
        </el-form-item>
        <el-form-item label="报表类型" prop="reportType">
          <el-select v-model="form.reportType" placeholder="请选择报表类型">
            <el-option label="日报" value="1" />
            <el-option label="周报" value="2" />
            <el-option label="月报" value="3" />
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
        <el-form-item label="学习时长(分钟)" prop="studyDuration">
          <el-input v-model="form.studyDuration" placeholder="请输入学习时长" />
        </el-form-item>
        <el-form-item label="完成课程数" prop="completedCourses">
          <el-input v-model="form.completedCourses" placeholder="请输入完成课程数" />
        </el-form-item>
        <el-form-item label="完成作业数" prop="completedHomework">
          <el-input v-model="form.completedHomework" placeholder="请输入完成作业数" />
        </el-form-item>
        <el-form-item label="正确率" prop="correctRate">
          <el-input v-model="form.correctRate" placeholder="请输入正确率" />
        </el-form-item>
        <el-form-item label="积分变化" prop="rankScoreChange">
          <el-input v-model="form.rankScoreChange" placeholder="请输入积分变化" />
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
import { listMyStudyReport, getMyStudyReport, delMyStudyReport, addMyStudyReport, updateMyStudyReport } from "@/api/study/myStudyReport"

export default {
  name: "MyStudyReport",
  dicts: ['report_type'],
  data() {
    return {
      loading: true,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      myStudyReportList: [],
      title: "",
      open: false,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        stuId: null,
        reportType: null,
        reportDate: null,
      },
      form: {},
      rules: {
        stuId: [
          { required: true, message: "学生ID不能为空", trigger: "blur" }
        ],
        reportType: [
          { required: true, message: "报表类型不能为空", trigger: "change" }
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
      listMyStudyReport(this.queryParams).then(response => {
        this.myStudyReportList = response.rows
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
        reportId: null,
        stuId: null,
        reportType: null,
        reportDate: null,
        studyDuration: null,
        completedCourses: null,
        completedHomework: null,
        correctRate: null,
        rankScoreChange: null,
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
      this.ids = selection.map(item => item.reportId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加学情报表"
    },
    handleUpdate(row) {
      this.reset()
      const reportId = row.reportId || this.ids
      getMyStudyReport(reportId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改学情报表"
      })
    },
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.reportId != null) {
            updateMyStudyReport(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addMyStudyReport(this.form).then(response => {
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    handleDelete(row) {
      const reportIds = row.reportId || this.ids
      this.$modal.confirm('是否确认删除学情报表编号为"' + reportIds + '"的数据项？').then(function() {
        return delMyStudyReport(reportIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    handleExport() {
      this.download('study/myStudyReport/export', {
        ...this.queryParams
      }, `myStudyReport_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
