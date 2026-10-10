<template>
  <view class="page">
    <!-- 顶部 -->
    <view class="header">
      <view class="header-bg"></view>
      <view class="header-content">
        <view class="header-top">
          <text class="back-btn" @click="goBack">〈 返回</text>
        </view>
        <text class="header-title">课程预约</text>
        <text class="header-sub">一键快速预约</text>
      </view>
    </view>

    <scroll-view scroll-y class="scroll" :style="{ height: scrollHeight + 'px' }">
      <!-- 课程详情（写死） -->
      <view class="section">
        <view class="section-head">
          <text class="section-title">课程详情</text>
        </view>
        <!-- 课程详情接口错误 -->
        <view class="error-bar" v-if="detailErrMsg" style="margin-bottom:20rpx;">
          <text class="error-icon">⚠️</text>
          <text class="error-text">{{ detailErrMsg }}</text>
        </view>
        <view class="detail-card">
          <view class="detail-header">
            <view class="detail-icon">
            <text class="detail-icon-text">{{ courseDetail.icon || '⚛' }}</text>
          </view>
          <view class="detail-title-area">
            <text class="detail-course-name">{{ courseDetail.name || '初中物理：力学基础突破' }}</text>
            <text class="detail-course-teacher">{{ courseDetail.teacher || '张明老师 · 12课时' }}</text>
          </view>
          </view>
          <view class="detail-divider"></view>
          <view class="detail-row">
            <text class="detail-label">上课时间</text>
            <text class="detail-value">{{ courseDetail.time || '周六 14:00 - 15:30' }}</text>
          </view>
          <view class="detail-row">
            <text class="detail-label">课时时长</text>
            <text class="detail-value">{{ courseDetail.duration || '1.5小时' }}</text>
          </view>
          <view class="detail-row">
            <text class="detail-label">课程人数</text>
            <view class="detail-count">
              <view class="count-track">
                <view class="count-fill" :style="'width:' + (courseDetail.fillRate || 80) + '%'"></view>
              </view>
              <text class="count-text">{{ courseDetail.count || '24/30人' }}</text>
            </view>
          </view>
        </view>
      </view>

      <!-- 课程介绍 -->
      <view class="section">
        <view class="section-head">
          <text class="section-title">课程介绍</text>
        </view>
        <view class="intro-card">
          <view class="intro-row">
            <text class="intro-label">课程类型</text>
            <text class="intro-value">{{ courseDetail.type || '—' }}</text>
          </view>
          <view class="intro-divider"></view>
          <view class="intro-row">
            <text class="intro-label">课程标签</text>
            <text class="intro-value">{{ courseDetail.tag || '—' }}</text>
          </view>
          <view class="intro-divider"></view>
          <view class="intro-row">
            <text class="intro-label">难度等级</text>
            <text class="intro-value">{{ courseDetail.difficultyText || '—' }}</text>
          </view>
          <view class="intro-divider"></view>
          <view class="intro-row intro-row-block">
            <text class="intro-label">课程描述</text>
            <text class="intro-desc">{{ courseDetail.description || '暂无描述' }}</text>
          </view>
          <view class="intro-divider"></view>
          <view class="intro-row">
            <text class="intro-label">课程备注</text>
            <text class="intro-value">{{ courseDetail.remark || '—' }}</text>
          </view>
        </view>
      </view>

      <!-- 提交按钮 -->
      <button class="submit-btn" @click="submitReserve" :disabled="submitting">
        <text v-if="!submitting">提交预约</text>
        <text v-else>提交中...</text>
      </button>

      <!-- 错误提示 -->
      <view class="error-bar" v-if="errMsg">
        <text class="error-icon">⚠️</text>
        <view class="error-body">
          <text class="error-text">{{ errMsg }}</text>
        </view>
      </view>

      <view class="bottom-space"></view>
    </scroll-view>
  </view>
</template>

<script>
import { reserveCourseApi, getCourseDetailApi } from '@/api/yueke/yueke.js'

const DIFFICULTY_MAP = { 1: '简单', 2: '中等', 3: '困难' }

