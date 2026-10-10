<template>
  <div class="error-heatmap">
    <div class="heatmap-header">
      <svg-icon icon-class="chart" class-name="heatmap-icon" />
      <span class="heatmap-title">AI 错题分析分布</span>
      <span class="heatmap-subtitle">各知识点错题占比</span>
      <el-date-picker
        v-model="selectedDate"
        type="date"
        size="mini"
        value-format="yyyy-MM-dd"
        placeholder="选择日期"
        class="date-select"
        @change="fetchData"
      />
    </div>
    <div ref="heatmapChart" class="heatmap-chart" />
  </div>
</template>

<script>
import * as echarts from 'echarts'
import resize from './mixins/resize'
import { getErrorHeatmap } from '@/api/study/dashboard'

export default {
  name: 'ErrorHeatmap',
  mixins: [resize],
  props: {
    width: { type: String, default: '100%' },
    height: { type: String, default: '280px' }
  },
  data() {
    return {
      chart: null,
      selectedDate: this.getToday(),
      pieData: []
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
    getToday() {
      const d = new Date()
      const year = d.getFullYear()
      const month = String(d.getMonth() + 1).padStart(2, '0')
      const day = String(d.getDate()).padStart(2, '0')
      return `${year}-${month}-${day}`
    },
    fetchData() {
      getErrorHeatmap(this.selectedDate).then(res => {
        const list = res.data || []
        const tagMap = {}
        list.forEach(item => {
          if (tagMap[item.tag]) {
            tagMap[item.tag] += item.errorCount
          } else {
            tagMap[item.tag] = item.errorCount
          }
        })
        this.pieData = Object.keys(tagMap).map(tag => ({
          name: tag,
          value: tagMap[tag]
        })).sort((a, b) => b.value - a.value)
        this.initChart()
      })
    },
    initChart() {
      if (this.chart) this.chart.dispose()
      this.chart = echarts.init(this.$refs.heatmapChart)

      const colors = ['#5470c6', '#91cc75', '#fac858', '#ee6666', '#73c0de', '#3ba272', '#fc8452', '#9a60b4', '#ea7ccc']

      this.chart.setOption({
        tooltip: {
          trigger: 'item',
          formatter: '{b}: {c} ({d}%)'
        },
        legend: {
          type: 'scroll',
          orient: 'vertical',
          right: 10,
          top: 20,
          bottom: 20,
          textStyle: { fontSize: 11 }
        },
        series: [
          {
            name: '错题分布',
            type: 'pie',
            radius: ['40%', '70%'],
            center: ['40%', '50%'],
            avoidLabelOverlap: false,
            itemStyle: {
              borderRadius: 6,
              borderColor: '#fff',
              borderWidth: 2
            },
            label: {
              show: false
            },
            emphasis: {
              label: {
                show: true,
                fontSize: 14,
                fontWeight: 'bold'
              },
              itemStyle: {
                shadowBlur: 10,
                shadowOffsetX: 0,
                shadowColor: 'rgba(0, 0, 0, 0.5)'
              }
            },
            labelLine: {
              show: false
            },
            data: this.pieData,
            color: colors
          }
        ]
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.error-heatmap {
  background: #fff;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);

  .heatmap-header {
    display: flex;
    align-items: center;
    margin-bottom: 12px;
    flex-wrap: wrap;

    .heatmap-icon {
      font-size: 20px;
      color: #E6A23C;
      margin-right: 8px;
    }

    .heatmap-title {
      font-size: 16px;
      font-weight: 600;
      color: #303133;
      margin-right: 8px;
    }

    .heatmap-subtitle {
      font-size: 12px;
      color: #909399;
      flex: 1;
    }

    .date-select {
      width: 150px;
    }
  }

  .heatmap-chart {
    width: 100%;
    height: 280px;
  }
}
</style>
