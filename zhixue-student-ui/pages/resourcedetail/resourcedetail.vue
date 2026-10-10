<template>
  <view class="page">
    <!-- 顶部导航 -->
    <view class="header">
      <view class="nav-bar">
        <uni-icons type="back" size="22" color="#333" @click="goBack" />
        <text class="title">{{ typeInfo.label }}详情</text>
        <view style="width: 22px;"></view>
      </view>
    </view>

    <scroll-view scroll-y class="content">
      <!-- 头部区域 -->
      <view class="hero-card" :style="{ background: typeInfo.gradient }">
        <view class="hero-icon">{{ typeInfo.icon }}</view>
        <view class="hero-type">{{ typeInfo.label }}</view>
      </view>

      <!-- 标题 -->
      <view class="title-card">
        <text class="res-title">{{ title }}</text>
        <view class="tag-row">
          <text class="type-badge" :style="{ backgroundColor: typeInfo.color + '20', color: typeInfo.color }">{{ typeInfo.label }}</text>
          <text v-if="resourceType === 1" class="tag-badge">精品课程</text>
          <text v-if="resourceType === 2" class="tag-badge">推荐阅读</text>
          <text v-if="resourceType === 3" class="tag-badge">核心期刊</text>
          <text v-if="resourceType === 4" class="tag-badge">名师讲堂</text>
        </view>
      </view>

      <!-- 视频类型 -->
      <template v-if="resourceType === 1">
        <view class="section-card">
          <text class="section-title">课程视频</text>
          <view class="video-placeholder" :style="{ background: typeInfo.gradient }">
            <text class="play-icon">▶</text>
            <text class="video-tip">点击播放视频</text>
          </view>
        </view>
        <view class="section-card">
          <text class="section-title">课程简介</text>
          <text class="desc-text">本课程通过生动的实验演示和详细的理论讲解，帮助学生深入理解核心知识点。课程内容由资深教师精心编排，适合课前预习和课后复习使用。</text>
        </view>
        <view class="section-card">
          <text class="section-title">课程目录</text>
          <view class="chapter-list">
            <view class="chapter-item" v-for="(c, i) in videoChapters" :key="i">
              <text class="chapter-num">{{ i + 1 }}</text>
              <text class="chapter-name">{{ c }}</text>
            </view>
          </view>
        </view>
      </template>

      <!-- 图书类型 -->
      <template v-if="resourceType === 2">
        <view class="section-card">
          <text class="section-title">图书信息</text>
          <view class="info-row">
            <text class="info-label">作者</text>
            <text class="info-value">教育部教材编写组</text>
          </view>
          <view class="info-row">
            <text class="info-label">出版社</text>
            <text class="info-value">人民教育出版社</text>
          </view>
          <view class="info-row">
            <text class="info-label">ISBN</text>
            <text class="info-value">978-7-107-12345-6</text>
          </view>
        </view>
        <view class="section-card">
          <text class="section-title">内容简介</text>
          <text class="desc-text">本书系统梳理了学科核心知识体系，配有大量例题和习题，注重培养学生的逻辑思维能力。全书共分八个章节，循序渐进，层层深入。</text>
        </view>
        <view class="section-card">
          <text class="section-title">目录概览</text>
          <view class="chapter-list">
            <view class="chapter-item" v-for="(c, i) in bookChapters" :key="i">
              <text class="chapter-num">{{ i + 1 }}</text>
              <text class="chapter-name">{{ c }}</text>
            </view>
          </view>
        </view>
      </template>

      <!-- 期刊类型 -->
      <template v-if="resourceType === 3">
        <view class="section-card">
          <text class="section-title">期刊信息</text>
          <view class="info-row">
            <text class="info-label">期号</text>
            <text class="info-value">2026年第3期</text>
          </view>
          <view class="info-row">
            <text class="info-label">主编</text>
            <text class="info-value">张教授</text>
          </view>
          <view class="info-row">
            <text class="info-label">发行单位</text>
            <text class="info-value">中国教育学会</text>
          </view>
        </view>
        <view class="section-card">
          <text class="section-title">本期导读</text>
          <text class="desc-text">本期聚焦教育改革前沿话题，收录了多篇高质量研究论文，涵盖教学方法创新、学生学习心理、课程设计优化等多个方向。</text>
        </view>
        <view class="section-card">
          <text class="section-title">文章列表</text>
          <view class="article-list">
            <view class="article-item" v-for="(a, i) in journalArticles" :key="i">
              <text class="article-title">{{ a.title }}</text>
              <text class="article-author">{{ a.author }}</text>
            </view>
          </view>
        </view>
      </template>

      <!-- 讲座类型 -->
      <template v-if="resourceType === 4">
        <view class="section-card">
          <text class="section-title">讲座信息</text>
          <view class="info-row">
            <text class="info-label">主讲人</text>
            <text class="info-value">李院士</text>
          </view>
          <view class="info-row">
            <text class="info-label">讲座时间</text>
            <text class="info-value">2026年6月15日 14:00</text>
          </view>
          <view class="info-row">
            <text class="info-label">地点</text>
            <text class="info-value">学术报告厅</text>
          </view>
        </view>
        <view class="section-card">
          <text class="section-title">讲座简介</text>
          <text class="desc-text">本次讲座将围绕学科前沿热点展开深入探讨，主讲人结合自身多年研究经验，为同学们带来一场内容丰富、观点独到的学术盛宴。</text>
        </view>
        <view class="section-card">
          <text class="section-title">讲座提纲</text>
          <view class="chapter-list">
            <view class="chapter-item" v-for="(c, i) in lectureOutline" :key="i">
              <text class="chapter-num">{{ i + 1 }}</text>
              <text class="chapter-name">{{ c }}</text>
            </view>
          </view>
        </view>
      </template>

      <!-- 底部信息 -->
      <view class="meta-row">
        <text class="meta-text">发布时间：2026-06-01</text>
      </view>
    </scroll-view>
  </view>
