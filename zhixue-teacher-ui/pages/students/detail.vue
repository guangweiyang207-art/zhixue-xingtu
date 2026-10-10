<template>
  <view class="page">
    <view class="head">
      <image class="avatar" :src="avatar" mode="aspectFill" />
      <view class="info">
        <text class="name">{{ data.realName || data.studentNo || data.userId || data.stuId }}</text>
        <text class="sub">{{ data.className || '-' }} · {{ data.grade || '-' }}</text>
      </view>
    </view>

    <view class="stats">
      <view class="card">
        <text class="num p">{{ data.homeworkCompletion || 0 }}%</text>
        <text class="lab">作业完成</text>
      </view>
      <view class="card">
        <text class="num g">{{ data.accuracyRate || 0 }}%</text>
        <text class="lab">正确率</text>
      </view>
      <view class="card">
        <text class="num o">{{ data.activityLevel || 0 }}</text>
        <text class="lab">活跃度</text>
      </view>
    </view>

    <view class="rank-box">
      <view class="rank-title">段位</view>
      <view class="rank">
        <text class="rl">{{ data.rankLevel || '未评级' }}</text>
        <text class="rs">积分 {{ data.rankScore || 0 }}</text>
      </view>
    </view>

    <view class="info-box">
      <view class="info-title">基本信息</view>
      <view class="row"><text class="k">学号</text><text class="v">{{ data.studentNo || '-' }}</text></view>
      <view class="row"><text class="k">专业</text><text class="v">{{ data.major || '-' }}</text></view>
      <view class="row"><text class="k">年级</text><text class="v">{{ data.grade || '-' }}</text></view>
      <view class="row"><text class="k">班级</text><text class="v">{{ data.className || '-' }}</text></view>
      <view class="row"><text class="k">做题总数</text><text class="v">{{ data.totalQuestions || 0 }} 道</text></view>
      <view class="row"><text class="k">答对题数</text><text class="v">{{ data.correctQuestions || 0 }} 道</text></view>
      <view class="row"><text class="k">学习时长</text><text class="v">{{ data.studyHours || 0 }} 小时</text></view>
      <view class="row"><text class="k">手机号</text><text class="v">{{ data.phone || '-' }}</text></view>
      <view class="row"><text class="k">邮箱</text><text class="v">{{ data.email || '-' }}</text></view>
      <view class="row"><text class="k">创建时间</text><text class="v">{{ data.createTime || '-' }}</text></view>
    </view>
  </view>
</template>

<script>
import request from '@/utils/request'

export default {
  data() {
    return {
      data: {},
      defaultAvatar: '/static/images/student-avatar.svg'
    }
  },
  computed: {
    avatar() {
      const a = this.data && this.data.avatar
      if (!a) return this.defaultAvatar
      if (a.indexOf('http') === 0) return a
      return a
    }
  },
  onLoad(opt) {
    const id = opt && opt.id
    console.log('[detail onLoad] id=', id)
    if (!id) {
      uni.showToast({ title: '未传学生ID', icon: 'none' })
      return
    }
    request({ url: '/students/student/' + id, method: 'GET' })
      .then(res => {
        console.log('[detail resp]', JSON.stringify(res))
        // RuoYi 的 AjaxResult: {code, msg, data}
        this.data = res.data || {}
      })
      .catch(err => {
        console.error('[detail err]', err)
        uni.showToast({ title: '加载失败', icon: 'none' })
      })
  }
}
</script>

<style lang="scss" scoped>
page { background: #f5f5f5; }
.page { padding: 0 24rpx 40rpx; }

.head { display: flex; align-items: center; padding: 40rpx 0; }
.avatar {
  width: 140rpx;
  height: 140rpx;
  border-radius: 50%;
  background: #f0f0f0;
  margin-right: 24rpx;
  border: 4rpx solid #ffffff;
  box-shadow: 0 0 0 4rpx #FFD7A8, 0 6rpx 20rpx rgba(0, 0, 0, 0.08);
}
.info { display: flex; flex-direction: column; gap: 8rpx; }
.name { font-size: 40rpx; font-weight: bold; color: #1a1a1a; }
.sub { font-size: 26rpx; color: #999; }

.stats { display: flex; gap: 20rpx; margin-bottom: 32rpx; }
.card { flex: 1; background: #fff; border-radius: 20rpx; padding: 32rpx 0; display: flex; flex-direction: column; align-items: center; gap: 8rpx; }
.num { font-size: 40rpx; font-weight: bold; }
.num.p { color: #5b5fc7; }
.num.g { color: #34c759; }
.num.o { color: #ff9500; }
.lab { font-size: 24rpx; color: #999; }

.rank-box { background: #fff; border-radius: 20rpx; padding: 24rpx; margin-bottom: 32rpx; }
.rank-title { font-size: 28rpx; font-weight: 600; margin-bottom: 16rpx; }
.rank { background: linear-gradient(135deg, #5b5fc7, #8b8fe8); border-radius: 16rpx; padding: 24rpx; display: flex; justify-content: space-between; color: #fff; }
.rl { font-size: 36rpx; font-weight: bold; }
.rs { font-size: 26rpx; }

.info-box { background: #fff; border-radius: 20rpx; padding: 24rpx; }
.info-title { font-size: 28rpx; font-weight: 600; margin-bottom: 16rpx; }
.row { display: flex; justify-content: space-between; padding: 20rpx 0; border-bottom: 1rpx solid #f0f0f0; }
.row:last-child { border-bottom: none; }
.k { color: #888; font-size: 26rpx; }
.v { color: #1a1a1a; font-size: 28rpx; font-weight: 500; }
</style>
