<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="段位名称" prop="rankName">
        <el-input
          v-model="queryParams.rankName"
          placeholder="请输入段位名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
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
          v-hasPermi="['study:myRankConfig:add']"
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
          v-hasPermi="['study:myRankConfig:edit']"
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
          v-hasPermi="['study:myRankConfig:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['study:myRankConfig:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="myRankConfigList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="段位ID" align="center" prop="rankId" />
      <el-table-column label="段位名称" align="center" prop="rankName" />
      <el-table-column label="段位图标" align="center" prop="rankIcon" />
      <el-table-column label="最低积分" align="center" prop="minScore" />
      <el-table-column label="最高积分" align="center" prop="maxScore" />
      <el-table-column label="段位颜色" align="center" prop="color">
        <template slot-scope="scope">
          <span :style="{ color: scope.row.color }">{{ scope.row.color }}</span>
        </template>
      </el-table-column>
      <el-table-column label="段位描述" align="center" prop="description" show-overflow-tooltip />
      <el-table-column label="排序" align="center" prop="sortOrder" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['study:myRankConfig:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['study:myRankConfig:remove']"
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

    <!-- 添加或修改段位配置对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="段位名称" prop="rankName">
          <el-input v-model="form.rankName" placeholder="请输入段位名称" />
        </el-form-item>
        <el-form-item label="段位图标" prop="rankIcon">
          <el-input v-model="form.rankIcon" placeholder="请输入段位图标" />
        </el-form-item>
        <el-form-item label="最低积分" prop="minScore">
          <el-input v-model="form.minScore" placeholder="请输入最低积分" />
        </el-form-item>
        <el-form-item label="最高积分" prop="maxScore">
          <el-input v-model="form.maxScore" placeholder="请输入最高积分" />
        </el-form-item>
        <el-form-item label="段位颜色" prop="color">
          <el-input v-model="form.color" placeholder="请输入段位颜色" />
        </el-form-item>
        <el-form-item label="段位描述" prop="description">
          <el-input v-model="form.description" type="textarea" placeholder="请输入段位描述" />
        </el-form-item>
        <el-form-item label="排序" prop="sortOrder">
          <el-input v-model="form.sortOrder" placeholder="请输入排序" />
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
import { listMyRankConfig, getMyRankConfig, delMyRankConfig, addMyRankConfig, updateMyRankConfig } from "@/api/study/myRankConfig"

export default {
  name: "MyRankConfig",
  data() {
    return {
      loading: true,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      myRankConfigList: [],
      title: "",
      open: false,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        rankName: null,
      },
      form: {},
      rules: {
        rankName: [
          { required: true, message: "段位名称不能为空", trigger: "blur" }
        ],
        minScore: [
          { required: true, message: "最低积分不能为空", trigger: "blur" }
        ],
        maxScore: [
          { required: true, message: "最高积分不能为空", trigger: "blur" }
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
      listMyRankConfig(this.queryParams).then(response => {
        this.myRankConfigList = response.rows
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
        rankId: null,
        rankName: null,
        rankIcon: null,
        minScore: null,
        maxScore: null,
        color: null,
        description: null,
        sortOrder: null,
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
      this.ids = selection.map(item => item.rankId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加段位配置"
    },
    handleUpdate(row) {
      this.reset()
      const rankId = row.rankId || this.ids
      getMyRankConfig(rankId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改段位配置"
      })
    },
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.rankId != null) {
            updateMyRankConfig(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addMyRankConfig(this.form).then(response => {
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    handleDelete(row) {
      const rankIds = row.rankId || this.ids
      this.$modal.confirm('是否确认删除段位配置编号为"' + rankIds + '"的数据项？').then(function() {
        return delMyRankConfig(rankIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    handleExport() {
      this.download('study/myRankConfig/export', {
        ...this.queryParams
      }, `myRankConfig_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
