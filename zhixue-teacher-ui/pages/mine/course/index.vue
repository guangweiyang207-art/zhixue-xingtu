<template>
  <view class="course-page">
    <!-- 页面标题 -->
    <view class="page-header">
      <text class="page-title">我的课程</text>
    </view>

    <!-- 课程列表 -->
    <view class="course-list" v-if="courses.length > 0">
      <view
        v-for="(course, index) in courses"
        :key="course.cId"
        class="course-card"
      >
        <view class="card-header">
          <view class="course-name-wrap">
            <text class="course-name">{{ course.cName || '(未命名课程)' }}</text>
            <text class="course-tag" v-if="course.tag">{{ course.tag }}</text>
          </view>
          <view class="card-actions">
            <view class="action-btn edit" @click="openEditModal(course, index)">
              <text class="iconfont icon-edit"></text>
            </view>
            <view class="action-btn delete" @click="openDeleteModal(course, index)">
              <text class="iconfont icon-clean"></text>
            </view>
          </view>
        </view>

        <view class="card-body">
          <view class="info-row">
            <text class="info-label">类型</text>
            <text class="info-value">{{ course.type || '—' }}</text>
          </view>
          <view class="info-row">
            <text class="info-label">难度</text>
            <text class="info-value">{{ difficultyText(course.difficulty) }}</text>
          </view>
          <view class="info-row">
            <text class="info-label">开课时间</text>
            <text class="info-value">{{ course.startTime || '—' }}</text>
          </view>
          <view class="info-row">
            <text class="info-label">选课人数</text>
            <text class="info-value">{{ (course.currentPerson || 0) }} / {{ course.maxPerson || '∞' }}</text>
          </view>
          <view class="info-row" v-if="course.description">
            <text class="info-label">课程简介</text>
            <text class="info-value multi-line">{{ course.description }}</text>
          </view>
        </view>
      </view>
    </view>

    <view v-else class="empty">
      <text class="empty-iconfont">📚</text>
      <text class="empty-text">还没有发布过课程,去"任务管理"里发布吧</text>
    </view>

    <!-- 编辑课程弹窗 -->
    <view class="modal-mask" v-if="showEditModal" @click="showEditModal = false">
      <view class="modal-content" @click.stop>
        <view class="modal-header">
          <text class="modal-title">编辑课程</text>
          <text class="modal-close" @click="showEditModal = false">×</text>
        </view>
        <view class="modal-body">
          <view class="form-item">
            <text class="form-label">课程名称</text>
            <input class="form-input" v-model="formData.cName" placeholder="请输入课程名称" />
          </view>
          <view class="form-item">
            <text class="form-label">课程类型</text>
            <input class="form-input" v-model="formData.type" placeholder="如:专业课 / 选修课" />
          </view>
          <view class="form-item">
            <text class="form-label">课程标签</text>
            <input class="form-input" v-model="formData.tag" placeholder="如:机器学习 / 入门" />
          </view>
          <view class="form-item">
            <text class="form-label">课程难度</text>
            <picker mode="selector" :range="difficultyLabels" :value="formData.difficulty - 1" @change="difficultyChange">
              <view class="picker-box">{{ difficultyLabels[formData.difficulty - 1] || '请选择' }}</view>
            </picker>
          </view>
          <view class="form-item">
            <text class="form-label">最大人数</text>
            <input class="form-input" type="number" v-model.number="formData.maxPerson" placeholder="如:50" />
          </view>
          <view class="form-item">
            <text class="form-label">开课时间</text>
            <picker mode="date" :value="formData.startTime" @change="startTimeChange">
              <view class="picker-box">{{ formData.startTime || '请选择日期' }}</view>
            </picker>
          </view>
          <view class="form-item">
            <text class="form-label">课程描述</text>
            <textarea class="form-textarea" v-model="formData.description" placeholder="简单介绍课程内容" />
          </view>
        </view>
        <view class="modal-footer">
          <view class="btn cancel" @click="showEditModal = false">取消</view>
          <view class="btn confirm" @click="handleUpdate">保存</view>
        </view>
      </view>
    </view>

    <!-- 删除确认弹窗 -->
    <view class="modal-mask" v-if="showDeleteModal" @click="showDeleteModal = false">
      <view class="modal-content" @click.stop>
        <view class="modal-header">
          <text class="modal-title">删除课程</text>
          <text class="modal-close" @click="showDeleteModal = false">×</text>
        </view>
        <view class="modal-body">
          <text class="confirm-text">确认删除 "{{ deleteTarget.cName }}" 吗?</text>
          <text class="confirm-sub">此操作不可恢复</text>
        </view>
        <view class="modal-footer">
          <view class="btn cancel" @click="showDeleteModal = false">取消</view>
          <view class="btn confirm delete-confirm" @click="handleDelete">确定删除</view>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
