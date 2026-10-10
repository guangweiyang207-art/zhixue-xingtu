<template>
  <view class="page">
    <view class="header">
      <view class="header-bg"></view>
      <view class="header-content">
        <view class="header-top">
          <text class="back-btn" @click="goBack">〈 返回</text>
        </view>
        <text class="header-title">我的课程</text>
        <text class="header-sub">已选课程与待确认预约</text>
      </view>
    </view>

    <view class="body">
      <!-- 错误提示 -->
      <view class="error-bar" v-if="apiErrMsg">
        <text class="error-icon">!</text>
        <text class="error-text">{{ apiErrMsg }}</text>
      </view>

      <!-- Tab 切换 -->
      <view class="tab-bar">
        <view class="tab-item" :class="{ active: activeTab === 'confirmed' }" @click="switchTab('confirmed')">
          <text class="tab-label">已选</text>
          <text class="tab-count">{{ confirmedList.length }}</text>
        </view>
        <view class="tab-item" :class="{ active: activeTab === 'pending' }" @click="switchTab('pending')">
          <text class="tab-label">待确认</text>
          <text class="tab-count pending">{{ pendingList.length }}</text>
        </view>
      </view>

      <!-- 已选列表 -->
      <view class="course-list" v-if="activeTab === 'confirmed'">
        <view class="course-card" v-for="(item, index) in confirmedList" :key="index">
          <view class="card-top">
            <view class="card-icon" :class="item.type">
              <text>{{ item.icon }}</text>
            </view>
            <view class="card-info">
              <text class="card-name">{{ item.cName }}</text>
              <text class="card-time">⏰ {{ item.timeText }}</text>
            </view>
          </view>
          <view class="card-meta">
            <text class="meta-person">👥 {{ item.currentPerson }}/{{ item.maxPerson }}人</text>
            <text class="meta-status confirmed">已确认</text>
          </view>
        </view>
        <view class="empty" v-if="confirmedList.length === 0">
          <text class="empty-icon">📚</text>
          <text class="empty-text">暂无已选课程</text>
        </view>
      </view>

      <!-- 待确认列表 -->
      <view class="course-list" v-if="activeTab === 'pending'">
        <view class="pending-wrap" v-for="(item, index) in pendingList" :key="index"
              @touchstart="onTouchStart($event, item)"
              @touchmove="onTouchMove($event, item)"
              @touchend="onTouchEnd($event, item)">
          <view class="pending-card" :style="{ transform: 'translateX(' + item.swipeX + 'px)' }">
            <view class="pending-top">
              <view class="pending-info">
                <text class="pending-name">{{ item.cName }}</text>
                <text class="pending-time">⏰ {{ item.timeText }}</text>
              </view>
              <text class="pending-tag">待确认</text>
            </view>
            <!-- 倒计时 -->
            <view class="countdown-bar">
              <text class="countdown-label">剩余确认时间</text>
              <text class="countdown-time" :class="{ urgent: item.remainingMinutes <= 5 }">
                {{ item.countdownText }}
              </text>
            </view>
            <view class="pending-actions">
              <text class="action-btn cancel" @click.stop="confirmCancel(item)">取消预约</text>
              <text class="action-btn confirm" @click.stop="confirmNow(item)">确认预约</text>
            </view>
          </view>
          <!-- 右滑露出的删除按钮 -->
          <view class="swipe-delete" @click.stop="swipeDelete(item)">
            <text class="swipe-delete-text">删除</text>
          </view>
        </view>
        <view class="empty" v-if="pendingList.length === 0">
          <text class="empty-icon">⏳</text>
          <text class="empty-text">暂无待确认预约</text>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
import { getMyCourseListApi, cancelReserveApi } from '@/api/mycourse/mycourse.js'

const PENDING_DURATION = 30 // 30分钟

const iconMap = {
  physics: '⚛', english: '文A', math: '∑',
  chemistry: '🧪', chinese: '📖'
}

