<template>
  <view class="container">
    <view v-if="loading" class="loading">加载中...</view>
    <block v-else-if="question">
      <!-- 学生信息卡 -->
      <view class="card">
        <view class="card-title">学生信息</view>
        <view class="stu-row">
          <image
            class="stu-avatar"
            :src="resolveAvatar(question.stuAvatar)"
            mode="aspectFill"
          />
          <view class="stu-meta">
            <text class="stu-name">{{ question.stuName || '-' }}</text>
            <text class="stu-info" v-if="question.stuNo">学号:{{ question.stuNo }}</text>
            <text class="stu-info" v-if="question.className">班级:{{ question.className }}</text>
          </view>
        </view>
      </view>

      <!-- 问题卡 -->
      <view class="card">
        <view class="card-title">学生提问</view>
        <view class="info-row">
          <text class="info-label">提问时间:</text>
          <text class="info-value">{{ formatTime(question.createTime) }}</text>
        </view>
        <view class="q-block">
          <text class="info-label">问题内容:</text>
          <text class="q-content">{{ question.question }}</text>
        </view>
      </view>

      <!-- 老师回答 -->
      <view class="card">
        <view class="card-title">我的回答</view>
        <textarea
          class="textarea"
          v-model="form.answer"
          placeholder="请输入对学生的回答"
          maxlength="1000"
        />
        <view class="word-count">{{ form.answer.length }}/1000</view>
        <button class="btn-submit" :disabled="submitting || question.status === 1" @tap="submit">
          {{ submitting ? '提交中...' : (question.status === 1 ? '已回复' : '提交回答') }}
        </button>
      </view>
    </block>
    <view v-else class="empty">记录不存在</view>
  </view>
</template>

<script>
import { getQaDetailApi, answerQuestionApi } from '../../api/system/questionAnswer.js'
import config from '@/config'

export default {
  data() {
    return {
      loading: true,
      submitting: false,
      qaId: null,
      question: null,
      form: { answer: '' },
      baseUrl: config.baseUrl,
      defaultAvatar: '/static/images/profile.jpg'
    }
  },
  onLoad(options) {
    this.qaId = options.id ? Number(options.id) : null
    if (!this.qaId) {
      uni.showToast({ title: '参数错误', icon: 'none' })
      return
    }
    this.loadDetail()
  },
  methods: {
    resolveAvatar(path) {
      if (!path) return this.defaultAvatar
      if (path.indexOf('http') === 0) return path
      return this.baseUrl + path
    },
    formatTime(t) {
      if (!t) return '-'
      const d = new Date(t)
      if (isNaN(d.getTime())) return t
      const pad = n => String(n).padStart(2, '0')
      return `${d.getFullYear()}-${pad(d.getMonth()+1)}-${pad(d.getDate())} ${pad(d.getHours())}:${pad(d.getMinutes())}`
    },
    async loadDetail() {
      this.loading = true
      try {
        const res = await getQaDetailApi(this.qaId)
        if (res.code === 200) {
          this.question = res.data
          // 若已回复,回填到文本框
          if (this.question && this.question.answer) {
            this.form.answer = this.question.answer
          }
        } else {
          uni.showToast({ title: res.msg || '加载失败', icon: 'none' })
        }
      } catch (e) {
        uni.showToast({ title: '网络异常', icon: 'none' })
      } finally {
        this.loading = false
      }
    },
    async submit() {
      if (this.question && this.question.status === 1) {
        return uni.showToast({ title: '已回复,无需重复提交', icon: 'none' })
      }
      if (!this.form.answer || !this.form.answer.trim()) {
        return uni.showToast({ title: '请输入回答内容', icon: 'none' })
      }
      this.submitting = true
      try {
        const res = await answerQuestionApi({
          id: this.qaId,
          answer: this.form.answer.trim()
        })
        if (res.code === 200) {
          uni.showToast({ title: '回答成功' })
          setTimeout(() => uni.navigateBack(), 800)
        } else {
          uni.showToast({ title: res.msg || '提交失败', icon: 'none' })
        }
      } catch (e) {
        uni.showToast({ title: '网络异常', icon: 'none' })
      } finally {
        this.submitting = false
      }
    }
  }
}
</script>

