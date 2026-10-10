<template>
  <view class="page">
    <view class="header">
      <view class="header-bg"></view>
      <view class="header-content">
        <view class="header-top">
          <text class="back-btn" @click="goBack">〈 返回</text>
        </view>
        <text class="header-title">今日提醒</text>
        <text class="header-sub">管理你的学习提醒事项</text>
      </view>
    </view>

    <view class="body">
      <!-- 接口错误提示 -->
      <view class="error-bar" v-if="apiErrMsg">
        <text class="error-icon">⚠️</text>
        <text class="error-text">{{ apiErrMsg }}</text>
      </view>

      <!-- 提醒列表 -->
      <view class="reminder-list">
        <view
          class="reminder-item-wrapper"
          v-for="(item, index) in reminders"
          :key="index"
        >
          <!-- 右滑操作按钮 -->
          <view class="swipe-actions" :class="{ visible: item.swiping }">
            <view class="action-btn action-update" @click="showUpdate(item)">更新</view>
            <view class="action-btn action-delete" @click="confirmDelete(item)">删除</view>
          </view>

          <!-- 提醒卡片 -->
          <view
            class="reminder-item"
            :class="{ swiping: item.swiping }"
            @touchstart="onTouchStart($event, index)"
            @touchmove="onTouchMove($event, index)"
            @touchend="onTouchEnd($event, index)"
          >
            <view class="reminder-left">
              <view class="reminder-time">
                <text class="time-hour">{{ item.hour }}</text>
                <text class="time-colon">:</text>
                <text class="time-minute">{{ item.minute }}</text>
              </view>
              <view class="time-ampm">{{ item.ampm }}</view>
            </view>
            <view class="reminder-divider"></view>
            <view class="reminder-body">
              <text class="reminder-title">{{ item.title }}</text>
              <text class="reminder-desc">{{ item.desc }}</text>
              <view class="reminder-repeat" v-if="item.repeat">
                <text class="repeat-icon">🔁</text>
                <text class="repeat-text">{{ item.repeat }}</text>
              </view>
            </view>
            <switch class="reminder-switch" :checked="item.enabled" color="#6b5aed" @change="toggleReminder(index)" />
          </view>
        </view>
      </view>

      <!-- 空状态 -->
      <view class="empty" v-if="reminders.length === 0">
        <text class="empty-icon">🔔</text>
        <text class="empty-text">暂无提醒</text>
        <text class="empty-hint">点击下方按钮添加提醒</text>
      </view>

      <!-- 添加提醒按钮 -->
      <button class="add-btn" @click="addReminder">
        <text class="add-icon">+</text>
        <text>添加提醒</text>
      </button>
    </view>

    <!-- 删除确认弹窗 -->
    <view class="modal-overlay" v-if="showDeleteModal" @click="cancelDelete">
      <view class="modal-box" @click.stop>
        <view class="modal-icon">🗑️</view>
        <text class="modal-title">是否删除</text>
        <text class="modal-desc">确定要删除「{{ deleteTarget ? deleteTarget.title : '' }}」提醒吗？</text>
        <view class="modal-actions">
          <button class="modal-btn modal-cancel" @click="cancelDelete">取消</button>
          <button class="modal-btn modal-confirm" @click="doDelete">确认</button>
        </view>
      </view>
    </view>

    <!-- 更新弹窗 -->
    <view class="modal-overlay" v-if="showUpdateModal" @click="closeUpdate">
      <view class="modal-box update-box" @click.stop>
        <view class="modal-icon">✏️</view>
        <text class="modal-title">更新提醒</text>

        <view class="form-group">
          <text class="form-label">标题</text>
          <input class="form-input" v-model="updateForm.title" placeholder="提醒标题" />
        </view>
        <view class="form-group">
          <text class="form-label">内容</text>
          <input class="form-input" v-model="updateForm.desc" placeholder="提醒内容" />
        </view>
        <view class="form-group">
          <text class="form-label">时间</text>
          <picker mode="time" :value="updateForm.time" @change="onUpdateTimeChange">
            <view class="form-input picker-value">{{ updateForm.time || '请选择时间' }}</view>
          </picker>
        </view>
        <view class="form-group">
          <text class="form-label">重复</text>
          <picker :range="repeatOptions" :value="updateRepeatIndex" @change="onUpdateRepeatChange">
            <view class="form-input picker-value">{{ updateForm.repeat || '请选择' }}</view>
          </picker>
        </view>

        <view class="modal-actions">
          <button class="modal-btn modal-cancel" @click="closeUpdate">取消</button>
          <button class="modal-btn modal-confirm" @click="doUpdate">确认</button>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
