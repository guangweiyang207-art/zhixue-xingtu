<template>
  <view class="page">
    <!-- 顶部标题栏 -->
    <view class="header">
      <view class="back-btn" @click="goBack">←</view>
      <text class="title">学习报告</text>
      <view style="width: 60rpx;"></view>
    </view>

    <!-- 统计卡片 -->
    <view class="stats-row">
      <view class="stat-card blue">
        <view class="stat-icon">⏱</view>
        <view class="stat-value">{{stats.studyHours || 0}}</view>
        <view class="stat-label">学习时长(小时)</view>
      </view>
      <view class="stat-card purple">
        <view class="stat-icon">📋</view>
        <view class="stat-value">{{stats.homeworkCount || 0}}</view>
        <view class="stat-label">完成作业(份)</view>
      </view>
      <view class="stat-card green">
        <view class="stat-icon">✓</view>
        <view class="stat-value">{{stats.correctRate || 0}}%</view>
        <view class="stat-label">正确率</view>
      </view>
    </view>

    <!-- 学习时长趋势 -->
    <view class="section-card">
      <view class="section-title">近7天学习动态（完成作业数）</view>
      <view class="chart-area">
        <view class="chart-bar-wrap" v-for="(day, idx) in weekData" :key="idx">
          <view class="chart-bar-bg">
            <view class="chart-bar" :style="{height: (day.value / maxWeekValue * 100) + '%'}"></view>
          </view>
          <text class="chart-label">{{day.label}}</text>
        </view>
      </view>
    </view>

    <!-- 各科掌握情况 -->
    <view class="section-card">
      <view class="section-title">各科掌握情况</view>
      <view class="subject-list">
        <view class="subject-item" v-for="(item, index) in subjectList" :key="index">
          <view class="subject-info">
            <text class="subject-name">{{item.name}}</text>
            <text class="subject-percent">{{item.percent}}%</text>
          </view>
          <view class="subject-progress-bg">
            <view class="subject-progress-bar" :style="{width: item.percent + '%', backgroundColor: item.color}"></view>
          </view>
        </view>
      </view>
    </view>

    <!-- 底部激励卡片 -->
    <view class="encourage-card">
      <view class="encourage-icon">🔥</view>
      <view class="encourage-text">你的努力，终有回响！</view>
      <view class="encourage-sub">本周学习时长排名上升，继续加油，下期更精彩！</view>
    </view>
  </view>
</template>

<script>
  import config from '@/config'

  const SUBJECT_COLORS = {math: '#6366f1', physics: '#f97316', english: '#dc2626', chemistry: '#ca8a04'};

  export default {
    data() {
      return {
        stats: {},
        weekData: [],
        subjectList: []
      }
    },
    computed: {
      maxWeekValue() {
        return Math.max(...this.weekData.map(d => d.value), 1);
      }
    },
    onLoad() {
      this.loadSummary();
    },
    methods: {
      loadSummary() {
        const stuId = uni.getStorageSync('userInfo')?.stu_id || 1;
        uni.request({
          url: config.baseUrl + '/mine/study/reportSummary',
          data: {stu_id: stuId},
          success: res => {
            const data = res.data && res.data.data ? res.data.data : null;
            if (data) {
              const durationMin = data.studyDuration || 0;
              this.stats = {
                studyHours: (durationMin / 60).toFixed(1),
                homeworkCount: data.completedHomework || 0,
                correctRate: data.correctRate || 0
              };
              // 近7天趋势
              this.weekData = (data.weekTrend || []).map(d => ({label: d.label, value: d.value || 0}));
              // 各科掌握情况
              this.subjectList = (data.subjects || []).map(s => ({
                name: s.name,
                percent: s.percent || 0,
                color: SUBJECT_COLORS[s.type] || '#6366f1'
              }));
            }
          },
          fail: err => {
            console.error('学习报告统计请求失败：', err);
            uni.showToast({title: '加载失败', icon: 'none'});
          }
        });
      },
      goBack() {
        uni.navigateBack();
      }
    }
  }
