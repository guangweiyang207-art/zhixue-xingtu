<template>
  <view class="page">
    <!-- 顶部 -->
    <view class="header">
      <view class="back-btn" @click="goBack">←</view>
      <view class="tab-wrap">
        <view class="tab-item" :class="{active: activeTab === 'homework'}" @click="activeTab = 'homework'">
          <text>作业</text>
          <view class="tab-line" v-if="activeTab === 'homework'"></view>
        </view>
        <view class="tab-item" :class="{active: activeTab === 'test'}" @click="activeTab = 'test'">
          <text>问答</text>
          <view class="tab-line" v-if="activeTab === 'test'"></view>
        </view>
      </view>
      <view class="placeholder"></view>
    </view>

    <!-- 作业列表 -->
    <scroll-view scroll-y class="list" v-if="activeTab === 'homework'">
      <!-- 子分类:待完成 / 已提交 / 已批改 -->
      <view class="sub-tabs">
        <view
          v-for="s in subTabList"
          :key="s.key"
          class="sub-tab-item"
          :class="{ active: homeworkSubTab === s.key }"
          @click="homeworkSubTab = s.key"
        >
          <text>{{ s.label }}</text>
          <text class="sub-tab-count">({{ homeworkSubCount(s.key) }})</text>
        </view>
      </view>

      <view v-for="(item, index) in currentHomeworkList" :key="(item && (item.hwId || item.hw_id)) || index" class="item" :data-index="index">
        <view class="top">
          <text class="name">{{ item.title || item.name }}</text>
          <text class="status" :class="[homeworkStatusClass(item)]">{{ homeworkStatusText(item) }}</text>
        </view>
        <view class="info">{{ item.subject || '综合' }} · 截止:{{ formatDate(item.deadline) }}</view>
        <view class="action-area">
          <!-- 待完成:进度 0% + 去完成 -->
          <view v-if="isWait(item)" class="progress-wrap">
            <view class="progress-bg">
              <view class="progress-bar" :style="{ width: '0%' }"></view>
            </view>
            <view class="btn-primary" :data-index="index" @click="doHomework">去完成</view>
          </view>
          <!-- 已提交未批改:100% 进度 + 已提交 -->
          <view v-else-if="isSubmitted(item)" class="progress-wrap">
            <view class="progress-bg">
              <view class="progress-bar submit" :style="{ width: '100%' }"></view>
            </view>
            <view class="status-text">已提交</view>
          </view>
          <!-- 已批改:分数 + 查看批改 -->
          <view v-else-if="isGraded(item)" class="check-row">
            <text class="score">得分:{{ item.score || 0 }}分</text>
            <view class="btn-secondary" :data-index="index" @click="viewDetail">查看批改</view>
          </view>
          <!-- 兜底 -->
          <view v-else class="btn-primary" :data-index="index" @click="doHomework">去完成</view>
        </view>
      </view>
      <view v-if="currentHomeworkList.length === 0" class="empty">
        {{ homeworkSubTab === 'wait' ? '暂无待完成作业,继续保持~' :
           homeworkSubTab === 'submit' ? '暂无已提交作业' :
           '暂无已批改作业' }}
      </view>
    </scroll-view>

    <!-- 问答模块(原"测试"位置) -->
    <scroll-view scroll-y class="list" v-else>
      <!-- 顶部操作条 -->
      <view class="qa-header">
        <view class="qa-title">向老师请教</view>
        <view class="qa-ask-btn" @click="openAskModal">+ 提问</view>
      </view>

      <!-- 状态统计 -->
      <view class="qa-stats">
        <view class="stat-item">
          <text class="stat-num">{{ qaStats.total }}</text>
          <text class="stat-label">全部</text>
        </view>
        <view class="stat-item">
          <text class="stat-num warn">{{ qaStats.pending }}</text>
          <text class="stat-label">待回复</text>
        </view>
        <view class="stat-item">
          <text class="stat-num ok">{{ qaStats.answered }}</text>
          <text class="stat-label">已回复</text>
        </view>
      </view>

      <!-- 我的问题列表 -->
      <view class="qa-section-title">我的提问</view>
      <view v-for="(item, index) in qaList" :key="item.id || index" class="qa-item" :data-index="index" @click="openDetail">
        <view class="qa-item-top">
          <image
            class="qa-teacher-avatar"
            :src="(item.teacherAvatar && (item.teacherAvatar.indexOf('http') === 0 ? item.teacherAvatar : (baseUrl + item.teacherAvatar))) || defaultTeacherAvatar"
            mode="aspectFill"
          />
          <view class="qa-teacher-info">
            <text class="qa-teacher-name">{{ item.teacherName || '老师' }}</text>
            <text class="qa-teacher-meta">{{ item.title || '' }} · {{ item.department || '' }}</text>
          </view>
          <view class="qa-status" :class="item.status === 1 ? 'ok' : 'warn'">
            {{ statusText(item.status) }}
          </view>
        </view>
        <view class="qa-question">{{ item.question }}</view>
        <view v-if="item.answer" class="qa-answer">
          <text class="qa-answer-label">老师回复:</text>
          <text class="qa-answer-text">{{ item.answer }}</text>
        </view>
        <view class="qa-time">{{ formatDateTime(item.createTime) }}</view>
      </view>
      <view v-if="qaList.length === 0" class="empty">暂无提问,点击右上角"提问"向老师请教吧～</view>
    </scroll-view>

    <!-- 提问弹窗 -->
    <view class="modal-mask" v-if="showAskModal" @tap="onMaskTap">
      <view class="modal-content" @tap.stop>
        <view class="modal-header">
          <text class="modal-title">向老师提问</text>
          <text class="modal-close" @tap.stop="closeAskModal">×</text>
        </view>
        <scroll-view scroll-y class="modal-body" @tap.stop>
          <!-- 选择老师 -->
          <view class="form-label">选择老师</view>
          <view class="teacher-picker" v-if="!pickedTeacher">
            <view v-if="teacherList.length === 0" class="teacher-empty">暂无可用老师</view>
            <view
              v-for="t in teacherList"
              :key="t.teacherId"
              class="teacher-row"
              :class="{picked: pickedTeacher && pickedTeacher.teacherId === t.teacherId}"
              @tap.stop="pickTeacher(t)"
            >
              <image
                class="teacher-avatar"
                :src="(t.avatar && (t.avatar.indexOf('http') === 0 ? t.avatar : (baseUrl + t.avatar))) || defaultTeacherAvatar"
                mode="aspectFill"
                @tap.stop
              />
              <view class="teacher-meta" @tap.stop>
                <text class="teacher-name">{{ t.realName || t.username }}</text>
                <text class="teacher-sub">{{ t.title || '' }} · {{ t.department || '' }}</text>
                <text class="teacher-spec" v-if="t.specialty">专长:{{ t.specialty }}</text>
              </view>
            </view>
          </view>
          <view v-else class="teacher-picked" @tap.stop>
            <view class="teacher-picked-info">
              <image
                class="teacher-avatar"
                :src="(pickedTeacher.avatar && (pickedTeacher.avatar.indexOf('http') === 0 ? pickedTeacher.avatar : (baseUrl + pickedTeacher.avatar))) || defaultTeacherAvatar"
                mode="aspectFill"
                @tap.stop
              />
              <view class="teacher-meta">
                <text class="teacher-name">{{ pickedTeacher.realName || pickedTeacher.username }}</text>
                <text class="teacher-sub">{{ pickedTeacher.title || '' }} · {{ pickedTeacher.department || '' }}</text>
              </view>
            </view>
            <text class="reselect" @tap.stop="pickedTeacher = null">重选</text>
          </view>

          <!-- 问题内容 -->
          <view class="form-label">问题内容</view>
          <textarea
            class="form-textarea"
            v-model="askForm.question"
            placeholder="请详细描述你要请教的问题,便于老师快速解答"
            maxlength="500"
            auto-height
            @tap.stop
          />
          <view class="word-count" @tap.stop>{{ askForm.question.length }}/500</view>
        </scroll-view>
        <view class="modal-footer">
          <view class="btn cancel" @tap.stop="closeAskModal">取消</view>
          <view class="btn confirm" @tap.stop="submitAsk">提交</view>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
  import { getHomeworkListApi, getMyHomeworkListApi } from '../../api/system/homework.js'
  import { getTeacherListApi } from '../../api/system/teacher.js'
  import { listMyQuestionsApi, askQuestionApi } from '../../api/system/questionAnswer.js'
  import config from '@/config'

  export default {
    data() {
    return {
      activeTab: 'homework',
      homeworkList: [],
      // 作业子 tab
      subTabList: [
        { key: 'wait', label: '待完成' },
        { key: 'submit', label: '已提交' },
        { key: 'graded', label: '已批改' }
      ],
      homeworkSubTab: 'wait',
      testList: [],
      // Q&A
      qaList: [],
      qaStats: { total: 0, pending: 0, answered: 0 },
      teacherList: [],
      pickedTeacher: null,
      showAskModal: false,
      askForm: { question: '' },
      baseUrl: config.baseUrl,
      defaultTeacherAvatar: '/static/images/teacher-avatar.svg',
      // 学生身份
      stuId: null,
      userId: null
    }
  },
  onShow() {
    // 每次回到页面都刷新一下作业,保证状态最新
    this.loadHomeworkList()
    if (this.activeTab === 'test') this.loadQaData()
  },
  onLoad() {
    this.loadStuInfo()
    this.loadHomeworkList()
  },
  computed: {
    /**
     * 当前子 tab 的作业列表(根据后端 status 字段分类)
     * status = 0 → 待完成
     * status = 1 → 已提交
     * status = 2 → 已批改
     */
    currentHomeworkList() {
      const map = { wait: 0, submit: 1, graded: 2 }
      const target = map[this.homeworkSubTab]
      const list = Array.isArray(this.homeworkList) ? this.homeworkList : []
      // 过滤掉 null/undefined 避免 v-for 渲染时触发 mp-runtime "Cannot read property 'hw_id' of undefined"
      return list.filter(item => item && (item.status || 0) === target)
    }
  },
  watch: {
    activeTab(v) {
      if (v === 'test') this.loadQaData()
    }
  },
  methods: {
    /**
     * 子 tab 数量统计
     */
    homeworkSubCount(key) {
      const map = { wait: 0, submit: 1, graded: 2 }
      const target = map[key]
      return this.homeworkList.filter(item => (item.status || 0) === target).length
    },
    isWait(item)       { return (item.status || 0) === 0 },
    isSubmitted(item)  { return (item.status || 0) === 1 },
    isGraded(item)     { return (item.status || 0) === 2 },
    homeworkStatusClass(item)  {
      const s = item.status || 0
      return s === 0 ? 'wait' : s === 1 ? 'submit' : 'check'
    },
    homeworkStatusText(item)   {
      const s = item.status || 0
      return s === 0 ? '待完成' : s === 1 ? '已提交' : '已批改'
    },
    loadStuInfo() {
      try {
        const info = uni.getStorageSync('userInfo') || {}
        this.stuId = info.stu_id || info.stuId || null
        this.userId = info.user_id || info.userId || null
      } catch (e) {}
    },
    /**
     * 加载当前学生的所有作业(后端按 userId 过滤并 JOIN 提交状态)
     *   接口:/studenthomework/homework/myList
     */
    loadHomeworkList() {
      getMyHomeworkListApi()
        .then(res => {
          // 后端 /myList 返回 {code, msg, data: [...]}
          const rows = (res && res.data) ? res.data : (res && res.rows) ? res.rows : []
          this.homeworkList = Array.isArray(rows) ? rows : []
        })
        .catch(err => {
          console.error('我的作业加载失败:', err)
          this.homeworkList = []
        })
    },
    loadQaData() {
      this.loadTeachers()
      this.loadMyQuestions()
    },
      loadTeachers() {
        // 复用 /teacher/list,后端返回 my_teacher + JOIN my_sys_user 的视图(若有)
        // 部分实现可能只返 my_teacher,我们做一个兼容:再单条补 sys_user 信息
        getTeacherListApi({pageSize: 100})
          .then(res => {
            const rows = (res && res.rows) ? res.rows : (res && res.data) ? res.data : []
            const list = Array.isArray(rows) ? rows : []
            // 如果 teacher 列表没有 realName,逐个去拉详情(尽量取 teacherNo / department / title)
            this.teacherList = list
          })
          .catch(err => {
            console.error('教师列表加载失败:', err)
            this.teacherList = []
          })
      },
      loadMyQuestions() {
        if (!this.stuId) {
          // 还没拿到 stuId,延迟再试
          this.loadStuInfo()
          if (!this.stuId) {
            this.qaList = []
            this.qaStats = { total: 0, pending: 0, answered: 0 }
            return
          }
        }
        listMyQuestionsApi({ stuId: this.stuId })
          .then(res => {
            const rows = (res && res.rows) ? res.rows : (res && res.data) ? res.data : []
            const list = Array.isArray(rows) ? rows : []
            this.qaList = list
            this.qaStats = {
              total: list.length,
              pending: list.filter(x => x.status === 0).length,
              answered: list.filter(x => x.status === 1).length
            }
          })
          .catch(err => {
            console.error('我的提问加载失败:', err)
            this.qaList = []
          })
      },
      openAskModal() {
        this.askForm.question = ''
        this.pickedTeacher = null
        if (this.teacherList.length === 0) this.loadTeachers()
        this.showAskModal = true
      },
      closeAskModal() {
        this.showAskModal = false
      },
      /**
       * 点击遮罩:仅在事件源是 mask 本身时关闭弹窗
       * (mp-weixin 中 @click.self 不可靠,改用 dataset.target 判断)
       */
      onMaskTap(e) {
        // mp-weixin 中 e.target === e.currentTarget 即点击的是 mask 本身
        // 同时兼容 vue/h5
        try {
          if (e && e.target && e.currentTarget && e.target === e.currentTarget) {
            this.closeAskModal()
          }
        } catch (err) {
          // 兜底:不关闭
        }
      },
      pickTeacher(t) {
        this.pickedTeacher = t
      },
      submitAsk() {
        if (!this.stuId) {
          return uni.showToast({ title: '未获取到学生身份,请重新登录', icon: 'none' })
        }
        if (!this.pickedTeacher) {
          return uni.showToast({ title: '请先选择老师', icon: 'none' })
        }
        if (!this.askForm.question || !this.askForm.question.trim()) {
          return uni.showToast({ title: '请填写问题内容', icon: 'none' })
        }
        const payload = {
          stuId: this.stuId,
          teacherId: this.pickedTeacher.teacherId,
          question: this.askForm.question.trim(),
          createBy: this.userId
        }
        askQuestionApi(payload).then(() => {
          uni.showToast({ title: '提问成功,等待老师回复', icon: 'success' })
          this.closeAskModal()
          this.loadMyQuestions()
        }).catch(err => {
          const msg = (err && (err.msg || err.message)) || '提问失败'
          uni.showToast({ title: msg, icon: 'none' })
        })
      },
      openDetail(e) {
        // 当前版本不做弹窗,占位避免点击报错
        const evt = (e && e.currentTarget) ? e.currentTarget : null
        const idxRaw = evt ? (evt.dataset ? evt.dataset.index : null) : null
        const idx = (idxRaw !== null && idxRaw !== undefined) ? Number(idxRaw) : null
        const item = (idx !== null && !isNaN(idx) && this.qaList[idx]) ? this.qaList[idx] : null
        console.log('[openDetail] item =', item)
      },
      statusText(s) {
        if (s === 1) return '已回复'
        if (s === 2) return '已关闭'
        return '待回复'
      },
      formatDate(dateStr) {
        if (!dateStr) return ''
        // iOS 仅支持 "yyyy/MM/dd HH:mm:ss" 这种斜杠格式,先把 "-" 替换成 "/"
        const safe = String(dateStr).replace(/-/g, '/')
        const d = new Date(safe)
        if (isNaN(d.getTime())) return String(dateStr)
        return `${d.getFullYear()}-${String(d.getMonth()+1).padStart(2,'0')}-${String(d.getDate()).padStart(2,'0')} ${String(d.getHours()).padStart(2,'0')}:${String(d.getMinutes()).padStart(2,'0')}`
      },
      formatDateTime(dateStr) {
        if (!dateStr) return ''
        const safe = String(dateStr).replace(/-/g, '/')
        const d = new Date(safe)
        if (isNaN(d.getTime())) return String(dateStr)
        return `${d.getFullYear()}-${String(d.getMonth()+1).padStart(2,'0')}-${String(d.getDate()).padStart(2,'0')} ${String(d.getHours()).padStart(2,'0')}:${String(d.getMinutes()).padStart(2,'0')}`
      },
      goBack() {
        uni.navigateBack({ delta: 1 })
      },
      doHomework(e) {
        // 兼容旧调用方式:也支持直接传 item
        const evt = (e && e.currentTarget) ? e.currentTarget : null
        const idxRaw = evt ? (evt.dataset ? evt.dataset.index : null) : null
        const idx = (idxRaw !== null && idxRaw !== undefined) ? Number(idxRaw) : null
        const item = (idx !== null && !isNaN(idx) && this.currentHomeworkList[idx])
          ? this.currentHomeworkList[idx]
          : (e && e.hwId ? e : null)
        console.log('[doHomework] item =', item, 'idx =', idx)
        if (!item) {
          console.error('[doHomework] 缺少作业数据', e)
          return uni.showToast({ title: '作业参数错误', icon: 'none' })
        }
        // 兼容多种字段名(hwId / id / hw_id)
        const hwId = item.hwId || item.id || item.hw_id
        if (!hwId) {
          console.error('[doHomework] 缺少作业ID', item)
          return uni.showToast({ title: '作业参数错误', icon: 'none' })
        }
        uni.navigateTo({ url: '/pages/homeworkdetail/homeworkdetail?hwId=' + hwId })
      },
      viewDetail(e) {
        const evt = (e && e.currentTarget) ? e.currentTarget : null
        const idxRaw = evt ? (evt.dataset ? evt.dataset.index : null) : null
        const idx = (idxRaw !== null && idxRaw !== undefined) ? Number(idxRaw) : null
        const item = (idx !== null && !isNaN(idx) && this.currentHomeworkList[idx])
          ? this.currentHomeworkList[idx]
          : (e && e.hwId ? e : null)
        if (!item) {
          console.error('[viewDetail] 缺少作业数据', e)
          return uni.showToast({ title: '作业参数错误', icon: 'none' })
        }
        const hwId = item.hwId || item.id || item.hw_id
        if (!hwId) {
          console.error('[viewDetail] 缺少作业ID', item)
          return uni.showToast({ title: '作业参数错误', icon: 'none' })
        }
        uni.navigateTo({ url: '/pages/homeworkdetail/homeworkdetail?hwId=' + hwId })
      }
    }
  }
