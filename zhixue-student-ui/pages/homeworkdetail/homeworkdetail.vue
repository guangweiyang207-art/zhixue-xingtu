<template>
  <view class="page">
    <view class="header">
      <view class="back-btn" @click="goBack">←</view>
      <text class="title">作业详情</text>
      <view class="placeholder"></view>
    </view>

    <scroll-view scroll-y class="content">
      <view v-if="homework">
        <!-- 作业信息卡片 -->
        <view class="info-card">
          <text class="hw-title">{{homework.title || '未命名作业'}}</text>
          <view class="info-row">
            <text class="label">截止时间：</text>
            <text class="value">{{formatDate(homework.deadline)}}</text>
          </view>
          <view class="info-row">
            <text class="label">总分：</text>
            <text class="value">{{homework.totalScore || 100}}分</text>
          </view>
          <view class="info-row">
            <text class="label">状态：</text>
            <text class="value status-tag" :class="[homework.statusClass]">{{homework.statusText}}</text>
          </view>
        </view>

        <!-- 作业内容 -->
        <view class="card">
          <text class="section-title">作业内容</text>
          <text class="desc-text">{{homework.content || '暂无内容描述'}}</text>
        </view>

        <!-- 学生作答区(逐题) -->
        <view class="card" v-if="homework.status === 0">
          <text class="section-title">我的作答</text>

          <!-- 有题目:逐题作答 -->
          <view v-if="questions.length > 0">
            <view class="q-item" v-for="(q, qi) in questions" :key="q.qId">
              <view class="q-head">
                <text class="q-no">{{ qi + 1 }}.</text>
                <text class="q-type">[{{typeName(q.questionType)}}]</text>
                <text class="q-score">({{q.score || 0}}分)</text>
              </view>
              <view class="q-content">{{q.questionContent}}</view>

              <!-- 单选/判断 -->
              <view v-if="(q.questionType === 1 || q.questionType === 3) && parseOptions(q.options).length" class="opt-list">
                <view
                  class="opt-item"
                  :class="{active: answers[q.qId] === opt.key}"
                  v-for="opt in parseOptions(q.options)"
                  :key="opt.key"
                  @click="selectSingle(q, opt.key)"
                >{{opt.text}}</view>
              </view>
              <!-- 无选项的客观题退化为文本 -->
              <textarea
                v-else-if="q.questionType === 1 || q.questionType === 2 || q.questionType === 3"
                class="q-input"
                :value="answers[q.qId]"
                @input="onTextInput(q, $event)"
                placeholder="请输入答案..."
              />

              <!-- 多选 -->
              <view v-if="q.questionType === 2 && parseOptions(q.options).length" class="opt-list">
                <view
                  class="opt-item"
                  :class="{active: isChecked(q, opt.key)}"
                  v-for="opt in parseOptions(q.options)"
                  :key="opt.key"
                  @click="toggleMulti(q, opt.key)"
                >{{opt.text}}</view>
              </view>

              <!-- 填空/简答 -->
              <textarea
                v-if="q.questionType === 4 || q.questionType === 5"
                class="q-input"
                :value="answers[q.qId]"
                @input="onTextInput(q, $event)"
                placeholder="请输入答案..."
              />
            </view>
          </view>

          <!-- 无题目:整体文本作答(兼容) -->
          <view v-else>
            <textarea
              class="answer-input"
              v-model="answer"
              placeholder="请在此处输入你的答案..."
              maxlength="2000"
            />
            <view class="input-tips">{{answer.length}}/2000</view>
          </view>
        </view>

        <!-- 已提交答案展示(逐题回显) -->
        <view class="card" v-if="homework.status !== 0 && submittedAnswers.length">
          <text class="section-title">我的作答</text>
          <view class="q-item" v-for="(sa, i) in submittedAnswers" :key="i">
            <view class="q-head">
              <text class="q-no">{{ i + 1 }}.</text>
              <text class="q-type">[{{typeName(sa.questionType)}}]</text>
            </view>
            <view class="q-content">{{sa.title}}</view>
            <text class="desc-text">{{sa.answer || '（未作答）'}}</text>
          </view>
        </view>

        <!-- 已提交答案展示(纯文本兼容) -->
        <view class="card" v-if="homework.status !== 0 && !submittedAnswers.length && submittedAnswer">
          <text class="section-title">我的作答</text>
          <text class="desc-text">{{submittedAnswer}}</text>
        </view>

        <!-- 成绩展示 -->
        <view class="card score-card" v-if="homework.status === 2">
          <view class="score-row">
            <text class="section-title">得分</text>
            <text class="score-value">{{homework.score || 0}}分</text>
          </view>
          <view class="comment-row" v-if="homework.teacherComment">
            <text class="label">老师评语：</text>
            <text class="desc-text">{{homework.teacherComment}}</text>
          </view>
        </view>
      </view>

      <view class="empty" v-else>
        <text>作业加载中...</text>
      </view>
    </scroll-view>

    <!-- 底部操作栏 -->
    <view class="footer-bar" v-if="homework">
      <view class="btn-submit" v-if="homework.status === 0" @click="submitHomework">提交作业</view>
      <view class="btn-back" v-else @click="goBack">返回</view>
    </view>
  </view>
