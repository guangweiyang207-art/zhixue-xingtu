<template>
	<view class="page-container">
		<!-- 点击遮罩关闭搜索 -->
		<view class="search-mask" v-if="searchVisible" @click="closeSearch"></view>
		<!-- 搜索栏 -->
		<view class="search-wrapper" :class="{ active: searchVisible }">
			<view class="search-input" @click="goSearch" v-if="!searchVisible">
				<uni-icons type="search" size="18" color="#c7c8cc" />
				<text class="placeholder">搜索课程、资源、知识点...</text>
			</view>
			<view class="search-active" v-else>
				<view class="search-active-box">
					<uni-icons type="search" size="18" color="#c7c8cc" />
					<input
						class="search-active-input"
						v-model="searchKeyword"
						placeholder="输入资源名称搜索..."
						focus
						@input="onSearchInput"
						@blur="onSearchBlur"
					/>
					<text class="search-cancel" @click="closeSearch">取消</text>
				</view>
			</view>
			<!-- 搜索结果 -->
			<view class="search-result-panel" v-if="searchVisible">
				<view class="search-result-item" v-for="(item, idx) in searchResults" :key="idx" @click="goResourceDetail(item)">
					<view class="result-icon" :style="{backgroundColor: getResourceColor(item.resourceType)}">
						<text class="result-icon-text">{{ getResourceIcon(item.resourceType) }}</text>
					</view>
					<view class="result-info">
						<text class="result-title">{{ item.title }}</text>
						<text class="result-desc">{{ item.content || '暂无描述' }}</text>
					</view>
				</view>
				<view class="search-empty" v-if="searchResults.length === 0 && searchKeyword">
					<text>未找到相关资源</text>
				</view>
			</view>
		</view>

		<!-- Banner轮播 -->
		<view class="banner-wrapper">
			<swiper class="swiper-box" indicator-dots circular autoplay interval="4000" duration="600">
				<swiper-item v-for="(item, index) in bannerList" :key="index">
					<view class="banner-item">
						<image :src="item" class="banner-img" mode="aspectFill" />
					</view>
				</swiper-item>
			</swiper>
		</view>

		<!-- 功能四宫格 -->
		<view class="func-grid-wrap">
			<view class="func-grid">
				<view class="func-item" v-for="(item, idx) in funcList" :key="idx" @click="goJump(item)">
					<view class="icon-box" :style="{backgroundColor: item.lightBg}">
						<uni-icons :type="item.icon" :color="item.mainColor" size="48" />
					</view>
					<text class="item-text" :style="{color: item.mainColor}">{{item.name}}</text>
				</view>
			</view>
		</view>

		<!-- 通知公告栏 -->
		<view class="notice-bar" v-if="latestNotice" @click="goNotice">
			<view class="notice-bar-icon">
				<uni-icons type="sound-filled" size="18" color="#6366f1" />
			</view>
			<view class="notice-bar-content">
				<text class="notice-bar-title">{{latestNotice.noticeTitle}}</text>
			</view>
			<text class="notice-bar-more">更多</text>
		</view>

		<!-- 今日待办 -->
		<view class="todo-wrap">
			<view class="todo-header">
				<text class="section-title">今日待办</text>
				<text class="look-all" @click="handleCheckAllTodo">查看全部</text>
			</view>
			<view v-for="(item, index) in needtodoList.slice(0, 2)" :key="index" class="item">
				<view class="todo-item">
					<view class="left-line" :style="{backgroundColor: getTodoColor(item.type)}"></view>
					<view class="content-box">
						<text class="title">{{item.title}}</text>
						<text class="desc">{{item.desc || '截止日期：' + formatDate(item.deadline)}}</text>
					</view>
					<view class="btn-go" :style="{color: item.btnColor || '#1E3A5F', backgroundColor: item.btnBg || '#E6EBF2'}" @click="goHomeworkDetail(item)">{{item.btnText || '去完成'}}</view>
				</view>
			</view>
			<view v-if="needtodoList.length === 0" class="empty-text">暂时没有待办作业哦~</view>
		</view>

		<!-- 推荐课程 -->
		<view class="course-wrap">
			<text class="section-title">推荐课程</text>
			<view class="course-list">
				<view class="course-item" v-for="(item, index) in courseList" :key="index" @click="goCourseDetail(item)">
					<image class="course-cover" :src="courseImages[index % courseImages.length]" mode="aspectFill"></image>
					<view class="course-info">
						<text class="course-name">{{item.cName || item.title}}</text>
						<text class="course-teacher">讲师：{{item.teacherName || '张建国'}} · {{item.hours || 12}}课时</text>
						<view class="progress-row">
							<view class="progress-bg">
								<view class="progress-bar" :style="{width: (item.progress || 0) + '%', backgroundColor: item.progressColor || '#1E3A5F'}"></view>
							</view>
							<text class="progress-text">进度 {{item.progress || 0}}%</text>
						</view>
					</view>
				</view>
			</view>
			<view v-if="courseList.length === 0" class="empty-text">暂无推荐课程</view>
		</view>

		<!-- 学情报表 -->
		<view class="study-report-card">
			<view class="card-header">
				<view class="header-left">
					<view class="icon-purple">
						<uni-icons type="bars" size="20" color="#fff" />
					</view>
					<text class="card-title">学情报表</text>
				</view>
				<view class="info-icon" @click="openModal">i</view>
			</view>
			<view class="data-grid">
				<view class="data-item">
					<view class="data-label">
						<uni-icons type="compose" size="14" color="#9ca3af" />
						<text>今日学习时长</text>
					</view>
					<view class="data-value v-purple">{{stats.studyHours || 0}} 小时</view>
				</view>
				<view class="data-item">
					<view class="data-label">
						<uni-icons type="calendar" size="14" color="#9ca3af" />
						<text>本周完成作业</text>
					</view>
					<view class="data-value v-purple">{{stats.homeworkCount || 0}} 份</view>
				</view>
				<view class="data-item">
					<view class="data-label">
						<uni-icons type="checkbox-filled" size="14" color="#9ca3af" />
						<text>答题正确率</text>
					</view>
					<view class="data-value v-green">{{stats.correctRate || 0}}%</view>
				</view>
				<view class="data-item">
					<view class="data-label">
						<uni-icons type="paperclip" size="14" color="#9ca3af" />
						<text>累计做题数</text>
					</view>
					<view class="data-value v-orange">{{stats.totalQuestions || 0}} 题</view>
				</view>
			</view>
			<view class="link-more" @click="openModal">
				<text>点击查看详细学情趋势</text>
				<uni-icons type="arrowright" size="14" color="#8b5cf6" />
			</view>
		</view>

		<!-- 学情趋势详情弹窗 -->
		<view v-if="showModal" class="mask" @click="closeModal">
			<view class="modal-box" @click.stop>
				<view class="modal-close-top" @click="closeModal">×</view>
				<view class="modal-header">
					<view class="icon-purple">
						<uni-icons type="bars" size="20" color="#fff" />
					</view>
					<text class="modal-title">学情趋势详情</text>
				</view>
				<view class="chart-tip">近7天完成作业（份）</view>
				<view class="chart-area">
					<view class="chart-bar-wrap" v-for="(day, idx) in weekData" :key="idx">
						<view class="chart-bar-bg">
							<view class="chart-bar" :style="{height: (day.value / maxWeekValue * 100) + '%'}"></view>
						</view>
						<text class="chart-label">{{day.label}}</text>
					</view>
				</view>
				<view class="week-row row-purple">
					<text>累计学习时长</text>
					<text class="row-value">{{weeklyStats.totalHours || 0}} 小时</text>
				</view>
				<view class="week-row row-green">
					<text>答题平均正确率</text>
					<text class="row-value">{{weeklyStats.correctRate || 0}}%</text>
				</view>
				<view class="week-row row-pink">
					<text>累计完成作业</text>
					<text class="row-value">{{weeklyStats.homeworkCount || 0}} 份</text>
				</view>
				<button class="confirm-btn" @click="closeModal">确定</button>
			</view>
		</view>
	</view>
