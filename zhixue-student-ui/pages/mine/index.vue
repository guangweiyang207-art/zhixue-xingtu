<template>
  <view class="mine-container">
    <!-- 头部 -->
    <view class="header">
      <text class="title">个人中心</text>
      <view class="header-right">
        <view class="bell" @click="goRemind">
          🔔
          <view class="badge" v-if="reminderCount > 0">{{ reminderCount > 99 ? '99+' : reminderCount }}</view>
        </view>
        <view class="setting" @click="goSettings">⚙️</view>
      </view>
    </view>

    <!-- 个人信息接口错误提示 -->
    <view class="error-bar" v-if="userErrMsg">
      <text class="error-icon">⚠️</text>
      <text class="error-text">{{ userErrMsg }}</text>
    </view>

    <!-- 用户信息 -->
    <view class="user-info">
      <view class="avatar" :style="avatarStyle">{{ avatarChar }}</view>
      <view>
        <view class="name">{{ userProfile.name || '陈小明' }}</view>
        <view class="desc">{{ userDesc }}</view>
      </view>
    </view>

    <!-- 段位/做题记录 接口错误提示 -->
    <view class="error-bar" v-if="rankErrMsg">
      <text class="error-icon">⚠️</text>
      <text class="error-text">{{ rankErrMsg }}</text>
    </view>
    <view class="error-bar" v-if="recordErrMsg" style="margin-top: -10rpx;">
      <text class="error-icon">⚠️</text>
      <text class="error-text">{{ recordErrMsg }}</text>
    </view>

    <!-- 段位卡片 -->
    <view class="rank-card">
      <view class="rank-header">
        <view>
          <view class="rank-title">当前段位</view>
          <view class="rank-name">{{ rankInfo.rankLevel || '青铜' }}</view>
          <view class="rank-score">当前积分：{{ rankInfo.rankScore || 0 }} 分</view>
        </view>
        <view class="crown">👑</view>
      </view>

      <view class="rank-progress">
        <view class="progress-text">距离 {{ rankInfo.nextRankName || '下一段位' }} 还需 {{ nextRankNeed }} 分</view>
        <view class="progress-bar">
          <view class="progress" :style="'width:' + (rankInfo.progress || 0) + '%'"></view>
        </view>
      </view>
    </view>

    <!-- 做题记录 -->
    <view class="section">
      <view class="section-head">
        <text class="section-title">最近做题记录</text>
      </view>
      <view class="record-item" v-for="(item, index) in records" :key="index">
        <text>{{ item.date }}</text>
        <text>{{ item.subject }}</text>
        <text>{{ item.count }}</text>
        <text style="color:#2ecc71">{{ item.rate }}</text>
      </view>
      <view v-if="!recordErrMsg && records.length === 0" style="text-align:center;padding:24rpx 0;font-size:24rpx;color:#9ca3af;">
        暂无做题记录，完成并等老师批改后这里会更新
      </view>
    </view>

    <!-- 功能菜单 -->
    <view class="menu-list">
      <view class="menu-item" @click="goRemind">
        <text>🔔 今日提醒</text>
        <text class="arrow">></text>
      </view>
      <view class="menu-item" @click="goErrorBook">
        <text>📕 错题本</text>
        <text class="arrow">></text>
      </view>
      <view class="menu-item" @click="goStudyRecord">
        <text>📊 学习记录</text>
        <text class="arrow">></text>
      </view>
      <view class="menu-item" @click="goMyCourse">
        <text>📚 已选课程列表</text>
        <text class="arrow">></text>
      </view>
    </view>
  </view>
</template>

<script>
import { getRankInfoApi, getRecentRecordsApi, getUserProfileApi } from '@/api/mine/mine.js'
import { countRemindersApi } from '@/api/reminder/reminder.js'

