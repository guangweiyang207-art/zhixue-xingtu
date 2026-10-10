<template>
  <view class="page">
    <view class="head">
      <view class="head-top">
        <text class="title">学生管理</text>
        <view class="add-btn" @click="showAdd = true">
          <text class="add-icon">+</text>
          <text>添加</text>
        </view>
      </view>
      <view class="search">
        <text class="search-icon">🔍</text>
        <input
          class="search-input"
          v-model="keyword"
          placeholder="搜索学号 / 班级 / 姓名"
          confirm-type="search"
          @input="onSearchInput"
          @confirm="loadList"
        />
        <text v-if="keyword" class="search-clear" @click="clearSearch">×</text>
      </view>
    </view>

    <scroll-view class="tabs" scroll-x enable-flex>
      <view
        v-for="(t, i) in tabs"
        :key="i"
        class="tab"
        :class="{ on: currentTab === i }"
        @click="switchTab(i)"
      >
        {{ t }}
      </view>
    </scroll-view>

    <view class="list">
      <view
        v-for="(item, idx) in list"
        :key="item.stuId || idx"
        class="card"
        :data-id="item.stuId"
        @click="onCardTap"
      >
        <view class="card-main">
          <view class="row1">
            <text class="name">{{ item.realName || item.studentNo || item.userId || item.stuId }}</text>
            <text class="tag">{{ item.className || '-' }}</text>
          </view>
          <view class="row2">
            <view class="m">
              <text class="ml">作业完成</text>
              <text class="mv p">{{ item.homeworkCompletion || 0 }}%</text>
            </view>
            <view class="m">
              <text class="ml">正确率</text>
              <text class="mv g">{{ item.accuracyRate || 0 }}%</text>
            </view>
            <view class="m">
              <text class="ml">活跃度</text>
              <text class="mv o">{{ item.activityLevel || 0 }}</text>
            </view>
          </view>
        </view>
        <view class="del" :data-id="item.stuId" @click.stop="onDelTap">删除</view>
      </view>

      <view v-if="!loading && list.length === 0" class="empty">
        <text>暂无数据</text>
      </view>
    </view>

    <!-- 删除弹窗 -->
    <view v-if="delTarget" class="mask" @click="delTarget = null">
      <view class="box" @click.stop>
        <view class="box-title">删除学生</view>
        <view class="box-body">确认删除 {{ delTarget.studentNo || delTarget.stuId }}？</view>
        <view class="box-foot">
          <view class="btn" @click="delTarget = null">取消</view>
          <view class="btn ok" @click="confirmDel">确定</view>
        </view>
      </view>
    </view>
    <!-- 添加学生弹窗（按学号+姓名） -->
    <view v-if="showAdd" class="mask" @click="closeAdd">
      <view class="box" @click.stop>
        <view class="box-title">添加学生</view>
        <view class="box-body">
          <view class="form-item">
            <text class="form-label">学号</text>
            <input
              class="form-input"
              v-model="addForm.studentNo"
              placeholder="请输入学号"
              maxlength="30"
            />
          </view>
          <view class="form-item">
            <text class="form-label">姓名</text>
            <input
              class="form-input"
              v-model="addForm.realName"
              placeholder="请输入姓名"
              maxlength="20"
            />
          </view>
          <view class="form-tip">系统会根据学号+姓名匹配 my_sys_user 中已存在的用户，确认后会关联到学生列表。</view>
        </view>
        <view class="box-foot">
          <view class="btn" @click="closeAdd">取消</view>
          <view class="btn ok" :class="{ disabled: addSubmitting }" @click="submitAdd">
            {{ addSubmitting ? '提交中...' : '确定' }}
          </view>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
import request from '@/utils/request'