export default {
  data() {
    return {
      scrollHeight: 600,
      cId: 1,
      iconMap: {
        physics: '⚛',
        english: '文A',
        math: '∑',
        chemistry: '🧪',
        chinese: '📖'
      },
      courseDetail: {},
      detailErrMsg: '',
      errMsg: '',
      submitting: false
    }
  },
  onLoad(options) {
    const sys = uni.getSystemInfoSync()
    this.scrollHeight = sys.windowHeight
    this.cId = options.c_id || 1
    this.loadCourseDetail()
  },
  methods: {
    loadCourseDetail() {
      this.detailErrMsg = ''
      getCourseDetailApi(this.cId).then(res => {
        if (res.data) {
          const d = res.data
          const parts = d.remark ? d.remark.split(' · ') : []
          this.courseDetail = {
            icon: this.iconMap[d.type] || '📚',
            name: d.cName,
            teacher: parts[1] ? (parts[1] + ' · ' + (parts[2] || '')) : (d.teacher ? d.teacher.teacherName + ' · 12课时' : ''),
            time: parts[0] || '',
            duration: parts[2] || '',
            count: (d.currentPerson || 0) + '/' + (d.maxPerson || 0) + '人',
            fillRate: d.maxPerson > 0 ? Math.round((d.currentPerson / d.maxPerson) * 100) : 0,
            type: d.type || '',
            tag: d.tag || '',
            difficulty: d.difficulty,
            difficultyText: DIFFICULTY_MAP[d.difficulty] || '',
            description: d.description || '',
            remark: d.remark || ''
          }
        }
      }).catch(err => {
        const code = err.code || 404
        const msg = err.msg || '请求失败'
        this.detailErrMsg = `接口 ${code} 错误：${msg}`
        console.error('获取课程详情失败：', err)
      })
    },
    goBack() {
      uni.navigateBack()
    },
    submitReserve() {
      if (this.submitting) return

      const stuId = uni.getStorageSync('userInfo')?.stu_id
      if (!stuId) {
        uni.showToast({ title: '未获取到登录学生信息', icon: 'none' })
        return
      }

      uni.showModal({
        title: '确认预约',
        content: `课程：${this.courseDetail.name || ''}\n\n是否确认预约该课程？`,
        cancelText: '取消',
        confirmText: '确认',
        success: (res) => {
          if (res.confirm) {
            this.doReserve(1)
          } else if (res.cancel) {
            this.doReserve(0)
          }
        }
      })
    },
    doReserve(status) {
      this.submitting = true
      const stuId = uni.getStorageSync('userInfo')?.stu_id
      const params = {
        stu_id: stuId,
        c_id: this.cId,
        status: status
      }

      reserveCourseApi(params).then(res => {
        const tip = status === 1 ? '预约成功' : '已保存，待确认'
        uni.showToast({ title: tip, icon: 'success' })
        this.errMsg = ''
        setTimeout(() => {
          uni.navigateBack()
        }, 1200)
      }).catch(err => {
        const msg = err.msg || '请求失败'
        this.errMsg = msg
        console.error('预约失败：', err)
      }).finally(() => {
        this.submitting = false
      })
    }
  }
}
</script>

<style scoped>
page {
  background: #f5f6fa;
}

.page {
  min-height: 100vh;
  background: #f5f6fa;
}

.header {
  position: relative;
  padding: 60rpx 32rpx 48rpx;
  overflow: hidden;
}

