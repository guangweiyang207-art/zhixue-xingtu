<template>
  <div class="activity-ring">
    <div class="ring-header">
      <svg-icon icon-class="peoples" class-name="ring-icon" />
      <span class="ring-title">学生 / 教师活跃度</span>
      <el-radio-group v-model="activePeriod" size="mini" @change="initChart">
        <el-radio-button label="week">本周</el-radio-button>
        <el-radio-button label="month">本月</el-radio-button>
      </el-radio-group>
    </div>
    <div ref="ringChart" class="ring-chart" />
    <div class="ring-stats">
      <div class="stat-item">
        <span class="dot student-dot" />
        <span class="stat-label">学生活跃</span>
        <span class="stat-value">{{ studentActive }}人</span>
        <span class="stat-rate">{{ studentRate }}%</span>
      </div>
      <div class="stat-item">
        <span class="dot teacher-dot" />
        <span class="stat-label">教师活跃</span>
        <span class="stat-value">{{ teacherActive }}人</span>
        <span class="stat-rate">{{ teacherRate }}%</span>
      </div>
    </div>
  </div>
</template>

<script>
import * as echarts from 'echarts'
import resize from './mixins/resize'
import { getActivityRing } from '@/api/study/dashboard'

export default {
  name: 'ActivityRing',
  mixins: [resize],
  data() {
    return {
      chart: null,
      activePeriod: 'week',
      studentActive: 0,
      teacherActive: 0,
      studentRate: 0,
      teacherRate: 0
    }
  },
  mounted() {
    this.$nextTick(() => this.fetchData())
  },
  beforeDestroy() {
    if (this.chart) {
      this.chart.dispose()
      this.chart = null
    }
  },
  methods: {
    fetchData() {
      getActivityRing(this.activePeriod).then(res => {
        const data = res.data || {}
        this.studentActive = data.activeStudents || 0
        this.teacherActive = data.activeTeachers || 0
        const totalStudents = data.totalStudents || 1
        const totalTeachers = data.totalTeachers || 1
        this.studentRate = Math.round((this.studentActive / totalStudents) * 100)
        this.teacherRate = Math.round((this.teacherActive / totalTeachers) * 100)
        this.initChart()
      })
    },
    initChart() {
      if (this.chart) this.chart.dispose()
      this.chart = echarts.init(this.$refs.ringChart)

      this.chart.setOption({
        tooltip: {
          trigger: 'item',
          formatter: '{b}: {c}人 ({d}%)'
        },
        series: [{
          type: 'pie',
          radius: ['55%', '75%'],
          avoidLabelOverlap: false,
          center: ['50%', '50%'],
          label: {
            show: true,
            position: 'center',
            formatter: () => `活跃用户\n${this.studentActive + this.teacherActive}人`,
            fontSize: 13,
            fontWeight: 600,
            color: '#303133',
            lineHeight: 22
          },
          emphasis: {
            label: { show: true, fontSize: 14, fontWeight: 'bold' },
            itemStyle: { shadowBlur: 10, shadowOffsetX: 0, shadowColor: 'rgba(0, 0, 0, 0.2)' }
          },
          data: [
            { value: this.studentActive, name: '学生', itemStyle: { color: '#409EFF' } },
            { value: this.teacherActive, name: '教师', itemStyle: { color: '#67C23A' } }
          ],
          animationDuration: 2000
        }]
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.activity-ring {
  background: #fff;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);

  .ring-header {
    display: flex;
    align-items: center;
    margin-bottom: 8px;

    .ring-icon {
      font-size: 20px;
      color: #409EFF;
      margin-right: 8px;
    }

    .ring-title {
      font-size: 16px;
      font-weight: 600;
      color: #303133;
      flex: 1;
    }
  }

  .ring-chart {
    width: 100%;
    height: 200px;
  }

  .ring-stats {
    display: flex;
    justify-content: space-around;
    padding: 0 16px;

    .stat-item {
      display: flex;
      align-items: center;
      flex-wrap: wrap;
      gap: 4px;

      .dot {
        width: 8px;
        height: 8px;
        border-radius: 50%;
      }

      .student-dot { background: #409EFF; }
      .teacher-dot { background: #67C23A; }

      .stat-label {
        font-size: 12px;
        color: #909399;
      }

      .stat-value {
        font-size: 14px;
        font-weight: 600;
        color: #303133;
        margin-left: 4px;
      }

      .stat-rate {
        font-size: 12px;
        color: #67C23A;
        background: #f0f9eb;
        padding: 0 6px;
        border-radius: 4px;
      }
    }
  }
}
</style>