import { listMyCourses, updateCourse, delCourse } from '@/api/mine/course'

export default {
  data() {
    return {
      courses: [],
      difficultyLabels: ['简单', '中等', '困难'],
      showEditModal: false,
      showDeleteModal: false,
      formData: {
        cId: null,
        cName: '',
        type: '',
        tag: '',
        difficulty: 2,
        maxPerson: null,
        startTime: '',
        description: ''
      },
      editIndex: -1,
      deleteTarget: {},
      deleteIndex: -1
    }
  },
  onLoad() {
    this.getCourseList()
  },
  onShow() {
    // 从任务管理发布完课程返回后自动刷新
    this.getCourseList()
  },
  onPullDownRefresh() {
    this.getCourseList()
    uni.stopPullDownRefresh()
  },
  methods: {
    getCourseList() {
      listMyCourses().then(res => {
        this.courses = res.data || []
      }).catch(() => {
        uni.showToast({ title: '获取课程列表失败', icon: 'none' })
      })
    },
    difficultyText(d) {
      if (!d) return '—'
      return this.difficultyLabels[d - 1] || '—'
    },
    difficultyChange(e) {
      this.formData.difficulty = e.detail.value + 1
    },
    startTimeChange(e) {
      this.formData.startTime = e.detail.value
    },
    openEditModal(course, index) {
      this.editIndex = index
      this.formData = {
        cId: course.cId,
        cName: course.cName || '',
        type: course.type || '',
        tag: course.tag || '',
        difficulty: course.difficulty || 2,
        maxPerson: course.maxPerson,
        startTime: (course.startTime || '').toString().substring(0, 10),
        description: course.description || ''
      }
      this.showEditModal = true
    },
    openDeleteModal(course, index) {
      this.deleteTarget = course
      this.deleteIndex = index
      this.showDeleteModal = true
    },
    handleUpdate() {
      if (!this.formData.cName) {
        uni.showToast({ title: '请输入课程名称', icon: 'none' })
        return
      }
      updateCourse({ ...this.formData }).then(() => {
        uni.showToast({ title: '保存成功', icon: 'success' })
        this.showEditModal = false
        this.getCourseList()
      }).catch(() => {
        uni.showToast({ title: '保存失败', icon: 'none' })
      })
    },
    handleDelete() {
      delCourse(this.deleteTarget.cId).then(() => {
        uni.showToast({ title: '已删除', icon: 'success' })
        this.showDeleteModal = false
        this.deleteTarget = {}
        this.deleteIndex = -1
        this.getCourseList()
      }).catch(() => {
        uni.showToast({ title: '删除失败', icon: 'none' })
      })
    }
  }
}
</script>

<style lang="scss" scoped>
page {
  background-color: #f5f6fa;
}

.course-page {
  padding: 0 24rpx 32rpx;
}

.page-header {
  padding-top: 40rpx;
  padding-bottom: 24rpx;
}

.page-title {
  font-size: 44rpx;
  font-weight: bold;
  color: #1a1a1a;
}

