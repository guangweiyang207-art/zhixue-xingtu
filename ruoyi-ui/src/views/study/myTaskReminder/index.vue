<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="学生姓名" prop="studentName">
        <el-input
          v-model="queryParams.studentName"
          placeholder="请输入学生姓名"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="任务类型" prop="taskType">
        <el-select v-model="queryParams.taskType" placeholder="请选择任务类型" clearable>
          <el-option label="作业截止" value="1" />
          <el-option label="课程开始" value="2" />
          <el-option label="自定义" value="3" />
        </el-select>
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable>
          <el-option label="取消" value="0" />
          <el-option label="有效" value="1" />
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
          v-hasPermi="['study:myTaskReminder:add']"
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
          v-hasPermi="['study:myTaskReminder:edit']"
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
          v-hasPermi="['study:myTaskReminder:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['study:myTaskReminder:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="myTaskReminderList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="提醒ID" align="center" prop="trId" />
      <el-table-column label="学生姓名" align="center" prop="studentName" />
      <el-table-column label="任务类型" align="center" prop="taskType">
        <template slot-scope="scope">
          <span v-if="scope.row.taskType == 1">作业截止</span>
          <span v-else-if="scope.row.taskType == 2">课程开始</span>
          <span v-else-if="scope.row.taskType == 3">自定义</span>
          <span v-else>{{ scope.row.taskType }}</span>
        </template>
      </el-table-column>
      <el-table-column label="任务标题" align="center" prop="taskTitle" />
      <el-table-column label="任务内容" align="center" prop="taskContent" show-overflow-tooltip />
      <el-table-column label="提醒时间" align="center" prop="remindTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.remindTime, '{y}-{m}-{d} {h}:{i}:{s}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="重复类型" align="center" prop="repeatType">
        <template slot-scope="scope">
          <span v-if="scope.row.repeatType == 0">不重复</span>
          <span v-else-if="scope.row.repeatType == 1">每天</span>
          <span v-else-if="scope.row.repeatType == 2">每周</span>
          <span v-else-if="scope.row.repeatType == 3">每月</span>
          <span v-else>{{ scope.row.repeatType }}</span>
        </template>
      </el-table-column>
      <el-table-column label="是否已读" align="center" prop="isRead">
        <template slot-scope="scope">
          <span v-if="scope.row.isRead == 0">否</span>
          <span v-else-if="scope.row.isRead == 1">是</span>
          <span v-else>{{ scope.row.isRead }}</span>
        </template>
      </el-table-column>
      <el-table-column label="状态" align="center" prop="status">
        <template slot-scope="scope">
          <span v-if="scope.row.status == 0">取消</span>
          <span v-else-if="scope.row.status == 1">有效</span>
          <span v-else>{{ scope.row.status }}</span>
        </template>
      </el-table-column>
      <el-table-column label="关联ID" align="center" prop="relatedId" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['study:myTaskReminder:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['study:myTaskReminder:remove']"
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

    <!-- 添加或修改任务提醒对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="学生ID" prop="stuId">
          <el-input v-model="form.stuId" placeholder="请输入学生ID" />
        </el-form-item>
        <el-form-item label="任务类型" prop="taskType">
          <el-select v-model="form.taskType" placeholder="请选择任务类型">
            <el-option label="作业截止" value="1" />
            <el-option label="课程开始" value="2" />
            <el-option label="自定义" value="3" />
          </el-select>
        </el-form-item>
        <el-form-item label="任务标题" prop="taskTitle">
          <el-input v-model="form.taskTitle" placeholder="请输入任务标题" />
        </el-form-item>
        <el-form-item label="任务内容" prop="taskContent">
          <el-input v-model="form.taskContent" type="textarea" placeholder="请输入任务内容" />
        </el-form-item>
        <el-form-item label="提醒时间" prop="remindTime">
          <el-date-picker clearable
            v-model="form.remindTime"
            type="datetime"
            value-format="yyyy-MM-dd HH:mm:ss"
            placeholder="请选择提醒时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="重复类型" prop="repeatType">
          <el-select v-model="form.repeatType" placeholder="请选择重复类型">
            <el-option label="不重复" value="0" />
            <el-option label="每天" value="1" />
            <el-option label="每周" value="2" />
            <el-option label="每月" value="3" />
          </el-select>
        </el-form-item>
        <el-form-item label="是否已读" prop="isRead">
          <el-radio-group v-model="form.isRead">
            <el-radio label="0">否</el-radio>
            <el-radio label="1">是</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio label="0">取消</el-radio>
            <el-radio label="1">有效</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="关联ID" prop="relatedId">
          <el-input v-model="form.relatedId" placeholder="请输入关联ID" />
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
import { listMyTaskReminder, getMyTaskReminder, delMyTaskReminder, addMyTaskReminder, updateMyTaskReminder } from "@/api/study/myTaskReminder"

export default {
  name: "MyTaskReminder",
  dicts: ['task_type', 'repeat_type', 'yes_no', 'reminder_status'],
  data() {
    return {
      loading: true,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      myTaskReminderList: [],
      title: "",
      open: false,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        stuId: null,
        studentName: null,
        taskType: null,
        status: null,
      },
      form: {},
      rules: {
        stuId: [
          { required: true, message: "学生ID不能为空", trigger: "blur" }
        ],
        taskTitle: [
          { required: true, message: "任务标题不能为空", trigger: "blur" }
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
      listMyTaskReminder(this.queryParams).then(response => {
        this.myTaskReminderList = response.rows
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
        trId: null,
        stuId: null,
        taskType: null,
        taskTitle: null,
        taskContent: null,
        remindTime: null,
        repeatType: "0",
        isRead: "0",
        status: "1",
        relatedId: null,
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
      this.ids = selection.map(item => item.trId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加任务提醒"
    },
    handleUpdate(row) {
      this.reset()
      const trId = row.trId || this.ids
      getMyTaskReminder(trId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改任务提醒"
      })
    },
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.trId != null) {
            updateMyTaskReminder(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addMyTaskReminder(this.form).then(response => {
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    handleDelete(row) {
      const trIds = row.trId || this.ids
      this.$modal.confirm('是否确认删除任务提醒编号为"' + trIds + '"的数据项？').then(function() {
        return delMyTaskReminder(trIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    handleExport() {
      this.download('study/myTaskReminder/export', {
        ...this.queryParams
      }, `myTaskReminder_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
