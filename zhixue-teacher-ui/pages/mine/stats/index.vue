<template>
  <view class="stats-page">
    <view class="page-header">
      <text class="page-title">教学统计</text>
    </view>

    <!-- 概览数字:课程数 / 学生数 / 活跃学生 -->
    <view class="overview-cards">
      <view class="overview-card total">
        <text class="card-value">{{ stats.totalCourses || 0 }}</text>
        <text class="card-label">我发布的课程</text>
      </view>
      <view class="overview-card students">
        <text class="card-value">{{ stats.totalStudents || 0 }}</text>
        <text class="card-label">报我课学生</text>
      </view>
    </view>

    <view class="overview-cards">
      <view class="overview-card active">
        <text class="card-value">{{ stats.activeStudents || 0 }}</text>
        <text class="card-label">近 7 天活跃学生</text>
      </view>
      <view class="overview-card pending">
        <text class="card-value">{{ stats.pendingHomeworks || 0 }}</text>
        <text class="card-label">待批改作业</text>
      </view>
    </view>

    <!-- 详情卡片 -->
    <view class="stats-list">
      <view class="stats-card">
        <view class="stats-header">
          <view class="stats-icon course">
            <text class="iconfont">📚</text>
          </view>
          <view class="stats-info">
            <text class="stats-title">课程</text>
            <text class="stats-desc">我发布的课程</text>
          </view>
        </view>
        <view class="stats-body">
          <view class="stats-item">
            <view class="stats-item-left">
              <text class="stats-item-label">课程总数</text>
              <text class="stats-item-value blue">{{ stats.totalCourses || 0 }}</text>
            </view>
            <view class="stats-item-right">
              <text class="stats-item-label">通知/公告</text>
              <text class="stats-item-value">{{ stats.totalNotices || 0 }}</text>
            </view>
          </view>
        </view>
      </view>

      <view class="stats-card">
        <view class="stats-header">
          <view class="stats-icon student">
            <text class="iconfont">👥</text>
          </view>
          <view class="stats-info">
            <text class="stats-title">学情</text>
            <text class="stats-desc">学生规模与活跃度</text>
          </view>
        </view>
        <view class="stats-body">
          <view class="stats-item">
            <view class="stats-item-left">
              <text class="stats-item-label">报我课学生</text>
              <text class="stats-item-value green">{{ stats.totalStudents || 0 }}</text>
            </view>
            <view class="stats-item-right">
              <text class="stats-item-label">近 7 天活跃</text>
              <text class="stats-item-value orange">{{ stats.activeStudents || 0 }}</text>
            </view>
          </view>
          <view class="active-bar" v-if="stats.totalStudents > 0">
            <view class="active-bar-inner"
                  :style="{ width: activeRatio + '%' }"></view>
            <text class="active-bar-text">活跃率 {{ activeRatio }}%</text>
          </view>
        </view>
      </view>

      <view class="stats-card">
        <view class="stats-header">
          <view class="stats-icon homework">
            <text class="iconfont">📝</text>
          </view>
          <view class="stats-info">
            <text class="stats-title">作业</text>
            <text class="stats-desc">作业发布与批改进度</text>
          </view>
        </view>
        <view class="stats-body">
          <view class="stats-item">
            <view class="stats-item-left">
              <text class="stats-item-label">已发布</text>
              <text class="stats-item-value green">{{ stats.totalHomeworks || 0 }}</text>
            </view>
            <view class="stats-item-right">
              <text class="stats-item-label">待批改</text>
              <text class="stats-item-value orange">{{ stats.pendingHomeworks || 0 }}</text>
            </view>
          </view>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
import { getTeacherStats } from '@/api/mine/stats'

