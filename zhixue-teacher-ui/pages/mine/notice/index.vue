<template>
  <view class="notice-page">
    <!-- 页面标题 -->
    <view class="page-header">
      <text class="page-title">消息通知</text>
    </view>

    <!-- 消息列表(与首页"系统通知"展示一致) -->
    <view class="notice-list">
      <view
        class="notice-item"
        v-for="item in noticeList"
        :key="item.noticeId"
        @click="goNoticeDetail(item)"
      >
        <view class="notice-icon">
          <uni-icons type="notification" size="20" color="#1E3A5F" />
        </view>
        <view class="notice-content">
          <text class="notice-title">{{ item.noticeTitle || '(无标题)' }}</text>
          <text class="notice-desc">{{ item.noticeContent }}</text>
          <text class="notice-time">{{ formatNoticeTime(item.publishTime) }}</text>
        </view>
      </view>
      <view v-if="noticeList.length === 0" class="notice-empty">暂无系统通知</view>
    </view>
  </view>
</template>

<script>
import request from '@/utils/request'

export default {
  data() {
    return {
      noticeList: []
    }
  },
  onLoad() {
    this.getNoticeList()
  },
  onShow() {
    this.getNoticeList()
  },
  onPullDownRefresh() {
    this.getNoticeList()
    uni.stopPullDownRefresh()
  },
  methods: {
    // 与首页"系统通知"共用同一个接口,保证数据展示一致
    getNoticeList() {
      request({
        url: '/teacher/notice/list',
        method: 'get',
        params: { limit: 50 }
      }).then(res => {
        if (res.code === 200) {
          this.noticeList = res.data || []
        } else {
          this.noticeList = []
        }
      }).catch(() => {
        uni.showToast({ title: '获取消息列表失败', icon: 'none' })
        this.noticeList = []
      })
    },
    // 跳转到通知详情(复用首页的详情页)
    goNoticeDetail(item) {
      uni.navigateTo({
        url: `/pages/notice/detail?id=${item.noticeId}`
      })
    },
    // 时间格式化(与首页保持一致)
    formatNoticeTime(t) {
      if (!t) return ''
      const d = new Date(t)
      if (isNaN(d.getTime())) return t
      const now = new Date()
      const sameDay = d.toDateString() === now.toDateString()
      if (sameDay) {
        const hh = String(d.getHours()).padStart(2, '0')
        const mm = String(d.getMinutes()).padStart(2, '0')
        return `${hh}:${mm}`
      }
      const y = d.getFullYear()
      const m = String(d.getMonth() + 1).padStart(2, '0')
      const day = String(d.getDate()).padStart(2, '0')
      return `${y}-${m}-${day}`
    }
  }
}
</script>

<style lang="scss" scoped>
page {
  background-color: #f5f6fa;
}

.notice-page {
  padding: 0 24rpx 48rpx;
}

.page-header {
  padding-top: 40rpx;
  padding-bottom: 24rpx;
}

.page-title {
  font-size: 44rpx;
  font-weight: bold;
  color: #1a1a1a;
}

.notice-list {
  display: flex;
  flex-direction: column;
  gap: 20rpx;
  padding-bottom: 24rpx;
}

.notice-item {
  display: flex;
  flex-direction: row;
  background-color: #fff;
  border-radius: 20rpx;
  padding: 24rpx;
}

.notice-icon {
  font-size: 40rpx;
  margin-right: 16rpx;
  line-height: 1.2;
}

.notice-content {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 8rpx;
}

.notice-title {
  font-size: 30rpx;
  font-weight: bold;
  color: #1a1a1a;
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 1;
  -webkit-box-orient: vertical;
}

.notice-desc {
  font-size: 26rpx;
  color: #666;
  line-height: 1.5;
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
}

.notice-time {
  font-size: 22rpx;
  color: #999;
  margin-top: 4rpx;
}

.notice-empty {
  text-align: center;
  font-size: 26rpx;
  color: #999;
  padding: 80rpx 0;
}
</style>
