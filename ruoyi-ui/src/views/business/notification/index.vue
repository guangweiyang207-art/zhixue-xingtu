<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="发送者ID" prop="senderId">
        <el-input
          v-model="queryParams.senderId"
          placeholder="请输入发送者ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="通知标题" prop="title">
        <el-input
          v-model="queryParams.title"
          placeholder="请输入通知标题"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="优先级 1-普通 2-重要 3-紧急" prop="priority">
        <el-input
          v-model="queryParams.priority"
          placeholder="请输入优先级 1-普通 2-重要 3-紧急"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="是否置顶 0-否 1-是" prop="isTop">
        <el-input
          v-model="queryParams.isTop"
          placeholder="请输入是否置顶 0-否 1-是"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="发布时间" prop="publishTime">
        <el-date-picker clearable
          v-model="queryParams.publishTime"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择发布时间">
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
          v-hasPermi="['business:notification:add']"
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
          v-hasPermi="['business:notification:edit']"
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
          v-hasPermi="['business:notification:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['business:notification:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="notificationList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="通知ID" align="center" prop="notiId" />
      <el-table-column label="发送者ID" align="center" prop="senderId" />
      <el-table-column label="发送者类型 1-系统 2-教师 3-管理员" align="center" prop="senderType" />
      <el-table-column label="通知标题" align="center" prop="title" />
      <el-table-column label="通知内容" align="center" prop="content" />
      <el-table-column label="目标类型 1-全部 2-指定学生 3-指定班级" align="center" prop="targetType" />
      <el-table-column label="目标对象ID列表" align="center" prop="targetIds" />
      <el-table-column label="优先级 1-普通 2-重要 3-紧急" align="center" prop="priority" />
      <el-table-column label="是否置顶 0-否 1-是" align="center" prop="isTop" />
      <el-table-column label="状态 0-草稿 1-已发布 2-已撤回" align="center" prop="status" />
      <el-table-column label="发布时间" align="center" prop="publishTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.publishTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['business:notification:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['business:notification:remove']"
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

    <!-- 添加或修改通知模块对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="发送者ID" prop="senderId">
          <el-input v-model="form.senderId" placeholder="请输入发送者ID" />
        </el-form-item>
        <el-form-item label="通知标题" prop="title">
          <el-input v-model="form.title" placeholder="请输入通知标题" />
        </el-form-item>
        <el-form-item label="通知内容">
          <editor v-model="form.content" :min-height="192"/>
        </el-form-item>
        <el-form-item label="优先级 1-普通 2-重要 3-紧急" prop="priority">
          <el-input v-model="form.priority" placeholder="请输入优先级 1-普通 2-重要 3-紧急" />
        </el-form-item>
        <el-form-item label="是否置顶 0-否 1-是" prop="isTop">
          <el-input v-model="form.isTop" placeholder="请输入是否置顶 0-否 1-是" />
        </el-form-item>
        <el-form-item label="发布时间" prop="publishTime">
          <el-date-picker clearable
            v-model="form.publishTime"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择发布时间">
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
import { listNotification, getNotification, delNotification, addNotification, updateNotification } from "@/api/business/notification"

export default {
  name: "Notification",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 通知模块表格数据
      notificationList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        senderId: null,
        senderType: null,
        title: null,
        content: null,
        targetType: null,
        targetIds: null,
        priority: null,
        isTop: null,
        status: null,
        publishTime: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        title: [
          { required: true, message: "通知标题不能为空", trigger: "blur" }
        ],
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询通知模块列表 */
    getList() {
      this.loading = true
      listNotification(this.queryParams).then(response => {
        this.notificationList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    // 取消按钮
    cancel() {
      this.open = false
      this.reset()
    },
    // 表单重置
    reset() {
      this.form = {
        notiId: null,
        senderId: null,
        senderType: null,
        title: null,
        content: null,
        targetType: null,
        targetIds: null,
        priority: null,
        isTop: null,
        status: null,
        publishTime: null,
        createTime: null,
        updateTime: null
      }
      this.resetForm("form")
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm")
      this.handleQuery()
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.notiId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加通知模块"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const notiId = row.notiId || this.ids
      getNotification(notiId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改通知模块"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.notiId != null) {
            updateNotification(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addNotification(this.form).then(response => {
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const notiIds = row.notiId || this.ids
      this.$modal.confirm('是否确认删除通知模块编号为"' + notiIds + '"的数据项？').then(function() {
        return delNotification(notiIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('business/notification/export', {
        ...this.queryParams
      }, `notification_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
