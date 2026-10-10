<template>
  <view class="container">
    <!-- 加载中 -->
    <view v-if="loading" class="loading">加载中...</view>

    <block v-else-if="detail">
      <!-- 头部信息 -->
      <view class="card">
        <view class="card-title">{{ detail.title || '未命名作业' }}</view>
        <view class="info-row">
          <text class="info-label">学生:</text>
          <text class="info-value">{{ detail.studentName }}</text>
          <text class="info-label" style="margin-left:20rpx;">学号:</text>
          <text class="info-value">{{ detail.studentNo || '-' }}</text>
        </view>
        <view class="info-row" v-if="detail.className">
          <text class="info-label">班级:</text>
          <text class="info-value">{{ detail.className }}</text>
        </view>
        <view class="info-row">
          <text class="info-label">提交时间:</text>
          <text class="info-value">{{ detail.submitTime || '-' }}</text>
        </view>
        <view class="info-row" v-if="detail.content">
          <text class="info-label">作业要求:</text>
          <text class="info-value">{{ detail.content }}</text>
        </view>
        <view class="info-row" v-if="detail.totalScore">
          <text class="info-label">总分:</text>
          <text class="info-value">{{ detail.totalScore }} 分</text>
        </view>
      </view>

      <!-- 学生作答(整段文本,兼容旧数据) -->
      <view class="card" v-if="rawAnswerText">
        <view class="card-title">学生作答（全文）</view>
        <view class="q-content">{{ rawAnswerText }}</view>
      </view>

      <!-- 题目列表 -->
      <view class="card" v-for="(q, idx) in detail.questions" :key="q.qId">
        <view class="q-title">
          <text class="q-index">{{ idx + 1 }}.</text>
          <text class="q-type">[{{ typeName(q.questionType) }}]</text>
          <text class="q-score">({{ q.score || 0 }}分)</text>
        </view>
        <view class="q-content">{{ q.questionContent }}</view>

        <!-- 选项(单选/多选) -->
        <view v-if="q.options" class="q-options">
          <view v-for="(opt, oi) in parseOptions(q.options)" :key="oi" class="q-option">
            <text>{{ opt }}</text>
          </view>
        </view>

        <view class="q-line">
          <text class="info-label">学生作答:</text>
          <text class="answer-text" :class="q.correct === true ? 'ok' : (q.correct === false ? 'err' : '')">
            {{ q.studentAnswer || '（未作答）' }}
          </text>
        </view>
        <view class="q-line">
          <text class="info-label">正确答案:</text>
          <text class="ok">{{ q.correctAnswer || '-' }}</text>
          <text v-if="q.correct === true" class="ok tag">✓</text>
          <text v-else-if="q.correct === false" class="err tag">✗</text>
        </view>
      </view>

      <!-- 批改表单 -->
      <view class="card">
        <view class="card-title">批改</view>
        <view class="form-row">
          <text class="info-label">得分:</text>
          <input class="form-input" type="digit" v-model.number="form.score" placeholder="请输入分数" />
          <text class="info-label" v-if="detail.totalScore">/ {{ detail.totalScore }}</text>
        </view>
        <view class="form-row column">
          <text class="info-label">教师评语:</text>
          <textarea class="form-textarea" v-model="form.comment" placeholder="请输入评语(选填)" maxlength="500" />
        </view>
        <button class="btn-submit" :disabled="submitting" @click="submitGrade">
          {{ submitting ? '提交中...' : '提交批改' }}
        </button>
      </view>
    </block>

    <view v-else class="empty">暂无数据</view>
  </view>
</template>

<script>
import request from '@/utils/request'

