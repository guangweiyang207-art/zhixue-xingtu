<template>
  <view class="mine-page">
    <!-- 教师信息卡片 -->
    <view class="teacher-card">
      <view class="teacher-header">
        <image
          class="teacher-avatar"
          :src="teacher.avatar || '/static/images/teacher-avatar.svg'"
          mode="aspectFill"
        />
        <view class="teacher-info">
          <text class="teacher-name">{{ teacher.name }} {{ teacher.postTitle }}</text>
          <text class="teacher-title">{{ teacher.professionTitle }} · {{ teacher.groupName }}</text>
        </view>
      </view>
      <view class="teacher-stats">
        <view class="stat-item">
          <text class="stat-label">教龄</text>
          <text class="stat-value">{{ teacher.teachingYears }}年</text>
        </view>
        <view class="stat-divider"></view>
        <view class="stat-item">
          <text class="stat-label">授课班级</text>
          <text class="stat-value">{{ teacher.classCount }}个</text>
        </view>
        <view class="stat-divider"></view>
        <view class="stat-item">
          <text class="stat-label">在读学生</text>
          <text class="stat-value">{{ teacher.studentCount }}人</text>
        </view>
      </view>
    </view>

    <!-- 菜单列表 -->
    <view class="menu-group">
      <view class="menu-item" @click="goToCourse">
        <view class="menu-icon blue">
          <text class="iconfont icon-user"></text>
        </view>
        <text class="menu-text">我的课程</text>
        <text class="menu-arrow iconfont icon-right"></text>
      </view>
      <view class="menu-item" @click="goToStats">
        <view class="menu-icon green">
          <text class="iconfont icon-aixin"></text>
        </view>
        <text class="menu-text">教学统计</text>
        <text class="menu-arrow iconfont icon-right"></text>
      </view>
      <view class="menu-item" @click="goToSetting">
        <view class="menu-icon orange">
          <text class="iconfont icon-setting"></text>
        </view>
        <text class="menu-text">账号设置</text>
        <text class="menu-arrow iconfont icon-right"></text>
      </view>
    </view>

    <view class="menu-group">
      <view class="menu-item" @click="goToNotice">
        <view class="menu-icon blue-light">
          <text class="iconfont icon-service"></text>
        </view>
        <text class="menu-text">消息通知</text>
        <view class="badge">{{ noticeCount }}</view>
        <text class="menu-arrow iconfont icon-right"></text>
      </view>
    </view>

    <!-- 退出登录 -->
    <view class="logout-btn" @click="handleLogout">
      <text class="logout-icon iconfont icon-logout"></text>
      <text class="logout-text">退出登录</text>
    </view>
  </view>
</template>

<script>
import { getTeacherInfo } from '@/api/mine/teacher'
import request from '@/utils/request'
import { removeRememberToken } from '@/utils/auth'

