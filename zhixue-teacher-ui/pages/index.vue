<template>
  <view class="container">
    <!-- 搜索栏 -->
    <view class="search-bar">
      <uni-icons type="search" size="18" color="#6B7280" />
      <input
        v-model="searchKey"
        class="search-input"
        placeholder="搜索课程、学生、作业..."
        @confirm="doSearch"
      />
      <button class="search-btn" @click="doSearch">搜索</button>
    </view>

    <!-- 轮播图(纯展示,不可点击) -->
    <swiper class="banner-swiper" indicator-dots circular autoplay interval="3000">
      <swiper-item v-for="(item, index) in bannerList" :key="index">
        <view class="banner-item" :style="{background: item.bgColor}">
          <view class="banner-tag">{{item.tag}}</view>
          <view class="banner-text">{{item.title}}</view>
        </view>
      </swiper-item>
    </swiper>

    <!-- 我的待办 -->
    <view class="section">
      <view class="section-header">
        <text class="section-title">我的待办</text>
        <text class="view-all" @click="goTodoList">查看全部</text>
      </view>
      <view class="todo-list">
        <view class="todo-item" @click="goHomeworkList">
          <view class="todo-icon todo-icon-1">
            <uni-icons type="checkbox-filled" size="26" color="#1E3A5F" />
          </view>
          <view class="todo-info">
            <text class="todo-title">待批改作业</text>
            <text class="todo-num">{{ todoWorkCount }} 份</text>
          </view>
        </view>
        <view class="todo-item" @click="goQuestionList">
          <view class="todo-icon todo-icon-2">
            <uni-icons type="chat-filled" size="26" color="#A47148" />
          </view>
          <view class="todo-info">
            <text class="todo-title">待回答问题</text>
            <text class="todo-num">{{ todoQuestionCount }} 个</text>
          </view>
        </view>
      </view>
    </view>

    <!-- 快捷发布 -->
    <view class="section">
      <view class="section-title">快捷发布</view>
      <view class="quick-release">
        <view class="release-item" @click="goPublishCourse">
          <view class="release-icon release-icon-2">
            <uni-icons type="videocam-filled" size="28" color="#4A7C59" />
          </view>
          <text class="release-text">发布课程</text>
        </view>
        <view class="release-item" @click="goPublishHomework">
          <view class="release-icon release-icon-1">
            <uni-icons type="compose" size="28" color="#1E3A5F" />
          </view>
          <text class="release-text">发布作业</text>
        </view>
        <view class="release-item" @click="goPublishNotice">
          <view class="release-icon release-icon-3">
            <uni-icons type="notification-filled" size="28" color="#B8762E" />
          </view>
          <text class="release-text">发布通知</text>
        </view>
      </view>
    </view>

    <!-- 系统通知（可点击） -->
      <view class="section">
        <view class="section-title">系统通知</view>
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
              <text class="notice-title">{{ item.noticeTitle }}</text>
              <text class="notice-desc">{{ item.noticeContent }}</text>
              <text class="notice-time">{{ formatNoticeTime(item.publishTime) }}</text>
            </view>
          </view>
          <view v-if="noticeList.length === 0" class="notice-empty">暂无系统通知</view>
        </view>
      </view>
  </view>
</template>

