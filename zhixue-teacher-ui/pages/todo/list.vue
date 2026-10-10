<template>
  <view class="container">
    <view class="section-title">全部待办</view>
    <view class="card" v-for="item in allTodo" :key="item.id">
      <view class="title">{{ item.title }}</view>
      <view class="type">{{ item.type === 'homework' ? '作业' : '问题' }}</view>
    </view>
  </view>
</template>

<script>
export default {
  data() {
    return {
      allTodo: [
        { id: 1, title: '初二数学作业', type: 'homework' },
        { id: 2, title: '二次函数图像问题', type: 'question' }
      ]
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
.section-title {
  display: flex;
  align-items: center;
  font-size: 32rpx;
  font-weight: $uni-font-weight-semibold;
  color: $uni-text-color;
  margin-bottom: 24rpx;
  letter-spacing: 0.5rpx;
  padding-left: 16rpx;
  position: relative;
}
.section-title::before {
  content: '';
  position: absolute;
  left: 0;
  top: 50%;
  transform: translateY(-50%);
  width: 6rpx;
  height: 26rpx;
  background: $uni-color-primary;
  border-radius: 3rpx;
}
.card {
  background: $uni-bg-color;
  border-radius: $uni-radius-lg;
  padding: 28rpx;
  margin-bottom: 20rpx;
  box-shadow: $uni-shadow-sm;
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-left: 6rpx solid $uni-color-primary;
}
.title {
  font-size: 28rpx;
  font-weight: $uni-font-weight-medium;
  color: $uni-text-color;
  letter-spacing: 0.3rpx;
  flex: 1;
  min-width: 0;
}
.type {
  font-size: 22rpx;
  color: $uni-color-primary;
  background: $uni-color-primary-soft;
  padding: 6rpx 16rpx;
  border-radius: $uni-radius-full;
  flex-shrink: 0;
  margin-left: 16rpx;
}
</style>