export default {
  data() {
    return {
      userErrMsg: '',
      rankErrMsg: '',
      recordErrMsg: '',
      userProfile: {},
      rankInfo: {},
      records: [],
      reminderCount: 0
    }
  },
  computed: {
    userDesc() {
      if (this.userProfile.major && this.userProfile.className) {
        return this.userProfile.major + ' · ' + this.userProfile.className
      }
      return this.userProfile.desc || '晨曦中学 · 初二(3)班'
    },
    nextRankNeed() {
      if (this.rankInfo.nextMinScore && this.rankInfo.rankScore) {
        return this.rankInfo.nextMinScore - this.rankInfo.rankScore
      }
      return 0
    },
    avatarChar() {
      const name = (this.userProfile.name && this.userProfile.name.trim()) || '陈小明'
      return name.charAt(0)
    },
    avatarStyle() {
      const name = (this.userProfile.name && this.userProfile.name.trim()) || '陈小明'
      const colors = [
        'linear-gradient(135deg, #1E3A5F 0%, #2A4F7A 100%)',
        'linear-gradient(135deg, #A47148 0%, #8E5F3D 100%)',
        'linear-gradient(135deg, #4A7C59 0%, #3A6447 100%)',
        'linear-gradient(135deg, #B8762E 0%, #9A6024 100%)',
        'linear-gradient(135deg, #4A6B7C 0%, #3A5564 100%)',
        'linear-gradient(135deg, #6B4F3A 0%, #523A29 100%)',
        'linear-gradient(135deg, #2A4F7A 0%, #1E3A5F 100%)',
        'linear-gradient(135deg, #8E5F3D 0%, #A47148 100%)'
      ]
      let hash = 0
      for (let i = 0; i < name.length; i++) {
        hash = name.charCodeAt(i) + ((hash << 5) - hash)
      }
      const idx = Math.abs(hash) % colors.length
      return 'background:' + colors[idx] + ';'
    }
  },
  onLoad() {
    this.loadUserProfile()
    this.loadRankInfo()
    this.loadRecentRecords()
    this.loadReminderCount()
  },
  methods: {
    loadUserProfile() {
      this.userErrMsg = ''
      const stuId = uni.getStorageSync('userInfo')?.stu_id || 1
      getUserProfileApi(stuId).then(res => {
        if (res.data) {
          this.userProfile = res.data
        }
      }).catch(err => {
        const code = err.code || 404
        const msg = err.msg || '请求失败'
        this.userErrMsg = `接口 ${code} 错误：${msg}`
        console.error('获取用户个人信息失败：', err)
      })
    },
    loadRankInfo() {
      const stuId = uni.getStorageSync('userInfo')?.stu_id || 1
      getRankInfoApi(stuId).then(res => {
        if (res.data) {
          this.rankInfo = res.data
        }
      }).catch(err => {
        const code = err.code || 404
        const msg = err.msg || '请求失败'
        this.rankErrMsg = `接口 ${code} 错误：${msg}`
        console.error('获取段位信息失败：', err)
      })
    },
    loadRecentRecords() {
      const stuId = uni.getStorageSync('userInfo')?.stu_id || 1
      getRecentRecordsApi(stuId).then(res => {
        if (res.data) {
          this.records = res.data
        }
      }).catch(err => {
        const code = err.code || 404
        const msg = err.msg || '请求失败'
        this.recordErrMsg = `接口 ${code} 错误：${msg}`
        console.error('获取做题记录失败：', err)
      })
    },
    loadReminderCount() {
      const stuId = uni.getStorageSync('userInfo')?.stu_id || 1
      countRemindersApi(stuId).then(res => {
        if (res.data !== undefined) this.reminderCount = res.data
      }).catch(err => {
        console.error('获取提醒数量失败：', err)
      })
    },
    goRemind() {
      uni.navigateTo({ url: '/pages/reminder/index' })
    },
    goSettings() {
      uni.navigateTo({ url: '/pages/settings/index' })
    },
    goErrorBook() {
      uni.navigateTo({ url: '/pages/errorbook/errorbook' })
    },
    goStudyRecord() {
      uni.navigateTo({ url: '/pages/studyrecord/index' })
    },
    goMyCourse() {
      uni.navigateTo({ url: '/pages/mycourse/index' })
    }
  }
};
</script>

<style lang="scss" scoped>
.mine-container {
  background: $uni-bg-color-page;
  min-height: 100vh;
  padding: 20rpx 24rpx 40rpx;
}

.error-bar {
  display: flex; align-items: center; gap: 10rpx;
  background: $uni-color-error-soft; border: 1rpx solid $uni-color-error-soft; border-radius: $uni-radius-sm;
  padding: 16rpx 20rpx; margin-bottom: 20rpx;
}
.error-icon { font-size: 28rpx; flex-shrink: 0; }
.error-text { font-size: 24rpx; color: $uni-color-error; }

