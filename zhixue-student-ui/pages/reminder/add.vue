<template>
  <view class="page">
    <view class="header">
      <view class="header-bg"></view>
      <view class="header-content">
        <view class="header-top">
          <text class="back-btn" @click="goBack">〈 返回</text>
        </view>
        <text class="header-title">添加提醒</text>
        <text class="header-sub">设置新的学习提醒</text>
      </view>
    </view>

    <view class="body">
      <view class="form-card">
        <view class="form-item">
          <text class="form-label">提醒标题</text>
          <input class="form-input" v-model="form.title" placeholder="例如：晨读时间" />
        </view>
        <view class="form-divider"></view>

        <view class="form-item">
          <text class="form-label">提醒内容</text>
          <textarea class="form-textarea" v-model="form.desc" placeholder="描述提醒的具体内容" />
        </view>
        <view class="form-divider"></view>

        <view class="form-item">
          <text class="form-label">提醒时间</text>
          <picker mode="time" @change="onTimeChange">
            <view class="picker-box">
              <text class="picker-text" v-if="!form.time">请选择时间</text>
              <text class="picker-text selected" v-else>{{ form.time }}</text>
              <text class="picker-arrow">〉</text>
            </view>
          </picker>
        </view>
        <view class="form-divider"></view>

        <view class="form-item">
          <text class="form-label">重复方式</text>
          <picker :range="repeatOptions" @change="onRepeatChange">
            <view class="picker-box">
              <text class="picker-text" v-if="!form.repeat">请选择重复方式</text>
              <text class="picker-text selected" v-else>{{ form.repeat }}</text>
              <text class="picker-arrow">〉</text>
            </view>
          </picker>
        </view>
      </view>

      <button class="save-btn" @click="saveReminder">
        <text>保存提醒</text>
      </button>
    </view>
  </view>
</template>

<script>
import { addReminderApi } from '@/api/reminder/reminder.js'

export default {
  data() {
    return {
      form: { title: '', desc: '', time: '', repeat: '' },
      repeatOptions: ['仅一次', '每天', '周一至周五', '周末', '自定义']
    }
  },
  methods: {
    onTimeChange(e) {
      this.form.time = e.detail.value
    },
    onRepeatChange(e) {
      this.form.repeat = this.repeatOptions[e.detail.value]
    },
    saveReminder() {
      if (!this.form.title.trim()) {
        uni.showToast({ title: '请输入提醒标题', icon: 'none' })
        return
      }
      if (!this.form.time) {
        uni.showToast({ title: '请选择提醒时间', icon: 'none' })
        return
      }
      const stuId = uni.getStorageSync('userInfo')?.stu_id || 1
      addReminderApi(stuId, this.form).then(res => {
        uni.showToast({ title: '提醒已添加', icon: 'success' })
        setTimeout(() => uni.navigateBack(), 1000)
      }).catch(err => {
        console.error('添加提醒失败：', err)
        uni.showToast({ title: '添加失败', icon: 'none' })
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

.form-card {
  background: #fff;
  border-radius: 20rpx;
  padding: 8rpx 24rpx;
  box-shadow: 0 4rpx 16rpx rgba(15,23,42,0.04);
  margin-bottom: 30rpx;
}
.form-item { padding: 24rpx 0; }
.form-label { display: block; font-size: 26rpx; color: #6b7280; margin-bottom: 12rpx; font-weight: 500; }
.form-input {
  width: 100%; height: 72rpx; font-size: 28rpx; color: #111827;
  background: #f9fafb; border: 1rpx solid #e5e7eb; border-radius: 12rpx;
  padding: 0 20rpx; box-sizing: border-box;
}
.form-textarea {
  width: 100%; height: 120rpx; font-size: 28rpx; color: #111827;
  background: #f9fafb; border: 1rpx solid #e5e7eb; border-radius: 12rpx;
  padding: 16rpx 20rpx; box-sizing: border-box;
}
.form-divider { height: 1rpx; background: #f3f4f6; }

.picker-box {
  display: flex; align-items: center; justify-content: space-between;
  width: 100%; height: 72rpx; font-size: 28rpx;
  background: #f9fafb; border: 1rpx solid #e5e7eb; border-radius: 12rpx;
  padding: 0 20rpx; box-sizing: border-box;
}
.picker-text { color: #9ca3af; }
.picker-text.selected { color: #111827; }
.picker-arrow { font-size: 28rpx; color: #9ca3af; }

.save-btn {
  width: 100%; padding: 28rpx;
  background: linear-gradient(135deg, #6b5aed, #7c3aed);
  color: #fff; border-radius: 16rpx; font-size: 32rpx; font-weight: 600;
  border: none; box-shadow: 0 8rpx 24rpx rgba(107,90,237,0.3);
}
</style>