</template>

<script>
  import { getHomeworkDetailApi, submitHomeworkApi, getHomeworkQuestionsApi } from '@/api/system/homework.js'

  export default {
    data() {
      return {
        hwId: null,
        homework: null,
        answer: '',
        submittedAnswer: '',
        questions: [],
        answers: {},
        submittedAnswers: []
      }
    },
    onLoad(options) {
      this.hwId = options.id || options.hwId;
      if (this.hwId) {
        this.loadDetail();
      }
    },
    methods: {
      typeName(t) {
        return ['', '单选', '多选', '判断', '填空', '简答'][t || 0] || '题目'
      },
      // 解析选项JSON: {"A":"func"} → [{key:'A', text:'A. func'}]; 数组 → [{key:item, text:item}]
      parseOptions(opt) {
        if (!opt) return []
        try {
          if (typeof opt === 'string') {
            const o = JSON.parse(opt)
            if (Array.isArray(o)) return o.map(item => ({key: String(item), text: String(item)}))
            if (typeof o === 'object') {
              return Object.keys(o).sort().map(k => ({key: k, text: `${k}. ${o[k]}`}))
            }
          }
          if (Array.isArray(opt)) return opt.map(item => ({key: String(item), text: String(item)}))
          if (typeof opt === 'object') {
            return Object.keys(opt).sort().map(k => ({key: k, text: `${k}. ${opt[k]}`}))
          }
        } catch (e) {}
        return []
      },
      selectSingle(q, key) {
        this.$set(this.answers, q.qId, key)
      },
      isChecked(q, key) {
        const val = this.answers[q.qId]
        return !!val && String(val).split(',').indexOf(key) > -1
      },
      toggleMulti(q, key) {
        let arr = this.answers[q.qId] ? String(this.answers[q.qId]).split(',') : []
        const idx = arr.indexOf(key)
        if (idx > -1) {
          arr.splice(idx, 1)
        } else {
          arr.push(key)
        }
        arr.sort()
        this.$set(this.answers, q.qId, arr.join(','))
      },
      onTextInput(q, e) {
        this.$set(this.answers, q.qId, e.detail.value)
      },
      loadDetail() {
        Promise.all([
          getHomeworkDetailApi(this.hwId),
          getHomeworkQuestionsApi(this.hwId).catch(() => null)
        ])
          .then(([res, qRes]) => {
            if (qRes && Array.isArray(qRes.data)) {
              this.questions = qRes.data
            }
            if (res && res.data) {
              const hw = res.data;
              const status = hw.status || 0;
              const statusMap = {0: 'wait', 1: 'submit', 2: 'check'};
              const textMap = {0: '未完成', 1: '已提交', 2: '已批改'};
              this.homework = {
                ...hw,
                statusClass: statusMap[status] || 'wait',
                statusText: textMap[status] || '未完成'
              };
              if (status !== 0) {
                this.submittedAnswer = hw.answers || '';
                this.buildSubmittedAnswers(hw.answers);
              }
            }
          })
          .catch(err => {
            console.error('获取作业详情失败：', err);
            uni.showToast({title: '加载失败', icon: 'none'});
          });
      },
      // 已提交作答回显:JSON则逐题映射,纯文本走兼容展示
      buildSubmittedAnswers(rawAnswers) {
        this.submittedAnswers = []
        if (!rawAnswers || !this.questions.length) return
        let map = null
        try {
          const parsed = JSON.parse(rawAnswers)
          if (parsed && typeof parsed === 'object' && !Array.isArray(parsed)) map = parsed
        } catch (e) { /* 纯文本 */ }
        if (!map) return
        this.submittedAnswers = this.questions.map(q => ({
          questionType: q.questionType,
          title: q.questionContent,
          answer: map[String(q.qId)] || map[q.qId] || ''
        }))
      },
      submitHomework() {
        let payloadAnswers = ''
        if (this.questions.length > 0) {
          const answered = Object.keys(this.answers).filter(k => {
            const v = this.answers[k]
            return v !== undefined && v !== null && String(v).trim() !== ''
          })
          if (answered.length === 0) {
            uni.showToast({title: '请至少作答一道题', icon: 'none'});
            return;
          }
          payloadAnswers = JSON.stringify(this.answers)
        } else {
          if (!this.answer || this.answer.trim().length === 0) {
            uni.showToast({title: '请输入答案', icon: 'none'});
            return;
          }
          payloadAnswers = this.answer.trim()
        }
        uni.showLoading({title: '提交中...'});
        submitHomeworkApi({
          hwId: Number(this.hwId),
          answers: payloadAnswers
        }).then(res => {
          uni.hideLoading();
          if (res && res.code === 200) {
            uni.showToast({title: '提交成功', icon: 'success'});
            this.submittedAnswer = payloadAnswers;
            this.homework.status = 1;
            this.homework.statusClass = 'submit';
            this.homework.statusText = '已提交';
            this.buildSubmittedAnswers(payloadAnswers);
          } else {
            uni.showToast({title: res?.msg || '提交失败', icon: 'none'});
          }
        }).catch(err => {
          uni.hideLoading();
          console.error('提交失败：', err);
          uni.showToast({title: '提交失败', icon: 'none'});
        });
      },
      goBack() {
        uni.navigateBack();
      },
      formatDate(dateStr) {
        if (!dateStr) return ''
        // iOS 仅支持 "yyyy/MM/dd HH:mm:ss" 斜杠格式,先把 "-" 替换为 "/"
        const safe = String(dateStr).replace(/-/g, '/')
        const d = new Date(safe)
        if (isNaN(d.getTime())) return String(dateStr)
        return `${d.getFullYear()}-${String(d.getMonth()+1).padStart(2,'0')}-${String(d.getDate()).padStart(2,'0')} ${String(d.getHours()).padStart(2,'0')}:${String(d.getMinutes()).padStart(2,'0')}`
      }
    }
  }
