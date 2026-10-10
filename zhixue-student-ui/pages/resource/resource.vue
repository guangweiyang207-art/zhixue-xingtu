<template>
  <view class="page">
    <!-- 顶部导航 -->
    <view class="header">
      <view class="nav-bar">
        <uni-icons type="back" size="22" color="#333" @click="goBack" />
        <text class="title">教学资源</text>
        <view style="width: 22px;"></view>
      </view>
    </view>

    <!-- 搜索框 -->
    <view class="search-wrap">
      <view class="search-box">
        <uni-icons type="search" size="16" color="#999"></uni-icons>
        <input
          class="search-input"
          placeholder="搜索资源名称..."
          v-model="keyword"
          confirm-type="search"
          @confirm="handleSearch"
        />
      </view>
    </view>

    <!-- 分类标签栏 -->
    <view class="tabs-wrap">
      <view
        v-for="(tab, tabIndex) in tabList"
        :key="tabIndex"
        class="tab-item"
        :class="{ active: activeTab === tabIndex }"
        @click="switchTab(tabIndex)"
      >
        {{ tab.label }}
      </view>
    </view>

    <!-- 资源列表 -->
    <scroll-view scroll-y class="list-scroll">
      <view
        v-for="(item, index) in resourceList"
        :key="index"
        class="resource-item"
        @click="goDetail(item)"
      >
        <view class="item-icon" :style="{ backgroundColor: getTypeColor(item.resourceType) }">
          <text class="icon-text">{{ getTypeIcon(item.resourceType) }}</text>
        </view>
        <view class="item-content">
          <view class="item-title-row">
            <text class="item-name">{{ item.title }}</text>
            <text class="type-tag" :style="{ backgroundColor: getTypeColor(item.resourceType) + '20', color: getTypeColor(item.resourceType) }">{{ getTypeName(item.resourceType) }}</text>
          </view>
          <text class="item-desc">{{ item.content || '暂无描述' }}</text>
        </view>
      </view>
      <view v-if="resourceList.length === 0" class="empty-text">暂无相关资源</view>
    </scroll-view>
  </view>
</template>

<script>
  import { getResourceListApi } from '@/api/system/resource.js'

  const typeMap = {
    1: { label: '视频', color: '#ef4444', icon: '▶' },
    2: { label: '图书', color: '#3b82f6', icon: '书' },
    3: { label: '期刊', color: '#f59e0b', icon: '刊' },
    4: { label: '讲座', color: '#8b5cf6', icon: '讲' }
  }

  export default {
    data() {
      return {
        keyword: '',
        tabList: [
          { label: '全部', value: null },
          { label: '视频', value: 1 },
          { label: '图书', value: 2 },
          { label: '期刊', value: 3 },
          { label: '讲座', value: 4 }
        ],
        activeTab: 0,
        resourceList: [],
        loading: false
      }
    },
    onLoad() {
      this.loadData()
    },
    methods: {
      goBack() {
        uni.navigateBack()
      },
      goDetail(item) {
        uni.navigateTo({
          url: '/pages/resourcedetail/resourcedetail?title=' + encodeURIComponent(item.title) + '&resourceType=' + item.resourceType
        })
      },
      getTypeName(resourceType) {
        return typeMap[resourceType]?.label || '其他'
      },
      getTypeColor(resourceType) {
        return typeMap[resourceType]?.color || '#999'
      },
      getTypeIcon(resourceType) {
        return typeMap[resourceType]?.icon || '文'
      },
      switchTab(index) {
        this.activeTab = index
        this.loadData()
      },
      handleSearch() {
        this.loadData()
      },
      loadData() {
        if (this.loading) return
        this.loading = true
        const params = {}
        const typeValue = this.tabList[this.activeTab].value
        if (typeValue !== null) {
          params.resourceType = typeValue
        }
        if (this.keyword.trim()) {
          params.title = this.keyword.trim()
        }
        getResourceListApi(params).then(res => {
          this.loading = false
          const list = res?.data || []
          this.resourceList = Array.isArray(list) ? list : []
        }).catch(err => {
          this.loading = false
          console.error('资源列表请求失败：', err)
        })
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
  .search-wrap {
    padding: 20rpx 28rpx;
    background: #fff;
  }
  .search-box {
    display: flex;
    align-items: center;
    background: #f2f3f6;
    border-radius: 18rpx;
    padding: 20rpx 24rpx;
    gap: 16rpx;
  }
  .search-input {
    flex: 1;
    font-size: 28rpx;
    background: transparent;
    color: #333;
  }
  .tabs-wrap {
    display: flex;
    gap: 18rpx;
    padding: 20rpx 28rpx;
    background: #fff;
    flex-wrap: wrap;
  }
  .tab-item {
    padding: 12rpx 28rpx;
    border-radius: 999rpx;
    font-size: 26rpx;
    background: #f2f3f6;
    color: #666;
  }
  .tab-item.active {
    background: #7C3AED;
    color: #ffffff;
  }
  .list-scroll {
    flex: 1;
    padding: 20rpx 28rpx;
  }
  .resource-item {
    display: flex;
    gap: 22rpx;
    padding: 28rpx 22rpx;
    background: #fff;
    border-radius: 20rpx;
    margin-bottom: 20rpx;
    align-items: flex-start;
    box-shadow: 0 8rpx 24rpx rgba(68, 78, 95, 0.06);
  }
  .item-icon {
    width: 88rpx;
    height: 88rpx;
    border-radius: 16rpx;
    flex-shrink: 0;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .icon-text {
    font-size: 32rpx;
    color: #fff;
    font-weight: 600;
  }
  .item-content {
    flex: 1;
    min-width: 0;
  }
  .item-title-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 12rpx;
  }
  .item-name {
    font-size: 30rpx;
    font-weight: 600;
    color: #111;
    flex: 1;
    margin-right: 16rpx;
    word-break: break-all;
  }
  .type-tag {
    font-size: 22rpx;
    padding: 6rpx 14rpx;
    border-radius: 10rpx;
    white-space: nowrap;
    font-weight: 500;
  }
  .item-desc {
    font-size: 26rpx;
    color: #666;
    line-height: 1.5;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
  }
  .empty-text {
    text-align: center;
    padding: 160rpx 0;
    color: #999;
    font-size: 30rpx;
  }
</style>
