<template>
  <view class="page">
    <view class="header-bg"></view>

    <view class="nav-bar">
      <text class="back-btn" @click="goBack">〈 返回</text>
      <text class="nav-title">学习记录</text>
      <text class="nav-subtitle">基于aiagent数据库</text>
    </view>

    <scroll-view scroll-y class="scroll-body" refresher-enabled @refresherrefresh="onRefresh" :refresher-triggered="refreshing">
      <view class="content-wrap" v-if="!loading">

        <!-- ===== 一、学生信息 ===== -->
        <view class="student-card" v-if="d.studentInfo">
          <view class="s-avatar">
            <text class="s-avatar-text">{{ d.studentInfo.realName ? d.studentInfo.realName.charAt(0) : '学' }}</text>
          </view>
          <view class="s-info">
            <text class="s-name">{{ d.studentInfo.realName || '' }}</text>
            <text class="s-school">{{ d.studentInfo.major || '' }}{{ d.studentInfo.grade ? ' · ' + d.studentInfo.grade : '' }}</text>
            <text class="s-stats">总做题{{ d.studentInfo.totalQuestions }}题 · 正确率{{ d.studentInfo.correctRate }}% · 学时{{ d.studentInfo.studyHours }}h</text>
          </view>
          <view class="s-rank">
            <text class="s-rank-name">{{ d.studentInfo.rankLevel || '青铜' }}</text>
            <text class="s-rank-score">{{ d.studentInfo.rankScore }}分</text>
          </view>
        </view>

        <!-- ===== 二、学习记录（my_study_record） ===== -->
        <view class="section">
          <view class="sec-title">📖 学习记录 <text class="sec-sub">my_study_record</text></view>
          <view class="record-grid">
            <view class="record-item" v-for="(r, i) in d.records" :key="i">
              <view class="ri-head">
                <text class="ri-date">{{ r.submitDate || '' }}</text>
                <text class="ri-week">{{ r.weekDay || '' }}</text>
                <text class="ri-time">{{ r.submitTime || '' }}</text>
              </view>
              <text class="ri-course">{{ r.cName || '' }}</text>
              <text class="ri-title">{{ r.title || '' }}</text>
              <view class="ri-score">
                <text class="ri-score-num">{{ r.studentScore }}</text>
                <text class="ri-score-sep">/</text>
                <text class="ri-score-total">{{ r.totalScore }}</text>
                <text class="ri-score-unit">分</text>
                <text class="ri-score-rate" :class="r.rateClass">{{ r.accuracyPercent }}%</text>
              </view>
              <view class="ri-bar">
                <view class="ri-bar-fill" :class="r.rateClass" :style="'width:' + (r.accuracyPercent || 0) + '%'"></view>
              </view>
              <view class="ri-meta" v-if="r.teacherComment || r.deadline">
                <text class="ri-comment" v-if="r.teacherComment">💬 {{ r.teacherComment }}</text>
                <text class="ri-deadline" v-if="r.deadline">截止 {{ r.deadline }}</text>
              </view>
            </view>
            <view class="empty-tip" v-if="!d.records || d.records.length === 0">暂无学习记录</view>
          </view>
        </view>

        <!-- ===== 三、课程进度（my_student_course + my_course） ===== -->
        <view class="section">
          <view class="sec-title">📚 课程进度 <text class="sec-sub">my_student_course + my_course</text></view>
          <view class="course-list">
            <view class="course-item" v-for="(c, i) in d.courseProgress" :key="i">
              <view class="ci-top">
                <text class="ci-type">{{ c.course_type || '' }}</text>
                <text class="ci-status" :class="c.statusClass">{{ statusText(c.status) }}</text>
              </view>
              <text class="ci-name">{{ c.c_name || '' }}</text>
              <view class="ci-progress">
                <view class="ci-bar-bg"><view class="ci-bar-fill" :style="'width:' + (c.progress || 0) + '%'"></view></view>
                <text class="ci-bar-text">{{ c.progress || 0 }}%</text>
              </view>
              <view class="ci-meta">
                <text>{{ c.course_tag || '' }}</text>
                <text v-if="c.resource_count">{{ c.resource_count }}个资源</text>
                <text v-if="c.score">成绩{{ c.score }}分</text>
              </view>
              <text class="ci-remark" v-if="c.remark">{{ c.remark }}</text>
            </view>
            <view class="empty-tip" v-if="!d.courseProgress || d.courseProgress.length === 0">暂无课程</view>
          </view>
        </view>

        <!-- ===== 四、学情报告（my_study_report） ===== -->
        <view class="section">
          <view class="sec-title">📊 学情报告 <text class="sec-sub">my_study_report</text></view>

          <view class="report-summary" v-if="d.latestReport">
            <text class="rs-head">📋 最新学情摘要</text>
            <view class="rs-row"><text class="rs-label">报表类型</text><text class="rs-val">{{ typeText(d.latestReport.report_type) }}</text></view>
            <view class="rs-row"><text class="rs-label">报表日期</text><text class="rs-val">{{ d.latestReport.report_date }}</text></view>
            <view class="rs-row"><text class="rs-label">学习时长</text><text class="rs-val">{{ Math.floor((d.latestReport.study_duration||0)/60) }}h{{ (d.latestReport.study_duration||0)%60 }}min</text></view>
            <view class="rs-row"><text class="rs-label">完成课程</text><text class="rs-val">{{ d.latestReport.completed_courses || 0 }}</text></view>
            <view class="rs-row"><text class="rs-label">完成作业</text><text class="rs-val">{{ d.latestReport.completed_homework || 0 }}份</text></view>
            <view class="rs-row"><text class="rs-label">正确率</text><text class="rs-val" :class="d.latestReport.rateClass">{{ d.latestReport.correct_rate }}%</text></view>
            <view class="rs-row"><text class="rs-label">积分变化</text><text class="rs-val" style="color:#f39c12">+{{ d.latestReport.rank_score_change || 0 }}</text></view>
            <view class="rs-row" v-if="d.latestReport.weak_points"><text class="rs-label">薄弱点</text><text class="rs-val" style="color:#e74c3c">{{ JSON.stringify(d.latestReport.weak_points) }}</text></view>
            <view class="rs-row" v-if="d.latestReport.suggestions"><text class="rs-label">学习建议</text><text class="rs-val" style="color:#2ecc71">💡 {{ d.latestReport.suggestions }}</text></view>
          </view>

          <view class="report-list">
            <view class="report-item" v-for="(r, i) in d.studyReports" :key="i" @click="r._exp = !r._exp">
              <view class="ri-top">
                <text class="ri-badge" :class="'badge-' + r.report_type">{{ typeText(r.report_type) }}</text>
                <text class="ri-date">{{ r.report_date }}</text>
              </view>
              <view class="ri-line">
                <text>时长 {{ Math.floor((r.study_duration||0)/60) }}h{{ (r.study_duration||0)%60 }}min</text>
                <text>正确率 {{ r.correct_rate||0 }}%</text>
                <text>积分 +{{ r.rank_score_change||0 }}</text>
              </view>
              <view class="ri-expand" v-if="r._exp">
                <text v-if="r.weak_points">📉 薄弱: {{ JSON.stringify(r.weak_points) }}</text>
                <text v-if="r.strengths">📈 优势: {{ JSON.stringify(r.strengths) }}</text>
                <text v-if="r.suggestions">💡 建议: {{ r.suggestions }}</text>
              </view>
            </view>
            <view class="empty-tip" v-if="!d.studyReports || d.studyReports.length === 0">暂无学情报告</view>
          </view>
        </view>

        <!-- ===== 底部留白 ===== -->
        <view style="height: 40rpx"></view>

      </view>

      <view class="loading-wrap" v-if="loading">
        <view class="loading-spinner"></view>
        <text class="loading-text">加载中...</text>
      </view>
    </scroll-view>
  </view>
