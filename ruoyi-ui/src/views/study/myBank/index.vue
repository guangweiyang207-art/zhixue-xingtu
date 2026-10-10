<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="题库名称" prop="qbName">
        <el-input
          v-model="queryParams.qbName"
          placeholder="请输入题库名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="题库类型" prop="type">
        <el-select v-model="queryParams.type" placeholder="请选择题库类型" clearable>
          <el-option label="编程" value="编程" />
          <el-option label="算法" value="算法" />
          <el-option label="数学" value="数学" />
          <el-option label="英语" value="英语" />
        </el-select>
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
          <el-option label="禁用" value="0" />
          <el-option label="启用" value="1" />
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
          v-hasPermi="['study:myBank:add']"
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
          v-hasPermi="['study:myBank:edit']"
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
          v-hasPermi="['study:myBank:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['study:myBank:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="myBankList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="题库ID" align="center" prop="hbId" />
      <el-table-column label="题库名称" align="center" prop="qbName" />
      <el-table-column label="题库描述" align="center" prop="description" show-overflow-tooltip />
      <el-table-column label="题库类型" align="center" prop="type" />
      <el-table-column label="标签" align="center" prop="tag" />
      <el-table-column label="创建教师" align="center" prop="teacherName" />
      <el-table-column label="教师工号" align="center" prop="teacherNo" />
      <el-table-column label="题目数量" align="center" prop="questionCount" />
      <el-table-column label="总分" align="center" prop="totalScore" />
      <el-table-column label="难度" align="center" prop="difficulty">
        <template slot-scope="scope">
          <span v-if="scope.row.difficulty == 1">简单</span>
          <span v-else-if="scope.row.difficulty == 2">中等</span>
          <span v-else-if="scope.row.difficulty == 3">困难</span>
          <span v-else>{{ scope.row.difficulty }}</span>
        </template>
      </el-table-column>
      <el-table-column label="状态" align="center" prop="status">
        <template slot-scope="scope">
          <span v-if="scope.row.status == 0">禁用</span>
          <span v-else-if="scope.row.status == 1">启用</span>
          <span v-else>{{ scope.row.status }}</span>
        </template>
      </el-table-column>
      <el-table-column label="是否公开" align="center" prop="isPublic">
        <template slot-scope="scope">
          <span v-if="scope.row.isPublic == 0">私有</span>
          <span v-else-if="scope.row.isPublic == 1">公开</span>
          <span v-else>{{ scope.row.isPublic }}</span>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d} {h}:{i}:{s}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['study:myBank:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['study:myBank:remove']"
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

    <!-- 添加或修改题库对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="题库名称" prop="qbName">
          <el-input v-model="form.qbName" placeholder="请输入题库名称" />
        </el-form-item>
        <el-form-item label="题库描述" prop="description">
          <el-input v-model="form.description" type="textarea" placeholder="请输入题库描述" />
        </el-form-item>
        <el-form-item label="题库类型" prop="type">
          <el-select v-model="form.type" placeholder="请选择题库类型">
            <el-option label="编程" value="编程" />
            <el-option label="算法" value="算法" />
            <el-option label="数学" value="数学" />
            <el-option label="英语" value="英语" />
          </el-select>
        </el-form-item>
        <el-form-item label="标签" prop="tag">
          <el-input v-model="form.tag" placeholder="请输入标签，用逗号分隔" />
        </el-form-item>
        <el-form-item label="创建教师ID" prop="teacherId">
          <el-input v-model="form.teacherId" placeholder="请输入创建教师ID" />
        </el-form-item>
        <el-form-item label="难度" prop="difficulty">
          <el-radio-group v-model="form.difficulty">
            <el-radio label="1">简单</el-radio>
            <el-radio label="2">中等</el-radio>
            <el-radio label="3">困难</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio label="0">禁用</el-radio>
            <el-radio label="1">启用</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="是否公开" prop="isPublic">
          <el-radio-group v-model="form.isPublic">
            <el-radio label="0">私有</el-radio>
            <el-radio label="1">公开</el-radio>
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
import { listMyBank, getMyBank, delMyBank, addMyBank, updateMyBank } from "@/api/study/myBank"

export default {
  name: "MyBank",
  data() {
    return {
      loading: true,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      myBankList: [],
      title: "",
      open: false,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        qbName: null,
        type: null,
        difficulty: null,
        status: null,
      },
      form: {},
      rules: {
        qbName: [
          { required: true, message: "题库名称不能为空", trigger: "blur" }
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
      listMyBank(this.queryParams).then(response => {
        this.myBankList = response.rows
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
        hbId: null,
        qbName: null,
        description: null,
        type: null,
        tag: null,
        teacherId: null,
        difficulty: "2",
        status: "1",
        isPublic: "0",
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
      this.ids = selection.map(item => item.hbId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加题库"
    },
    handleUpdate(row) {
      this.reset()
      const hbId = row.hbId || this.ids
      getMyBank(hbId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改题库"
      })
    },
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.hbId != null) {
            updateMyBank(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addMyBank(this.form).then(response => {
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    handleDelete(row) {
      const hbIds = row.hbId || this.ids
      this.$modal.confirm('是否确认删除题库编号为"' + hbIds + '"的数据项？').then(function() {
        return delMyBank(hbIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    handleExport() {
      this.download('study/myBank/export', {
        ...this.queryParams
      }, `myBank_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
