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
      <el-form-item label="课程ID" prop="cId">
        <el-input
          v-model="queryParams.cId"
          placeholder="请输入课程ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="标签" prop="tag">
        <el-input
          v-model="queryParams.tag"
          placeholder="请输入标签/知识点"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="是否已掌握" prop="isMastered">
        <el-select v-model="queryParams.isMastered" placeholder="请选择" clearable>
          <el-option label="否" value="0" />
          <el-option label="是" value="1" />
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
          v-hasPermi="['study:myErrorBook:add']"
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
          v-hasPermi="['study:myErrorBook:edit']"
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
          v-hasPermi="['study:myErrorBook:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['study:myErrorBook:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="myErrorBookList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="记录ID" align="center" prop="ebId" />
      <el-table-column label="学生ID" align="center" prop="stuId" />
      <el-table-column label="题目ID" align="center" prop="hqId" />
      <el-table-column label="课程ID" align="center" prop="cId" />
      <el-table-column label="错误答案" align="center" prop="wrongAnswer" show-overflow-tooltip />
      <el-table-column label="正确答案" align="center" prop="correctAnswer" show-overflow-tooltip />
      <el-table-column label="解析" align="center" prop="analysis" show-overflow-tooltip />
      <el-table-column label="标签/知识点" align="center" prop="tag" />
      <el-table-column label="错误次数" align="center" prop="errorCount" />
      <el-table-column label="是否已掌握" align="center" prop="isMastered">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.yes_no" :value="scope.row.isMastered"/>
        </template>
      </el-table-column>
      <el-table-column label="最后错误时间" align="center" prop="lastWrongTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.lastWrongTime, '{y}-{m}-{d} {h}:{i}:{s}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['study:myErrorBook:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['study:myErrorBook:remove']"
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

    <!-- 添加或修改错题本对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="学生ID" prop="stuId">
          <el-input v-model="form.stuId" placeholder="请输入学生ID" />
        </el-form-item>
        <el-form-item label="题目ID" prop="hqId">
          <el-input v-model="form.hqId" placeholder="请输入题目ID" />
        </el-form-item>
        <el-form-item label="课程ID" prop="cId">
          <el-input v-model="form.cId" placeholder="请输入课程ID" />
        </el-form-item>
        <el-form-item label="错误答案" prop="wrongAnswer">
          <el-input v-model="form.wrongAnswer" placeholder="请输入错误答案" />
        </el-form-item>
        <el-form-item label="正确答案" prop="correctAnswer">
          <el-input v-model="form.correctAnswer" placeholder="请输入正确答案" />
        </el-form-item>
        <el-form-item label="解析" prop="analysis">
          <el-input v-model="form.analysis" type="textarea" placeholder="请输入解析" />
        </el-form-item>
        <el-form-item label="标签/知识点" prop="tag">
          <el-input v-model="form.tag" placeholder="请输入标签/知识点" />
        </el-form-item>
        <el-form-item label="错误次数" prop="errorCount">
          <el-input v-model="form.errorCount" placeholder="请输入错误次数" />
        </el-form-item>
        <el-form-item label="是否已掌握" prop="isMastered">
          <el-radio-group v-model="form.isMastered">
            <el-radio label="0">否</el-radio>
            <el-radio label="1">是</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="最后错误时间" prop="lastWrongTime">
          <el-date-picker clearable
            v-model="form.lastWrongTime"
            type="datetime"
            value-format="yyyy-MM-dd HH:mm:ss"
            placeholder="请选择最后错误时间">
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
import { listMyErrorBook, getMyErrorBook, delMyErrorBook, addMyErrorBook, updateMyErrorBook } from "@/api/study/myErrorBook"

export default {
  name: "MyErrorBook",
  dicts: ['yes_no'],
  data() {
    return {
      loading: true,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      myErrorBookList: [],
      title: "",
      open: false,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        stuId: null,
        cId: null,
        tag: null,
        isMastered: null,
      },
      form: {},
      rules: {
        stuId: [
          { required: true, message: "学生ID不能为空", trigger: "blur" }
        ],
        hqId: [
          { required: true, message: "题目ID不能为空", trigger: "blur" }
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
      listMyErrorBook(this.queryParams).then(response => {
        this.myErrorBookList = response.rows
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
        ebId: null,
        stuId: null,
        hqId: null,
        cId: null,
        wrongAnswer: null,
        correctAnswer: null,
        analysis: null,
        tag: null,
        errorCount: null,
        isMastered: "0",
        lastWrongTime: null,
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
      this.ids = selection.map(item => item.ebId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加错题本"
    },
    handleUpdate(row) {
      this.reset()
      const ebId = row.ebId || this.ids
      getMyErrorBook(ebId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改错题本"
      })
    },
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.ebId != null) {
            updateMyErrorBook(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addMyErrorBook(this.form).then(response => {
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    handleDelete(row) {
      const ebIds = row.ebId || this.ids
      this.$modal.confirm('是否确认删除错题本编号为"' + ebIds + '"的数据项？').then(function() {
        return delMyErrorBook(ebIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    handleExport() {
      this.download('study/myErrorBook/export', {
        ...this.queryParams
      }, `myErrorBook_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
