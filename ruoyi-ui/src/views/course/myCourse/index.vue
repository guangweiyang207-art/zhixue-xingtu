<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="课程名称" prop="cName">
        <el-input
          v-model="queryParams.cName"
          placeholder="请输入课程名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="授课教师" prop="teacherName">
        <el-input
          v-model="queryParams.teacherName"
          placeholder="请输入授课教师姓名"
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
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable>
          <el-option label="下架" value="0" />
          <el-option label="上架" value="1" />
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
          v-hasPermi="['course:myCourse:add']"
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
          v-hasPermi="['course:myCourse:edit']"
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
          v-hasPermi="['course:myCourse:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['course:myCourse:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="myCourseList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="课程ID" align="center" prop="cId" />
      <el-table-column label="课程名称" align="center" prop="cName" />
      <el-table-column label="授课教师" align="center" prop="teacherName" />
      <el-table-column label="教师工号" align="center" prop="teacherNo" />
      <el-table-column label="课程类型" align="center" prop="type" />
      <el-table-column label="课程标签" align="center" prop="tag" />
      <el-table-column label="难度" align="center" prop="difficulty">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.difficulty === 1" type="success" size="small">简单</el-tag>
          <el-tag v-else-if="scope.row.difficulty === 2" type="warning" size="small">中等</el-tag>
          <el-tag v-else-if="scope.row.difficulty === 3" type="danger" size="small">困难</el-tag>
          <span v-else>{{ scope.row.difficulty }}</span>
        </template>
      </el-table-column>
      <el-table-column label="最大人数" align="center" prop="maxPerson" />
      <el-table-column label="当前人数" align="center" prop="currentPerson" />
      <el-table-column label="作业数量" align="center" prop="homeworkCount" />
      <el-table-column label="状态" align="center" prop="status">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.status === 0" type="info" size="small">下架</el-tag>
          <el-tag v-else-if="scope.row.status === 1" type="success" size="small">上架</el-tag>
          <span v-else>{{ scope.row.status }}</span>
        </template>
      </el-table-column>
      <el-table-column label="开课时间" align="center" prop="startTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.startTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="结课时间" align="center" prop="endTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.endTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['course:myCourse:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['course:myCourse:remove']"
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

    <!-- 添加或修改课程对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="课程名称" prop="cName">
          <el-input v-model="form.cName" placeholder="请输入课程名称" />
        </el-form-item>
        <el-form-item label="授课教师ID" prop="teacherId">
          <el-input v-model="form.teacherId" placeholder="请输入授课教师ID" />
        </el-form-item>
        <el-form-item label="课程类型" prop="type">
          <el-input v-model="form.type" placeholder="请输入课程类型" />
        </el-form-item>
        <el-form-item label="课程标签" prop="tag">
          <el-input v-model="form.tag" placeholder="请输入课程标签" />
        </el-form-item>
        <el-form-item label="难度" prop="difficulty">
          <el-select v-model="form.difficulty" placeholder="请选择难度">
            <el-option label="简单" value="1" />
            <el-option label="中等" value="2" />
            <el-option label="困难" value="3" />
          </el-select>
        </el-form-item>
        <el-form-item label="最大人数" prop="maxPerson">
          <el-input v-model="form.maxPerson" placeholder="请输入最大人数" />
        </el-form-item>
        <el-form-item label="课程描述" prop="description">
          <el-input v-model="form.description" type="textarea" placeholder="请输入课程描述" />
        </el-form-item>
        <el-form-item label="封面图" prop="coverImage">
          <el-input v-model="form.coverImage" placeholder="请输入封面图URL" />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio label="0">下架</el-radio>
            <el-radio label="1">上架</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="开课时间" prop="startTime">
          <el-date-picker clearable
            v-model="form.startTime"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择开课时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="结课时间" prop="endTime">
          <el-date-picker clearable
            v-model="form.endTime"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择结课时间">
          </el-date-picker>
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
import { listMyCourse, getMyCourse, delMyCourse, addMyCourse, updateMyCourse } from "@/api/course/myCourse"

export default {
  name: "MyCourse",
  dicts: ['course_difficulty', 'course_status'],
  data() {
    return {
      loading: true,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      myCourseList: [],
      title: "",
      open: false,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        cName: null,
        teacherName: null,
        difficulty: null,
        status: null,
      },
      form: {},
      rules: {
        cName: [
          { required: true, message: "课程名称不能为空", trigger: "blur" }
        ],
        teacherId: [
          { required: true, message: "授课教师ID不能为空", trigger: "blur" }
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
      listMyCourse(this.queryParams).then(response => {
        this.myCourseList = response.rows
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
        cId: null,
        cName: null,
        teacherName: null,
        teacherId: null,
        type: null,
        tag: null,
        difficulty: null,
        maxPerson: null,
        description: null,
        coverImage: null,
        status: "0",
        startTime: null,
        endTime: null,
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
      this.ids = selection.map(item => item.cId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加课程"
    },
    handleUpdate(row) {
      this.reset()
      const cId = row.cId || this.ids
      getMyCourse(cId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改课程"
      })
    },
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.cId != null) {
            updateMyCourse(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addMyCourse(this.form).then(response => {
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    handleDelete(row) {
      const cIds = row.cId || this.ids
      this.$modal.confirm('是否确认删除课程编号为"' + cIds + '"的数据项？').then(function() {
        return delMyCourse(cIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    handleExport() {
      this.download('course/myCourse/export', {
        ...this.queryParams
      }, `myCourse_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