export default {
  data() {
    return {
      teacher: {
        name: '',
        avatar: '',
        postTitle: '老师',
        professionTitle: '',
        groupName: '',
        teachingYears: 0,
        classCount: 0,
        studentCount: 0
      },
      noticeCount: 0
    }
  },
  onLoad() {
    this.getTeacherInfo()
    this.getNoticeCount()
  },
  onShow() {
    this.getNoticeCount()
  },
  methods: {
    goToCourse() {
      uni.navigateTo({
        url: '/pages/mine/course/index'
      })
    },
    goToStats() {
      uni.navigateTo({
        url: '/pages/mine/stats/index'
      })
    },
    goToSetting() {
      uni.navigateTo({
        url: '/pages/mine/setting/index'
      })
    },
    goToNotice() {
      uni.navigateTo({
        url: '/pages/mine/notice/index'
      })
    },
    getTeacherInfo() {
      getTeacherInfo().then(res => {
        const data = res.data || {}
        this.teacher = {
          name: data.name || '',
          avatar: data.avatar || '',
          postTitle: data.postTitle || '老师',
          professionTitle: data.professionTitle || '',
          groupName: data.groupName || '',
          teachingYears: data.teachingYears || 0,
          classCount: data.classCount || 0,
          studentCount: data.studentCount || 0
        }
      }).catch(() => {
        uni.showToast({ title: '获取教师信息失败', icon: 'none' })
      })
    },
    getNoticeCount() {
      // 与"消息通知"页使用同一数据源(/teacher/notice/list),保证徽标数与列表条数一致
      request({
        url: '/teacher/notice/list',
        method: 'get',
        params: { limit: 50 }
      }).then(res => {
        this.noticeCount = res.code === 200 ? (res.data || []).length : 0
      }).catch(() => {
        // 静默失败
        this.noticeCount = 0
      })
    },
    // 退出登录
    handleLogout() {
      uni.showModal({
        title: '提示',
        content: '确定要退出登录吗?',
        confirmColor: '#ff4d4f',
        success: (res) => {
          if (!res.confirm) return
          // 退出后清除记住登录凭据,下次打开需重新输入账号密码
          removeRememberToken()
          this.$store.dispatch('LogOut').then(() => {
            uni.reLaunch({ url: '/pages/login' })
          }).catch(() => {
            // 即使后端调用失败,也强制清理本地登录态并跳转
            uni.removeStorageSync('App-Token')
            uni.removeStorageSync('App-TeacherId')
            uni.removeStorageSync('App-RealName')
            uni.reLaunch({ url: '/pages/login' })
          })
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

.mine-page {
  padding: 24rpx;
}

/* 教师信息卡片 */
.teacher-card {
  background-color: #5b5fc7;
  border-radius: 32rpx;
  padding: 40rpx 32rpx;
  margin-bottom: 32rpx;
}

.teacher-header {
  display: flex;
  flex-direction: row;
  align-items: center;
  margin-bottom: 40rpx;
}

.teacher-avatar {
  width: 120rpx;
  height: 120rpx;
  border-radius: 50%;
  background-color: rgba(255, 255, 255, 0.2);
  margin-right: 24rpx;
}

.teacher-info {
  display: flex;
  flex-direction: column;
  gap: 8rpx;
}

.teacher-name {
  font-size: 40rpx;
  font-weight: bold;
  color: #fff;
}

.teacher-title {
  font-size: 26rpx;
  color: rgba(255, 255, 255, 0.8);
}

.teacher-stats {
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-around;
  padding-top: 32rpx;
  border-top: 1rpx solid rgba(255, 255, 255, 0.2);
}

.stat-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8rpx;
}

.stat-label {
  font-size: 24rpx;
  color: rgba(255, 255, 255, 0.7);
}

.stat-value {
  font-size: 36rpx;
  font-weight: bold;
  color: #fff;
}

.stat-divider {
  width: 1rpx;
  height: 60rpx;
  background-color: rgba(255, 255, 255, 0.2);
}

/* 菜单组 */
.menu-group {
  background-color: #fff;
  border-radius: 24rpx;
  padding: 0 24rpx;
  margin-bottom: 24rpx;
}

.menu-item {
  display: flex;
  flex-direction: row;
  align-items: center;
  padding: 28rpx 0;
  border-bottom: 1rpx solid #f5f5f5;
}

.menu-item:last-child {
  border-bottom: none;
}

.menu-icon {
  width: 56rpx;
  height: 56rpx;
  border-radius: 16rpx;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 20rpx;

  &.blue {
    background-color: #eef2ff;

    .iconfont {
      color: #5b5fc7;
    }
  }

  &.green {
    background-color: #e6f7ef;

    .iconfont {
      color: #34c759;
    }
  }

  &.orange {
    background-color: #fff5e6;

    .iconfont {
      color: #ff9500;
    }
  }

  &.blue-light {
    background-color: #e6f0ff;

    .iconfont {
      color: #3c96f3;
    }
  }

  &.gray {
    background-color: #f5f5f5;

    .iconfont {
      color: #999;
    }
  }
}

.iconfont {
  font-size: 32rpx;
}

.menu-text {
  flex: 1;
  font-size: 30rpx;
  color: #333;
}

.badge {
  min-width: 36rpx;
  height: 36rpx;
  background-color: #ff4d4f;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 12rpx;
  padding: 0 8rpx;

  text {
    font-size: 22rpx;
    color: #fff;
  }
}

.menu-arrow {
  font-size: 24rpx;
  color: #ccc;
}

/* 退出登录 */
.logout-btn {
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: center;
  background-color: #fff;
  border-radius: 24rpx;
  padding: 32rpx 0;
  margin-top: 8rpx;
}

.logout-icon {
  font-size: 32rpx;
  color: #ff4d4f;
  margin-right: 8rpx;
}

.logout-text {
  font-size: 30rpx;
  color: #ff4d4f;
}
</style>