export default {
  data() {
    return {
      stats: {
        totalCourses: 0,
        totalStudents: 0,
        activeStudents: 0,
        totalHomeworks: 0,
        pendingHomeworks: 0,
        totalNotices: 0
      }
    }
  },
  computed: {
    activeRatio() {
      if (!this.stats.totalStudents) return 0
      return Math.round((this.stats.activeStudents / this.stats.totalStudents) * 100)
    }
  },
  onLoad() { this.loadStats() },
  onShow() { this.loadStats() },
  onPullDownRefresh() {
    this.loadStats()
    uni.stopPullDownRefresh()
  },
  methods: {
    loadStats() {
      getTeacherStats().then(res => {
        this.stats = Object.assign({
          totalCourses: 0, totalStudents: 0, activeStudents: 0,
          totalHomeworks: 0, pendingHomeworks: 0, totalNotices: 0
        }, res.data || {})
      }).catch(() => {
        uni.showToast({ title: '获取统计失败', icon: 'none' })
      })
    }
  }
}
</script>

<style lang="scss" scoped>
page { background-color: #f5f6fa; }
.stats-page { padding: 0 24rpx 32rpx; }

.page-header { padding-top: 40rpx; padding-bottom: 24rpx; }
.page-title { font-size: 44rpx; font-weight: bold; color: #1a1a1a; }

.overview-cards {
  display: flex;
  flex-direction: row;
  gap: 20rpx;
  margin-bottom: 20rpx;
}

.overview-card {
  flex: 1;
  padding: 28rpx 20rpx;
  border-radius: 20rpx;
  display: flex;
  flex-direction: column;
  align-items: center;
  color: #fff;

  &.total    { background: linear-gradient(135deg, #5b5fc7 0%, #7b7fd4 100%); }
  &.students { background: linear-gradient(135deg, #3c96f3 0%, #6cb1f5 100%); }
  &.active   { background: linear-gradient(135deg, #ff9500 0%, #ffb347 100%); }
  &.pending  { background: linear-gradient(135deg, #ff4d4f 0%, #ff7875 100%); }
}

.card-value {
  font-size: 48rpx;
  font-weight: bold;
  margin-bottom: 6rpx;
}
.card-label { font-size: 24rpx; color: rgba(255,255,255,0.9); }

.stats-list {
  display: flex;
  flex-direction: column;
  gap: 20rpx;
}

.stats-card {
  background-color: #fff;
  border-radius: 20rpx;
  padding: 24rpx;
}

.stats-header {
  display: flex;
  flex-direction: row;
  align-items: center;
  margin-bottom: 20rpx;
  padding-bottom: 16rpx;
  border-bottom: 1rpx solid #f0f0f0;
}

.stats-icon {
  width: 64rpx;
  height: 64rpx;
  border-radius: 16rpx;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 16rpx;
  font-size: 32rpx;

  &.course   { background-color: #eef2ff; }
  &.student  { background-color: #e6f0ff; }
  &.homework { background-color: #e6f7ef; }
}

.stats-info { display: flex; flex-direction: column; gap: 4rpx; }
.stats-title { font-size: 30rpx; font-weight: bold; color: #1a1a1a; }
.stats-desc  { font-size: 24rpx; color: #999; }

.stats-body { display: flex; flex-direction: column; gap: 12rpx; }
.stats-item {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
}
.stats-item-left, .stats-item-right {
  display: flex;
  flex-direction: row;
  align-items: center;
  gap: 12rpx;
}
.stats-item-label { font-size: 26rpx; color: #999; }
.stats-item-value { font-size: 28rpx; font-weight: 600; color: #333;
  &.green  { color: #34c759; }
  &.blue   { color: #3c96f3; }
  &.orange { color: #ff9500; }
}

.active-bar {
  position: relative;
  height: 24rpx;
  background: #f0f0f0;
  border-radius: 12rpx;
  overflow: hidden;
  margin-top: 8rpx;
}
.active-bar-inner {
  position: absolute;
  left: 0; top: 0; bottom: 0;
  background: linear-gradient(90deg, #5b5fc7, #3c96f3);
  border-radius: 12rpx;
  transition: width 0.3s ease;
}
.active-bar-text {
  position: absolute;
  left: 0; right: 0; top: 50%;
  transform: translateY(-50%);
  text-align: center;
  font-size: 20rpx;
  color: #fff;
  font-weight: 600;
  text-shadow: 0 1rpx 2rpx rgba(0,0,0,0.2);
}
</style>