<script>
import request from '@/utils/request'
export default {
  data() {
    return {
      searchKey: '',
      searchResult: [],
      todoWorkCount: 0,
      todoQuestionCount: 0,
      // 通知数据完全来自 /teacher/notice/list,不再使用本地模拟数据,保证条数与后端一致
      noticeList: [],
      bannerList: [
        {
          tag: '教学活动',
          title: '2026年度优秀教案评选活动正式启动',
          bgColor: '#E8F0FF'
        },
        {
          tag: '培训活动',
          title: '暑期教师信息化能力提升培训班',
          bgColor: '#F0F4FF'
        }
      ]
    }
  },
  onShow() {
    // 每次显示页面刷新待办数量、通知数据
    this.getTodoData()
    this.getNoticeData()
  },
  methods: {
    // 通知跳转详情
    goNoticeDetail(item) {
      uni.navigateTo({
        url: `/pages/notice/detail?id=${item.noticeId}`
      })
    },

    // 通知时间格式化:今天显示 HH:mm,昨天显示 "昨天",更早显示 yyyy-MM-dd
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
    },

    // ========== 搜索功能 + 接口 ==========
    async doSearch() {
      if (!this.searchKey.trim()) {
        uni.showToast({ title: '请输入搜索内容', icon: 'none' })
        return
      }
      try {
        const res = await request({
          url: '/system/search',
          method: 'POST',
          data: { key: this.searchKey }
        })
        if (res.code === 200) {
          this.searchResult = res.data || []
          if (this.searchResult.length === 0) {
            uni.showToast({ title: '暂无匹配结果', icon: 'none' })
          } else {
            uni.showToast({ title: '搜索成功' })
            // 此处可扩展：跳转搜索结果页
          }
        } else {
          uni.showToast({ title: '查询失败', icon: 'none' })
        }
      } catch (err) {
        this.searchResult = []
        uni.showToast({ title: '网络异常', icon: 'none' })
      }
    },

    // ========== 获取待办数量 接口 ==========
    async getTodoData() {
      try {
        const res = await request({
          url: '/teacher/todo/count',
          method: 'GET'
        })
        if (res.code === 200) {
          this.todoWorkCount = res.data.homeworkCount || 0
          this.todoQuestionCount = res.data.questionCount || 0
        }
      } catch (err) {
        // 接口异常显示 0,不再使用模拟数据
        this.todoWorkCount = 0
        this.todoQuestionCount = 0
      }
    },

    // ========== 获取系统通知 接口 ==========
    async getNoticeData() {
      try {
        const res = await request({
          url: '/teacher/notice/list',
          method: 'GET'
        })
        if (res.code === 200) {
          this.noticeList = res.data || []
        } else {
          this.noticeList = []
        }
      } catch (err) {
        // 接口异常显示为空,不再回退到模拟数据
        this.noticeList = []
      }
    },

    // ========== 跳转逻辑（核心：联动任务页标签） ==========
    // 查看全部待办
    goTodoList() {
      uni.navigateTo({ url: '/pages/todo/list' })
    },

    // 待批改作业 → 跳转待批改作业列表页
    goHomeworkList() {
      uni.navigateTo({ url: '/pages/todo/homework' })
    },

    // 待回答问题 → 跳转待回答问题列表页
    goQuestionList() {
      uni.navigateTo({ url: '/pages/todo/question' })
    },

    // 快捷发布作业 → 跳转任务页 + 切到【发布作业】标签
    goPublishHomework() {
      uni.switchTab({
        url: '/pages/task/index',
        success: () => {
          setTimeout(() => {
            uni.$emit('changeTaskTab', 'homework')
          }, 150)
        }
      })
    },

    // 快捷发布课程 → 跳转任务页 + 切到【发布课程】标签
    goPublishCourse() {
      uni.switchTab({
        url: '/pages/task/index',
        success: () => {
          setTimeout(() => {
            uni.$emit('changeTaskTab', 'course')
          }, 150)
        }
      })
    },

    // 发布通知（独立页面）
    goPublishNotice() {
      uni.navigateTo({ url: '/pages/notice/publish' })
    }
  }
}
</script>

