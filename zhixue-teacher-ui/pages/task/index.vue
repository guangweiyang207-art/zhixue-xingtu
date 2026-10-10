<template>
  <view class="container">
    <!-- 标签栏 -->
    <view class="tabs">
      <view class="tab-item" :class="currentTab === 0 ? 'active' : ''" @click="currentTab = 0">
        发布课程
      </view>
      <view class="tab-item" :class="currentTab === 1 ? 'active' : ''" @click="currentTab = 1">
        发布作业
      </view>
      <view class="tab-item" :class="currentTab === 2 ? 'active' : ''" @click="currentTab = 2">
        批改问答
      </view>
    </view>

    <!-- 发布课程 -->
    <view class="form-page" v-show="currentTab === 0">
      <view class="form-item">
        <text class="label">课程名称</text>
        <input v-model="courseForm.name" placeholder="请输入课程名称" class="input" />
      </view>
      <view class="form-item">
        <text class="label">课程类型</text>
        <input v-model="courseForm.type" placeholder="如:理科/文科/编程" class="input" />
      </view>
      <view class="form-item">
        <text class="label">课程标签</text>
        <input v-model="courseForm.tag" placeholder="如:高考冲刺/零基础" class="input" />
      </view>
      <view class="form-item">
        <text class="label">课程描述</text>
        <textarea v-model="courseForm.description" placeholder="请输入课程描述" class="textarea" />
      </view>
      <view class="form-item">
        <text class="label">难度</text>
        <picker mode="selector" :range="difficultyList" :value="courseForm.difficultyIndex" @change="difficultyChange">
          <view class="picker-box">{{ difficultyList[courseForm.difficultyIndex] }}</view>
        </picker>
      </view>
      <view class="form-item">
        <text class="label">上课时间</text>
        <picker mode="date" :value="courseForm.time" @change="timeChange">
          <view class="picker-box">{{ courseForm.time || '选择时间' }}</view>
        </picker>
      </view>
      <view class="form-item">
        <text class="label">上课时间(周几/时段)</text>
        <view class="time-slot">
          <picker mode="selector" :range="weekList" :value="courseForm.weekIndex" @change="weekChange">
            <view class="picker-box small">{{ weekList[courseForm.weekIndex] || '请选择' }}</view>
          </picker>
          <text class="time-sep"> </text>
          <picker mode="time" :value="courseForm.startTime" @change="startTimeChange">
            <view class="picker-box small">{{ courseForm.startTime || '开始' }}</view>
          </picker>
          <text class="time-sep"> ~ </text>
          <picker mode="time" :value="courseForm.endTime" @change="endTimeChange">
            <view class="picker-box small">{{ courseForm.endTime || '结束' }}</view>
          </picker>
        </view>
      </view>
      <button class="submit" @click="submitCourse" :loading="loading">发布课程</button>
    </view>

    <!-- 发布作业 -->
    <view class="form-page" v-show="currentTab === 1">
      <view class="form-item">
        <text class="label">作业标题</text>
        <input v-model="homeworkForm.title" placeholder="请输入作业标题" class="input" />
      </view>
      <view class="form-item">
        <text class="label">作业内容</text>
        <textarea v-model="homeworkForm.content" placeholder="请输入作业内容" class="textarea" />
      </view>
      <view class="form-item">
        <text class="label">所属课程</text>
        <picker mode="selector" :range="courseOptions" range-key="name" :value="homeworkForm.courseIndex" @change="courseChange">
          <view class="picker-box">{{ courseOptions[homeworkForm.courseIndex] && courseOptions[homeworkForm.courseIndex].name || '请选择课程' }}</view>
        </picker>
      </view>
      <view class="form-item">
        <text class="label">班级</text>
        <picker mode="selector" :range="classList" :value="homeworkForm.classIndex" @change="homeClassChange">
          <view class="picker-box">{{ classList[homeworkForm.classIndex] || '请选择班级' }}</view>
        </picker>
      </view>
      <view class="form-item">
        <text class="label">作业类型</text>
        <picker mode="selector" :range="homeworkTypeList" :value="homeworkForm.typeIndex" @change="homeworkTypeChange">
          <view class="picker-box">{{ homeworkTypeList[homeworkForm.typeIndex] }}</view>
        </picker>
      </view>
      <view class="form-item">
        <text class="label">总分</text>
        <input v-model.number="homeworkForm.totalScore" type="number" placeholder="默认 100" class="input" />
      </view>
      <view class="form-item">
        <text class="label">截止时间</text>
        <picker mode="date" :value="homeworkForm.deadline" @change="deadlineChange">
          <view class="picker-box">{{ homeworkForm.deadline || '选择时间' }}</view>
        </picker>
      </view>
      <button class="submit" @click="submitHomework" :loading="loading">发布作业</button>
    </view>

    <!-- 批改问答（修复版，v-show + 固定结构） -->
    <view class="answer-page" v-show="currentTab === 2">
      <view class="list-title">待批改问答</view>
      <view class="answer-item" v-for="(item, index) in answerList" :key="index" v-show="!item.isReply">
        <view class="student-info">
          <text class="name">{{ item.studentName }}</text>
          <text class="time">{{ item.createTime }}</text>
        </view>
        <view class="question">提问：{{ item.question }}</view>
        <view class="reply-box">
          <textarea v-model="item.replyContent" placeholder="请输入回复内容" class="reply-textarea" />
          <button class="reply-btn" @click="replyAnswer(item.id, index)">回复批改</button>
        </view>
      </view>

      <view class="list-title" style="margin-top: 40rpx;">已批改问答</view>
      <view class="answer-item done" v-for="(item, index) in answerList" :key="index" v-show="item.isReply">
        <view class="student-info">
          <text class="name">{{ item.studentName }}</text>
          <text class="time">{{ item.createTime }}</text>
        </view>
        <view class="question">提问：{{ item.question }}</view>
        <view class="reply-content">老师回复：{{ item.replyContent }}</view>
      </view>

      <view class="empty" v-show="answerList.length === 0">暂无学生提问</view>
    </view>
  </view>
