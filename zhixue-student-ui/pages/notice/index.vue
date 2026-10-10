<template>
  <view class="notice-page">
    <!-- 顶部导航 -->
    <view class="nav-bar">
      <view class="nav-back" @click="goBack">
        <uni-icons type="left" size="22" color="#1f2937" />
      </view>
      <text class="nav-title">消息通知</text>
      <view class="nav-placeholder"></view>
    </view>

    <!-- 通知列表 -->
    <view class="notice-list" v-if="noticeList.length > 0">
      <view class="notice-item" v-for="(item, index) in noticeList" :key="index">
        <view class="notice-item-head" @click="toggle(index)">
          <view class="notice-icon">
            <uni-icons type="sound-filled" size="22" color="#6366f1" />
          </view>
          <view class="notice-info">
            <view class="title-row">
              <text class="notice-title">{{ item.noticeTitle }}</text>
              <view v-if="item.priority === 2" class="urgent-tag">重要</view>
            </view>
            <text class="notice-time">{{ formatTime(item.publishTime || item.createTime) }}</text>
          </view>
          <uni-icons :type="expandedIndex === index ? 'up' : 'down'" size="16" color="#9ca3af" />
        </view>
        <view class="notice-content" v-if="expandedIndex === index">
          <text class="content-text">{{ item.noticeContent || '暂无内容' }}</text>
        </view>
      </view>
    </view>

    <!-- 空状态 -->
    <view class="empty-state" v-if="noticeList.length === 0 && loaded">
      <uni-icons type="email" size="60" color="#d1d5db" />
      <text class="empty-text">暂无通知消息</text>
      <text class="empty-sub">老师发布的新通知会在这里显示</text>
    </view>
  </view>
</template>

<script>
  import config from '@/config'

  export default {
    data() {
      return {
        noticeList: [],
        expandedIndex: -1,
        loaded: false
      }
    },
    onLoad() {
      this.loadNotices()
    },
    methods: {
      loadNotices() {
        uni.request({
          url: config.baseUrl + '/mxy/notice/list',
          data: { status: 1 },
          success: res => {
            this.loaded = true
            if (res.data && res.data.code === 200 && Array.isArray(res.data.data)) {
              // 置顶优先,再按发布时间倒序
              const list = res.data.data
              list.sort((a, b) => {
                if ((b.isTop || 0) !== (a.isTop || 0)) return (b.isTop || 0) - (a.isTop || 0)
                return new Date(b.publishTime || b.createTime || 0) - new Date(a.publishTime || a.createTime || 0)
              })
              this.noticeList = list
            }
          },
          fail: () => {
            this.loaded = true
            uni.showToast({ title: '加载失败', icon: 'none' })
          }
        })
      },
      toggle(index) {
        this.expandedIndex = this.expandedIndex === index ? -1 : index
      },
      formatTime(t) {
        if (!t) return ''
        return String(t).replace('T', ' ').slice(0, 16)
      },
      goBack() {
        uni.navigateBack()
      }
    }
  }
</script>

<style lang="scss" scoped>
  .notice-page {
    min-height: 100vh;
    background: #f6f7fb;
    padding-bottom: 40rpx;
  }

  .nav-bar {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: calc(var(--status-bar-height) + 16rpx) 24rpx 16rpx;

    .nav-back {
      width: 64rpx;
      height: 64rpx;
      display: flex;
      align-items: center;
      justify-content: center;
      background: #fff;
      border-radius: 50%;
      box-shadow: 0 2rpx 8rpx rgba(0, 0, 0, 0.06);
    }

    .nav-title {
      font-size: 34rpx;
      font-weight: 600;
      color: #1f2937;
    }

    .nav-placeholder {
      width: 64rpx;
    }
  }

  .notice-list {
    padding: 24rpx 32rpx;
  }

  .notice-item {
    background: #fff;
    border-radius: 20rpx;
    margin-bottom: 24rpx;
    padding: 28rpx;
    box-shadow: 0 2rpx 12rpx rgba(0, 0, 0, 0.04);
  }

  .notice-item-head {
    display: flex;
    align-items: center;
  }

  .notice-icon {
    width: 76rpx;
    height: 76rpx;
    background: #eef2ff;
    border-radius: 18rpx;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
  }

  .notice-info {
    flex: 1;
    margin: 0 20rpx;
    overflow: hidden;

    .title-row {
      display: flex;
      align-items: center;
      gap: 12rpx;
    }

    .notice-title {
      font-size: 30rpx;
      font-weight: 600;
      color: #1f2937;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    .urgent-tag {
      flex-shrink: 0;
      font-size: 20rpx;
      color: #dc2626;
      background: #fee2e2;
      border-radius: 8rpx;
      padding: 2rpx 12rpx;
    }

    .notice-time {
      display: block;
      margin-top: 8rpx;
      font-size: 24rpx;
      color: #9ca3af;
    }
  }

  .notice-content {
    margin-top: 20rpx;
    padding-top: 20rpx;
    border-top: 1rpx solid #f3f4f6;

    .content-text {
      font-size: 28rpx;
      color: #4b5563;
      line-height: 1.7;
      white-space: pre-wrap;
      word-break: break-all;
    }
  }

  .empty-state {
    padding-top: 200rpx;
    display: flex;
    flex-direction: column;
    align-items: center;

    .empty-text {
      margin-top: 24rpx;
      font-size: 30rpx;
      color: #6b7280;
    }

    .empty-sub {
      margin-top: 12rpx;
      font-size: 24rpx;
      color: #9ca3af;
    }
  }
</style>