</template>

<script>
	import {
		getStudentHomeworkList,
		getRecommendCourseApi,
		getHomeStatsApi
	} from '@/api/system/index/index.js';
	import { getResourceListApi } from '@/api/system/resource.js'
	import config from '@/config'

	export default {
		data() {
			return {
				showModal: false,
				searchVisible: false,
				searchKeyword: '',
				searchResults: [],
				allResources: [],
				stats: {},
				latestNotice: null,
				weeklyStats: {
					totalHours: 0,
					correctRate: 0,
					homeworkCount: 0
				},
				weekData: [],
				courseList: [],
				courseImages: [
					'https://images.unsplash.com/photo-1635070041078-e363dbe005cb?w=400&q=80',
					'https://images.unsplash.com/photo-1456513080510-7bf3a84b82f8?w=400&q=80',
					'https://images.unsplash.com/photo-1532094349884-543bc11b234d?w=400&q=80',
					'https://images.unsplash.com/photo-1523240795612-9a054b0db644?w=400&q=80'
				],
				needtodoList: [],
				bannerList: [
					'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?w=800&q=80',
					'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=800&q=80'
				],
				funcList: [{
						name: '教学资源',
						icon: 'paperclip',
						mainColor: '#3671e9',
						lightBg: '#e1ecff',
						path: '/pages/resource/resource'
					},
					{
						name: '作业问答',
						icon: 'compose',
						mainColor: '#9944dd',
						lightBg: '#f2e1ff',
						path: '/pages/exam/exam'
					},
					{
						name: '错题本',
						icon: 'list',
						mainColor: '#e6642c',
						lightBg: '#ffe9d3',
						path: '/pages/errorbook/errorbook'
					},
					{
						name: '学习报告',
						icon: 'bars',
						mainColor: '#08b365',
						lightBg: '#d6f8e6',
						path: '/pages/report/report'
					}
				]
			}
		},
		computed: {
			maxWeekValue() {
				return Math.max(...this.weekData.map(d => d.value), 1);
			}
		},
		onLoad() {
			this.loadData();
		},
		onPullDownRefresh() {
			this.loadData(() => {
				uni.stopPullDownRefresh();
			});
		},
		methods: {
			loadData(callback) {
				Promise.all([
					this.loadTodoList(),
					this.loadCourseList(),
					this.loadStats(),
					this.loadLatestNotice()
				]).then(() => {
					if (callback) callback();
				}).catch(() => {
					if (callback) callback();
				});
			},
			loadLatestNotice() {
				return new Promise(resolve => {
					uni.request({
						url: config.baseUrl + '/mxy/notice/list',
						data: { status: 1 },
						success: res => {
							if (res.data && res.data.code === 200 && Array.isArray(res.data.data) && res.data.data.length > 0) {
								const list = res.data.data.slice().sort((a, b) => {
									if ((b.isTop || 0) !== (a.isTop || 0)) return (b.isTop || 0) - (a.isTop || 0);
									return new Date(b.publishTime || b.createTime || 0) - new Date(a.publishTime || a.createTime || 0);
								});
								this.latestNotice = list[0];
							}
							resolve();
						},
						fail: () => resolve()
					});
				});
			},
			goNotice() {
				this.$tab.navigateTo('/pages/notice/index');
			},
			loadTodoList() {
				return getStudentHomeworkList()
					.then(res => {
						const list = res && res.data ? res.data : [];
						const allList = Array.isArray(list) ? list.map(item => ({
							...item,
							title: item.title || '未命名作业',
							desc: item.deadline ? '截止日期：' + this.formatDate(item.deadline) : '',
							btnText: '去完成',
							btnColor: '#4f7cf7',
							btnBg: '#edf4ff'
						})) : [];
						this.needtodoList = allList.filter(item => item.status === 0);
					})
					.catch(err => {
						console.error('待办请求失败：', err);
					});
			},
			loadCourseList() {
				return getRecommendCourseApi()
					.then(res => {
						const list = res && res.data ? res.data : [];
						this.courseList = Array.isArray(list) ? list.map((item, idx) => ({
							...item,
							progress: [65, 25, 80, 40][idx % 4],
							progressColor: ['#1E3A5F', '#A47148', '#4A7C59', '#B8762E'][idx % 4],
							hours: 12
						})) : [];
					})
					.catch(err => {
						console.error('课程请求失败：', err);
					});
			},
			loadStats() {
				// 学情报表统计与近7天趋势统一走实时汇总接口
				const stuId = uni.getStorageSync('userInfo')?.stu_id || 1;
				return Promise.all([
					getHomeStatsApi().catch(() => null),
					new Promise(resolve => {
						uni.request({
							url: config.baseUrl + '/mine/study/reportSummary',
							data: { stu_id: stuId },
							success: res => resolve(res.data && res.data.data ? res.data.data : null),
							fail: () => resolve(null)
						});
					})
				]).then(([res, summary]) => {
					const data = res && res.data ? res.data : null;
					if (data) {
						const durationMin = data.studyDuration || 0;
						this.stats = {
							studyHours: (durationMin / 60).toFixed(1),
							homeworkCount: data.completedHomework || 0,
							correctRate: data.correctRate || 0,
							totalQuestions: data.completedCourses || 0
						};
					} else {
						this.stats = {
							studyHours: 0,
							homeworkCount: 0,
							correctRate: 0,
							totalQuestions: 0
						};
					}
					if (summary) {
						this.weekData = (summary.weekTrend || []).map(d => ({label: d.label, value: d.value || 0}));
						this.weeklyStats = {
							totalHours: ((summary.studyDuration || 0) / 60).toFixed(1),
							correctRate: summary.correctRate || 0,
							homeworkCount: summary.completedHomework || 0
						};
					}
				}).catch(err => {
					console.error('统计请求失败：', err);
				});
			},
			openModal() {
				this.showModal = true;
			},
			closeModal() {
				this.showModal = false;
			},
			goJump(item) {
				uni.navigateTo({
					url: item.path
				});
			},
			goSearch() {
				this.searchVisible = true;
				this.searchKeyword = '';
				this.searchResults = [];
				if (this.allResources.length === 0) {
					getResourceListApi({ pageSize: 100 }).then(res => {
						const list = res && res.data ? (res.data.list || res.data) : [];
						this.allResources = Array.isArray(list) ? list : [];
						this.searchResults = this.allResources.slice(0, 6);
					}).catch(() => {
						this.allResources = [];
					});
				} else {
					this.searchResults = this.allResources.slice(0, 6);
				}
			},
			closeSearch() {
				this.searchVisible = false;
				this.searchKeyword = '';
				this.searchResults = [];
			},
			onSearchInput() {
				const kw = this.searchKeyword.trim().toLowerCase();
				if (!kw) {
					this.searchResults = this.allResources.slice(0, 6);
					return;
				}
				const filtered = this.allResources.filter(item => {
					const title = (item.title || '').toLowerCase();
					const content = (item.content || '').toLowerCase();
					return title.includes(kw) || content.includes(kw);
				});
				this.searchResults = filtered.slice(0, 6);
			},
			onSearchBlur() {
				if (!this.searchKeyword.trim()) {
					this.searchResults = this.allResources.slice(0, 6);
				}
			},
			goResourceDetail(item) {
				uni.navigateTo({
					url: '/pages/resourcedetail/resourcedetail?reId=' + item.reId
				});
			},
			getResourceColor(type) {
				const map = { 1: '#A8443B', 2: '#1E3A5F', 3: '#B8762E', 4: '#A47148' };
				return map[type] || '#6B7280';
			},
			getResourceIcon(type) {
				const map = { 1: '▶', 2: '书', 3: '刊', 4: '讲' };
				return map[type] || '文';
			},
			handleCheckAllTodo() {
				uni.navigateTo({
					url: "/pages/homeworkall/homeworkall"
				});
			},
			goHomeworkDetail(item) {
				if (item.hwId) {
					uni.navigateTo({
						url: `/pages/homeworkdetail/homeworkdetail?id=${item.hwId}`
					});
				}
			},
			getTodoColor(type) {
				const colors = ['#1E3A5F', '#A47148', '#4A7C59', '#B8762E'];
				return colors[(type || 0) % 4];
			},
			formatDate(dateStr) {
				if (!dateStr) return '';
				// iOS 仅支持 "yyyy/MM/dd HH:mm:ss" 斜杠格式
				const safe = String(dateStr).replace(/-/g, '/');
				const d = new Date(safe);
				if (isNaN(d.getTime())) return String(dateStr);
				return `${d.getMonth() + 1}月${d.getDate()}日 ${String(d.getHours()).padStart(2, '0')}:${String(d.getMinutes()).padStart(2, '0')}`;
			},
			goCourseDetail(item) {
				uni.navigateTo({
					url: '/pages/resourcedetail/resourcedetail?title=' + encodeURIComponent(item.cName || item.title) + '&resourceType=1'
				});
			}
		}
	}