</template>

<script>
import { publishCourse, listCourse } from '@/api/course'
import { publishHomework } from '@/api/homework'
import { listClassNames } from '@/api/student'
import { getRealName } from '@/utils/auth'
import request from '@/utils/request'

export default {
  data() {
    return {
      currentTab: 0,
      loading: false,
      // 班级下拉(从后端 /student/class-names 拉)
      classList: [],
      // 课程下拉(从后端 /course/list 拉,简单映射成 {id,name})
      courseOptions: [],
      // 作业类型(1-客观题 2-主观题 3-混合)
      homeworkTypeList: ["客观题", "主观题", "混合"],
      // 课程难度(发布课程用)
      difficultyList: ["简单", "中等", "困难"],
      // 周几下拉
      weekList: ["周一", "周二", "周三", "周四", "周五", "周六", "周日"],
      courseForm: {
        name: "", type: "", tag: "", description: "", difficultyIndex: 1, time: "",
        weekIndex: 0, startTime: "", endTime: ""
      },
      homeworkForm: {
        title: "",
        content: "",
        courseIndex: 0,
        classIndex: 0,
        typeIndex: 0,
        totalScore: 100,
        deadline: ""
      },
      // 学生问答(待回答 + 已回答,从后端 /teacher/answer/list|replied 拉)
      answerList: []
    };
  },
  onLoad() {
    // 主页快捷发布通过 uni.$emit 切换 tab;tabBar 页面 onShow 会重复触发,这里只注册一次
    uni.$on("changeTaskTab", (type) => {
      if (type === "course") this.currentTab = 0;
      if (type === "homework") this.currentTab = 1;
    });
    this.loadClassList();
    this.loadCourseList();
  },
  onShow() {
    this.getAnswerList();
  },
  onUnload() {
    uni.$off("changeTaskTab");
  },
  methods: {
    classChange(e) { this.courseForm.classIndex = e.detail.value; },
    difficultyChange(e) { this.courseForm.difficultyIndex = e.detail.value; },
    timeChange(e) { this.courseForm.time = e.detail.value; },
    weekChange(e) { this.courseForm.weekIndex = e.detail.value; },
    startTimeChange(e) { this.courseForm.startTime = e.detail.value; },
    endTimeChange(e) { this.courseForm.endTime = e.detail.value; },
    courseChange(e) { this.homeworkForm.courseIndex = e.detail.value; },
    homeClassChange(e) { this.homeworkForm.classIndex = e.detail.value; },
    homeworkTypeChange(e) { this.homeworkForm.typeIndex = e.detail.value; },
    deadlineChange(e) { this.homeworkForm.deadline = e.detail.value; },

    async loadClassList() {
      try {
        const res = await listClassNames();
        if (res.code === 200 && Array.isArray(res.data)) {
          this.classList = res.data;
        }
      } catch (e) { /* 静默,前端允许为空 */ }
    },

    async loadCourseList() {
      try {
        const res = await listCourse({});
        if (res.code === 200 && Array.isArray(res.data)) {
          this.courseOptions = res.data.map(c => ({ id: c.cId, name: c.cName }));
        }
      } catch (e) { /* 静默 */ }
    },

    async submitCourse() {
      const f = this.courseForm;
      if (!f.name)        return uni.showToast({ title: "请输入课程名称", icon: "none" });
      if (!f.type)        return uni.showToast({ title: "请输入课程类型", icon: "none" });
      if (!f.tag)         return uni.showToast({ title: "请输入课程标签", icon: "none" });
      if (!f.description) return uni.showToast({ title: "请输入课程描述", icon: "none" });
      // 周几 + 几点到几点 校验
      if (!f.startTime || !f.endTime) {
        return uni.showToast({ title: "请填写上课时段(周几 几点到几点)", icon: "none" });
      }
      // 拼装 remark,例如: "周三 09:00 ~ 10:30 · 张明老师"
      const week = this.weekList[f.weekIndex] || "";
      const realName = getRealName() || "";
      // 若开始/结束时间相差整数小时,使用 HH:mm-HH:mm,否则保留 picker 原值
      const timeSlot = `${f.startTime}-${f.endTime}`;
      const teacherTail = realName ? ` · ${realName}老师` : "";
      const remark = `${week} ${timeSlot}${teacherTail}`;
      this.loading = true;
      try {
        // 后端 /course/publish 自动注入 teacher_id + max_person/current_person/status 等默认值
        const res = await publishCourse({
          cName:       f.name,
          type:        f.type,
          tag:         f.tag,
          description: f.description,
          difficulty:  f.difficultyIndex + 1,   // 0->1简单 / 1->2中等 / 2->3困难
          startTime:   f.time || null,
          remark:      remark
        });
        if (res.code === 200) {
          uni.showToast({ title: "发布成功" });
          this.courseForm = {
            name: "", type: "", tag: "", description: "",
            difficultyIndex: 1, time: "",
            weekIndex: 0, startTime: "", endTime: ""
          };
        } else {
          uni.showToast({ title: res.msg || "发布失败", icon: "none" });
        }
      } catch (e) {
        uni.showToast({ title: "网络异常", icon: "none" });
      }
      this.loading = false;
    },

    async submitHomework() {
      const f = this.homeworkForm;
      if (!f.title)                       return uni.showToast({ title: "请输入作业标题", icon: "none" });
      if (!f.content)                     return uni.showToast({ title: "请输入作业内容", icon: "none" });
      if (!this.courseOptions[f.courseIndex]) return uni.showToast({ title: "请选择所属课程", icon: "none" });
      if (!this.classList[f.classIndex])  return uni.showToast({ title: "请选择班级", icon: "none" });
      if (!f.deadline)                    return uni.showToast({ title: "请选择截止时间", icon: "none" });
      this.loading = true;
      try {
        // 后端 /homework/publish 自动注入 teacher_id + status(1) + create_time/update_time,
        // 并按 className 把作业派发到 my_student_homework
        const res = await publishHomework({
          title:      f.title,
          content:    f.content,
          courseId:   this.courseOptions[f.courseIndex].id,
          className:  this.classList[f.classIndex],
          type:       f.typeIndex + 1,   // 0->1客观题 / 1->2主观题 / 2->3混合
          totalScore: f.totalScore || 100,
          deadline:   f.deadline
        });
        if (res.code === 200) {
          uni.showToast({ title: "发布成功" });
          this.homeworkForm = {
            title: "", content: "",
            courseIndex: 0, classIndex: 0,
            typeIndex: 0, totalScore: 100, deadline: ""
          };
        } else {
          uni.showToast({ title: res.msg || "发布失败", icon: "none" });
        }
      } catch (e) {
        uni.showToast({ title: "网络异常", icon: "none" });
      }
      this.loading = false;
    },

    async getAnswerList() {
      try {
        // 待回答 + 已回答两个接口,统一映射成 {id, studentName, question, createTime, replyContent, isReply}
        const [pending, replied] = await Promise.all([
          request({ url: '/teacher/answer/list', method: 'GET' }),
          request({ url: '/teacher/answer/replied', method: 'GET' })
        ]);
        const mapItem = (q, isReply) => ({
          id: q.id,
          studentName: q.studentName,
          question: q.question,
          createTime: q.createTime,
          replyContent: isReply ? (q.answer || '') : '',
          isReply
        });
        const list = [
          ...((pending.data || []).map(q => mapItem(q, false))),
          ...((replied.data || []).map(q => mapItem(q, true)))
        ];
        this.answerList = list;
      } catch (err) {
        console.error('获取学生问答失败:', err);
      }
    },

    async replyAnswer(id, index) {
      const item = this.answerList[index];
      if (!item.replyContent) return uni.showToast({ title: "请输入回复内容", icon: "none" });
      try {
        const res = await request({
          url: "/teacher/answer/reply",
          method: "POST",
          data: { chatId: id, answer: item.replyContent }
        });
        if (res.code === 200) {
          uni.showToast({ title: "回复成功", icon: "success" });
          this.$set(this.answerList[index], "isReply", true);
        } else {
          uni.showToast({ title: res.msg || "回复失败", icon: "none" });
        }
      } catch (e) {
        uni.showToast({ title: "回复失败", icon: "none" });
      }
    }
  }
};
</script>