import { getReminderListApi, deleteReminderApi, getReminderByIdApi, updateReminderApi } from '@/api/reminder/reminder.js'

export default {
  data() {
    return {
      apiErrMsg: '',
      reminders: [],

      // 删除
      showDeleteModal: false,
      deleteTarget: null,

      // 更新
      showUpdateModal: false,
      updateTarget: null,
      updateForm: { title: '', desc: '', time: '', repeat: '' },
      repeatOptions: ['仅一次', '每天', '每周', '每月'],

      // 滑动
      touchStartX: 0,
      swipeIndex: -1
    }
  },
  computed: {
    updateRepeatIndex() {
      const idx = this.repeatOptions.indexOf(this.updateForm.repeat)
      return idx >= 0 ? idx : 0
    }
  },
  onLoad() {
    this.loadReminders()
  },
  methods: {
    loadReminders() {
      const stuId = uni.getStorageSync('userInfo')?.stu_id || 1
      getReminderListApi(stuId).then(res => {
        if (res.data) {
          this.reminders = res.data.map(item => ({ ...item, swiping: false }))
        }
      }).catch(err => {
        this.apiErrMsg = `接口 ${err.code || 404} 错误：${err.msg || '请求失败'}`
        console.error('获取提醒列表失败：', err)
      })
    },

    // ---- 切换开关 ----
    toggleReminder(index) {
      this.reminders[index].enabled = !this.reminders[index].enabled
    },

    // ---- 添加 ----
    addReminder() {
      uni.navigateTo({ url: '/pages/reminder/add' })
    },

    // ---- 返回 ----
    goBack() {
      uni.navigateBack()
    },

    // ---- 滑动处理 ----
    onTouchStart(e, index) {
      this.touchStartX = e.touches[0].clientX
      // 关闭其它项的滑动状态
      this.reminders.forEach((item, i) => { if (i !== index) item.swiping = false })
    },
    onTouchMove(e, index) {
      const deltaX = e.touches[0].clientX - this.touchStartX
      if (deltaX < -30) {
        this.reminders[index].swiping = true
      } else if (deltaX > 30) {
        this.reminders[index].swiping = false
      }
    },
    onTouchEnd(e, index) {
      const deltaX = e.changedTouches[0].clientX - this.touchStartX
      if (deltaX < -50) {
        this.reminders[index].swiping = true
      } else if (deltaX > 50) {
        this.reminders[index].swiping = false
      }
    },

    // ---- 删除 ----
    confirmDelete(item) {
      this.deleteTarget = item
      this.showDeleteModal = true
    },
    cancelDelete() {
      if (this.deleteTarget) this.deleteTarget.swiping = false
      this.showDeleteModal = false
      this.deleteTarget = null
    },
    doDelete() {
      if (!this.deleteTarget || !this.deleteTarget.trId) return
      deleteReminderApi(this.deleteTarget.trId).then(() => {
        uni.showToast({ title: '提醒已删除', icon: 'success' })
        this.showDeleteModal = false
        this.deleteTarget = null
        this.loadReminders()
      }).catch(err => {
        uni.showToast({ title: '删除失败', icon: 'none' })
        console.error('删除提醒失败：', err)
      })
    },

    // ---- 更新 ----
    showUpdate(item) {
      this.updateTarget = item
      // 先查询后端获取完整字段
      getReminderByIdApi(item.trId).then(res => {
        if (res.data) {
          this.updateForm = {
            title: res.data.title || '',
            desc: res.data.desc || '',
            time: res.data.time || '',
            repeat: res.data.repeat || '仅一次'
          }
        } else {
          // fallback to local data
          this.updateForm = {
            title: item.title || '',
            desc: item.desc || '',
            time: (item.hour || '08') + ':' + (item.minute || '00'),
            repeat: item.repeat || '仅一次'
          }
        }
        this.showUpdateModal = true
      }).catch(() => {
        // fallback
        this.updateForm = {
          title: item.title || '',
          desc: item.desc || '',
          time: (item.hour || '08') + ':' + (item.minute || '00'),
          repeat: item.repeat || '仅一次'
        }
        this.showUpdateModal = true
      })
    },
    closeUpdate() {
      if (this.updateTarget) this.updateTarget.swiping = false
      this.showUpdateModal = false
      this.updateTarget = null
    },
    onUpdateTimeChange(e) {
      this.updateForm.time = e.detail.value
    },
    onUpdateRepeatChange(e) {
      this.updateForm.repeat = this.repeatOptions[e.detail.value]
    },
    doUpdate() {
      const target = this.updateTarget
      if (!target || !target.trId) return
      if (!this.updateForm.title.trim()) {
        uni.showToast({ title: '请输入标题', icon: 'none' })
        return
      }
      if (!this.updateForm.time) {
        uni.showToast({ title: '请选择时间', icon: 'none' })
        return
      }
      updateReminderApi(target.trId, this.updateForm).then(() => {
        uni.showToast({ title: '提醒已更新', icon: 'success' })
        this.showUpdateModal = false
        this.updateTarget = null
        this.loadReminders()
      }).catch(err => {
        uni.showToast({ title: '更新失败', icon: 'none' })
        console.error('更新提醒失败：', err)
      })
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
.header-title {
  display: block; font-size: 48rpx; font-weight: 700; color: #fff; margin-bottom: 8rpx;
}
.header-sub { font-size: 26rpx; color: rgba(255,255,255,0.85); }

.body { padding: 24rpx; }

.error-bar {
  display: flex; align-items: center; gap: 12rpx;
  background: #fef2f2; border: 1rpx solid #fecaca; border-radius: 12rpx;
  padding: 18rpx 20rpx; margin-bottom: 20rpx;
}
.error-icon { font-size: 28rpx; }
.error-text { font-size: 24rpx; color: #dc2626; }

.reminder-list { margin-bottom: 30rpx; }

/* 每个提醒项的容器，用于右滑溢出 */
.reminder-item-wrapper {
  position: relative;
  overflow: hidden;
  border-radius: 20rpx;
  margin-bottom: 16rpx;
}

/* 右滑露出的操作按钮 */
.swipe-actions {
  position: absolute;
  top: 0; right: 0; bottom: 0;
  display: flex;
  align-items: stretch;
  transform: translateX(100%);
  transition: transform 0.25s ease;
  z-index: 1;
}
.swipe-actions.visible {
  transform: translateX(0);
}
.action-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 130rpx;
  color: #fff;
  font-size: 28rpx;
  font-weight: 600;
}
.action-update { background: #3b82f6; }
.action-delete { background: #ef4444; border-radius: 0 20rpx 20rpx 0; }

/* 提醒卡片本体 */
.reminder-item {
  display: flex;
  align-items: center;
  background: #fff;
  border-radius: 20rpx;
  padding: 24rpx;
  box-shadow: 0 4rpx 16rpx rgba(15,23,42,0.04);
  position: relative;
  z-index: 2;
  transition: transform 0.25s ease;
}
.reminder-item.swiping {
  transform: translateX(-260rpx);
}

.reminder-left {
  display: flex;
  align-items: baseline;
  min-width: 120rpx;
  margin-right: 16rpx;
}
.time-hour { font-size: 44rpx; font-weight: 700; color: #6b5aed; }
.time-colon { font-size: 36rpx; font-weight: 700; color: #6b5aed; margin: 0 2rpx; }
.time-minute { font-size: 44rpx; font-weight: 700; color: #6b5aed; }
.time-ampm { font-size: 20rpx; color: #9ca3af; margin-top: 20rpx; margin-left: 4rpx; }

.reminder-divider {
  width: 2rpx;
  height: 80rpx;
  background: #f3f4f6;
  margin-right: 20rpx;
}

.reminder-body { flex: 1; min-width: 0; }
.reminder-title { display: block; font-size: 28rpx; font-weight: 600; color: #111827; margin-bottom: 4rpx; }
.reminder-desc { display: block; font-size: 24rpx; color: #9ca3af; }
.reminder-repeat { display: flex; align-items: center; gap: 6rpx; margin-top: 8rpx; }
.repeat-icon { font-size: 20rpx; }
.repeat-text { font-size: 22rpx; color: #6b5aed; background: #f5f3ff; padding: 4rpx 12rpx; border-radius: 8rpx; }

.reminder-switch { transform: scale(0.8); flex-shrink: 0; }

.empty {
  text-align: center;
  padding: 80rpx 0;
}
.empty-icon { font-size: 80rpx; display: block; margin-bottom: 20rpx; }
.empty-text { display: block; font-size: 32rpx; color: #6b7280; margin-bottom: 8rpx; }
.empty-hint { display: block; font-size: 26rpx; color: #9ca3af; }

.add-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 12rpx;
  width: 100%;
  padding: 28rpx;
  background: linear-gradient(135deg, #6b5aed, #7c3aed);
  color: #fff;
  border-radius: 16rpx;
  font-size: 30rpx;
  font-weight: 600;
  border: none;
  box-shadow: 0 8rpx 24rpx rgba(107,90,237,0.3);
}
.add-icon { font-size: 36rpx; }

/* 弹窗遮罩 */
.modal-overlay {
  position: fixed;
  top: 0; left: 0; right: 0; bottom: 0;
  background: rgba(0,0,0,0.45);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 999;
}
.modal-box {
  background: #fff;
  border-radius: 24rpx;
  padding: 48rpx 36rpx 36rpx;
  width: 600rpx;
  text-align: center;
}
.update-box { text-align: left; width: 680rpx; }
.modal-icon { font-size: 56rpx; margin-bottom: 16rpx; }
.modal-title { display: block; font-size: 34rpx; font-weight: 700; color: #111827; margin-bottom: 12rpx; }
.modal-desc { display: block; font-size: 28rpx; color: #6b7280; margin-bottom: 32rpx; }
.modal-actions { display: flex; gap: 20rpx; }
.modal-btn {
  flex: 1;
  padding: 22rpx 0;
  border-radius: 14rpx;
  font-size: 28rpx;
  font-weight: 600;
  border: none;
}
.modal-cancel { background: #f3f4f6; color: #374151; }
.modal-confirm { background: linear-gradient(135deg, #6b5aed, #7c3aed); color: #fff; }

/* 更新表单 */
.form-group { margin-bottom: 24rpx; }
.form-label { display: block; font-size: 26rpx; color: #374151; font-weight: 600; margin-bottom: 8rpx; }
.form-input {
  width: 100%;
  padding: 24rpx 28rpx;
  background: #f9fafb;
  border: 2rpx solid #e5e7eb;
  border-radius: 14rpx;
  font-size: 30rpx;
  color: #111827;
  box-sizing: border-box;
}
.picker-value { min-height: 40rpx; }
</style>