export default {
  data() {
    return {
      apiErrMsg: '',
      activeTab: 'confirmed',
      confirmedList: [],
      pendingList: [],
      timer: null,
      touchStartX: 0,
      SWIPE_THRESHOLD: 60 // 滑动多少 px 露出删除按钮
    }
  },
  onLoad() {
    const stuId = uni.getStorageSync('userInfo')?.stu_id || 1
    this.stuId = stuId
    this.loadData()
  },
  onUnload() {
    if (this.timer) {
      clearInterval(this.timer)
      this.timer = null
    }
  },
  methods: {
    loadData() {
      const stuId = this.stuId || uni.getStorageSync('userInfo')?.stu_id || 1
      this.stuId = stuId
      this.apiErrMsg = ''

      getMyCourseListApi(stuId, null).then(res => {
        if (!res.data || !Array.isArray(res.data)) {
          this.confirmedList = []
          this.pendingList = []
          return
        }
        const raw = res.data
        this.confirmedList = raw.filter(d => d.status === 1).map(d => this.formatConfirmed(d))
        this.pendingList = raw.filter(d => d.status === 0).map(d => this.formatPending(d))

        // 启动倒计时
        this.startCountdown()
      }).catch(err => {
        this.apiErrMsg = `接口 ${err.code || 404} 错误：${err.msg || '请求失败'}`
        console.error('获取课程列表失败：', err)
      })
    },
    formatConfirmed(d) {
      return {
        caId: d.ca_id,
        cId: d.c_id,
        cName: d.c_name,
        type: d.type,
        icon: iconMap[d.type] || '📚',
        currentPerson: d.current_person || 0,
        maxPerson: d.max_person || 0,
        timeText: this.formatTimeRange(d.start_time, d.end_time)
      }
    },
    formatPending(d) {
      const createTime = new Date(d.create_time).getTime()
      const now = Date.now()
      const elapsed = Math.floor((now - createTime) / 1000) // seconds
      const remaining = PENDING_DURATION * 60 - elapsed
      const remainingMinutes = Math.max(0, Math.ceil(remaining / 60))

      return {
        caId: d.ca_id,
        cId: d.c_id,
        cName: d.c_name,
        type: d.type,
        icon: iconMap[d.type] || '📚',
        timeText: this.formatTimeRange(d.start_time, d.end_time),
        createTime: d.create_time,
        remainingSeconds: Math.max(0, remaining),
        remainingMinutes: remainingMinutes,
        countdownText: this.buildCountdownText(remaining),
        swipeX: 0
      }
    },
    buildCountdownText(remainingSeconds) {
      if (remainingSeconds <= 0) return '00:00'
      const m = Math.floor(remainingSeconds / 60)
      const s = remainingSeconds % 60
      return String(m).padStart(2, '0') + ':' + String(s).padStart(2, '0')
    },
    startCountdown() {
      if (this.timer) clearInterval(this.timer)
      this.timer = setInterval(() => {
        let hasExpired = false
        this.pendingList.forEach(item => {
          if (item.remainingSeconds <= 0) return
          item.remainingSeconds--
          item.remainingMinutes = Math.max(0, Math.ceil(item.remainingSeconds / 60))
          item.countdownText = this.buildCountdownText(item.remainingSeconds)

          if (item.remainingSeconds <= 0) {
            hasExpired = true
          }
        })

        if (hasExpired) {
          // 将过期项自动从列表移除（状态自动改为2）
          const expired = this.pendingList.filter(i => i.remainingSeconds <= 0)
          expired.forEach(item => {
            cancelReserveApi(item.caId).catch(() => {})
          })
          this.pendingList = this.pendingList.filter(i => i.remainingSeconds > 0)
        }
      }, 1000)
    },
    formatTimeRange(start, end) {
      if (!start && !end) return ''
      const s = start ? this.fmt(start) : ''
      const e = end ? this.fmt(end) : ''
      if (s && e) return s + ' ~ ' + e
      return s || e || ''
    },
    fmt(t) {
      if (!t) return ''
      const d = new Date(t)
      const month = d.getMonth() + 1
      const day = d.getDate()
      const h = String(d.getHours()).padStart(2, '0')
      const m = String(d.getMinutes()).padStart(2, '0')
      return month + '/' + day + ' ' + h + ':' + m
    },
    switchTab(tab) {
      this.activeTab = tab
    },
    // 右滑删除 - 触摸事件
    onTouchStart(e, item) {
      this.touchStartX = e.touches[0].clientX
    },
    onTouchMove(e, item) {
      const dx = e.touches[0].clientX - this.touchStartX
      // 只允许向左滑（负值）
      if (dx < 0) {
        item.swipeX = Math.max(dx, -this.SWIPE_THRESHOLD - 20)
      } else if (item.swipeX < 0) {
        // 向右滑回
        item.swipeX = Math.min(0, dx - this.SWIPE_THRESHOLD - 20)
      }
    },
    onTouchEnd(e, item) {
      if (item.swipeX < -this.SWIPE_THRESHOLD) {
        item.swipeX = -(this.SWIPE_THRESHOLD + 20)
      } else {
        item.swipeX = 0
      }
      // 收起其他卡片的滑动
      this.pendingList.forEach(i => {
        if (i !== item) i.swipeX = 0
      })
    },
    swipeDelete(item) {
      uni.showModal({
        title: '删除预约',
        content: `确定要删除「${item.cName}」的预约吗？`,
        success: (res) => {
          item.swipeX = 0
          if (res.confirm) {
            cancelReserveApi(item.caId).then(() => {
              uni.showToast({ title: '已删除', icon: 'success' })
              this.loadData()
            }).catch(err => {
              uni.showToast({ title: err.msg || '删除失败', icon: 'none' })
            })
          }
        }
      })
    },
    confirmCancel(item) {
      uni.showModal({
        title: '取消预约',
        content: `确定要取消「${item.cName}」的预约吗？`,
        success: (res) => {
          if (res.confirm) {
            cancelReserveApi(item.caId).then(() => {
              uni.showToast({ title: '已取消', icon: 'success' })
              this.loadData()
            }).catch(err => {
              uni.showToast({ title: err.msg || '取消失败', icon: 'none' })
            })
          }
        }
      })
    },
    confirmNow(item) {
      uni.showModal({
        title: '确认预约',
        content: `确定要确认「${item.cName}」的预约吗？`,
        success: (res) => {
          if (!res.confirm) return
          // 调用修改状态接口将 status 从 0 改为 1
          // 直接使用 cancel + re-book 方式，或者用 update endpoint
          // 简单处理: 先取消旧的，再重新提交确认
          this.confirmPending(item)
        }
      })
    },
    confirmPending(item) {
      // 直接通过新增预约接口重新提交确认
      const stuId = this.stuId || uni.getStorageSync('userInfo')?.stu_id || 1
      const params = {
        stu_id: stuId,
        stu_no: '',
        c_id: item.cId,
        name: '',
        phone: '',
        remark: '用户确认',
        status: 1
      }
      // 使用导入的 reserveCourseApi
      const { reserveCourseApi } = require('@/api/yueke/yueke.js')
      reserveCourseApi(params).then(() => {
        uni.showToast({ title: '预约成功', icon: 'success' })
        // 取消旧的待确认记录
        cancelReserveApi(item.caId).catch(() => {})
        this.loadData()
      }).catch(err => {
        uni.showToast({ title: err.msg || '确认失败', icon: 'none' })
      })
    },
    goBack() {
      uni.navigateBack()
    }
  }
}
</script>