export default {
  data() {
    return {
      loading: true,
      submitting: false,
      shId: null,
      detail: null,
      form: { score: null, comment: '' }
    }
  },
  computed: {
    // 旧数据 answers 为纯文本(非JSON)时,题目里没有逐题作答,展示原文
    rawAnswerText() {
      if (!this.detail || !this.detail.answers) return ''
      const qs = this.detail.questions || []
      const hasPerQuestion = qs.some(q => q.studentAnswer)
      return hasPerQuestion ? '' : this.detail.answers
    }
  },
  onLoad(options) {
    this.shId = options.id ? Number(options.id) : null
    if (!this.shId) {
      uni.showToast({ title: '参数错误', icon: 'none' })
      return
    }
    this.loadDetail()
  },
  methods: {
    typeName(t) {
      return ['', '单选', '多选', '判断', '填空', '简答'][t || 0]
    },
    parseOptions(opt) {
      if (!opt) return []
      try {
        if (typeof opt === 'string') {
          const o = JSON.parse(opt)
          if (Array.isArray(o)) return o
          if (typeof o === 'object') {
            return Object.keys(o).sort().map(k => `${k}. ${o[k]}`)
          }
        }
        if (Array.isArray(opt)) return opt
        if (typeof opt === 'object') {
          return Object.keys(opt).sort().map(k => `${k}. ${opt[k]}`)
        }
      } catch (e) {}
      return []
    },
    async loadDetail() {
      this.loading = true
      try {
        const res = await request({ url: '/homework/detail/' + this.shId, method: 'GET' })
        if (res.code === 200) {
          this.detail = res.data
          this.form.score = res.data.score
          this.form.comment = res.data.comment || ''
        } else {
          uni.showToast({ title: res.msg || '加载失败', icon: 'none' })
        }
      } catch (e) {
        uni.showToast({ title: '网络异常', icon: 'none' })
      } finally {
        this.loading = false
      }
    },
    async submitGrade() {
      if (this.form.score === null || this.form.score === '' || this.form.score < 0) {
        uni.showToast({ title: '请输入有效分数', icon: 'none' })
        return
      }
      this.submitting = true
      try {
        const res = await request({
          url: '/homework/grade',
          method: 'POST',
          data: {
            shId: this.shId,
            score: this.form.score,
            comment: this.form.comment
          }
        })
        if (res.code === 200) {
          uni.showToast({ title: '批改成功' })
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
  margin-bottom: 20rpx;
  color: $uni-text-color;
  letter-spacing: 0.5rpx;
  padding-left: 14rpx;
  position: relative;
  line-height: 1.4;
  word-break: break-all;
}
.card-title::before {
  content: '';
  position: absolute;
  left: 0;
  top: 14rpx;
  width: 6rpx;
  height: 22rpx;
  background: $uni-color-primary;
  border-radius: 3rpx;
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
.info-value {
  color: $uni-text-color;
}

.q-title {
  font-size: 28rpx;
  font-weight: $uni-font-weight-semibold;
  color: $uni-text-color;
  margin-bottom: 14rpx;
  display: flex;
  align-items: center;
  flex-wrap: wrap;
}
.q-index {
  color: $uni-color-primary;
  margin-right: 8rpx;
  font-weight: $uni-font-weight-bold;
}
.q-type {
  color: $uni-color-accent;
  margin-right: 12rpx;
  font-weight: $uni-font-weight-medium;
}
.q-score {
  color: $uni-text-color-tertiary;
  font-size: 24rpx;
}
.q-content {
  font-size: 28rpx;
  color: $uni-text-color;
  line-height: 1.6;
  margin-bottom: 18rpx;
  word-break: break-all;
}
.q-options {
  background: $uni-bg-color-alt;
  border-radius: $uni-radius-sm;
  padding: 18rpx 20rpx;
  margin-bottom: 18rpx;
}
.q-option {
  font-size: 26rpx;
  color: $uni-text-color-secondary;
  line-height: 1.8;
}
.q-line {
  font-size: 26rpx;
  color: $uni-text-color-secondary;
  margin-top: 12rpx;
  display: flex;
  align-items: center;
  flex-wrap: wrap;
}
.answer-text {
  margin-left: 8rpx;
  color: $uni-text-color;
}
.ok { color: $uni-color-success; font-weight: $uni-font-weight-medium; }
.err { color: $uni-color-error; font-weight: $uni-font-weight-medium; }
.tag {
  margin-left: 8rpx;
  font-weight: $uni-font-weight-bold;
}

.form-row {
  display: flex;
  align-items: center;
  margin-bottom: 24rpx;
}
.form-row.column {
  flex-direction: column;
  align-items: flex-start;
}
.form-input {
  flex: 1;
  height: 80rpx;
  border: 1rpx solid $uni-border-color-light;
  border-radius: $uni-radius-sm;
  padding: 0 20rpx;
  font-size: 28rpx;
  background: $uni-bg-color-alt;
  color: $uni-text-color;
  margin: 0 8rpx;
  transition: border-color $uni-duration-fast $uni-ease, background $uni-duration-fast $uni-ease;
}
.form-input:focus {
  border-color: $uni-color-primary;
  background: $uni-bg-color;
}
.form-textarea {
  width: 100%;
  height: 200rpx;
  border: 1rpx solid $uni-border-color-light;
  border-radius: $uni-radius-sm;
  padding: 20rpx 24rpx;
  font-size: 28rpx;
  margin-top: 12rpx;
  box-sizing: border-box;
  background: $uni-bg-color-alt;
  color: $uni-text-color;
  line-height: 1.5;
  transition: border-color $uni-duration-fast $uni-ease, background $uni-duration-fast $uni-ease;
}
.form-textarea:focus {
  border-color: $uni-color-primary;
  background: $uni-bg-color;
}
.btn-submit {
  width: 100%;
  height: 96rpx;
  background: $uni-color-primary;
  color: $uni-text-color-inverse;
  border-radius: $uni-radius-md;
  font-size: 30rpx;
  font-weight: $uni-font-weight-medium;
  margin-top: 30rpx;
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
