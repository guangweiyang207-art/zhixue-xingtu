<template>
  <view class="course-container">
    <view class="page-title">选课约课</view>

    <!-- 接口错误提示 -->
    <view class="page-error" v-if="courseErrMsg">
      <text class="page-error-icon">⚠️</text>
      <text class="page-error-text">{{ courseErrMsg }}</text>
    </view>

    <!-- 热门课程接口错误提示 -->
    <view class="page-error" v-if="hotErrMsg">
      <text class="page-error-icon">⚠️</text>
      <text class="page-error-text">{{ hotErrMsg }}</text>
    </view>

    <!-- 今日热门课程 -->
    <view class="hot-course" v-if="hotCourse && hotCourse.length > 0">
      <view class="hot-tag">今日热门</view>
      <view class="course-name">{{ hotCourse[0].cName }}</view>
      <view class="course-info">
        <text>{{ hotCourse[0].teacher.teacherName }} | {{ formatHotTime(hotCourse[0]) }}</text>
      </view>
      <view class="enroll-info">
        <view class="avatars">
          <image class="avatar" src="/static/images/avatar/avatar1.svg" mode="aspectFill"></image>
          <image class="avatar" src="/static/images/avatar/avatar2.svg" mode="aspectFill"></image>
          <image class="avatar" src="/static/images/avatar/avatar3.svg" mode="aspectFill"></image>
        </view>
        <text class="count">等{{ hotCourse[0].appointmentCount || hotCourse[0].currentPerson || 0 }}人已约</text>
      </view>
      <button class="reserve-btn" @click="reserveCourse(hotCourse[0].cId)">立即预约</button>
    </view>

    <!-- 分类标签 -->
    <view class="course-tabs">
      <view
        class="tab-item"
        :class="{ active: activeTab === tab.type }"
        v-for="tab in tabList"
        :key="tab.type"
        @click="onTabClick(tab.type)"
      >
        {{ tab.label }}
      </view>
    </view>

    <!-- 分类错误提示 -->
    <view class="tab-error" v-if="tabErrMsg">
      <text class="tab-error-icon">⚠️</text>
      <text class="tab-error-text">{{ tabErrMsg }}</text>
    </view>

    <!-- 课程列表 -->
    <view class="course-list" v-if="courseList && courseList.length > 0">
      <view class="course-item" v-for="(item, index) in courseList" :key="index">
        <view class="icon-box" :class="item.type">
          <text class="icon">{{ getCourseIcon(item.type) }}</text>
        </view>
        <view class="course-detail">
          <view class="course-title">{{ item.cName }}</view>
          <view class="meta">
            <text>◎ {{ item.remark ? item.remark.split('·')[0].trim() : '' }}</text>
            <text>⚙ {{ item.currentPerson }}/{{ item.maxPerson }}人</text>
          </view>
          <button class="reserve-course-btn" @click="reserveCourse(item.cId)">预约课程</button>
        </view>
      </view>
    </view>
    <view class="empty-list" v-else-if="!courseErrMsg && !tabErrMsg">
      <text class="empty-text">暂无课程数据</text>
    </view>
  </view>
</template>

<script>
import { getCourseListApi, getHotCourseApi, getCourseTypesApi } from '@/api/yueke/yueke.js'

export default {
  data() {
    return {
      activeTab: 'all',
      tabErrMsg: '',
      hotErrMsg: '',
      courseErrMsg: '',
      hotCourse: [],
      tabList: [
        { label: '全部课程', type: 'all' }
      ],
      courseList: [],
      iconMap: {
        physics: '⚛',
        english: '文A',
        math: '∑',
        chemistry: '🧪',
        chinese: '📖'
      }
    }
  },
  onLoad() {
    this.loadCourseTypes()
    this.loadHotCourse()
    this.loadCourseList()
  },
  onShow() {
    this.loadCourseTypes()
    this.loadHotCourse()
    this.loadCourseList()
  },
  methods: {
    getCourseIcon(type) {
      return this.iconMap[type] || '📚'
    },
    formatHotTime(course) {
      if (course.remark) {
        const parts = course.remark.split('·')
        return parts.length > 0 ? parts[0].trim() : ''
      }
      return ''
    },
    loadCourseTypes() {
      getCourseTypesApi().then(res => {
        if (res.data && Array.isArray(res.data)) {
          const dynamicTabs = res.data
            .filter(t => t !== null && t !== '')
            .map(t => ({ label: t, type: t }))
          this.tabList = [{ label: '全部课程', type: 'all' }, ...dynamicTabs]
        }
      }).catch(err => {
        const code = err.code || 404
        const msg = err.msg || '请求失败'
        this.tabErrMsg = `接口 ${code} 错误：${msg}`
        console.error('获取课程分类失败：', err)
      })
    },
    loadHotCourse() {
      this.hotErrMsg = ''
      getHotCourseApi().then(res => {
        if (res.data) {
          this.hotCourse = res.data
        }
      }).catch(err => {
        const code = err.code || 404
        const msg = err.msg || '请求失败'
        this.hotErrMsg = `接口 ${code} 错误：${msg}`
        console.error('获取热门课程失败：', err)
      })
    },
    loadCourseList() {
      this.courseErrMsg = ''
      getCourseListApi('all').then(res => {
        if (res.data) this.courseList = res.data
      }).catch(err => {
        const code = err.code || 404
        const msg = err.msg || '请求失败'
        this.courseErrMsg = `接口 ${code} 错误：${msg}`
        console.error('获取课程列表失败：', err)
      })
    },
    onTabClick(type) {
      this.activeTab = type
      this.tabErrMsg = ''

      getCourseListApi(type).then(res => {
        if (res.data) {
          this.courseList = res.data
        }
      }).catch(err => {
        const code = err.code || 404
        const msg = err.msg || '请求失败'
        this.tabErrMsg = `接口 ${code} 错误：${msg}`
        console.error('获取课程列表失败：', err)
      })
    },
    reserveCourse(cId) {
      uni.navigateTo({ url: '/pages/yueke/index?c_id=' + (cId || 1) })
    }
  }
};
</script>