.header-bg {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(135deg, #6b5aed 0%, #a855f7 50%, #ec4899 100%);
  border-radius: 0 0 48rpx 48rpx;
}

.header-content {
  position: relative;
  z-index: 1;
}

.header-top {
  margin-bottom: 20rpx;
}

.back-btn {
  font-size: 26rpx;
  color: rgba(255, 255, 255, 0.9);
  padding: 8rpx 0;
}

.header-title {
  display: block;
  font-size: 48rpx;
  font-weight: 700;
  color: #fff;
  margin-bottom: 8rpx;
}

.header-sub {
  font-size: 26rpx;
  color: rgba(255, 255, 255, 0.85);
}

.scroll {
  padding: 0 24rpx;
  box-sizing: border-box;
  margin-top: -20rpx;
}

.section {
  margin-bottom: 28rpx;
}

.section-head {
  margin-bottom: 16rpx;
}

.section-title {
  font-size: 32rpx;
  font-weight: 600;
  color: #111827;
}

/* Detail Card */
.detail-card {
  background: #fff;
  border-radius: 20rpx;
  padding: 28rpx 24rpx;
  box-shadow: 0 4rpx 16rpx rgba(15, 23, 42, 0.04);
}

.detail-header {
  display: flex;
  align-items: center;
  gap: 20rpx;
}

.detail-icon {
  width: 80rpx;
  height: 80rpx;
  background: #eef2ff;
  border-radius: 16rpx;
  display: flex;
  align-items: center;
  justify-content: center;
}

.detail-icon-text {
  font-size: 40rpx;
}

.detail-title-area {
  flex: 1;
  min-width: 0;
}

.detail-course-name {
  display: block;
  font-size: 30rpx;
  font-weight: 600;
  color: #111827;
  margin-bottom: 6rpx;
}

.detail-course-teacher {
  font-size: 24rpx;
  color: #9ca3af;
}

.detail-divider {
  height: 1rpx;
  background: #f3f4f6;
  margin: 20rpx 0;
}

.detail-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 14rpx 0;
}

.detail-label {
  font-size: 26rpx;
  color: #6b7280;
}

.detail-value {
  font-size: 26rpx;
  color: #111827;
  font-weight: 500;
}

.detail-count {
  display: flex;
  align-items: center;
  gap: 12rpx;
}

.count-track {
  width: 120rpx;
  height: 8rpx;
  background: #f3f4f6;
  border-radius: 999rpx;
  overflow: hidden;
}

.count-fill {
  height: 100%;
  background: linear-gradient(90deg, #6b5aed, #a78bfa);
  border-radius: 999rpx;
}

.count-text {
  font-size: 24rpx;
  color: #6b5aed;
  font-weight: 500;
}

/* Intro */
.intro-card {
  background: #fff;
  border-radius: 20rpx;
  padding: 8rpx 24rpx;
  box-shadow: 0 4rpx 16rpx rgba(15, 23, 42, 0.04);
}

.intro-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 24rpx 0;
  gap: 16rpx;
}

.intro-row-block {
  display: block;
}

.intro-label {
  font-size: 26rpx;
  color: #6b7280;
  font-weight: 500;
  flex-shrink: 0;
}

.intro-value {
  font-size: 26rpx;
  color: #111827;
  text-align: right;
  flex: 1;
  word-break: break-all;
}

.intro-desc {
  display: block;
  font-size: 26rpx;
  color: #374151;
  line-height: 1.6;
  margin-top: 12rpx;
  word-break: break-all;
}

.intro-divider {
  height: 1rpx;
  background: #f3f4f6;
}

/* Submit */
.submit-btn {
  width: 100%;
  padding: 28rpx;
  background: linear-gradient(135deg, #6b5aed, #7c3aed);
  color: #fff;
  border-radius: 16rpx;
  font-size: 32rpx;
  font-weight: 600;
  border: none;
  box-shadow: 0 8rpx 24rpx rgba(107, 90, 237, 0.3);
}

.submit-btn[disabled] {
  opacity: 0.5;
}

.bottom-space {
  height: 48rpx;
}

/* Error Bar */
.error-bar {
  margin-top: 24rpx;
  background: #fef2f2;
  border: 1rpx solid #fecaca;
  border-radius: 16rpx;
  padding: 24rpx;
  display: flex;
  gap: 16rpx;
}

.error-icon {
  font-size: 40rpx;
  flex-shrink: 0;
  margin-top: 4rpx;
}

.error-body {
  flex: 1;
  min-width: 0;
}

.error-text {
  display: block;
  font-size: 24rpx;
  color: #b91c1c;
}
</style>