<style lang="scss" scoped>
@import '@/static/scss/global.scss';

/* ============================================================
 * 页面容器
 * ============================================================ */
.container {
  min-height: 100vh;
  background-color: $uni-bg-color-page;
  padding: 24rpx 24rpx 40rpx;
  box-sizing: border-box;
}

/* ============================================================
 * 标签栏 (复用 .zx-tabs 风格)
 * ============================================================ */
.tabs {
  display: flex;
  background: $uni-bg-color;
  border-radius: $uni-radius-md;
  padding: 8rpx;
  margin-bottom: 24rpx;
  box-shadow: $uni-shadow-sm;
  position: relative;
  z-index: 99;
}
.tab-item {
  flex: 1;
  text-align: center;
  padding: 18rpx 0;
  font-size: 26rpx;
  color: $uni-text-color-secondary;
  border-radius: $uni-radius-sm;
  font-weight: $uni-font-weight-medium;
  min-height: 72rpx;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all $uni-duration-fast $uni-ease;
}
.tab-item.active {
  background: $uni-color-primary;
  color: $uni-text-color-inverse;
  box-shadow: 0 2rpx 6rpx rgba(30, 58, 95, 0.15);
}

/* ============================================================
 * 表单卡片
 * ============================================================ */
.form-page {
  background: $uni-bg-color;
  border-radius: $uni-radius-lg;
  padding: 32rpx 28rpx;
  box-shadow: $uni-shadow-sm;
}
.form-item { margin-bottom: 28rpx; }
.form-item:last-of-type { margin-bottom: 0; }