<style scoped>
.course-container {
  padding: 20rpx;
  background-color: #f5f7fa;
  min-height: 100vh;
}
.page-title {
  font-size: 40rpx;
  font-weight: bold;
  margin: 20rpx 0;
}

.page-error {
  display: flex; align-items: center; gap: 10rpx;
  background: #fef2f2; border: 1rpx solid #fecaca; border-radius: 12rpx;
  padding: 16rpx 20rpx; margin-bottom: 20rpx;
}
.page-error-icon { font-size: 28rpx; flex-shrink: 0; }
.page-error-text { font-size: 24rpx; color: #b91c1c; }

.hot-course {
  background: linear-gradient(135deg, #667eea 0%, #a855f7 100%);
  border-radius: 20rpx;
  padding: 30rpx;
  color: #fff;
  margin-bottom: 30rpx;
  position: relative;
}
.hot-tag {
  background: rgba(255,255,255,0.2);
  padding: 8rpx 20rpx;
  border-radius: 20rpx;
  font-size: 26rpx;
  display: inline-block;
}
.course-name {
  font-size: 40rpx;
  font-weight: bold;
  margin: 15rpx 0;
}
.course-info {
  font-size: 28rpx;
  opacity: 0.9;
  margin-bottom: 20rpx;
}
.enroll-info {
  display: flex;
  align-items: center;
}
.avatars {
  display: flex;
}
.avatar {
  width: 50rpx;
  height: 50rpx;
  border-radius: 50%;
  background: rgba(255,255,255,0.3);
  margin-right: -10rpx;
  border: 2rpx solid #fff;
  overflow: hidden;
  flex-shrink: 0;
}
.count {
  margin-left: 15rpx;
  font-size: 26rpx;
}
.reserve-btn {
  position: absolute;
  right: 30rpx;
  bottom: 30rpx;
  background: #fff;
  color: #667eea;
  border-radius: 30rpx;
  padding: 15rpx 30rpx;
  font-size: 28rpx;
  border: none;
}
.course-tabs {
  display: flex;
  flex-wrap: nowrap;
  overflow-x: auto;
  white-space: nowrap;
  margin-bottom: 25rpx;
}
.tab-item {
  padding: 15rpx 25rpx;
  background: #fff;
  border-radius: 30rpx;
  font-size: 27rpx;
  margin-right: 15rpx;
  flex-shrink: 0;
  white-space: nowrap;
}
.tab-item.active {
  background: #667eea;
  color: #fff;
}
.tab-error {
  background: #fef2f2;
  border: 1rpx solid #fecaca;
  border-radius: 12rpx;
  padding: 16rpx 20rpx;
  margin-bottom: 20rpx;
  display: flex;
  align-items: center;
  gap: 10rpx;
}
.tab-error-icon {
  font-size: 28rpx;
  flex-shrink: 0;
}
.tab-error-text {
  font-size: 24rpx;
  color: #b91c1c;
}
.course-list {
  background: #fff;
  border-radius: 20rpx;
  overflow: hidden;
}
.course-item {
  display: flex;
  padding: 30rpx;
  border-bottom: 1rpx solid #f0f0f0;
}
.icon-box {
  width: 120rpx;
  height: 120rpx;
  border-radius: 20rpx;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 20rpx;
}
.icon-box.physics {
  background: #e8f3ff;
}
.icon-box.english {
  background: #f8f0ff;
}
.icon {
  font-size: 50rpx;
  color: #667eea;
}
.course-detail {
  flex: 1;
}
.course-title {
  font-size: 32rpx;
  font-weight: bold;
  margin-bottom: 15rpx;
}
.meta {
  display: flex;
  justify-content: space-between;
  color: #999;
  font-size: 26rpx;
  margin-bottom: 20rpx;
}
.reserve-course-btn {
  width: 100%;
  background: #f0f5ff;
  color: #667eea;
  border-radius: 10rpx;
  padding: 15rpx;
  font-size: 27rpx;
  border: none;
}
.empty-list {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 60rpx 0;
}
.empty-text {
  font-size: 28rpx;
  color: #999;
}
</style>