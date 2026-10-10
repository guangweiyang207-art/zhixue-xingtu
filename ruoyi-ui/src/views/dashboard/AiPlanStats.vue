<template>
  <div class="ai-plan-stats">
    <div class="stats-header">
      <svg-icon icon-class="ai" class-name="stats-icon" />
      <span class="stats-title">平台数据总览</span>
    </div>
    <el-row :gutter="16">
      <el-col :span="8">
        <div class="stat-card total-card">
          <div class="stat-label">学生总数</div>
          <div class="stat-value">
            <count-to :start-val="0" :end-val="totalStudents" :duration="3000" />
          </div>
        </div>
      </el-col>
      <el-col :span="8">
        <div class="stat-card today-card">
          <div class="stat-label">教师总数</div>
          <div class="stat-value">
            <count-to :start-val="0" :end-val="totalTeachers" :duration="3000" />
          </div>
        </div>
      </el-col>
      <el-col :span="8">
        <div class="stat-card course-card">
          <div class="stat-label">课程总数</div>
          <div class="stat-value">
            <count-to :start-val="0" :end-val="totalCourses" :duration="3000" />
          </div>
        </div>
      </el-col>
    </el-row>
    <el-row :gutter="16" style="margin-top: 12px;">
      <el-col :span="8">
        <div class="stat-card homework-card">
          <div class="stat-label">作业总数</div>
          <div class="stat-value">
            <count-to :start-val="0" :end-val="totalHomework" :duration="3000" />
          </div>
        </div>
      </el-col>
      <el-col :span="8">
        <div class="stat-card study-card">
          <div class="stat-label">今日学习人数</div>
          <div class="stat-value">
            <count-to :start-val="0" :end-val="todayStudyCount" :duration="3000" />
          </div>
        </div>
      </el-col>
      <el-col :span="8">
        <div class="stat-card error-card">
          <div class="stat-label">待解决错题数</div>
          <div class="stat-value">
            <count-to :start-val="0" :end-val="totalErrorQuestions" :duration="3000" />
          </div>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import CountTo from 'vue-count-to'
import { getPlatformOverview } from '@/api/study/dashboard'

export default {
  name: 'AiPlanStats',
  components: { CountTo },
  data() {
    return {
      totalStudents: 0,
      totalTeachers: 0,
      totalCourses: 0,
      totalHomework: 0,
      todayStudyCount: 0,
      totalErrorQuestions: 0
    }
  },
  created() {
    this.fetchData()
  },
  methods: {
    fetchData() {
      getPlatformOverview().then(res => {
        const data = res.data
        this.totalStudents = data.totalStudents || 0
        this.totalTeachers = data.totalTeachers || 0
        this.totalCourses = data.totalCourses || 0
        this.totalHomework = data.totalHomework || 0
        this.todayStudyCount = data.todayStudyCount || 0
        this.totalErrorQuestions = data.totalErrorQuestions || 0
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.ai-plan-stats {
  background: #fff;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);

  .stats-header {
    display: flex;
    align-items: center;
    margin-bottom: 20px;

    .stats-icon {
      font-size: 22px;
      color: #409EFF;
      margin-right: 8px;
    }

    .stats-title {
      font-size: 16px;
      font-weight: 600;
      color: #303133;
    }
  }

  .stat-card {
    background: linear-gradient(135deg, #f5f7fa 0%, #e8ecf1 100%);
    border-radius: 8px;
    padding: 16px;
    text-align: center;
    transition: transform 0.3s;

    &:hover {
      transform: translateY(-2px);
    }

    .stat-label {
      font-size: 13px;
      color: #909399;
      margin-bottom: 8px;
    }

    .stat-value {
      font-size: 32px;
      font-weight: 700;
      color: #303133;
      margin-bottom: 6px;
    }

    .stat-trend {
      font-size: 12px;

      .trend-up {
        color: #67C23A;
      }

      .trend-down {
        color: #F56C6C;
      }
    }
  }

  .total-card {
    background: linear-gradient(135deg, #eef6ff 0%, #dceaff 100%);
    .stat-value { color: #409EFF; }
  }

  .today-card {
    background: linear-gradient(135deg, #f0f9eb 0%, #e1f3d8 100%);
    .stat-value { color: #67C23A; }
  }

  .course-card {
    background: linear-gradient(135deg, #fdf6ec 0%, #faecd8 100%);
    .stat-value { color: #E6A23C; }
  }

  .homework-card {
    background: linear-gradient(135deg, #fef0f0 0%, #fde2e2 100%);
    .stat-value { color: #F56C6C; }
  }

  .study-card {
    background: linear-gradient(135deg, #f0f5ff 0%, #dce8ff 100%);
    .stat-value { color: #909399; }
  }

  .error-card {
    background: linear-gradient(135deg, #f5f0ff 0%, #e8dcff 100%);
    .stat-value { color: #722ed1; }
  }
}
</style>