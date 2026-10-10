<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="80px">
      <el-form-item label="学号" prop="studentNo">
        <el-input
          v-model="queryParams.studentNo"
          placeholder="请输入学号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="学生姓名" prop="userName">
        <el-input
          v-model="queryParams.userName"
          placeholder="请输入学生姓名"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="专业" prop="major">
        <el-select v-model="queryParams.major" placeholder="请选择专业" clearable>
          <el-option label="计算机科学" value="计算机科学" />
          <el-option label="软件工程" value="软件工程" />
          <el-option label="人工智能" value="人工智能" />
          <el-option label="网络工程" value="网络工程" />
          <el-option label="数据科学" value="数据科学" />
          <el-option label="机器人工程" value="机器人工程" />
        </el-select>
      </el-form-item>
      <el-form-item label="班级" prop="className">
        <el-select v-model="queryParams.className" placeholder="请选择班级" clearable>
          <el-option label="计科1班" value="计科1班" />
          <el-option label="软工1班" value="软工1班" />
          <el-option label="智科1班" value="智科1班" />
          <el-option label="网工1班" value="网工1班" />
          <el-option label="数科1班" value="数科1班" />
          <el-option label="机器人1班" value="机器人1班" />
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
          v-hasPermi="['userext:myStudent:add']"
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
          v-hasPermi="['userext:myStudent:edit']"
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
          v-hasPermi="['userext:myStudent:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['userext:myStudent:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="myStudentList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="学生ID" align="center" prop="stuId" />
      <el-table-column label="学生姓名" align="center" prop="userName" />
      <el-table-column label="学号" align="center" prop="studentNo" />
      <el-table-column label="专业" align="center" prop="major" />
      <el-table-column label="年级" align="center" prop="grade" />
      <el-table-column label="班级" align="center" prop="className" />
      <el-table-column label="生日" align="center" prop="birthday" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.birthday, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="指导教师" align="center" prop="teacherName" />
      <el-table-column label="当前段位" align="center" prop="rankLevel" />
      <el-table-column label="段位积分" align="center" prop="rankScore" />
      <el-table-column label="选课数量" align="center" prop="courseCount" />
      <el-table-column label="作业完成数" align="center" prop="homeworkCount" />
      <el-table-column label="总做题数" align="center" prop="totalQuestions" />
      <el-table-column label="正确题数" align="center" prop="correctQuestions" />
      <el-table-column label="学习时长(小时)" align="center" prop="studyHours" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" fixed="right" width="120">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['userext:myStudent:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['userext:myStudent:remove']"
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

    <!-- 添加或修改学生对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="120px">
        <el-form-item label="学生姓名" prop="userName">
          <el-input v-model="form.userName" placeholder="请输入学生姓名" />
        </el-form-item>
        <el-form-item label="学号" prop="studentNo">
          <el-input v-model="form.studentNo" placeholder="请输入学号" />
        </el-form-item>
        <el-form-item label="专业" prop="major">
          <el-select v-model="form.major" placeholder="请选择专业" clearable>
            <el-option label="计算机科学" value="计算机科学" />
            <el-option label="软件工程" value="软件工程" />
            <el-option label="人工智能" value="人工智能" />
            <el-option label="网络工程" value="网络工程" />
            <el-option label="数据科学" value="数据科学" />
            <el-option label="机器人工程" value="机器人工程" />
          </el-select>
        </el-form-item>
        <el-form-item label="年级" prop="grade">
          <el-input v-model="form.grade" placeholder="请输入年级" />
        </el-form-item>
        <el-form-item label="班级" prop="className">
          <el-select v-model="form.className" placeholder="请选择班级" clearable>
            <el-option label="计科1班" value="计科1班" />
            <el-option label="软工1班" value="软工1班" />
            <el-option label="智科1班" value="智科1班" />
            <el-option label="网工1班" value="网工1班" />
            <el-option label="数科1班" value="数科1班" />
            <el-option label="机器人1班" value="机器人1班" />
          </el-select>
        </el-form-item>
        <el-form-item label="生日" prop="birthday">
          <el-date-picker clearable
            v-model="form.birthday"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择生日">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="关联教师ID" prop="teacherId">
          <el-input v-model="form.teacherId" placeholder="请输入关联教师ID" />
        </el-form-item>
        <el-form-item label="当前段位" prop="rankLevel">
          <el-input v-model="form.rankLevel" placeholder="请输入当前段位" />
        </el-form-item>
        <el-form-item label="段位积分" prop="rankScore">
          <el-input v-model="form.rankScore" placeholder="请输入段位积分" />
        </el-form-item>
        <el-form-item v-if="form.stuId == null">
          <el-alert
            title="保存后将自动在 my_sys_user 中创建一条学生账号：用户名 student{userId}（与 user_id 保持一致），默认密码 123456"
            type="info"
            :closable="false"
            show-icon
          />
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
import { listMyStudent, getMyStudent, delMyStudent, addMyStudent, updateMyStudent } from "@/api/userext/myStudent"

export default {
  name: "MyStudent",
  data() {
    return {
      loading: true,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      myStudentList: [],
      title: "",
      open: false,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        studentNo: null,
        userName: null,
        major: null,
        className: null,
      },
      form: {},
      rules: {
        userName: [
          { required: true, message: "学生姓名不能为空", trigger: "blur" }
        ],
        studentNo: [
          { required: true, message: "学号不能为空", trigger: "blur" }
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
      listMyStudent(this.queryParams).then(response => {
        this.myStudentList = response.rows
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
        stuId: null,
        userId: null,
        userName: null,
        studentNo: null,
        major: null,
        grade: null,
        className: null,
        birthday: null,
        teacherId: null,
        rankLevel: null,
        rankScore: null,
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
      this.ids = selection.map(item => item.stuId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加学生"
    },
    handleUpdate(row) {
      this.reset()
      const stuId = row.stuId || this.ids
      getMyStudent(stuId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改学生"
      })
    },
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.stuId != null) {
            updateMyStudent(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addMyStudent(this.form).then(response => {
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    handleDelete(row) {
      const stuIds = row.stuId || this.ids
      this.$modal.confirm('是否确认删除学生编号为"' + stuIds + '"的数据项？').then(function() {
        return delMyStudent(stuIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    handleExport() {
      this.download('userext/myStudent/export', {
        ...this.queryParams
      }, `myStudent_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