<style lang="scss" scoped>
.container {
  background-color: $uni-bg-color-page;
  min-height: 100vh;
  padding: 20rpx 24rpx 40rpx;
}
.search-bar {
  display: flex;
  align-items: center;
  background: $uni-bg-color;
  border-radius: $uni-radius-full;
  padding: 12rpx 20rpx 12rpx 28rpx;
  margin-bottom: 24rpx;
  box-shadow: $uni-shadow-sm;
}
.search-icon {
  font-size: 28rpx;
  color: $uni-text-color-tertiary;
}
.search-input {
  flex: 1;
  font-size: 28rpx;
  color: $uni-text-color;
  margin: 0 15rpx;
}
.search-btn {
  background: $uni-color-primary;
  color: $uni-text-color-inverse;
  border-radius: $uni-radius-full;
  padding: 12rpx 28rpx;
  font-size: 24rpx;
  border: none;
  letter-spacing: 1rpx;
  box-shadow: $uni-shadow-sm;
}
.search-btn::after { border: none; }
.banner-swiper {
  width: 100%;
  height: 200rpx;
  border-radius: $uni-radius-md;
  overflow: hidden;
  margin-bottom: 28rpx;
}
.banner-item {
  width: 100%;
  height: 100%;
  padding: 30rpx;
  display: flex;
  flex-direction: column;
  justify-content: center;
  color: $uni-text-color;
  background: $uni-color-primary-soft;
}
.banner-tag {
  background: $uni-color-primary;
  color: $uni-text-color-inverse;
  border-radius: $uni-radius-xs;
  padding: 6rpx 14rpx;
  font-size: 22rpx;
  width: fit-content;
  margin-bottom: 12rpx;
  letter-spacing: 0.5rpx;
}
.banner-text {
  font-size: 30rpx;
  font-weight: $uni-font-weight-semibold;
  color: $uni-text-color;
  letter-spacing: 0.5rpx;
}
.section {
  margin-bottom: 28rpx;
}
.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 18rpx;
  padding: 0 4rpx;
}
.section-title {
  font-size: 32rpx;
  font-weight: $uni-font-weight-semibold;
  color: $uni-text-color;
  letter-spacing: 0.5rpx;
  position: relative;
  padding-left: 16rpx;
}
.section-title::before {
  content: '';
  position: absolute;
  left: 0; top: 50%;
  transform: translateY(-50%);
  width: 6rpx; height: 24rpx;
  background: $uni-color-primary;
  border-radius: 3rpx;
}
.view-all {
  color: $uni-color-primary;
  font-size: 24rpx;
}
.todo-list {
  display: flex;
  justify-content: space-between;
  gap: 16rpx;
}
.todo-item {
  background: $uni-bg-color;
  border-radius: $uni-radius-lg;
  flex: 1;
  padding: 28rpx;
  display: flex;
  align-items: center;
  box-shadow: $uni-shadow-sm;
}
.todo-icon {
  width: 72rpx;
  height: 72rpx;
  border-radius: $uni-radius-md;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 32rpx;
  margin-right: 18rpx;
  flex-shrink: 0;
}
.todo-icon-1 { background: $uni-color-primary-soft; }
.todo-icon-2 { background: $uni-color-accent-soft; }
.todo-info {
  display: flex;
  flex-direction: column;
  min-width: 0;
}
.todo-title {
  font-size: 24rpx;
  color: $uni-text-color-tertiary;
}
.todo-num {
  font-size: 32rpx;
  font-weight: $uni-font-weight-semibold;
  color: $uni-text-color;
  margin-top: 6rpx;
}
.quick-release {
  background: $uni-bg-color;
  border-radius: $uni-radius-lg;
  padding: 36rpx 24rpx;
  display: flex;
  justify-content: space-around;
  box-shadow: $uni-shadow-sm;
}
.release-item {
  display: flex;
  flex-direction: column;
  align-items: center;
}
.release-icon {
  width: 88rpx;
  height: 88rpx;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 34rpx;
  margin-bottom: 14rpx;
}
.release-icon-1 { background: $uni-color-primary-soft; }
.release-icon-2 { background: $uni-color-success-soft; }
.release-icon-3 { background: $uni-color-warning-soft; }
.release-text {
  font-size: 24rpx;
  color: $uni-text-color-secondary;
}
.notice-list {
  background: $uni-bg-color;
  border-radius: $uni-radius-lg;
  padding: 8rpx 20rpx;
  box-shadow: $uni-shadow-sm;
}
.notice-item {
  display: flex;
  padding: 24rpx 4rpx;
  border-bottom: 1rpx solid $uni-divider-color;
}
.notice-item:last-child {
  border-bottom: none;
}
.notice-icon {
  font-size: 30rpx;
  margin-right: 18rpx;
  color: $uni-color-primary;
  width: 48rpx;
  height: 48rpx;
  background: $uni-color-primary-soft;
  border-radius: $uni-radius-md;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}
.notice-content {
  flex: 1;
  display: flex;
  flex-direction: column;
  min-width: 0;
}
.notice-title {
  font-size: 28rpx;
  font-weight: $uni-font-weight-medium;
  color: $uni-text-color;
  margin-bottom: 6rpx;
}
.notice-desc {
  font-size: 24rpx;
  color: $uni-text-color-tertiary;
  margin-bottom: 6rpx;
}
.notice-time {
  font-size: 22rpx;
  color: $uni-text-color-placeholder;
  align-self: flex-end;
}
.notice-empty {
  text-align: center;
  font-size: 24rpx;
  color: $uni-text-color-tertiary;
  padding: 40rpx 0;
}
</style>