</script>

<style scoped>
  page {
    background-color: #f6f7fb;
  }
  .page {
    height: 100vh;
    display: flex;
    flex-direction: column;
  }
  .header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-top: calc(var(--status-bar-height) + 20rpx);
    padding-left: 28rpx;
    padding-right: 28rpx;
    padding-bottom: 20rpx;
    background: #fff;
  }
  .back-btn {
    font-size: 40rpx;
    color: #1f2937;
    width: 60rpx;
  }
  .title {
    font-size: 36rpx;
    font-weight: 700;
    color: #1f2937;
  }
  .placeholder {
    width: 60rpx;
  }
  .content {
    flex: 1;
    padding: 20rpx 28rpx;
    overflow: hidden;
  }
  .info-card,
  .card {
    background: #fff;
    border-radius: 24rpx;
    padding: 28rpx;
    margin-bottom: 20rpx;
  }
  .hw-title {
    font-size: 34rpx;
    font-weight: 700;
    color: #1f2937;
    margin-bottom: 20rpx;
    display: block;
  }
  .info-row {
    display: flex;
    margin-bottom: 14rpx;
    font-size: 28rpx;
  }
  .label {
    color: #9ca3af;
    width: 160rpx;
    flex-shrink: 0;
  }
  .value {
    color: #374151;
    flex: 1;
  }
  .status-tag {
    font-size: 24rpx;
    padding: 6rpx 18rpx;
    border-radius: 12rpx;
    display: inline-block;
    width: auto;
    text-align: center;
  }
  .wait {
    background: #fef9c3;
    color: #a16207;
  }
  .submit {
    background: #dcfce7;
    color: #15803d;
  }
  .check {
    background: #dbeafe;
    color: #1d4ed8;
  }
  .section-title {
    font-size: 30rpx;
    font-weight: 700;
    color: #1f2937;
    margin-bottom: 16rpx;
    display: block;
  }
  .desc-text {
    font-size: 28rpx;
    color: #4b5563;
    line-height: 1.6;
    word-break: break-all;
  }
  .answer-input {
    width: 100%;
    min-height: 240rpx;
    background: #f9fafb;
    border-radius: 16rpx;
    padding: 20rpx;
    font-size: 28rpx;
    color: #374151;
    line-height: 1.6;
    box-sizing: border-box;
  }
  .input-tips {
    text-align: right;
    font-size: 24rpx;
    color: #9ca3af;
    margin-top: 12rpx;
  }
  .q-item {
    padding: 20rpx 0;
    border-bottom: 1rpx solid #f3f4f6;
  }
  .q-item:last-child { border-bottom: none; }
  .q-head {
    display: flex;
    align-items: center;
    margin-bottom: 12rpx;
  }
  .q-no {
    color: #6366f1;
    font-weight: 700;
    margin-right: 8rpx;
  }
  .q-type {
    color: #8b5cf6;
    font-size: 24rpx;
    margin-right: 12rpx;
  }
  .q-score {
    color: #9ca3af;
    font-size: 24rpx;
  }
  .q-content {
    font-size: 28rpx;
    color: #1f2937;
    line-height: 1.6;
    margin-bottom: 14rpx;
  }
  .opt-list {
    display: flex;
    flex-direction: column;
    gap: 12rpx;
  }
  .opt-item {
    padding: 18rpx 24rpx;
    background: #f9fafb;
    border: 2rpx solid #f3f4f6;
    border-radius: 14rpx;
    font-size: 26rpx;
    color: #374151;
  }
  .opt-item.active {
    background: #eef2ff;
    border-color: #6366f1;
    color: #4338ca;
    font-weight: 600;
  }
  .q-input {
    width: 100%;
    min-height: 160rpx;
    background: #f9fafb;
    border-radius: 14rpx;
    padding: 18rpx;
    font-size: 26rpx;
    color: #374151;
    line-height: 1.6;
    box-sizing: border-box;
  }
  .score-card {
    background: linear-gradient(135deg, #fff9f0, #fff0f5);
  }
  .score-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 16rpx;
  }
  .score-value {
    font-size: 40rpx;
    font-weight: 700;
    color: #f59e0b;
  }
  .comment-row {
    margin-top: 12rpx;
  }
  .footer-bar {
    padding: 20rpx 28rpx 40rpx;
    background: #fff;
    border-top: 1rpx solid #f3f4f6;
  }
  .btn-submit {
    width: 100%;
    padding: 28rpx;
    background: linear-gradient(135deg, #6366f1, #8b5cf6);
    color: #fff;
    border-radius: 20rpx;
    font-size: 30rpx;
    font-weight: 600;
    text-align: center;
  }
  .btn-back {
    width: 100%;
    padding: 28rpx;
    background: #f3f4f6;
    color: #4b5563;
    border-radius: 20rpx;
    font-size: 30rpx;
    font-weight: 600;
    text-align: center;
  }
  .empty {
    text-align: center;
    padding: 200rpx 0;
    color: #9ca3af;
    font-size: 30rpx;
  }
</style>