<style lang="scss" scoped>
@import '@/static/scss/global.scss';

.container {
  min-height: 100vh;
  background-color: $uni-bg-color-page;
  padding: 24rpx 24rpx 40rpx;
  box-sizing: border-box;
}
.loading, .empty {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 120rpx 32rpx;
  color: $uni-text-color-tertiary;
  font-size: 26rpx;
}
.card {
  background: $uni-bg-color;
  border-radius: $uni-radius-lg;
  padding: 28rpx;
  margin-bottom: 20rpx;
  box-shadow: $uni-shadow-sm;
  border-left: 6rpx solid $uni-color-primary;
}
.card-title {
  display: flex;
  align-items: center;
  font-size: 30rpx;
  font-weight: $uni-font-weight-semibold;
  margin-bottom: 24rpx;
  color: $uni-text-color;
  letter-spacing: 0.5rpx;
  padding-left: 14rpx;
  position: relative;
}
.card-title::before {
  content: '';
  position: absolute;
  left: 0;
  top: 50%;
  transform: translateY(-50%);
  width: 6rpx;
  height: 22rpx;
  background: $uni-color-primary;
  border-radius: 3rpx;
}

.stu-row { display: flex; align-items: center; }
.stu-avatar {
  width: 96rpx;
  height: 96rpx;
  border-radius: 50%;
  background: $uni-color-primary-soft;
  flex-shrink: 0;
  border: 1rpx solid $uni-border-color-light;
}
.stu-meta {
  margin-left: 20rpx;
  display: flex;
  flex-direction: column;
  min-width: 0;
}
.stu-name {
  font-size: 30rpx;
  font-weight: $uni-font-weight-semibold;
  color: $uni-text-color;
  letter-spacing: 0.3rpx;
}
.stu-info {
  font-size: 24rpx;
  color: $uni-text-color-tertiary;
  margin-top: 6rpx;
}

.info-row {
  font-size: 26rpx;
  color: $uni-text-color-secondary;
  margin-bottom: 12rpx;
  display: flex;
  align-items: center;
  flex-wrap: wrap;
}
.info-label {
  color: $uni-text-color-tertiary;
  margin-right: 8rpx;
}
.info-value { color: $uni-text-color; }
.q-block {
  background: $uni-bg-color-alt;
  padding: 20rpx;
  border-radius: $uni-radius-sm;
  margin-top: 12rpx;
}
.q-content {
  font-size: 28rpx;
  color: $uni-text-color;
  line-height: 1.6;
  display: block;
  margin-top: 10rpx;
  word-break: break-all;
}

.textarea {
  width: 100%;
  height: 280rpx;
  border: 1rpx solid $uni-border-color-light;
  border-radius: $uni-radius-sm;
  padding: 20rpx 24rpx;
  font-size: 28rpx;
  box-sizing: border-box;
  background: $uni-bg-color-alt;
  color: $uni-text-color;
  line-height: 1.5;
  transition: border-color $uni-duration-fast $uni-ease, background $uni-duration-fast $uni-ease;
}
.textarea:focus {
  border-color: $uni-color-primary;
  background: $uni-bg-color;
}
.word-count {
  text-align: right;
  font-size: 22rpx;
  color: $uni-text-color-tertiary;
  margin-top: 8rpx;
  margin-bottom: 12rpx;
}
.btn-submit {
  width: 100%;
  height: 96rpx;
  background: $uni-color-primary;
  color: $uni-text-color-inverse;
  border-radius: $uni-radius-md;
  font-size: 30rpx;
  font-weight: $uni-font-weight-medium;
  margin-top: 12rpx;
  border: none;
  box-shadow: 0 4rpx 12rpx rgba(30, 58, 95, 0.18);
  letter-spacing: 1rpx;
}
.btn-submit::after { border: none; }
.btn-submit:active { background: $uni-color-primary-press; }
.btn-submit[disabled] {
  background: $uni-border-color-strong;
  opacity: 0.6;
  box-shadow: none;
}
</style>
