<template>
  <view class="task-wrap">
    <!-- uView 标签页 -->
    <u-tabs
      :list="tabList"
      :current="currentTab"
      @change="tabChange"
      active-color="#5151E5"
      inactive-color="#666"
    ></u-tabs>

    <!-- 发布课程 -->
    <view class="form-box" v-if="currentTab === 0">
      <u-form :model="courseForm" ref="courseFormRef">
        <u-form-item label="课程名称" label-width="120rpx">
          <u-input v-model="courseForm.name" placeholder="请输入课程名称"></u-input>
        </u-form-item>

        <u-form-item label="选择班级" label-width="120rpx">
          <u-picker
            :show="classPickerShow"
            :columns="classList"
            @confirm="classConfirm"
            @cancel="classPickerShow = false"
          ></u-picker>
          <view class="picker-view" @click="classPickerShow = true">
            {{ courseForm.className || '请选择班级' }}
          </view>
        </u-form-item>

        <u-form-item label="上课时间" label-width="120rpx">
          <u-datetime-picker
            :show="timePickerShow"
            mode="date"
            @confirm="timeConfirm"
            @cancel="timePickerShow = false"
          ></u-datetime-picker>
          <view class="picker-view" @click="timePickerShow = true">
            {{ courseForm.time || '请选择上课时间' }}
          </view>
        </u-form-item>

        <u-button type="primary" class="submit-btn" @click="publishCourse">发布课程</u-button>
      </u-form>
    </view>

    <!-- 发布作业 -->
    <view class="form-box" v-if="currentTab === 1">
      <u-form :model="homeworkForm" ref="homeworkFormRef">
        <u-form-item label="作业标题" label-width="120rpx">
          <u-input v-model="homeworkForm.title" placeholder="请输入作业标题"></u-input>
        </u-form-item>

        <u-form-item label="作业内容" label-width="120rpx">
          <u-textarea
            v-model="homeworkForm.content"
            placeholder="请输入作业内容/要求"
            :rows="4"
          ></u-textarea>
        </u-form-item>

        <u-form-item label="所属课程" label-width="120rpx">
          <u-picker
            :show="coursePickerShow"
            :columns="courseList"
            @confirm="courseConfirm"
            @cancel="coursePickerShow = false"
          ></u-picker>
          <view class="picker-view" @click="coursePickerShow = true">
            {{ homeworkForm.courseName || '请选择课程' }}
          </view>
        </u-form-item>

        <u-form-item label="截止时间" label-width="120rpx">
          <u-datetime-picker
            :show="deadlinePickerShow"
            mode="date"
            @confirm="deadlineConfirm"
            @cancel="deadlinePickerShow = false"
          ></u-datetime-picker>
          <view class="picker-view" @click="deadlinePickerShow = true">
            {{ homeworkForm.deadline || '请选择截止时间' }}
          </view>
        </u-form-item>

        <u-button type="primary" class="submit-btn" @click="publishHomework">发布作业</u-button>
      </u-form>
    </view>

    <!-- 批改问答 -->
    <view class="empty-box" v-if="currentTab === 2">
      <u-empty text="批改问答功能开发中"></u-empty>
    </view>
  </view>
</template>

<script>
export default {
  data() {
    return {
      // 标签页配置
      tabList: [
        { name: '发布课程' },
        { name: '发布作业' },
        { name: '批改问答' }
      ],
      currentTab: 0,

      // 班级选择器
      classPickerShow: false,
      classList: [['初二(1)班', '初二(2)班', '初二(3)班']],

      // 课程选择器
      coursePickerShow: false,
      courseList: [['数学', '语文', '英语', '物理']],

      // 上课时间
      timePickerShow: false,
      // 作业截止时间
      deadlinePickerShow: false,

      // 课程表单
      courseForm: {
        name: '',
        className: '',
        time: ''
      },

      // 作业表单
      homeworkForm: {
        title: '',
        content: '',
        courseName: '',
        deadline: ''
      }
    }
  },
  methods: {
    // 切换标签
    tabChange(index) {
      this.currentTab = index
    },

    // 班级选择确认
    classConfirm(e) {
      this.courseForm.className = e.value[0]
      this.classPickerShow = false
    },

    // 上课时间确认
    timeConfirm(e) {
      this.courseForm.time = e.value
      this.timePickerShow = false
    },

    // 所属课程确认
    courseConfirm(e) {
      this.homeworkForm.courseName = e.value[0]
      this.coursePickerShow = false
    },

    // 作业截止时间确认
    deadlineConfirm(e) {
      this.homeworkForm.deadline = e.value
      this.deadlinePickerShow = false
    },

    // 发布课程
    publishCourse() {
      if (!this.courseForm.name) {
        uni.$u.toast('请输入课程名称')
        return
      }
      if (!this.courseForm.className) {
        uni.$u.toast('请选择班级')
        return
      }
      if (!this.courseForm.time) {
        uni.$u.toast('请选择上课时间')
        return
      }
      uni.$u.toast('课程发布成功')
      // 此处可对接后端接口
    },

    // 发布作业
    publishHomework() {
      if (!this.homeworkForm.title) {
        uni.$u.toast('请输入作业标题')
        return
      }
      if (!this.homeworkForm.content) {
        uni.$u.toast('请输入作业内容')
        return
      }
      if (!this.homeworkForm.courseName) {
        uni.$u.toast('请选择所属课程')
        return
      }
      if (!this.homeworkForm.deadline) {
        uni.$u.toast('请选择截止时间')
        return
      }
      uni.$u.toast('作业发布成功')
      // 此处可对接后端接口
    }
  }
}
</script>

<style scoped>
.task-wrap {
  padding: 20rpx;
  background-color: #f5f7fa;
  min-height: 100vh;
}

.form-box {
  margin-top: 30rpx;
  background: #fff;
  border-radius: 16rpx;
  padding: 20rpx;
}

.picker-view {
  width: 100%;
  height: 70rpx;
  line-height: 70rpx;
  padding: 0 15rpx;
  border: 1rpx solid #e5e6eb;
  border-radius: 8rpx;
  box-sizing: border-box;
}

.submit-btn {
  margin-top: 40rpx;
  border-radius: 8rpx;
}

.empty-box {
  margin-top: 100rpx;
}
</style>