.label {
  font-size: 26rpx;
  margin-bottom: 12rpx;
  display: block;
  color: $uni-text-color-secondary;
  font-weight: $uni-font-weight-medium;
  letter-spacing: 0.3rpx;
}
.label::before {
  content: '';
  display: inline-block;
  width: 4rpx;
  height: 18rpx;
  background: $uni-color-primary;
  border-radius: 2rpx;
  margin-right: 10rpx;
  vertical-align: middle;
  transform: translateY(-2rpx);
}

.input,
.textarea,
.picker-box {
  width: 100%;
  border: 1rpx solid $uni-border-color-light;
  border-radius: $uni-radius-sm;
  padding: 0 24rpx;
  font-size: 28rpx;
  color: $uni-text-color;
  background: $uni-bg-color-alt;
  box-sizing: border-box;
  transition: border-color $uni-duration-fast $uni-ease, background $uni-duration-fast $uni-ease;
}
.input:focus,
.textarea:focus,
.picker-box:active {
  border-color: $uni-color-primary;
  background: $uni-bg-color;
}
.input,
.picker-box {
  height: 88rpx;
  line-height: 88rpx;
}
.textarea {
  height: 200rpx;
  line-height: 1.5;
  padding: 20rpx 24rpx;
}
.picker-box {
  position: relative;
}
.picker-box::after {
  content: '';
  position: absolute;
  top: 50%;
  right: 24rpx;
  width: 12rpx;
  height: 12rpx;
  border-right: 2rpx solid $uni-text-color-tertiary;
  border-bottom: 2rpx solid $uni-text-color-tertiary;
  transform: translateY(-65%) rotate(45deg);
}
.picker-box.small {
  height: 72rpx;
  line-height: 72rpx;
  font-size: 24rpx;
  padding: 0 36rpx 0 16rpx;
}