</script>

<style scoped>
  page {
    background-color: #f6f7fb;
  }

  .page {
    width: 100%;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
  }

  .header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-top: var(--status-bar-height);
    padding-left: 28rpx;
    padding-right: 28rpx;
    padding-bottom: 20rpx;
    background: #fff;
  }

  .back-btn {
    font-size: 36rpx;
    color: #1f2937;
    width: 60rpx;
  }

  .placeholder {
    width: 60rpx;
  }

  .tab-wrap {
    display: flex;
    gap: 40rpx;
    flex: 1;
    justify-content: center;
  }

  .tab-item {
    position: relative;
    padding-bottom: 20rpx;
    font-size: 30rpx;
    color: #9ca3af;
    font-weight: 500;
  }

  .tab-item.active {
    color: #1f2937;
    font-weight: 700;
  }

  .tab-line {
    position: absolute;
    bottom: 0;
    left: 50%;
    transform: translateX(-50%);
    width: 48rpx;
    height: 6rpx;
    background: #8b5cf6;
    border-radius: 999rpx;
  }

  .list {
    flex: 1;
    padding: 22rpx 28rpx 28rpx;
  }

  /* 作业子 tab: 待完成 / 已提交 / 已批改 */
  .sub-tabs {
    display: flex;
    background: #f4f4f6;
    border-radius: 16rpx;
    padding: 6rpx;
    margin-bottom: 24rpx;
  }
  .sub-tab-item {
    flex: 1;
    text-align: center;
    font-size: 26rpx;
    color: #666;
    padding: 14rpx 0;
    border-radius: 12rpx;
    transition: all 0.2s;
  }
  .sub-tab-item.active {
    background: #ffffff;
    color: #5b5fc7;
    font-weight: 600;
    box-shadow: 0 2rpx 8rpx rgba(91, 95, 199, 0.12);
  }
  .sub-tab-count {
    font-size: 22rpx;
    margin-left: 4rpx;
    opacity: 0.8;
  }

  .item {
    background: #fff;
    border-radius: 24rpx;
    padding: 28rpx 24rpx;
    margin-bottom: 20rpx;
    box-shadow: 0 4rpx 16rpx rgba(68, 78, 95, 0.04);
  }

  .top {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 12rpx;
    gap: 16rpx;
  }

  .name {
    font-size: 30rpx;
    font-weight: 600;
    color: #1f2937;
    line-height: 1.3;
  }

  .status {
    font-size: 22rpx;
    padding: 6rpx 16rpx;
    border-radius: 999rpx;
    flex-shrink: 0;
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

  .info {
    font-size: 24rpx;
    color: #9ca3af;
    margin-bottom: 20rpx;
  }

  .action-area {
    margin-top: 8rpx;
  }

  .progress-wrap {
    display: flex;
    align-items: center;
    gap: 16rpx;
  }

  .progress-bg {
    flex: 1;
    height: 20rpx;
    background: #f3f4f6;
    border-radius: 999rpx;
    overflow: hidden;
  }

  .progress-bar {
    height: 100%;
    background: linear-gradient(90deg, #6366f1, #8b5cf6);
    border-radius: 999rpx;
  }

  .progress-bar.submit {
    background: #22c55e;
  }

  .btn-primary {
    padding: 16rpx 32rpx;
    background: linear-gradient(135deg, #6366f1, #8b5cf6);
    color: #fff;
    border-radius: 16rpx;
    font-size: 26rpx;
    font-weight: 600;
    text-align: center;
    flex-shrink: 0;
  }

  .btn-secondary {
    padding: 14rpx 28rpx;
    background: #eff6ff;
    color: #3b82f6;
    border-radius: 14rpx;
    font-size: 24rpx;
    font-weight: 500;
    flex-shrink: 0;
  }

  .status-text {
    font-size: 26rpx;
    color: #9ca3af;
    flex-shrink: 0;
  }

  .check-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .score {
    font-size: 28rpx;
    color: #16a34a;
    font-weight: 600;
  }

  .empty {
    text-align: center;
    font-size: 28rpx;
    color: #9ca3af;
    padding: 80rpx 0;
  }

  /* ===== Q&A ===== */
  .qa-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 12rpx 8rpx 24rpx;
  }

  .qa-title {
    font-size: 32rpx;
    font-weight: 700;
    color: #1f2937;
  }

  .qa-ask-btn {
    padding: 12rpx 26rpx;
    background: linear-gradient(135deg, #6366f1, #8b5cf6);
    color: #fff;
    border-radius: 999rpx;
    font-size: 26rpx;
    font-weight: 600;
  }

  .qa-stats {
    display: flex;
    background: #fff;
    border-radius: 24rpx;
    padding: 28rpx 0;
    margin-bottom: 24rpx;
    box-shadow: 0 4rpx 16rpx rgba(68, 78, 95, 0.04);
  }

  .stat-item {
    flex: 1;
    display: flex;
    flex-direction: column;
    align-items: center;
  }

  .stat-num {
    font-size: 40rpx;
    font-weight: 700;
    color: #1f2937;
  }

  .stat-num.warn { color: #f59e0b; }
  .stat-num.ok   { color: #16a34a; }

  .stat-label {
    font-size: 24rpx;
    color: #9ca3af;
    margin-top: 6rpx;
  }

  .qa-section-title {
    font-size: 26rpx;
    color: #6b7280;
    font-weight: 600;
    padding: 6rpx 8rpx 16rpx;
  }

  .qa-item {
    background: #fff;
    border-radius: 20rpx;
    padding: 24rpx;
    margin-bottom: 18rpx;
    box-shadow: 0 4rpx 16rpx rgba(68, 78, 95, 0.04);
  }

  .qa-item-top {
    display: flex;
    align-items: center;
    margin-bottom: 16rpx;
  }

  .qa-teacher-avatar,
  .teacher-avatar {
    width: 72rpx;
    height: 72rpx;
    border-radius: 50%;
    background: #e5e7eb;
    flex-shrink: 0;
  }

  .qa-teacher-info,
  .teacher-meta {
    flex: 1;
    margin-left: 18rpx;
    display: flex;
    flex-direction: column;
    min-width: 0;
  }

  .qa-teacher-name,
  .teacher-name {
    font-size: 28rpx;
    font-weight: 600;
    color: #1f2937;
  }

  .qa-teacher-meta,
  .teacher-sub {
    font-size: 22rpx;
    color: #9ca3af;
    margin-top: 4rpx;
  }

  .teacher-spec {
    font-size: 22rpx;
    color: #6b7280;
    margin-top: 4rpx;
  }

  .qa-status {
    font-size: 22rpx;
    padding: 6rpx 16rpx;
    border-radius: 999rpx;
    flex-shrink: 0;
  }

  .qa-status.warn {
    background: #fef3c7;
    color: #a16207;
  }

  .qa-status.ok {
    background: #dcfce7;
    color: #15803d;
  }

  .qa-question {
    font-size: 28rpx;
    color: #1f2937;
    line-height: 1.5;
    margin-bottom: 14rpx;
    word-break: break-all;
  }

  .qa-answer {
    background: #f3f4f6;
    border-radius: 14rpx;
    padding: 16rpx 18rpx;
    margin-bottom: 12rpx;
  }

  .qa-answer-label {
    font-size: 24rpx;
    color: #6b7280;
    font-weight: 600;
    margin-right: 8rpx;
  }

  .qa-answer-text {
    font-size: 26rpx;
    color: #1f2937;
    line-height: 1.5;
  }

  .qa-time {
    font-size: 22rpx;
    color: #9ca3af;
    text-align: right;
  }

  /* 弹窗 */
  .modal-mask {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.5);
    z-index: 999;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .modal-content {
    width: 86%;
    max-height: 80vh;
    background: #fff;
    border-radius: 24rpx;
    display: flex;
    flex-direction: column;
    overflow: hidden;
  }

  .modal-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 28rpx 24rpx 12rpx;
    border-bottom: 1rpx solid #f3f4f6;
  }

  .modal-title {
    font-size: 30rpx;
    font-weight: 700;
    color: #1f2937;
  }

  .modal-close {
    font-size: 40rpx;
    color: #9ca3af;
    line-height: 1;
  }

  .modal-body {
    padding: 24rpx;
    max-height: 60vh;
  }

  .form-label {
    font-size: 26rpx;
    color: #6b7280;
    font-weight: 600;
    margin-bottom: 14rpx;
  }

  .teacher-picker {
    margin-bottom: 24rpx;
  }

  .teacher-row {
    display: flex;
    align-items: center;
    padding: 18rpx;
    border: 2rpx solid #f3f4f6;
    border-radius: 16rpx;
    margin-bottom: 14rpx;
  }

  .teacher-row.picked {
    border-color: #8b5cf6;
    background: #f5f3ff;
  }

  .teacher-empty {
    text-align: center;
    color: #9ca3af;
    font-size: 24rpx;
    padding: 30rpx 0;
  }

  .teacher-picked {
    display: flex;
    align-items: center;
    justify-content: space-between;
    background: #f5f3ff;
    border: 2rpx solid #8b5cf6;
    border-radius: 16rpx;
    padding: 18rpx;
    margin-bottom: 24rpx;
  }

  .teacher-picked-info {
    display: flex;
    align-items: center;
    flex: 1;
  }

  .reselect {
    font-size: 24rpx;
    color: #8b5cf6;
    padding: 6rpx 12rpx;
  }

  .form-textarea {
    width: 100%;
    min-height: 200rpx;
    background: #f9fafb;
    border-radius: 16rpx;
    padding: 20rpx;
    font-size: 28rpx;
    color: #1f2937;
    box-sizing: border-box;
  }

  .word-count {
    text-align: right;
    font-size: 22rpx;
    color: #9ca3af;
    margin-top: 8rpx;
  }

  .modal-footer {
    display: flex;
    padding: 16rpx 24rpx 28rpx;
    gap: 16rpx;
    border-top: 1rpx solid #f3f4f6;
  }

  .btn {
    flex: 1;
    text-align: center;
    padding: 20rpx 0;
    border-radius: 16rpx;
    font-size: 28rpx;
    font-weight: 600;
  }

  .btn.cancel {
    background: #f3f4f6;
    color: #6b7280;
  }

  .btn.confirm {
    background: linear-gradient(135deg, #6366f1, #8b5cf6);
    color: #fff;
  }
</style>
