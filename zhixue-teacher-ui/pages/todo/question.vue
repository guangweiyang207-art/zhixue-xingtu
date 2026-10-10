<template>
  <view class="container">
    <view class="page-header">
      <text class="page-title">待回答问题</text>
      <text class="page-count">共 {{ questionList.length }} 个</text>
    </view>

    <view v-if="loading" class="loading">加载中...</view>

    <view v-else-if="questionList.length === 0" class="empty">
      <view class="empty-icon">📭</view>
      <view class="empty-text">暂无待回答问题</view>
    </view>

    <view v-else>
      <view class="card" v-for="item in questionList" :key="item.id" @tap="goAnswer(item)">
        <view class="card-top">
          <image
            class="stu-avatar"
            :src="resolveAvatar(item.stuAvatar)"
            mode="aspectFill"
          />
          <view class="stu-info">
            <text class="stu-name">{{ item.stuName || '学生' }}</text>
            <text class="stu-meta">
              {{ item.stuNo ? '学号:' + item.stuNo : '' }}
              <text v-if="item.className">  ·  {{ item.className }}</text>
            </text>
          </view>
          <view class="status-tag">待回复</view>
        </view>
        <view class="card-question">
          <text class="q-label">问题:</text>
          <text class="q-text">{{ item.question }}</text>
        </view>
        <view class="card-bottom">
          <text class="time">{{ formatTime(item.createTime) }}</text>
          <view class="btn" @tap.stop="goAnswer(item)">回答问题</view>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
import { listTeacherInboxApi } from '../../api/system/questionAnswer.js'
import { getTeacherId } from '../../utils/auth.js'
import config from '@/config'

export default {
  data() {
    return {
      loading: true,
      questionList: [],
      teacherId: null,
      baseUrl: config.baseUrl,
      defaultAvatar: '/static/images/profile.jpg'
    }
  },
  onLoad() {
    this.teacherId = getTeacherId()
    this.getQuestionList()
  },
  onShow() {
    // 从详情页回复返回后刷新
    this.getQuestionList()
  },
  methods: {
    async getQuestionList() {
      this.loading = true
      try {
        const res = await listTeacherInboxApi({
          teacherId: this.teacherId,
          status: 0
        })
        if (res.code === 200) {
          this.questionList = res.data || []
        } else {
          uni.showToast({ title: res.msg || '获取失败', icon: 'none' })
        }
      } catch (err) {
        uni.showToast({ title: '网络异常', icon: 'none' })
      } finally {
        this.loading = false
      }
    },
    resolveAvatar(path) {
      if (!path) return this.defaultAvatar
      if (path.indexOf('http') === 0) return path
      return this.baseUrl + path
    },
    formatTime(t) {
      if (!t) return ''
      const d = new Date(t)
      if (isNaN(d.getTime())) return t
      const pad = n => String(n).padStart(2, '0')
      return `${d.getFullYear()}-${pad(d.getMonth()+1)}-${pad(d.getDate())} ${pad(d.getHours())}:${pad(d.getMinutes())}`
    },
    goAnswer(item) {
      uni.navigateTo({ url: '/pages/todo/answer?id=' + item.id })
    }
  }
}
</script>

<style lang="scss" scoped>
@import '@/static/scss/global.scss';

.container {
  min-height: 100vh;
  background-color: $uni-bg-color-page;
  padding: 24rpx 24rpx 40rpx;
  box-sizing: border-box;
}
.page-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 8rpx 4rpx 28rpx;
}
.page-title {
  font-size: 36rpx;
  font-weight: $uni-font-weight-bold;
  color: $uni-text-color;
  letter-spacing: 0.5rpx;
}
.page-count {
  font-size: 22rpx;
  color: $uni-color-primary;
  background: $uni-color-primary-soft;
  padding: 6rpx 18rpx;
  border-radius: $uni-radius-full;
  font-weight: $uni-font-weight-medium;
}
.loading, .empty {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 120rpx 32rpx;
  color: $uni-text-color-tertiary;
  font-size: 26rpx;
}
.empty-icon {
  width: 120rpx;
  height: 120rpx;
  border-radius: 50%;
  background: $uni-bg-color-alt;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 56rpx;
  margin-bottom: 20rpx;
}
.empty-text { font-size: 26rpx; color: $uni-text-color-tertiary; }

.card {
  background: $uni-bg-color;
  border-radius: $uni-radius-lg;
  padding: 28rpx 28rpx 24rpx;
  margin-bottom: 20rpx;
  box-shadow: $uni-shadow-sm;
  border-left: 6rpx solid $uni-color-accent;
}
.card-top {
  display: flex;
  align-items: center;
  margin-bottom: 20rpx;
}
.stu-avatar {
  width: 80rpx;
  height: 80rpx;
  border-radius: 50%;
  background: $uni-color-primary-soft;
  flex-shrink: 0;
  border: 1rpx solid $uni-border-color-light;
}
.stu-info {
  flex: 1;
  margin-left: 18rpx;
  display: flex;
  flex-direction: column;
  min-width: 0;
}
.stu-name {
  font-size: 30rpx;
  font-weight: $uni-font-weight-semibold;
  color: $uni-text-color;
  letter-spacing: 0.3rpx;
}
.stu-meta {
  font-size: 22rpx;
  color: $uni-text-color-tertiary;
  margin-top: 4rpx;
}
.status-tag {
  font-size: 22rpx;
  padding: 6rpx 16rpx;
  background: $uni-color-warning-soft;
  color: $uni-color-warning;
  border-radius: $uni-radius-full;
  font-weight: $uni-font-weight-medium;
  flex-shrink: 0;
}
.card-question {
  background: $uni-bg-color-alt;
  border-radius: $uni-radius-sm;
  padding: 20rpx;
  margin-bottom: 18rpx;
}
.q-label {
  font-size: 24rpx;
  color: $uni-text-color-tertiary;
  font-weight: $uni-font-weight-medium;
  margin-right: 8rpx;
}
.q-text {
  font-size: 28rpx;
  color: $uni-text-color;
  line-height: 1.6;
  word-break: break-all;
}
.card-bottom {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding-top: 4rpx;
}
.time {
  font-size: 22rpx;
  color: $uni-text-color-tertiary;
}
.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  height: 64rpx;
  padding: 0 28rpx;
  background: $uni-color-primary;
  color: $uni-text-color-inverse;
  border-radius: $uni-radius-md;
  font-size: 24rpx;
  font-weight: $uni-font-weight-medium;
  border: none;
  box-shadow: 0 2rpx 6rpx rgba(30, 58, 95, 0.15);
}
.btn::after { border: none; }
.btn:active { background: $uni-color-primary-press; }
</style>