export default {
  data() {
    return {
      keyword: '',
      tabs: ['全部学生'],
      currentTab: 0,
      list: [],
      loading: false,
      delTarget: null,
      showAdd: false,
      addForm: {
        studentNo: '',
        realName: ''
      },
      addSubmitting: false,
      searchTimer: null
    }
  },
  onLoad() {
    this.loadClasses()
    this.loadList()
  },
  methods: {
    loadClasses() {
      request({ url: '/students/student/classes', method: 'GET' })
        .then(res => {
          const cs = (res.data || []).filter(Boolean)
          this.tabs = ['全部学生'].concat(cs)
        })
        .catch(() => {})
    },
    loadList() {
      this.loading = true
      const params = {}
      if (this.currentTab > 0) {
        params.className = this.tabs[this.currentTab]
      }
      if (this.keyword && this.keyword.trim()) {
        params.searchValue = this.keyword.trim()
      }
      request({ url: '/students/student/list', method: 'GET', data: params })
        .then(res => {
          this.list = res.rows || []
          this.loading = false
        })
        .catch(() => {
          this.loading = false
        })
    },
    switchTab(i) {
      this.currentTab = i
      this.loadList()
    },
    /**
     * 搜索输入（防抖）
     */
    onSearchInput() {
      if (this.searchTimer) clearTimeout(this.searchTimer)
      this.searchTimer = setTimeout(() => {
        this.loadList()
      }, 300)
    },
    clearSearch() {
      this.keyword = ''
      this.loadList()
    },
    closeAdd() {
      if (this.addSubmitting) return
      this.showAdd = false
      this.addForm.studentNo = ''
      this.addForm.realName = ''
    },
    submitAdd() {
      const sn = (this.addForm.studentNo || '').trim()
      const rn = (this.addForm.realName || '').trim()
      if (!sn) {
        uni.showToast({ title: '请输入学号', icon: 'none' })
        return
      }
      if (!rn) {
        uni.showToast({ title: '请输入姓名', icon: 'none' })
        return
      }
      this.addSubmitting = true
      request({
        url: '/students/student/add-by-no-name',
        method: 'POST',
        data: { studentNo: sn, realName: rn }
      })
        .then(res => {
          this.addSubmitting = false
          // RuoYi 成功：{code:200, msg, data}
          uni.showToast({ title: res.msg || '添加成功', icon: 'success' })
          this.showAdd = false
          this.addForm.studentNo = ''
          this.addForm.realName = ''
          this.loadList()
          this.loadClasses()
        })
        .catch(err => {
          this.addSubmitting = false
          const msg = (err && err.msg) || (err && err.message) || '添加失败'
          uni.showToast({ title: msg, icon: 'none' })
        })
    },
    /**
     * 点击卡片：用事件对象拿 stuId
     */
    onCardTap(e) {
      const ds = (e && e.currentTarget && e.currentTarget.dataset) || {}
      const id = ds.id
      console.log('[card click] dataset=', JSON.stringify(ds), ' id=', id)
      if (!id) {
        uni.showToast({ title: '卡片ID为空', icon: 'none' })
        return
      }
      uni.navigateTo({
        url: '/pages/students/detail?id=' + id,
        fail: (err) => {
          console.error('[navigateTo fail]', err)
          uni.showToast({ title: '跳转失败', icon: 'none' })
        }
      })
    },
    /**
     * 点击删除
     */
    onDelTap(e) {
      const ds = (e && e.currentTarget && e.currentTarget.dataset) || {}
      const id = ds.id
      const item = this.list.find(x => String(x.stuId) === String(id))
      if (!item) {
        uni.showToast({ title: '未找到学生', icon: 'none' })
        return
      }
      this.delTarget = item
    },
    confirmDel() {
      if (!this.delTarget) return
      const id = this.delTarget.stuId
      request({ url: '/students/student/' + id, method: 'DELETE' })
        .then(() => {
          uni.showToast({ title: '删除成功', icon: 'success' })
          this.delTarget = null
          this.loadList()
          this.loadClasses()
        })
        .catch(() => {
          uni.showToast({ title: '删除失败', icon: 'none' })
        })
    }
  }
}
</script>