</template>

<script>
import { getProfile, getRecords, getProgress, getReports, rateClass, statusClass, statusText, typeText, tryParseJSON } from '@/api/studyrecord/index.js'

export default {
  data() {
    return {
      loading: true,
      refreshing: false,
      d: {
        studentInfo: null,
        records: [],
        courseProgress: [],
        studyReports: [],
        latestReport: null
      }
    }
  },
  onLoad() {
    this.loadData()
  },
  methods: {
	  statusText,
	    typeText,
	
    async loadData() {
      this.loading = true
      const userInfo = uni.getStorageSync('userInfo')
      const stuId = (userInfo && userInfo.stu_id) || 1

      try {
        const [profileRes, recordsRes, progressRes, reportsRes] = await Promise.all([
          getProfile(stuId),
          getRecords(stuId),
          getProgress(stuId),
          getReports(stuId)
        ])

        if (profileRes && profileRes.code === 200) this.d.studentInfo = profileRes.data

        if (reportsRes && reportsRes.code === 200 && reportsRes.data) {
          this.d.studyReports = reportsRes.data.reports || []
          this.d.latestReport = reportsRes.data.latest || null
          if (this.d.latestReport) {
            tryParseJSON(this.d.latestReport, 'weak_points')
            tryParseJSON(this.d.latestReport, 'strengths')
          }
          this.d.studyReports.forEach(r => {
            tryParseJSON(r, 'weak_points')
            tryParseJSON(r, 'strengths')
          })
        }

        if (recordsRes && recordsRes.code === 200 && recordsRes.data) {
          this.d.records = recordsRes.data || []
          this.d.records.forEach(r => { r.rateClass = rateClass(r.accuracyPercent) })
        }

        if (progressRes && progressRes.code === 200 && progressRes.data) {
          this.d.courseProgress = progressRes.data || []
          this.d.courseProgress.forEach(c => { c.statusClass = statusClass(c.status) })
        }

        if (this.d.latestReport) {
          this.d.latestReport.rateClass = rateClass(this.d.latestReport.correct_rate)
        }

        uni.showToast({ title: '加载成功', icon: 'success' })
      } catch (e) {
        console.error('数据加载失败:', e)
        uni.showToast({ title: '加载失败', icon: 'none' })
      }
      this.loading = false
    },
    onRefresh() {
      this.refreshing = true
      this.loadData()
      setTimeout(() => { this.refreshing = false }, 500)
    },
    goBack() {
      uni.navigateBack()
    }
  }
}
</script>