</template>

<script>
  const typeMap = {
    1: { label: '视频', color: '#ef4444', icon: '▶', gradient: 'linear-gradient(135deg, #ef4444, #f97316)' },
    2: { label: '图书', color: '#3b82f6', icon: '书', gradient: 'linear-gradient(135deg, #3b82f6, #6366f1)' },
    3: { label: '期刊', color: '#f59e0b', icon: '刊', gradient: 'linear-gradient(135deg, #f59e0b, #fbbf24)' },
    4: { label: '讲座', color: '#8b5cf6', icon: '讲', gradient: 'linear-gradient(135deg, #8b5cf6, #a78bfa)' }
  }

  export default {
    data() {
      return {
        title: '',
        resourceType: 1,
        videoChapters: ['第一章 基础概念讲解', '第二章 核心原理分析', '第三章 典型案例演示', '第四章 综合应用训练'],
        bookChapters: ['第一章 绪论', '第二章 基础理论', '第三章 方法与实践', '第四章 案例分析', '第五章 拓展阅读'],
        journalArticles: [
          { title: '基于大数据的个性化学习路径研究', author: '王教授 · 北京大学' },
          { title: '翻转课堂模式在中学教学中的应用', author: '刘老师 · 华东师范大学' },
          { title: '核心素养导向的课程设计策略', author: '陈老师 · 北京师范大学' }
        ],
        lectureOutline: ['研究背景与意义', '核心理论框架', '最新研究成果', '未来发展趋势', '互动答疑环节']
      }
    },
    computed: {
      typeInfo() {
        return typeMap[this.resourceType] || typeMap[1]
      }
    },
    onLoad(options) {
      this.title = decodeURIComponent(options.title || '资源详情')
      this.resourceType = Number(options.resourceType || 1)
    },
    methods: {
      goBack() {
        uni.navigateBack()
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
    background: #fff;
    padding-top: calc(var(--status-bar-height) + 20rpx);
    padding-bottom: 20rpx;
    padding-left: 30rpx;
    padding-right: 30rpx;
  }
  .nav-bar {
    display: flex;
    align-items: center;
    justify-content: space-between;
  }
  .title {
    font-size: 36rpx;
    font-weight: 600;
    color: #222;
  }
  .content {
    flex: 1;
    padding: 24rpx;
  }
  .hero-card {
    height: 280rpx;
    border-radius: 24rpx;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    margin-bottom: 24rpx;
    color: #fff;
  }
  .hero-icon {
    font-size: 80rpx;
    margin-bottom: 12rpx;
  }
  .hero-type {
    font-size: 32rpx;
    font-weight: 600;
  }
  .title-card {
    background: #fff;
    border-radius: 20rpx;
    padding: 32rpx;
    margin-bottom: 24rpx;
  }
  .res-title {
    font-size: 36rpx;
    font-weight: 700;
    color: #111;
    margin-bottom: 20rpx;
    display: block;
  }
  .tag-row {
    display: flex;
    gap: 16rpx;
    flex-wrap: wrap;
  }
  .type-badge {
    font-size: 24rpx;
    padding: 8rpx 20rpx;
    border-radius: 12rpx;
    font-weight: 500;
  }
  .tag-badge {
    font-size: 24rpx;
    padding: 8rpx 20rpx;
    border-radius: 12rpx;
    background: #f2f3f6;
    color: #666;
  }
  .section-card {
    background: #fff;
    border-radius: 20rpx;
    padding: 32rpx;
    margin-bottom: 24rpx;
  }
  .section-title {
    font-size: 30rpx;
    font-weight: 600;
    color: #222;
    margin-bottom: 20rpx;
    display: block;
  }
  .desc-text {
    font-size: 28rpx;
    color: #555;
    line-height: 1.8;
  }
  .video-placeholder {
    height: 400rpx;
    border-radius: 16rpx;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    color: #fff;
  }
  .play-icon {
    font-size: 80rpx;
    margin-bottom: 16rpx;
  }
  .video-tip {
    font-size: 28rpx;
  }
  .info-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20rpx 0;
    border-bottom: 1rpx solid #f2f3f6;
  }
  .info-label {
    font-size: 28rpx;
    color: #666;
  }
  .info-value {
    font-size: 28rpx;
    color: #333;
    font-weight: 500;
  }
  .chapter-list {
    display: flex;
    flex-direction: column;
    gap: 16rpx;
  }
  .chapter-item {
    display: flex;
    align-items: center;
    gap: 16rpx;
    padding: 20rpx;
    background: #f8f9fb;
    border-radius: 12rpx;
  }
  .chapter-num {
    width: 44rpx;
    height: 44rpx;
    line-height: 44rpx;
    text-align: center;
    background: #e6e8ec;
    border-radius: 50%;
    font-size: 24rpx;
    color: #666;
    flex-shrink: 0;
  }
  .chapter-name {
    font-size: 28rpx;
    color: #333;
  }
  .article-list {
    display: flex;
    flex-direction: column;
    gap: 20rpx;
  }
  .article-item {
    padding: 20rpx;
    background: #f8f9fb;
    border-radius: 12rpx;
  }
  .article-title {
    font-size: 28rpx;
    color: #333;
    font-weight: 500;
    margin-bottom: 8rpx;
    display: block;
  }
  .article-author {
    font-size: 24rpx;
    color: #999;
  }
  .meta-row {
    padding: 20rpx 0 40rpx;
    text-align: center;
  }
  .meta-text {
    font-size: 24rpx;
    color: #999;
  }
</style>