/* 时段选择 */
.time-slot {
  display: flex;
  align-items: center;
  width: 100%;
}
.time-slot .picker-box.small { flex: 1; }
.time-sep {
  color: $uni-text-color-tertiary;
  font-size: 24rpx;
  padding: 0 10rpx;
  flex-shrink: 0;
}

/* 提交按钮 (复用 .zx-btn) */
.submit {
  width: 100%;
  height: 96rpx;
  background: $uni-color-primary;
  color: $uni-text-color-inverse;
  border-radius: $uni-radius-md;
  font-size: 30rpx;
  font-weight: $uni-font-weight-medium;
  border: none;
  margin-top: 24rpx;
  box-shadow: 0 4rpx 12rpx rgba(30, 58, 95, 0.18);
  letter-spacing: 1rpx;
}
.submit::after { border: none; }
.submit:active { background: $uni-color-primary-press; }
.submit[disabled],
.submit.is-disabled { opacity: $uni-opacity-disabled; }

/* ============================================================
 * 批改问答页
 * ============================================================ */
.answer-page { padding: 4rpx 0 40rpx; }
.list-title {
  display: flex;
  align-items: center;
  font-size: 30rpx;
  font-weight: $uni-font-weight-semibold;
  margin-bottom: 20rpx;
  color: $uni-text-color;
  letter-spacing: 0.5rpx;
  padding-left: 16rpx;
  position: relative;
}
.list-title::before {
  content: '';
  position: absolute;
  left: 0;
  top: 50%;
  transform: translateY(-50%);
  width: 6rpx;
  height: 24rpx;
  background: $uni-color-primary;
  border-radius: 3rpx;
}
.list-title + .list-title { margin-top: 40rpx; }

.answer-item {
  background: $uni-bg-color;
  border-radius: $uni-radius-lg;
  padding: 28rpx;
  margin-bottom: 20rpx;
  box-shadow: $uni-shadow-sm;
  border-left: 6rpx solid $uni-color-primary;
  position: relative;
  overflow: hidden;
}
.answer-item.done {
  border-left-color: $uni-color-success;
  opacity: 0.92;
}

.student-info {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16rpx;
  padding-bottom: 16rpx;
  border-bottom: 1rpx solid $uni-divider-color;
}
.name {
  font-size: 28rpx;
  font-weight: $uni-font-weight-semibold;
  color: $uni-text-color;
  letter-spacing: 0.3rpx;
}
.time {
  font-size: 22rpx;
  color: $uni-text-color-tertiary;
}

.question {
  font-size: 26rpx;
  color: $uni-text-color-secondary;
  line-height: 1.6;
  margin-bottom: 20rpx;
  word-break: break-all;
}

.reply-box {
  border-top: 1rpx solid $uni-divider-color;
  padding-top: 20rpx;
}
.reply-textarea {
  width: 100%;
  height: 140rpx;
  border: 1rpx solid $uni-border-color-light;
  border-radius: $uni-radius-sm;
  padding: 18rpx 20rpx;
  font-size: 26rpx;
  color: $uni-text-color;
  background: $uni-bg-color-alt;
  box-sizing: border-box;
  margin-bottom: 16rpx;
  line-height: 1.5;
}
.reply-textarea:focus {
  border-color: $uni-color-primary;
  background: $uni-bg-color;
}
.reply-btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  height: 72rpx;
  padding: 0 32rpx;
  background: $uni-color-primary;
  color: $uni-text-color-inverse;
  border-radius: $uni-radius-md;
  font-size: 26rpx;
  font-weight: $uni-font-weight-medium;
  border: none;
  box-shadow: 0 2rpx 6rpx rgba(30, 58, 95, 0.15);
}
.reply-btn::after { border: none; }
.reply-btn:active { background: $uni-color-primary-press; }

.reply-content {
  font-size: 26rpx;
  color: $uni-color-success;
  line-height: 1.6;
  padding: 16rpx 20rpx;
  background: $uni-color-success-soft;
  border-radius: $uni-radius-sm;
  word-break: break-all;
}

.empty {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 80rpx 32rpx;
  color: $uni-text-color-tertiary;
  font-size: 26rpx;
}
.empty::before {
  content: '·';
  font-size: 60rpx;
  color: $uni-border-color-strong;
  line-height: 1;
  margin-bottom: 16rpx;
  letter-spacing: 6rpx;
}
</style>