<style>
.page {
  min-height: 100vh;
  background: #f4f6fa;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
}
.header-bg {
  position: fixed;
  top: 0; left: 0; right: 0;
  height: 200rpx;
  background: linear-gradient(135deg, #667eea, #764ba2);
  border-radius: 0 0 40rpx 40rpx;
  z-index: 0;
}
.nav-bar {
  position: relative; z-index: 1;
  display: flex; align-items: center;
  padding: 80rpx 32rpx 20rpx;
  color: #fff;
}
.back-btn { font-size: 28rpx; padding: 8rpx 0; }
.nav-title { font-size: 36rpx; font-weight: 700; margin-left: 20rpx; }
.nav-subtitle { font-size: 20rpx; opacity: 0.7; margin-left: 12rpx; margin-top: 8rpx; }
.scroll-body {
  position: relative; z-index: 1;
  height: calc(100vh - 140rpx);
  padding: 0 24rpx 40rpx;
}
.content-wrap { padding-bottom: 40rpx; }

/* ===== 学生卡片 ===== */
.student-card {
  background: rgba(255,255,255,0.95);
  backdrop-filter: blur(20rpx);
  border-radius: 24rpx;
  padding: 28rpx 32rpx;
  margin-top: 10rpx;
  display: flex;
  align-items: center;
  box-shadow: 0 8rpx 32rpx rgba(102,126,234,0.15);
}
.s-avatar {
  width: 90rpx; height: 90rpx;
  border-radius: 50%;
  background: linear-gradient(135deg, #667eea, #764ba2);
  display: flex; align-items: center; justify-content: center;
  flex-shrink: 0;
}
.s-avatar-text { font-size: 36rpx; color: #fff; font-weight: 700; }
.s-info { flex: 1; margin-left: 20rpx; }
.s-name { font-size: 30rpx; font-weight: 700; color: #1a1a2e; display: block; }
.s-school { font-size: 22rpx; color: #888; display: block; margin-top: 4rpx; }
.s-stats { font-size: 20rpx; color: #aaa; display: block; margin-top: 4rpx; }
.s-rank { text-align: center; }
.s-rank-name {
  font-size: 22rpx; color: #fff; font-weight: 600;
  background: linear-gradient(135deg, #CD7F32, #E8A050);
  padding: 6rpx 18rpx; border-radius: 30rpx; display: block;
}
.s-rank-score { font-size: 20rpx; color: #888; margin-top: 6rpx; display: block; }

/* ===== Section ===== */
.section { margin-top: 28rpx; }
.sec-title {
  font-size: 30rpx; font-weight: 700; color: #1a1a2e;
  margin-bottom: 14rpx; display: flex; align-items: center;
}
.sec-sub { font-size: 18rpx; color: #bbb; font-weight: 400; margin-left: 12rpx; }

/* ===== 学习记录 ===== */
.record-grid { display: flex; flex-direction: column; gap: 14rpx; }
.record-item {
  background: #fff; border-radius: 18rpx; padding: 22rpx 24rpx;
  box-shadow: 0 4rpx 20rpx rgba(0,0,0,0.05);
}
.ri-head { display: flex; align-items: center; gap: 10rpx; margin-bottom: 10rpx; }
.ri-date { font-size: 24rpx; font-weight: 600; color: #333; }
.ri-week { font-size: 20rpx; color: #888; background: #f5f5f5; padding: 2rpx 10rpx; border-radius: 6rpx; }
.ri-time { font-size: 20rpx; color: #aaa; margin-left: auto; }
.ri-course { font-size: 22rpx; color: #667eea; font-weight: 500; display: block; }
.ri-title { font-size: 26rpx; font-weight: 600; color: #222; display: block; margin-top: 4rpx; }
.ri-score { display: flex; align-items: baseline; gap: 4rpx; margin-top: 12rpx; }
.ri-score-num { font-size: 40rpx; font-weight: 800; color: #333; }
.ri-score-sep { font-size: 24rpx; color: #ccc; }
.ri-score-total { font-size: 28rpx; color: #999; }
.ri-score-unit { font-size: 20rpx; color: #aaa; margin-left: 4rpx; }
.ri-score-rate { font-size: 22rpx; font-weight: 600; margin-left: 16rpx; padding: 2rpx 14rpx; border-radius: 20rpx; }
.rate-excellent { color: #fff; background: #2ecc71; }
.rate-good { color: #fff; background: #3498db; }
.rate-medium { color: #fff; background: #f39c12; }
.rate-low { color: #fff; background: #e74c3c; }
.ri-bar { height: 6rpx; background: #f0f0f0; border-radius: 6rpx; margin-top: 10rpx; overflow: hidden; }
.ri-bar-fill { height: 100%; border-radius: 6rpx; transition: width 0.6s; }
.ri-bar-fill.rate-excellent { background: linear-gradient(90deg, #2ecc71, #27ae60); }
.ri-bar-fill.rate-good { background: linear-gradient(90deg, #3498db, #2980b9); }
.ri-bar-fill.rate-medium { background: linear-gradient(90deg, #f39c12, #e67e22); }
.ri-bar-fill.rate-low { background: linear-gradient(90deg, #e74c3c, #c0392b); }
.ri-meta { margin-top: 10rpx; font-size: 20rpx; }
.ri-comment { color: #f39c12; display: block; }
.ri-deadline { color: #e74c3c; display: block; margin-top: 4rpx; }

/* ===== 课程 ===== */
.course-list { display: flex; flex-direction: column; gap: 14rpx; }
.course-item { background: #fff; border-radius: 18rpx; padding: 22rpx 24rpx; box-shadow: 0 4rpx 20rpx rgba(0,0,0,0.05); }
.ci-top { display: flex; justify-content: space-between; align-items: center; margin-bottom: 10rpx; }
.ci-type { font-size: 20rpx; padding: 4rpx 16rpx; border-radius: 20rpx; color: #fff; background: linear-gradient(135deg, #667eea, #764ba2); }
.ci-status { font-size: 22rpx; }
.status-ongoing { color: #3498db; }
.status-done { color: #2ecc71; }
.status-quit { color: #e74c3c; }
.ci-name { font-size: 28rpx; font-weight: 600; color: #222; display: block; margin-bottom: 12rpx; }
.ci-progress { display: flex; align-items: center; gap: 14rpx; }
.ci-bar-bg { flex: 1; height: 10rpx; background: #f0f0f0; border-radius: 10rpx; overflow: hidden; }
.ci-bar-fill { height: 100%; background: linear-gradient(90deg, #667eea, #764ba2); border-radius: 10rpx; }
.ci-bar-text { font-size: 24rpx; font-weight: 600; color: #667eea; width: 60rpx; text-align: right; }
.ci-meta { display: flex; gap: 16rpx; margin-top: 8rpx; font-size: 20rpx; color: #aaa; }
.ci-remark { font-size: 20rpx; color: #888; margin-top: 6rpx; display: block; }

/* ===== 报告 ===== */
.report-summary { background: linear-gradient(135deg, #667eea, #764ba2); border-radius: 18rpx; padding: 22rpx 24rpx; margin-bottom: 14rpx; }
.rs-head { font-size: 26rpx; color: #fff; font-weight: 600; margin-bottom: 12rpx; display: block; }
.rs-row { display: flex; justify-content: space-between; padding: 6rpx 0; border-bottom: 1rpx solid rgba(255,255,255,0.1); }
.rs-label { font-size: 22rpx; color: rgba(255,255,255,0.8); }
.rs-val { font-size: 22rpx; font-weight: 600; color: #fff; }
.report-list { display: flex; flex-direction: column; gap: 10rpx; }
.report-item { background: #fff; border-radius: 14rpx; padding: 18rpx 22rpx; box-shadow: 0 4rpx 16rpx rgba(0,0,0,0.04); }
.ri-top { display: flex; justify-content: space-between; align-items: center; margin-bottom: 8rpx; }
.ri-badge { font-size: 20rpx; padding: 2rpx 14rpx; border-radius: 20rpx; color: #fff; }
.badge-1 { background: #3498db; }
.badge-2 { background: #9b59b6; }
.badge-3 { background: #e74c3c; }
.ri-date { font-size: 22rpx; color: #888; }
.ri-line { display: flex; gap: 16rpx; font-size: 22rpx; color: #666; }
.ri-expand { margin-top: 10rpx; padding-top: 8rpx; border-top: 2rpx solid #f0f0f0; display: flex; flex-direction: column; gap: 6rpx; font-size: 22rpx; }



/* ===== 空状态 ===== */
.empty-tip { text-align: center; padding: 30rpx 0; font-size: 24rpx; color: #bbb; }

/* ===== 加载 ===== */
.loading-wrap { display: flex; flex-direction: column; align-items: center; padding: 200rpx 0; }
.loading-spinner {
  width: 60rpx; height: 60rpx;
  border: 6rpx solid #f0f0f0;
  border-top-color: #667eea;
  border-radius: 50%;
  animation: spin 0.8s linear infinite;
}
@keyframes spin { to { transform: rotate(360deg); } }
.loading-text { font-size: 24rpx; color: #888; margin-top: 16rpx; }
</style>