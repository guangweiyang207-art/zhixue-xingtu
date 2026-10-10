<template>
  <view class="container">
    <view v-if="homeworkList.length === 0" class="empty">暂无待批改作业</view>
    <view class="card" v-for="item in homeworkList" :key="item.id">
      <view class="title">{{ item.title || item.homeworkName || '未命名作业' }}</view>
      <view class="desc">提交时间：{{ item.submitTime || item.createTime || item.time || '-' }}</view>
      <view class="desc" v-if="item.studentName">学生：{{ item.studentName }}</view>
      <button class="btn" @click="goCorrect(item.id)">批改作业</button>
    </view>
  </view>
</template>

<script>
import request from '@/utils/request'
export default {
  data() {
    return {
      homeworkList: []
    }
  },
  onLoad() {
    this.getHomeworkList()
  },
  methods: {
    async getHomeworkList() {
      try {
        const res = await request({
          url: '/homework/list',
          method: 'GET'
        })
        if (res.code === 200) {
          this.homeworkList = res.data || []
        } else {
          uni.showToast({ title: '获取失败', icon: 'none' })
        }
      } catch (err) {
        uni.showToast({ title: '网络异常', icon: 'none' })
      }
    },
    goCorrect(id) {
      uni.navigateTo({ url: '/pages/todo/correct?id=' + id })
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

.empty {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 100rpx 32rpx;
  color: $uni-text-color-tertiary;
  font-size: 26rpx;
}
.empty::before {
  content: '·';
  font-size: 60rpx;
  color: $uni-border-color-strong;
  line-height: 1;
  margin-bottom: 16rpx;
  letter-spacing: 6rpx;
}

.card {
  background: $uni-bg-color;
  border-radius: $uni-radius-lg;
  padding: 28rpx;
  margin-bottom: 20rpx;
  box-shadow: $uni-shadow-sm;
  border-left: 6rpx solid $uni-color-primary;
  position: relative;
  overflow: hidden;
}
.title {
  font-size: 30rpx;
  font-weight: $uni-font-weight-semibold;
  color: $uni-text-color;
  margin-bottom: 12rpx;
  letter-spacing: 0.3rpx;
}
.desc {
  font-size: 24rpx;
  color: $uni-text-color-tertiary;
  margin-bottom: 20rpx;
  line-height: 1.5;
}
.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  height: 64rpx;
  padding: 0 28rpx;
  background: $uni-color-primary;
  color: $uni-text-color-inverse;
  border-radius: $uni-radius-sm;
  font-size: 24rpx;
  font-weight: $uni-font-weight-medium;
  border: none;
  box-shadow: 0 2rpx 6rpx rgba(30, 58, 95, 0.15);
}
.btn::after { border: none; }
.btn:active { background: $uni-color-primary-press; }
</style>