.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20rpx 4rpx 24rpx;
}
.title {
  font-size: 38rpx;
  font-weight: $uni-font-weight-bold;
  color: $uni-text-color;
  letter-spacing: 0.5rpx;
}
.header-right {
  display: flex;
  gap: 30rpx;
}
.bell, .setting {
  font-size: 36rpx;
  position: relative;
  color: $uni-text-color;
}
.badge {
  position: absolute;
  top: -10rpx;
  right: -10rpx;
  background: $uni-color-error;
  color: $uni-text-color-inverse;
  font-size: 20rpx;
  min-width: 30rpx;
  height: 30rpx;
  padding: 0 6rpx;
  border-radius: $uni-radius-full;
  display: flex;
  align-items: center;
  justify-content: center;
}
.user-info {
  display: flex;
  align-items: center;
  background: $uni-bg-color;
  border-radius: $uni-radius-lg;
  padding: 28rpx;
  margin-bottom: 24rpx;
  box-shadow: $uni-shadow-sm;
}
.avatar {
  width: 112rpx;
  height: 112rpx;
  border-radius: 50%;
  background: $uni-color-primary-soft;
  margin-right: 20rpx;
  display: flex;
  align-items: center;
  justify-content: center;
  color: $uni-color-primary;
  font-size: 44rpx;
  font-weight: $uni-font-weight-semibold;
  flex-shrink: 0;
}
.name {
  font-size: 34rpx;
  font-weight: $uni-font-weight-semibold;
  color: $uni-text-color;
}
.desc {
  font-size: 24rpx;
  color: $uni-text-color-tertiary;
  margin-top: 8rpx;
}
.rank-card {
  background: $uni-color-primary;
  border-radius: $uni-radius-lg;
  padding: 32rpx;
  color: $uni-text-color-inverse;
  margin-bottom: 24rpx;
  position: relative;
  overflow: hidden;
}
.rank-card::after {
  content: '';
  position: absolute;
  top: -60rpx; right: -60rpx;
  width: 220rpx; height: 220rpx;
  background: rgba(164, 113, 72, 0.15);
  border-radius: 50%;
}
.rank-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  position: relative;
  z-index: 1;
}
.rank-title {
  font-size: 24rpx;
  opacity: 0.7;
}
.rank-name {
  font-size: 40rpx;
  font-weight: $uni-font-weight-semibold;
  margin-top: 8rpx;
  letter-spacing: 1rpx;
}
.rank-score {
  font-size: 24rpx;
  opacity: 0.75;
  margin-top: 6rpx;
}
.crown {
  font-size: 60rpx;
}
.rank-progress {
  margin-top: 24rpx;
  position: relative;
  z-index: 1;
}
.progress-text {
  font-size: 24rpx;
  margin-bottom: 12rpx;
  opacity: 0.85;
}
.progress-bar {
  height: 10rpx;
  background: rgba(255,255,255,0.18);
  border-radius: $uni-radius-full;
  overflow: hidden;
}
.progress {
  height: 100%;
  background: $uni-color-accent;
  border-radius: $uni-radius-full;
  transition: width $uni-duration-base $uni-ease;
}
.section {
  background: $uni-bg-color;
  border-radius: $uni-radius-lg;
  padding: 28rpx;
  margin-bottom: 24rpx;
  box-shadow: $uni-shadow-sm;
}
.section-title {
  font-size: 30rpx;
  font-weight: $uni-font-weight-semibold;
  color: $uni-text-color;
  margin-bottom: 16rpx;
  letter-spacing: 0.5rpx;
}

.section-head {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16rpx;
}
.section-more {
  font-size: 24rpx;
  color: $uni-color-primary;
}
.record-item {
  display: flex;
  justify-content: space-between;
  padding: 20rpx 0;
  font-size: 26rpx;
  color: $uni-text-color;
  border-bottom: 1rpx solid $uni-divider-color;
}
.record-item:last-child { border-bottom: none; }
.menu-list {
  background: $uni-bg-color;
  border-radius: $uni-radius-lg;
  overflow: hidden;
  box-shadow: $uni-shadow-sm;
}
.menu-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 28rpx 32rpx;
  font-size: 28rpx;
  color: $uni-text-color;
  border-bottom: 1rpx solid $uni-divider-color;
  position: relative;
}
.menu-item:last-child { border-bottom: none; }
.arrow {
  color: $uni-text-color-placeholder;
  font-size: 26rpx;
}
</style>