<style lang="scss" scoped>
page { background: #f5f5f5; }
.page { padding: 0 24rpx 40rpx; }

.head { padding: 40rpx 0 16rpx; }
.head-top { display: flex; justify-content: space-between; align-items: center; margin-bottom: 28rpx; }
.title { font-size: 48rpx; font-weight: bold; color: #1a1a1a; }
.add-btn { background: #5856e0; color: #fff; padding: 14rpx 28rpx; border-radius: 36rpx; font-size: 28rpx; display: flex; align-items: center; }
.add-icon { font-size: 34rpx; font-weight: bold; margin-right: 6rpx; line-height: 1; }

.search {
  display: flex;
  align-items: center;
  background: #fff;
  border-radius: 40rpx;
  padding: 18rpx 28rpx;
  box-shadow: 0 4rpx 16rpx rgba(88, 86, 224, 0.08);
  border: 2rpx solid #ececff;
}
.search-icon { font-size: 32rpx; margin-right: 12rpx; line-height: 1; }
.search-input { flex: 1; font-size: 30rpx; height: 44rpx; line-height: 44rpx; color: #1a1a1a; }
.search-clear { font-size: 40rpx; color: #ccc; padding: 0 8rpx; line-height: 1; }

.tabs {
  display: flex;
  flex-wrap: nowrap;
  white-space: nowrap;
  padding-bottom: 24rpx;
  -webkit-overflow-scrolling: touch;
}
.tab {
  flex-shrink: 0;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  height: 44rpx;
  padding: 0 26rpx;
  background: #fff;
  border-radius: 22rpx;
  font-size: 24rpx;
  line-height: 1;
  border: 1rpx solid #eee;
  margin-right: 14rpx;
}
.tab.on { background: #5856e0; color: #fff; border-color: #5856e0; }
.tab:last-child { margin-right: 24rpx; }

.list { display: flex; flex-direction: column; gap: 20rpx; }
.card { background: #fff; border-radius: 20rpx; padding: 24rpx; display: flex; flex-direction: row; align-items: center; }
.card-main { flex: 1; }
.row1 { display: flex; align-items: center; margin-bottom: 10rpx; }
.name { font-size: 32rpx; font-weight: 600; margin-right: 12rpx; }
.tag { font-size: 22rpx; color: #5856e0; background: #f0efff; padding: 4rpx 12rpx; border-radius: 8rpx; }
.row2 { display: flex; }
.m { flex: 1; }
.ml { font-size: 22rpx; color: #888; display: block; }
.mv { font-size: 28rpx; font-weight: 600; }
.mv.p { color: #5856e0; }
.mv.g { color: #2cd87a; }
.mv.o { color: #ff8a3d; }

.del { background: #ff4d4d; color: #fff; padding: 12rpx 20rpx; border-radius: 12rpx; font-size: 24rpx; margin-left: 16rpx; }

.empty { text-align: center; color: #999; padding: 60rpx 0; font-size: 26rpx; }

.mask { position: fixed; inset: 0; background: rgba(0,0,0,0.5); display: flex; align-items: center; justify-content: center; z-index: 999; }
.box { width: 80%; background: #fff; border-radius: 20rpx; overflow: hidden; }
.box-title { padding: 24rpx; font-size: 32rpx; font-weight: 600; border-bottom: 1rpx solid #eee; }
.box-body { padding: 24rpx; }
.box-foot { display: flex; border-top: 1rpx solid #eee; }
.btn { flex: 1; text-align: center; padding: 24rpx; font-size: 28rpx; color: #666; border-right: 1rpx solid #eee; }
.btn.ok { color: #5856e0; border-right: none; }
.btn.ok.disabled { color: #aaa; }

.form-item { display: flex; flex-direction: column; margin-bottom: 24rpx; }
.form-label { font-size: 26rpx; color: #666; margin-bottom: 10rpx; }
.form-input { background: #f5f5f7; border-radius: 12rpx; padding: 18rpx 20rpx; font-size: 28rpx; }
.form-tip { font-size: 22rpx; color: #999; line-height: 1.5; margin-top: 8rpx; }
</style>
