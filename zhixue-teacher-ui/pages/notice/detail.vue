<template>
  <view class="wrap">
    <view class="card">
      <view class="tag">系统通知</view>
      <view class="title">{{detail.title}}</view>
      <view class="content">{{detail.content}}</view>
    </view>
  </view>
</template>

<script>
export default {
  data() {
    return {
      detail: {}
    }
  },
  onLoad(options) {
    const id = Number(options.id)
    const list = [
      {
        id: 1,
        title: '课程审核通知',
        content: '您好，您提交的【初二数学平面几何】课程已通过平台审核，现已正式上线，学生可正常查看与学习。感谢您的辛勤付出！'
      },
      {
        id: 2,
        title: '作业提交提醒',
        content: '系统提醒：当前您有3份学生提交的作业待批改，请及时进入【任务管理】-【待批改作业】进行批阅。'
      },
      {
        id: 3,
        title: '平台功能更新',
        content: '平台已更新：新增批量导入学生、批量发布作业功能，提升教学管理效率，快去体验吧！'
      }
    ]
    this.detail = list.find(item => item.id === id) || list[0]
  }
}
</script>

<style scoped>
.wrap {
  background: #f5f7fa;
  min-height: 100vh;
  padding: 20rpx;
}
.card {
  background: #fff;
  border-radius: 20rpx;
  padding: 40rpx;
}
.tag {
  display: inline-block;
  background: #5151E20;
  color: #5151E5;
  font-size: 24rpx;
  padding: 6rpx 12rpx;
  border-radius: 8rpx;
  margin-bottom: 20rpx;
}
.title {
  font-size: 36rpx;
  font-weight: bold;
  color: #333;
  margin-bottom: 30rpx;
}
.content {
  font-size: 28rpx;
  color: #555;
  line-height: 1.6;
  white-space: pre-wrap;
}
</style>