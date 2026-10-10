<template>
  <view class="page">
    <view class="header">
      <view class="header-bg"></view>
      <view class="header-content">
        <view class="header-top">
          <text class="back-btn" @click="goBack">〈 返回</text>
        </view>
        <text class="header-title">错题本</text>
        <text class="header-sub">收录做错的题目，针对性巩固</text>
      </view>
    </view>

    <view class="body">
      <!-- 加载中 -->
      <view class="loading-bar" v-if="loading">
        <text class="loading-text">加载中...</text>
      </view>

      <!-- 接口错误提示 -->
      <view class="error-bar" v-if="apiErrMsg && !loading">
        <text class="error-icon">⚠</text>
        <text class="error-text">{{ apiErrMsg }}</text>
      </view>

      <!-- 统计概览 -->
      <view class="stat-card">
        <view class="stat-item">
          <text class="stat-num">{{ stats.total }}</text>
          <text class="stat-label">总错题</text>
        </view>
        <view class="stat-divider"></view>
        <view class="stat-item">
          <text class="stat-num">{{ stats.pending }}</text>
          <text class="stat-label">待复习</text>
        </view>
        <view class="stat-divider"></view>
        <view class="stat-item">
          <text class="stat-num">{{ stats.masteryRate }}%</text>
          <text class="stat-label">掌握率</text>
        </view>
      </view>

      <!-- 筛选标签 -->
      <view class="filter-tabs">
        <view class="filter-item" :class="{ active: activeFilter === 'all' }" @click="switchFilter('all')">全部</view>
        <view class="filter-item" :class="{ active: activeFilter === 'math' }" @click="switchFilter('math')">数学</view>
        <view class="filter-item" :class="{ active: activeFilter === 'physics' }" @click="switchFilter('physics')">物理</view>
        <view class="filter-item" :class="{ active: activeFilter === 'english' }" @click="switchFilter('english')">英语</view>
        <view class="filter-item" :class="{ active: activeFilter === 'chemistry' }" @click="switchFilter('chemistry')">化学</view>
      </view>

      <!-- 空状态 -->
      <view class="empty-state" v-if="!loading && errors.length === 0 && !apiErrMsg">
        <text class="empty-icon">✓</text>
        <text class="empty-text">暂无错题数据</text>
      </view>

      <!-- 错题列表 -->
      <view class="error-list">
        <view class="error-item" v-for="(item, index) in errors" :key="index" @click="toggleExpand(index)">
          <view class="error-header">
            <view class="error-subject" :class="item.subject">{{ item.subjectName }}</view>
            <text class="error-course">{{ item.courseName }}</text>
          </view>
          <view class="error-content">
            <text class="error-question">{{ item.question }}</text>
            <view class="error-answer">
              <text class="answer-wrong">你的答案：{{ item.wrongAnswer }}</text>
              <text class="answer-correct">正确答案：{{ item.correctAnswer }}</text>
            </view>
            <!-- 展开显示解析（支持v-if展开） -->
            <view class="error-analysis" v-if="item.expanded && item.analysis">
              <text class="analysis-label">解析：</text>
              <text class="analysis-text">{{ item.analysis }}</text>
            </view>
            <view class="error-bottom">
              <view class="error-left">
                <text class="error-date">{{ item.date }}</text>
                <text class="error-count" v-if="item.errorCount > 1">错误{{ item.errorCount }}次</text>
              </view>
              <view class="error-right-actions">
                <view class="ai-ask-btn" @click.stop="goAiAsk(item)">
                  <uni-icons type="chatbubble-filled" size="14" color="#8b5cf6" />
                  <text class="ai-ask-text">AI讲解</text>
                </view>
                <view class="error-status" :class="item.status">
                  {{ item.status === 'pending' ? '待复习' : '已掌握' }}
                </view>
              </view>
            </view>
          </view>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
import { getErrorListApi, getErrorStatsApi } from '@/api/errorbook/errorbook.js'

