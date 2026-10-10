<template>
  <view class="page">
    <!-- 顶部导航栏 -->
    <view class="header">
      <view class="nav-bar">
        <uni-icons type="back" size="22" color="#333" @click="goBack" />
        <text class="title">全部作业</text>
        <view style="width: 22px;"></view>
      </view>
    </view>

    <!-- 作业列表 -->
    <scroll-view scroll-y class="list">
      <view
        v-for="(item, index) in homeworkList"
        :key="index"
        class="item"
      >
        <view class="top">
          <text class="name">{{ item.title }}</text>
          <text 
            class="status" 
            :class="{
              wait: item.status === 0,
              submit: item.status === 1,
              check: item.status === 2
            }"
          >
            {{ getStatusText(item.status) }}
          </text>
        </view>
        <view class="info">截止：{{ formatDate(item.deadline) }}</view>
        <view class="btn-box">
          <button
            v-if="item.status === 0"
            class="btn-do"
            @click="goDo(item)"
          >去完成</button>
          <view v-if="item.status === 1" class="btn-submit">已提交</view>
          <view v-if="item.status === 2" class="check-row">
            <text class="score">得分：{{ item.score || 0 }}分</text>
            <button class="btn-check" @click="goDo(item)">查看批改</button>
          </view>
        </view>
      </view>
      <view v-if="homeworkList.length === 0" class="empty-text">暂无作业</view>
    </scroll-view>
  </view>
</template>

<script>
  import { getStudentHomeworkList } from '@/api/system/index/index.js'

  export default {
    data() {
      return {
        homeworkList: []
      }
    },
    onLoad() {
      this.loadHomeworkList()
    },
    methods: {
      goBack() {
        uni.navigateBack()
      },
      getStatusText(status) {
        const map = { 0: '未完成', 1: '已提交', 2: '已批改' }
        return map[status] || '未完成'
      },
      formatDate(date) {
        if (!date) return ''
        // iOS 仅支持 "yyyy/MM/dd HH:mm:ss" 斜杠格式
        const safe = String(date).replace(/-/g, '/')
        const d = new Date(safe)
        if (isNaN(d.getTime())) return String(date)
        const month = d.getMonth() + 1
        const day = d.getDate()
        const hours = String(d.getHours()).padStart(2, '0')
        const minutes = String(d.getMinutes()).padStart(2, '0')
        return `${month}月${day}日 ${hours}:${minutes}`
      },
      loadHomeworkList() {
        getStudentHomeworkList().then(res => {
          const list = res && res.data ? res.data : []
          this.homeworkList = Array.isArray(list) ? list : []
        }).catch(err => {
          console.error('作业列表请求失败：', err)
        })
      },
      goDo(item) {
        uni.navigateTo({
          url: `/pages/homeworkdetail/homeworkdetail?id=${item.hwId}`
        })
      }
    }
  }
</script>

<style scoped>
  page {
    background-color: #f5f6f8;
  }
  .page {
    width: 100%;
    height: 100vh;
    display: flex;
    flex-direction: column;
  }
  .header {
    background: #fff;
    padding-top: calc(var(--status-bar-height) + 20rpx);
    padding-bottom: 20rpx;
    padding-left: 30rpx;
    padding-right: 30rpx;
  }
  .nav-bar {
    display: flex;
    align-items: center;
    justify-content: space-between;
  }
  .title {
    font-size: 36rpx;
    font-weight: 600;
    color: #222;
  }
  .list {
    flex: 1;
    padding: 20rpx 30rpx;
  }
  .item {
    background: #fff;
    border-radius: 20rpx;
    padding: 32rpx 28rpx;
    margin-bottom: 24rpx;
  }
  .top {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 12rpx;
  }
  .name {
    font-size: 32rpx;
    font-weight: 500;
    color: #111;
    flex: 1;
    margin-right: 20rpx;
  }
  .status {
    font-size: 24rpx;
    padding: 6rpx 16rpx;
    border-radius: 12rpx;
    white-space: nowrap;
  }
  .wait {
    background: #fff6cc;
    color: #cc9900;
  }
  .submit {
    background: #dcf8e8;
    color: #28a745;
  }
  .check {
    background: #e6f0ff;
    color: #3474d9;
  }
  .info {
    font-size: 26rpx;
    color: #999;
    margin-bottom: 20rpx;
  }
  .btn-box {
    display: flex;
    justify-content: flex-end;
    align-items: center;
  }
  .btn-do {
    margin: 0;
    padding: 0 32rpx;
    height: 64rpx;
    line-height: 64rpx;
    font-size: 26rpx;
    color: #fff;
    background: linear-gradient(90deg, #6B5AED, #8B7CF0);
    border-radius: 32rpx;
    border: none;
  }
  .btn-do::after {
    border: none;
  }
  .btn-submit {
    font-size: 26rpx;
    color: #28a745;
    background: #dcf8e8;
    padding: 10rpx 24rpx;
    border-radius: 24rpx;
  }
  .check-row {
    display: flex;
    align-items: center;
    gap: 16rpx;
  }
  .score {
    font-size: 28rpx;
    color: #ff6b6b;
    font-weight: 600;
  }
  .btn-check {
    margin: 0;
    padding: 0 24rpx;
    height: 56rpx;
    line-height: 56rpx;
    font-size: 24rpx;
    color: #3474d9;
    background: #e6f0ff;
    border-radius: 28rpx;
    border: none;
  }
  .btn-check::after {
    border: none;
  }
  .empty-text {
    text-align: center;
    padding: 120rpx 0;
    color: #999;
    font-size: 30rpx;
  }
</style>