</script>

<style lang="scss" scoped>
	.page-container {
	  /* 给最外层容器增加顶部外边距，实现整体下移 */
	  margin-top: 60rpx; 
	}
	page {
		background-color: $uni-bg-color-page;
	}

	.page-container {
		padding-bottom: 40rpx;
	}

	.search-wrapper {
		padding: 18rpx 28rpx 10rpx;
		background: $uni-bg-color;
		position: relative;
		z-index: 10;
	}
	.search-wrapper.active {
		z-index: 100;
	}
	.search-mask {
		position: fixed;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		background: $uni-bg-color-mask;
		z-index: 90;
	}

	.search-input {
		display: flex;
		align-items: center;
		height: 84rpx;
		padding: 0 28rpx;
		background: $uni-bg-color-page;
		border: 1rpx solid $uni-border-color;
		border-radius: $uni-radius-full;
	}

	.search-input uni-icons {
		margin-right: 16rpx;
		flex-shrink: 0;
	}

	.placeholder {
		font-size: 26rpx;
		color: $uni-text-color-placeholder;
	}

	.search-active {
		padding: 0 28rpx;
	}
	.search-active-box {
		display: flex;
		align-items: center;
		height: 84rpx;
		padding: 0 20rpx;
		background: $uni-bg-color-page;
		border: 1rpx solid $uni-border-color;
		border-radius: $uni-radius-full;
	}
	.search-active-input {
		flex: 1;
		margin-left: 16rpx;
		font-size: 28rpx;
		color: $uni-text-color;
	}
	.search-cancel {
		margin-left: 16rpx;
		font-size: 28rpx;
		color: $uni-color-primary;
		padding: 8rpx 12rpx;
	}
	.search-result-panel {
		position: absolute;
		top: 100%;
		left: 28rpx;
		right: 28rpx;
		background: $uni-bg-color;
		border-radius: $uni-radius-lg;
		margin-top: 12rpx;
		padding: 12rpx 0;
		box-shadow: $uni-shadow-md;
		z-index: 100;
		max-height: 600rpx;
		overflow-y: auto;
	}
	.search-result-item {
		display: flex;
		align-items: center;
		padding: 20rpx 28rpx;
		border-bottom: 1rpx solid $uni-divider-color;
	}
	.search-result-item:last-child {
		border-bottom: none;
	}
	.result-icon {
		width: 72rpx;
		height: 72rpx;
		border-radius: $uni-radius-md;
		display: flex;
		align-items: center;
		justify-content: center;
		margin-right: 20rpx;
		flex-shrink: 0;
	}
	.result-icon-text {
		font-size: 32rpx;
		color: $uni-text-color-inverse;
	}
	.result-info {
		flex: 1;
		overflow: hidden;
	}
	.result-title {
		font-size: 30rpx;
		color: $uni-text-color;
		font-weight: 500;
		display: block;
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
	}
	.result-desc {
		font-size: 24rpx;
		color: $uni-text-color-tertiary;
		margin-top: 6rpx;
		display: block;
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
	}
	.search-empty {
		padding: 40rpx;
		text-align: center;
		font-size: 28rpx;
		color: $uni-text-color-tertiary;
	}

	.banner-wrapper {
		padding: 0 28rpx;
		margin-bottom: 18rpx;
	}

	.swiper-box {
		width: 100%;
		height: 300rpx;
		border-radius: 26rpx;
		overflow: hidden;
	}

	.banner-item,
	.banner-img {
		width: 100%;
		height: 100%;
	}

	.func-grid-wrap {
		padding: 14rpx 28rpx 0;
		background: $uni-bg-color;
	}

	.func-grid {
		display: grid;
		grid-template-columns: repeat(4, 1fr);
		gap: 18rpx;
	}

	.func-item {
		display: flex;
		flex-direction: column;
		align-items: center;
		padding: 20rpx 8rpx 18rpx;
		border: 1rpx solid $uni-border-color-light;
		border-radius: $uni-radius-md;
		background: $uni-bg-color;
	}

	.icon-box {
		width: 108rpx;
		height: 108rpx;
		border-radius: $uni-radius-md;
		display: flex;
		align-items: center;
		justify-content: center;
		margin-bottom: 12rpx;
	}

	.item-text {
		font-size: 26rpx;
		font-weight: 500;
		line-height: 1.2;
		text-align: center;
	}

	.notice-bar {
		display: flex;
		align-items: center;
		margin: 18rpx 28rpx 0;
		padding: 20rpx 24rpx;
		background: $uni-bg-color;
		border-radius: $uni-radius-lg;
		box-shadow: $uni-shadow-sm;
	}

	.notice-bar-icon {
		width: 60rpx;
		height: 60rpx;
		background: #eef2ff;
		border-radius: 14rpx;
		display: flex;
		align-items: center;
		justify-content: center;
		flex-shrink: 0;
	}

	.notice-bar-content {
		flex: 1;
		margin: 0 18rpx;
		overflow: hidden;

		.notice-bar-title {
			display: block;
			font-size: 27rpx;
			color: $uni-text-color;
			overflow: hidden;
			text-overflow: ellipsis;
			white-space: nowrap;
		}
	}

	.notice-bar-more {
		flex-shrink: 0;
		font-size: 24rpx;
		color: $uni-color-primary;
	}

	.todo-wrap,
	.course-wrap,
	.study-report-card {
		margin: 18rpx 28rpx 0;
		padding: 26rpx;
		background: $uni-bg-color;
		border-radius: $uni-radius-lg;
	}

	.todo-header,
	.card-header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-bottom: 22rpx;
	}

	.header-left {
		display: flex;
		align-items: center;
		gap: 16rpx;
	}

	.section-title,
	.card-title {
		font-size: 32rpx;
		font-weight: $uni-font-weight-semibold;
		color: $uni-text-color;
	}

	.look-all {
		font-size: 26rpx;
		color: $uni-color-primary;
	}

	.item {
		margin-bottom: 18rpx;
	}

	.item:last-child {
		margin-bottom: 0;
	}

	.todo-item {
		display: flex;
		align-items: center;
		background: $uni-bg-color;
		border: 1rpx solid $uni-border-color-light;
		border-radius: $uni-radius-md;
		padding: 26rpx 22rpx;
	}

	.left-line {
		width: 6rpx;
		height: 74rpx;
		background-color: $uni-color-primary;
		border-radius: $uni-radius-full;
		margin-right: 20rpx;
		flex-shrink: 0;
	}

	.content-box {
		flex: 1;
		display: flex;
		flex-direction: column;
		min-width: 0;
	}

	.content-box .title {
		font-size: 30rpx;
		font-weight: 500;
		color: $uni-text-color;
		margin-bottom: 6rpx;
	}

	.desc {
		font-size: 24rpx;
		color: $uni-text-color-tertiary;
		line-height: 1.35;
	}

	.btn-go {
		padding: 14rpx 26rpx;
		background-color: $uni-color-primary-soft;
		color: $uni-color-primary;
		border-radius: $uni-radius-full;
		font-size: 26rpx;
		white-space: nowrap;
		flex-shrink: 0;
	}

	.course-list {
		display: flex;
		flex-direction: column;
		gap: 18rpx;
	}

	.course-item {
		display: flex;
		gap: 22rpx;
		align-items: flex-start;
		padding: 20rpx;
		border: 1rpx solid $uni-border-color-light;
		border-radius: $uni-radius-md;
		background: $uni-bg-color;
	}

	.course-cover {
		width: 152rpx;
		height: 152rpx;
		border-radius: $uni-radius-md;
		flex-shrink: 0;
	}

	.course-info {
		flex: 1;
		min-width: 0;
	}

	.course-name {
		display: block;
		font-size: 30rpx;
		font-weight: $uni-font-weight-semibold;
		color: $uni-text-color;
		margin-bottom: 8rpx;
		line-height: 1.25;
	}

	.course-teacher {
		display: block;
		font-size: 24rpx;
		color: $uni-text-color-tertiary;
		margin-bottom: 14rpx;
	}

	.progress-row {
		display: flex;
		align-items: center;
		gap: 14rpx;
	}

	.progress-bg {
		flex: 1;
		height: 12rpx;
		background: $uni-bg-color-alt;
		border-radius: $uni-radius-full;
		overflow: hidden;
	}

	.progress-bar {
		height: 100%;
		border-radius: $uni-radius-full;
		transition: width $uni-duration-base $uni-ease;
	}

	.progress-text {
		font-size: 24rpx;
		color: $uni-text-color-tertiary;
		white-space: nowrap;
	}

	.study-report-card {
		background: $uni-color-primary-soft;
		border: 1rpx solid $uni-color-primary-soft;
	}

	.icon-purple {
		width: 56rpx;
		height: 56rpx;
		background: $uni-color-primary;
		border-radius: $uni-radius-sm;
		display: flex;
		align-items: center;
		justify-content: center;
	}

	.info-icon {
		width: 40rpx;
		height: 40rpx;
		border-radius: 50%;
		border: 2rpx solid $uni-color-primary-hover;
		color: $uni-color-primary;
		font-size: 24rpx;
		display: flex;
		align-items: center;
		justify-content: center;
		font-weight: 500;
	}

	.data-grid {
		display: grid;
		grid-template-columns: repeat(2, 1fr);
		gap: 16rpx;
	}

	.data-item {
		padding: 22rpx;
		border-radius: $uni-radius-md;
		background: $uni-bg-color;
		box-shadow: $uni-shadow-xs;
	}

	.data-label {
		display: flex;
		align-items: center;
		gap: 8rpx;
		font-size: 24rpx;
		color: $uni-text-color-tertiary;
		margin-bottom: 12rpx;
	}

	.data-value {
		font-size: 36rpx;
		font-weight: $uni-font-weight-semibold;
	}

	.v-purple { color: $uni-color-primary; }
	.v-green  { color: $uni-color-success; }
	.v-orange { color: $uni-color-warning; }

	.link-more {
		margin-top: 24rpx;
		display: flex;
		align-items: center;
		justify-content: center;
		gap: 8rpx;
		font-size: 26rpx;
		color: $uni-color-primary;
	}

	.empty-text {
		text-align: center;
		font-size: 26rpx;
		color: $uni-text-color-tertiary;
		padding: 40rpx 0;
	}

	/* 弹窗 */
	.mask {
		position: fixed;
		left: 0;
		top: 0;
		right: 0;
		bottom: 0;
		background: $uni-bg-color-mask;
		display: flex;
		align-items: center;
		justify-content: center;
		z-index: 9999;
	}

	.modal-box {
		width: 86%;
		max-width: 600rpx;
		background: $uni-bg-color;
		border-radius: $uni-radius-xl;
		padding: 40rpx 32rpx;
		position: relative;
		z-index: 10000;
	}

	.modal-close-top {
		position: absolute;
		top: 24rpx;
		right: 28rpx;
		font-size: 44rpx;
		color: $uni-text-color-tertiary;
		line-height: 1;
	}

	.modal-header {
		display: flex;
		align-items: center;
		gap: 16rpx;
		margin-bottom: 32rpx;
	}

	.modal-title {
		font-size: 32rpx;
		font-weight: $uni-font-weight-semibold;
		color: $uni-text-color;
	}

	.chart-tip {
		font-size: 26rpx;
		color: $uni-text-color-tertiary;
		margin-bottom: 24rpx;
		text-align: center;
	}

	.chart-area {
		display: flex;
		justify-content: space-between;
		align-items: flex-end;
		height: 200rpx;
		margin-bottom: 32rpx;
		padding: 0 10rpx;
	}

	.chart-bar-wrap {
		display: flex;
		flex-direction: column;
		align-items: center;
		flex: 1;
	}

	.chart-bar-bg {
		width: 32rpx;
		height: 160rpx;
		background: $uni-bg-color-alt;
		border-radius: 16rpx;
		overflow: hidden;
		display: flex;
		align-items: flex-end;
	}

	.chart-bar {
		width: 100%;
		background: $uni-color-primary;
		border-radius: 16rpx;
		transition: height 0.5s ease;
	}

	.chart-label {
		font-size: 22rpx;
		color: $uni-text-color-tertiary;
		margin-top: 12rpx;
	}

	.week-row {
		padding: 24rpx 28rpx;
		border-radius: $uni-radius-md;
		margin-bottom: 16rpx;
		display: flex;
		justify-content: space-between;
		align-items: center;
		font-size: 28rpx;
	}

	.row-purple {
		background: $uni-color-primary-soft;
		color: $uni-color-primary;
	}

	.row-green {
		background: $uni-color-success-soft;
		color: $uni-color-success;
	}

	.row-pink {
		background: $uni-color-accent-soft;
		color: $uni-color-accent;
	}

	.row-value {
		font-weight: $uni-font-weight-semibold;
		font-size: 32rpx;
	}

	.confirm-btn {
		width: 100%;
		padding: 28rpx;
		border-radius: $uni-radius-md;
		border: none;
		background: $uni-color-primary;
		color: $uni-text-color-inverse;
		font-size: 30rpx;
		font-weight: $uni-font-weight-medium;
		margin-top: 24rpx;
		pointer-events: auto !important;
	}
</style>