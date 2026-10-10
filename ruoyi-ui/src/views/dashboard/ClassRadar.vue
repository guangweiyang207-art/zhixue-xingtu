<template>
  <div class="class-radar">
    <div class="radar-header">
      <svg-icon icon-class="chart" class-name="radar-icon" />
      <span class="radar-title">班级学情对比</span>
      <el-select v-model="selectedClass" size="mini" class="class-select" @change="initChart">
        <el-option v-for="item in classList" :key="item.className" :label="item.className" :value="item.className" />
      </el-select>
    </div>
    <div ref="radarChart" class="radar-chart" />
  </div>
</template>

<script>
import * as echarts from 'echarts'
import resize from './mixins/resize'
import { getClassRadar } from '@/api/study/dashboard'

export default {
  name: 'ClassRadar',
  mixins: [resize],
  data() {
    return {
      chart: null,
      classList: [],
      selectedClass: '',
      indicators: [
        { name: '平均正确率', max: 100 },
        { name: '平均学习时长', max: 100 },
        { name: '作业完成数', max: 100 },
        { name: '排名得分', max: 100 },
        { name: '总答题数', max: 100 }
      ]
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
      getClassRadar().then(res => {
        const list = res.data || []
        this.classList = list
        if (list.length > 0) {
          this.selectedClass = list[0].className
          this.initChart()
        }
      })
    },
    getClassRadarData() {
      const selected = this.classList.find(c => c.className === this.selectedClass)
      if (!selected) return { current: [0, 0, 0, 0, 0], average: [0, 0, 0, 0, 0] }

      const maxVals = this.indicators.map((ind, i) => {
        if (i === 0) return Math.max(...this.classList.map(c => Number(c.avgCorrectRate)), 1)
        if (i === 1) return Math.max(...this.classList.map(c => Number(c.avgStudyDuration)), 1)
        if (i === 2) return Math.max(...this.classList.map(c => Number(c.avgCompletedHomework)), 1)
        if (i === 3) return Math.max(...this.classList.map(c => Number(c.avgRankScore)), 1)
        return Math.max(...this.classList.map(c => Number(c.avgTotalQuestions)), 1)
      })

      const current = [
        Number(selected.avgCorrectRate) / maxVals[0] * 100,
        Number(selected.avgStudyDuration) / maxVals[1] * 100,
        Number(selected.avgCompletedHomework) / maxVals[2] * 100,
        Number(selected.avgRankScore) / maxVals[3] * 100,
        Number(selected.avgTotalQuestions) / maxVals[4] * 100
      ]

      const allAvg = [
        this.classList.reduce((s, c) => s + Number(c.avgCorrectRate), 0) / this.classList.length / maxVals[0] * 100,
        this.classList.reduce((s, c) => s + Number(c.avgStudyDuration), 0) / this.classList.length / maxVals[1] * 100,
        this.classList.reduce((s, c) => s + Number(c.avgCompletedHomework), 0) / this.classList.length / maxVals[2] * 100,
        this.classList.reduce((s, c) => s + Number(c.avgRankScore), 0) / this.classList.length / maxVals[3] * 100,
        this.classList.reduce((s, c) => s + Number(c.avgTotalQuestions), 0) / this.classList.length / maxVals[4] * 100
      ]

      return { current, average: allAvg }
    },
    initChart() {
      if (this.chart) this.chart.dispose()
      this.chart = echarts.init(this.$refs.radarChart)
      const classData = this.getClassRadarData()

      this.chart.setOption({
        tooltip: {
          trigger: 'item',
          formatter: p => {
            let res = `${p.seriesName}<br/>`
            p.value.forEach((v, i) => {
              res += `${this.indicators[i].name}: ${v.toFixed(1)}<br/>`
            })
            return res
          }
        },
        radar: {
          indicator: this.indicators,
          radius: '65%',
          center: ['50%', '55%'],
          axisName: { color: '#606266', fontSize: 11 },
          splitArea: {
            areaStyle: { color: ['rgba(64, 158, 255, 0.02)', 'rgba(64, 158, 255, 0.04)'] }
          }
        },
        series: [{
          type: 'radar',
          data: [
            {
              value: classData.current,
              name: this.selectedClass,
              areaStyle: { color: 'rgba(64, 158, 255, 0.2)' },
              lineStyle: { color: '#409EFF', width: 2 },
              itemStyle: { color: '#409EFF' }
            },
            {
              value: classData.average,
              name: '年级平均',
              areaStyle: { color: 'rgba(192, 196, 204, 0.15)' },
              lineStyle: { color: '#C0C4CC', width: 2, type: 'dashed' },
              itemStyle: { color: '#C0C4CC' }
            }
          ]
        }]
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.class-radar {
  background: #fff;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);

  .radar-header {
    display: flex;
    align-items: center;
    margin-bottom: 8px;

    .radar-icon {
      font-size: 20px;
      color: #67C23A;
      margin-right: 8px;
    }

    .radar-title {
      font-size: 16px;
      font-weight: 600;
      color: #303133;
      flex: 1;
    }

    .class-select {
      width: 120px;
    }
  }

  .radar-chart {
    width: 100%;
    height: 260px;
  }
}
</style>