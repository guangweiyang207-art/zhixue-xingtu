<template>
  <view class="detail-page">
    <!-- 消息头部 -->
    <view class="detail-header">
      <view class="notice-icon" :class="notice.type">
        <text class="iconfont" :class="iconClass"></text>
      </view>
      <view class="header-info">
        <text class="notice-title">{{ notice.title }}</text>
        <text class="notice-time">{{ notice.time }}</text>
      </view>
    </view>

    <!-- 消息内容 -->
    <view class="detail-content">
      <view class="content-card">
        <text class="content-text">{{ notice.content }}</text>
      </view>
    </view>

    <!-- 底部操作 -->
    <view class="detail-footer">
      <view class="action-btn" @click="markAsUnread" v-if="notice.isRead">
        <text>标记为未读</text>
      </view>
      <view class="action-btn delete" @click="deleteNotice">
        <text>删除消息</text>
      </view>
    </view>
  </view>
</template>

<script>
import { getNotice, unreadNotice, delNotice } from '@/api/mine/notice'

export default {
  data() {
    return {
      notice: {
        id: 0,
        title: '',
        summary: '',
        time: '',
        type: 'system',
        isRead: false,
        content: ''
      }
    }
  },
  computed: {
    iconClass() {
      const iconMap = {
        exam: 'icon-people',
        content: 'icon-edit',
        homework: 'icon-aixin',
        system: 'icon-setting',
        course: 'icon-user'
      }
      return iconMap[this.notice.type] || 'icon-service'
    }
  },
  onLoad(options) {
    if (options.id) {
      this.getNoticeDetail(options.id)
    }
  },
  methods: {
    getNoticeDetail(id) {
      getNotice(id).then(res => {
        this.notice = res.data || {}
      }).catch(() => {
        uni.showToast({ title: '获取消息详情失败', icon: 'none' })
      })
    },
    markAsUnread() {
      unreadNotice(this.notice.id).then(() => {
        this.notice.isRead = false
        uni.showToast({ title: '已标记为未读', icon: 'success' })
        setTimeout(() => {
          uni.navigateBack()
        }, 1000)
      }).catch(() => {
        uni.showToast({ title: '操作失败', icon: 'none' })
      })
    },
    deleteNotice() {
      uni.showModal({
        title: '删除消息',
        content: '确认要删除这条消息吗？',
        success: (res) => {
          if (res.confirm) {
            delNotice(this.notice.id).then(() => {
              uni.showToast({ title: '已删除', icon: 'success' })
              setTimeout(() => {
                uni.navigateBack()
              }, 1000)
            }).catch(() => {
              uni.showToast({ title: '删除失败', icon: 'none' })
            })
          }
        }
      })
    }
  }
}
</script>

<style lang="scss" scoped>
page {
  background-color: #f5f6fa;
}

.detail-page {
  padding: 0 24rpx;
}

.detail-header {
  display: flex;
  flex-direction: row;
  align-items: center;
  padding: 32rpx 0;
}

.notice-icon {
  width: 80rpx;
  height: 80rpx;
  border-radius: 20rpx;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 20rpx;

  .iconfont {
    font-size: 40rpx;
  }

  &.exam {
    background-color: #fff5e6;

    .iconfont {
      color: #ff9500;
    }
  }

  &.content {
    background-color: #eef2ff;

    .iconfont {
      color: #5b5fc7;
    }
  }

  &.homework {
    background-color: #e6f7ef;

    .iconfont {
      color: #34c759;
    }
  }

  &.system {
    background-color: #f5f5f5;

    .iconfont {
      color: #999;
    }
  }

  &.course {
    background-color: #e6f0ff;

    .iconfont {
      color: #3c96f3;
    }
  }
}

.header-info {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 8rpx;
}

.notice-title {
  font-size: 36rpx;
  font-weight: bold;
  color: #1a1a1a;
}

.notice-time {
  font-size: 24rpx;
  color: #999;
}

.detail-content {
  margin-bottom: 48rpx;
}

.content-card {
  background-color: #fff;
  border-radius: 20rpx;
  padding: 32rpx;
}

.content-text {
  font-size: 30rpx;
  color: #333;
  line-height: 1.8;
}

.detail-footer {
  display: flex;
  flex-direction: row;
  gap: 20rpx;
  padding-bottom: 32rpx;
}

.action-btn {
  flex: 1;
  height: 80rpx;
  background-color: #fff;
  border-radius: 40rpx;
  display: flex;
  align-items: center;
  justify-content: center;

  text {
    font-size: 28rpx;
    color: #333;
  }

  &.delete {
    background-color: #fff0f0;

    text {
      color: #ff4d4f;
    }
  }
}
</style>