</script>

<style scoped>
	.page-container {
	  /* 给最外层容器增加顶部外边距，实现整体下移 */
	  margin-top: 100rpx; 
	}
  page {
    background-color: #f6f7fb;
  }

  .page {
    min-height: 100vh;
    padding-bottom: 40rpx;
  }

  .header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-top: var(--status-bar-height);
    padding-left: 28rpx;
    padding-right: 28rpx;
    padding-bottom: 22rpx;
    background: #fff;
  }

  .back-btn {
    font-size: 44rpx;
    color: #1f2937;
    line-height: 1;
    width: 60rpx;
  }

  .title {
    font-size: 36rpx;
    font-weight: 700;
    color: #1f2937;
    flex: 1;
    text-align: center;
  }

  .stats-row {
    display: flex;
    gap: 16rpx;
    padding: 20rpx 28rpx;
    background: #fff;
  }

  .stat-card {
    flex: 1;
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 24rpx 16rpx;
    border-radius: 20rpx;
    background: #f8fafc;
  }

  .stat-card.blue {
    background: #eff6ff;
  }

  .stat-card.purple {
    background: #faf5ff;
  }

  .stat-card.green {
    background: #f0fdf4;
  }

  .stat-icon {
    font-size: 40rpx;
    margin-bottom: 8rpx;
  }

  .stat-value {
    font-size: 36rpx;
    font-weight: 700;
    color: #1f2937;
    margin-bottom: 4rpx;
  }

  .stat-label {
    font-size: 22rpx;
    color: #9ca3af;
  }

  .section-card {
    margin: 18rpx 28rpx 0;
    padding: 26rpx;
    background: #fff;
    border-radius: 28rpx;
  }

  .section-title {
    font-size: 30rpx;
    font-weight: 700;
    color: #1f2937;
    margin-bottom: 24rpx;
  }

  .chart-area {
    display: flex;
    justify-content: space-between;
    align-items: flex-end;
    height: 200rpx;
    padding: 0 10rpx;
  }

  .chart-bar-wrap {
    display: flex;
    flex-direction: column;
    align-items: center;
    flex: 1;
  }

  .chart-bar-bg {
    width: 32rpx;
    height: 160rpx;
    background: #f3f4f6;
    border-radius: 16rpx;
    overflow: hidden;
    display: flex;
    align-items: flex-end;
  }

  .chart-bar {
    width: 100%;
    background: linear-gradient(to top, #8b5cf6, #a78bfa);
    border-radius: 16rpx;
    transition: height 0.5s ease;
  }

  .chart-label {
    font-size: 22rpx;
    color: #9ca3af;
    margin-top: 12rpx;
  }

  .subject-list {
    display: flex;
    flex-direction: column;
    gap: 20rpx;
  }

  .subject-item {}

  .subject-info {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 10rpx;
  }

  .subject-name {
    font-size: 26rpx;
    color: #374151;
  }

  .subject-percent {
    font-size: 24rpx;
    color: #6b7280;
  }

  .subject-progress-bg {
    height: 16rpx;
    background: #f3f4f6;
    border-radius: 999rpx;
    overflow: hidden;
  }

  .subject-progress-bar {
    height: 100%;
    border-radius: 999rpx;
    transition: width 0.5s ease;
  }

  .encourage-card {
    margin: 18rpx 28rpx 0;
    padding: 32rpx;
    background: linear-gradient(135deg, #8b5cf6, #7c3aed);
    border-radius: 28rpx;
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
  }

  .encourage-icon {
    font-size: 48rpx;
    margin-bottom: 12rpx;
  }

  .encourage-text {
    font-size: 30rpx;
    font-weight: 700;
    color: #fff;
    margin-bottom: 8rpx;
  }

  .encourage-sub {
    font-size: 24rpx;
    color: rgba(255, 255, 255, 0.8);
  }
</style>
