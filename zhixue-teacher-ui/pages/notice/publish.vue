<template>
  <view style="padding: 20px;background: #f5f7fa;min-height: 100vh;">
    <view style="background:#fff;border-radius: 16px;padding: 20px;margin-bottom:20px;">
      <view style="margin-bottom:15px;">
        <text style="font-size:16px;">通知标题</text>
        <input
          v-model="form.title"
          placeholder="请输入标题"
          style="border:1px solid #eee;height:44px;border-radius:8px;margin-top:5px;padding:0 10px;"
        />
      </view>

      <view style="margin-bottom:15px;">
        <text style="font-size:16px;">通知内容</text>
        <textarea
          v-model="form.content"
          placeholder="请输入内容"
          style="border:1px solid #eee;height:150px;border-radius:8px;margin-top:5px;padding:10px;"
        ></textarea>
      </view>

      <view style="margin-bottom:15px;">
        <text style="font-size:16px;">接收对象</text>
        <picker mode="selector" :range="targets" @change="selTarget">
          <view style="border:1px solid #eee;height:44px;line-height:44px;border-radius:8px;margin-top:5px;padding:0 10px;">
            {{ targets[selIndex] }}
          </view>
        </picker>
      </view>
    </view>

    <button
      style="background:#5151E5;color:#fff;border-radius:12px;height:50px;line-height:50px;font-size:18px;"
      @click="submit"
    >
      发布通知
    </button>
  </view>
</template>

<script>
import { publishNotice } from '@/api/index.js'
export default {
  data() {
    return {
      form: { title: '', content: '', target: 'all' },
      targets: ['全体', '学生', '老师'],
      selIndex: 0
    }
  },
  methods: {
    selTarget(e) {
      this.selIndex = e.detail.value
    },
    async submit() {
      if (!this.form.title) {
        uni.showToast({ title: '请输入标题', icon: 'none' })
        return
      }
      if (!this.form.content) {
        uni.showToast({ title: '请输入内容', icon: 'none' })
        return
      }
      try {
        // 后端 Notice 字段: status 1-已发布(0-草稿,默认,不传首页看不到), sender_id=teacherId
        const pad = n => String(n).padStart(2, '0')
        const now = new Date()
        const publishTime = `${now.getFullYear()}-${pad(now.getMonth() + 1)}-${pad(now.getDate())} ${pad(now.getHours())}:${pad(now.getMinutes())}:${pad(now.getSeconds())}`
        await publishNotice({
          noticeTitle: this.form.title,
          noticeContent: this.form.content,
          noticeType: 1,
          status: 1,
          createBy: Number(uni.getStorageSync('App-TeacherId')) || null,
          publishTime
        })
        uni.showToast({ title: '发布成功' })
        setTimeout(() => uni.navigateBack(), 1000)
      } catch (e) {
        uni.showToast({ title: '发布失败', icon: 'none' })
      }
    }
  }
}
</script>