<style scoped>
page { background: #f5f6fa; }
.page { min-height: 100vh; background: #f5f6fa; }

.header {
  position: relative;
  padding: 80rpx 32rpx 48rpx;
  overflow: hidden;
}
.header-bg {
  position: absolute;
  top: 0; left: 0; right: 0; bottom: 0;
  background: linear-gradient(135deg, #6b5aed 0%, #a855f7 50%, #ec4899 100%);
  border-radius: 0 0 48rpx 48rpx;
}
.header-content { position: relative; z-index: 1; }
.header-top { margin-bottom: 20rpx; }
.back-btn { font-size: 26rpx; color: rgba(255,255,255,0.9); padding: 8rpx 0; }
.header-title { display: block; font-size: 48rpx; font-weight: 700; color: #fff; margin-bottom: 8rpx; }
.header-sub { font-size: 26rpx; color: rgba(255,255,255,0.85); }

.body { padding: 24rpx; }

.error-bar {
  display: flex; align-items: center; gap: 12rpx;
  background: #fef2f2; border: 1rpx solid #fecaca; border-radius: 12rpx;
  padding: 18rpx 20rpx; margin-bottom: 20rpx;
}
.error-icon {
  width: 36rpx; height: 36rpx; border-radius: 50%;
  background: #dc2626; color: #fff; font-size: 22rpx;
  display: flex; align-items: center; justify-content: center; flex-shrink: 0;
}
.error-text { font-size: 24rpx; color: #dc2626; }

/* Tab */
.tab-bar {
  display: flex; background: #fff; border-radius: 16rpx;
  padding: 6rpx; margin-bottom: 20rpx; box-shadow: 0 2rpx 12rpx rgba(0,0,0,0.04);
}
.tab-item {
  flex: 1; display: flex; align-items: center; justify-content: center;
  padding: 18rpx 0; border-radius: 12rpx; gap: 8rpx;
}
.tab-item.active { background: linear-gradient(135deg, #6b5aed, #a855f7); }
.tab-label { font-size: 28rpx; font-weight: 600; color: #6b7280; }
.tab-item.active .tab-label { color: #fff; }
.tab-count {
  font-size: 22rpx; padding: 2rpx 14rpx; border-radius: 20rpx;
  background: #f3f4f6; color: #6b7280;
}
.tab-item.active .tab-count { background: rgba(255,255,255,0.25); color: #fff; }
.tab-count.pending { color: #f59e0b; }

/* Course List */
.course-list { margin-bottom: 30rpx; }

.course-card {
  background: #fff; border-radius: 20rpx; padding: 24rpx;
  margin-bottom: 16rpx; box-shadow: 0 4rpx 16rpx rgba(15,23,42,0.04);
}
.card-top { display: flex; align-items: center; gap: 16rpx; margin-bottom: 14rpx; }
.card-icon {
  width: 72rpx; height: 72rpx; border-radius: 16rpx;
  display: flex; align-items: center; justify-content: center; flex-shrink: 0;
  font-size: 32rpx;
}
.card-icon.physics { background: #eef2ff; }
.card-icon.english { background: #fef2f2; }
.card-icon.math { background: #f0fdf4; }
.card-icon.chemistry { background: #fef3c7; }
.card-icon.chinese { background: #fce7f3; }

.card-info { flex: 1; min-width: 0; }
.card-name { display: block; font-size: 28rpx; font-weight: 600; color: #111827; margin-bottom: 4rpx; }
.card-time { font-size: 24rpx; color: #9ca3af; }

.card-meta {
  display: flex; align-items: center; justify-content: space-between;
  padding-top: 14rpx; border-top: 1rpx solid #f3f4f6;
}
.meta-person { font-size: 24rpx; color: #6b7280; }
.meta-status {
  font-size: 22rpx; padding: 4rpx 16rpx; border-radius: 8rpx;
}
.meta-status.confirmed { background: #eef2ff; color: #6b5aed; }

/* Pending card */
.pending-wrap {
  position: relative; overflow: hidden; margin-bottom: 16rpx; border-radius: 20rpx;
}
.pending-card {
  background: #fff; border-radius: 20rpx; padding: 24rpx;
  border-left: 6rpx solid #f59e0b;
  transition: transform 0.2s ease;
  position: relative; z-index: 1;
}
.pending-top {
  display: flex; align-items: flex-start; justify-content: space-between; margin-bottom: 16rpx;
}
.pending-info { flex: 1; }
.pending-name { display: block; font-size: 28rpx; font-weight: 600; color: #111827; margin-bottom: 4rpx; }
.pending-time { font-size: 24rpx; color: #9ca3af; }
.pending-tag {
  font-size: 22rpx; padding: 4rpx 16rpx; border-radius: 8rpx;
  background: #fef3c7; color: #f59e0b; flex-shrink: 0;
}

/* Countdown */
.countdown-bar {
  display: flex; align-items: center; gap: 12rpx;
  background: #fffbeb; border-radius: 12rpx;
  padding: 16rpx 20rpx; margin-bottom: 16rpx;
}
.countdown-label { font-size: 24rpx; color: #92400e; }
.countdown-time {
  font-size: 32rpx; font-weight: 700; color: #f59e0b; font-family: monospace;
}
.countdown-time.urgent { color: #dc2626; animation: pulse 1s infinite; }

@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.5; }
}

.pending-actions {
  display: flex; gap: 16rpx;
}
.action-btn {
  flex: 1; text-align: center; padding: 20rpx 0;
  border-radius: 12rpx; font-size: 26rpx; font-weight: 600;
}
.action-btn.cancel {
  background: #fef2f2; color: #dc2626;
}
.action-btn.confirm {
  background: linear-gradient(135deg, #6b5aed, #a855f7);
  color: #fff;
}

/* Swipe delete */
.swipe-delete {
  position: absolute; right: 0; top: 0; bottom: 0;
  width: 140rpx; background: #dc2626;
  display: flex; align-items: center; justify-content: center;
  border-radius: 0 20rpx 20rpx 0;
}
.swipe-delete-text { color: #fff; font-size: 28rpx; font-weight: 600; }

/* Empty */
.empty {
  display: flex; flex-direction: column; align-items: center;
  padding: 80rpx 0;
}
.empty-icon { font-size: 80rpx; margin-bottom: 20rpx; }
.empty-text { font-size: 28rpx; color: #9ca3af; }
</style>