.course-list {
  display: flex;
  flex-direction: column;
  gap: 20rpx;
}

.course-card {
  background-color: #fff;
  border-radius: 20rpx;
  padding: 24rpx;
}

.card-header {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20rpx;
  padding-bottom: 20rpx;
  border-bottom: 1rpx solid #f0f0f0;
}

.course-name-wrap {
  display: flex;
  flex-direction: row;
  align-items: center;
  gap: 12rpx;
  flex: 1;
  min-width: 0;
}

.course-name {
  font-size: 32rpx;
  font-weight: bold;
  color: #1a1a1a;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.course-tag {
  padding: 4rpx 14rpx;
  border-radius: 8rpx;
  background: #eef2ff;
  color: #5b5fc7;
  font-size: 22rpx;
  flex-shrink: 0;
}

.card-actions {
  display: flex;
  flex-direction: row;
  gap: 12rpx;
  flex-shrink: 0;
}

.action-btn {
  width: 48rpx;
  height: 48rpx;
  border-radius: 12rpx;
  display: flex;
  align-items: center;
  justify-content: center;

  &.edit { background-color: #eef2ff;
    .iconfont { color: #5b5fc7; }
  }
  &.delete { background-color: #fff0f0;
    .iconfont { color: #ff4d4f; }
  }
}

.iconfont { font-size: 24rpx; }

.card-body { display: flex; flex-direction: column; gap: 12rpx; }
.info-row {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: flex-start;
  gap: 16rpx;
}
.info-label { font-size: 26rpx; color: #999; flex-shrink: 0; }
.info-value {
  font-size: 26rpx;
  color: #333;
  text-align: right;
  word-break: break-all;
}
.info-value.multi-line {
  text-align: left;
  flex: 1;
  line-height: 1.5;
}

.empty {
  margin-top: 120rpx;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 16rpx;
}
.empty-iconfont { font-size: 80rpx; }
.empty-text { font-size: 26rpx; color: #999; }

.modal-mask {
  position: fixed;
  top: 0; left: 0; right: 0; bottom: 0;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 999;
}

.modal-content {
  width: 600rpx;
  max-height: 85vh;
  background-color: #fff;
  border-radius: 24rpx;
  padding: 32rpx;
  overflow-y: auto;
}

.modal-header {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24rpx;
}

.modal-title { font-size: 36rpx; font-weight: bold; color: #1a1a1a; }
.modal-close { font-size: 40rpx; color: #999; padding: 0 8rpx; }
.modal-body { margin-bottom: 24rpx; }

.form-item { margin-bottom: 20rpx; }
.form-item:last-child { margin-bottom: 0; }
.form-label {
  display: block;
  font-size: 28rpx;
  color: #666;
  margin-bottom: 8rpx;
}
.form-input, .picker-box {
  width: 100%;
  height: 72rpx;
  border: 1rpx solid #e0e0e0;
  border-radius: 12rpx;
  padding: 0 20rpx;
  font-size: 28rpx;
  box-sizing: border-box;
  line-height: 72rpx;
}
.form-textarea {
  width: 100%;
  height: 160rpx;
  border: 1rpx solid #e0e0e0;
  border-radius: 12rpx;
  padding: 20rpx;
  font-size: 28rpx;
  box-sizing: border-box;
}

.confirm-text {
  display: block;
  font-size: 32rpx;
  color: #1a1a1a;
  text-align: center;
  margin-bottom: 12rpx;
}
.confirm-sub {
  display: block;
  font-size: 26rpx;
  color: #999;
  text-align: center;
}

.modal-footer { display: flex; flex-direction: row; gap: 20rpx; }
.btn {
  flex: 1;
  height: 80rpx;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 12rpx;
  font-size: 28rpx;

  &.cancel { background-color: #f5f5f5; color: #666; }
  &.confirm { background-color: #5b5fc7; color: #fff;
    &.delete-confirm { background-color: #ff4d4f; }
  }
}
</style>
