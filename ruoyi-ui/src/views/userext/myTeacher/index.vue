<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="80px">
      <el-form-item label="工号" prop="teacherNo">
        <el-input
          v-model="queryParams.teacherNo"
          placeholder="请输入工号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="教师姓名" prop="userName">
        <el-input
          v-model="queryParams.userName"
          placeholder="请输入教师姓名"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="职称" prop="title">
        <el-select v-model="queryParams.title" placeholder="请选择职称" clearable>
          <el-option label="教授" value="教授" />
          <el-option label="副教授" value="副教授" />
          <el-option label="讲师" value="讲师" />
          <el-option label="助教" value="助教" />
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
          v-hasPermi="['userext:myTeacher:add']"
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
          v-hasPermi="['userext:myTeacher:edit']"
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
          v-hasPermi="['userext:myTeacher:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['userext:myTeacher:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="myTeacherList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="教师ID" align="center" prop="teacherId" />
      <el-table-column label="教师姓名" align="center" prop="userName" />
      <el-table-column label="工号" align="center" prop="teacherNo" />
      <el-table-column label="所属院系" align="center" prop="department" />
      <el-table-column label="职称" align="center" prop="title" />
      <el-table-column label="专长领域" align="center" prop="specialty" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['userext:myTeacher:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['userext:myTeacher:remove']"
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

    <!-- 添加或修改教师对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="教师姓名" prop="userName">
          <el-input v-model="form.userName" placeholder="请输入教师姓名" />
        </el-form-item>
        <el-form-item label="工号" prop="teacherNo">
          <el-input v-model="form.teacherNo" placeholder="请输入工号" />
        </el-form-item>
        <el-form-item label="所属院系" prop="department">
          <el-input v-model="form.department" placeholder="请输入所属院系" />
        </el-form-item>
        <el-form-item label="职称" prop="title">
          <el-input v-model="form.title" placeholder="请输入职称" />
        </el-form-item>
        <el-form-item label="专长领域" prop="specialty">
          <el-input v-model="form.specialty" placeholder="请输入专长领域" />
        </el-form-item>
        <el-form-item v-if="form.teacherId == null">
          <el-alert
            title="保存后将自动在 my_sys_user 中创建一条教师账号：用户名 teacher{userId}（与 user_id 保持一致），默认密码 123456"
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
import { listMyTeacher, getMyTeacher, delMyTeacher, addMyTeacher, updateMyTeacher } from "@/api/userext/myTeacher"

export default {
  name: "MyTeacher",
  data() {
    return {
      loading: true,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      myTeacherList: [],
      title: "",
      open: false,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        teacherNo: null,
        userName: null,
        title: null,
      },
      form: {},
      rules: {
        teacherNo: [
          { required: true, message: "工号不能为空", trigger: "blur" }
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
      listMyTeacher(this.queryParams).then(response => {
        this.myTeacherList = response.rows
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
        teacherId: null,
        userId: null,
        userName: null,
        teacherNo: null,
        department: null,
        title: null,
        specialty: null,
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
      this.ids = selection.map(item => item.teacherId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加教师"
    },
    handleUpdate(row) {
      this.reset()
      const teacherId = row.teacherId || this.ids
      getMyTeacher(teacherId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改教师"
      })
    },
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.teacherId != null) {
            updateMyTeacher(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addMyTeacher(this.form).then(response => {
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    handleDelete(row) {
      const teacherIds = row.teacherId || this.ids
      this.$modal.confirm('是否确认删除教师编号为"' + teacherIds + '"的数据项？').then(function() {
        return delMyTeacher(teacherIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    handleExport() {
      this.download('userext/myTeacher/export', {
        ...this.queryParams
      }, `myTeacher_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