export default {
  data() {
    return {
      activeFilter: 'all',
      loading: false,
      apiErrMsg: '',
      errors: [],
      stats: {
        total: 0,
        pending: 0,
        mastered: 0,
        masteryRate: 0
      }
    }
  },
  onLoad() {
    this.fetchAll()
  },
  methods: {
    fetchAll() {
      this.fetchStats()
      this.fetchErrors()
    },
    fetchStats() {
      const stuId = uni.getStorageSync('userInfo')?.stu_id || 1
      getErrorStatsApi({ stu_id: stuId }).then(res => {
        if (res.data) {
          this.stats = {
            total: res.data.total || 0,
            pending: res.data.pending || 0,
            mastered: res.data.mastered || 0,
            masteryRate: res.data.masteryRate || 0
          }
        }
      }).catch(err => {
        console.error('获取错题统计失败：', err)
      })
    },
    fetchErrors() {
      this.loading = true
      this.apiErrMsg = ''
      const stuId = uni.getStorageSync('userInfo')?.stu_id || 1
      getErrorListApi({ stu_id: stuId, subject: this.activeFilter }).then(res => {
        this.loading = false
        if (res.data && Array.isArray(res.data)) {
          // 为每个项添加expanded字段控制解析的展开/折叠
          this.errors = res.data.map(item => ({
            ...item,
            expanded: false,
            question: item.tag || item.question || '错题'
          }))
        } else {
          this.errors = []
        }
      }).catch(err => {
        this.loading = false
        this.apiErrMsg = `接口 ${err.code || 404} 错误：${err.msg || '请求失败'}`
        console.error('获取错题列表失败：', err)
      })
    },
    switchFilter(subject) {
      this.activeFilter = subject
      this.fetchErrors()
    },
    toggleExpand(index) {
      this.errors[index].expanded = !this.errors[index].expanded
      // 强制更新视图
      this.$forceUpdate()
    },
    // 一键让 AI 讲解这道错题(tab 页需经 storage 中转传参)
    goAiAsk(item) {
      const parts = ['请给我详细讲解这道错题，包括解题思路和相关知识点：']
      parts.push('题目：' + (item.question || '未知题目'))
      if (item.wrongAnswer) parts.push('我的答案：' + item.wrongAnswer)
      if (item.correctAnswer) parts.push('正确答案：' + item.correctAnswer)
      uni.setStorageSync('ai_pending_ask', parts.join('\n'))
      uni.switchTab({ url: '/pages/ai/index' })
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
  padding: calc(var(--status-bar-height) + 32rpx) 32rpx 48rpx;
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

.loading-bar {
  display: flex; align-items: center; justify-content: center;
  padding: 30rpx; margin-bottom: 20rpx;
}
.loading-text { font-size: 26rpx; color: #9ca3af; }

.error-bar {
  display: flex; align-items: center; gap: 12rpx;
  background: #fef2f2; border: 1rpx solid #fecaca; border-radius: 12rpx;
  padding: 18rpx 20rpx; margin-bottom: 20rpx;
}
.error-icon { font-size: 28rpx; }
.error-text { font-size: 24rpx; color: #dc2626; }

.stat-card {
  display: flex; align-items: center;
  background: #fff; border-radius: 20rpx; padding: 30rpx;
  margin-bottom: 24rpx; box-shadow: 0 4rpx 16rpx rgba(15,23,42,0.04);
}
.stat-item { flex: 1; text-align: center; }
.stat-num { display: block; font-size: 40rpx; font-weight: 700; color: #6b5aed; }
.stat-label { display: block; font-size: 24rpx; color: #9ca3af; margin-top: 6rpx; }
.stat-divider { width: 1rpx; height: 60rpx; background: #f3f4f6; }

.filter-tabs {
  display: flex; gap: 16rpx; margin-bottom: 24rpx; flex-wrap: wrap;
}
.filter-item {
  padding: 14rpx 28rpx; background: #fff; border-radius: 30rpx;
  font-size: 26rpx; color: #6b7280;
}
.filter-item.active { background: #6b5aed; color: #fff; }

.empty-state {
  display: flex; flex-direction: column; align-items: center;
  padding: 80rpx 0;
}
.empty-icon {
  width: 100rpx; height: 100rpx; line-height: 100rpx; text-align: center;
  background: #eef2ff; color: #6b5aed; border-radius: 50%;
  font-size: 48rpx; margin-bottom: 20rpx;
}
.empty-text { font-size: 28rpx; color: #9ca3af; }

.error-list { margin-bottom: 30rpx; }

.error-item {
  background: #fff; border-radius: 20rpx; padding: 24rpx;
  margin-bottom: 16rpx; box-shadow: 0 4rpx 16rpx rgba(15,23,42,0.04);
}

.error-header {
  display: flex; align-items: center; gap: 12rpx; margin-bottom: 12rpx;
}
.error-subject {
  font-size: 22rpx; padding: 6rpx 18rpx; border-radius: 8rpx;
}
.error-subject.math { background: #eef2ff; color: #4f46e5; }
.error-subject.physics { background: #f0fdf4; color: #16a34a; }
.error-subject.english { background: #fef2f2; color: #dc2626; }
.error-subject.chemistry { background: #fefce8; color: #ca8a04; }
.error-subject.other { background: #f3f4f6; color: #6b7280; }

.error-course { font-size: 22rpx; color: #9ca3af; flex: 1; }

.error-content { }
.error-question { display: block; font-size: 28rpx; color: #111827; margin-bottom: 12rpx; }

.error-answer { margin-bottom: 8rpx; }
.answer-wrong { display: block; font-size: 24rpx; color: #dc2626; margin-bottom: 4rpx; }
.answer-correct { display: block; font-size: 24rpx; color: #16a34a; }

.error-analysis {
  background: #f8fafc; border-radius: 12rpx; padding: 16rpx;
  margin-bottom: 12rpx; border-left: 4rpx solid #6b5aed;
}
.analysis-label { font-size: 24rpx; font-weight: 600; color: #6b5aed; }
.analysis-text { font-size: 24rpx; color: #475569; line-height: 1.6; }

.error-bottom { display: flex; justify-content: space-between; align-items: center; }
.error-left { display: flex; align-items: center; gap: 16rpx; }
.error-date { font-size: 22rpx; color: #9ca3af; }
.error-count { font-size: 22rpx; color: #f59e0b; background: #fffbeb; padding: 2rpx 12rpx; border-radius: 6rpx; }

.error-status {
  font-size: 22rpx; padding: 4rpx 16rpx; border-radius: 8rpx;
}
.error-status.pending { background: #fef3c7; color: #d97706; }
.error-status.mastered { background: #dcfce7; color: #16a34a; }
.error-right-actions { display: flex; align-items: center; gap: 12rpx; }
.ai-ask-btn {
  display: flex; align-items: center; gap: 4rpx;
  padding: 6rpx 16rpx; border-radius: 24rpx;
  background: #f3efff; border: 1rpx solid #e3d9ff;
}
.ai-ask-text { font-size: 22rpx; color: #8b5cf6; font-weight: 500; }
</style>