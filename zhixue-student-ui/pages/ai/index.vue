<template>
  <view class="page">
    <!-- 顶部导航 -->
    <view class="header">
      <view class="nav-bar">
        <uni-icons type="back" size="22" color="#333" @click="goBack" />
        <view class="nav-center">
          <view class="ai-avatar-small">AI</view>
          <text class="nav-title">AI学习助手</text>
        </view>
        <view class="nav-clear" @click="onClearChat">
          <uni-icons type="trash" size="20" color="#9ca3af" />
        </view>
      </view>
      <!-- 错题个性化提示条 -->
      <view class="err-tip" v-if="errorCount > 0">
        <uni-icons type="info-filled" size="14" color="#8b5cf6" />
        <text class="err-tip-text">已结合你的 {{ errorCount }} 道错题，解答更具针对性</text>
      </view>
    </view>

    <!-- 消息列表 -->
    <scroll-view
      scroll-y
      class="chat-scroll"
      :scroll-top="scrollTop"
      :scroll-with-animation="true"
      @scroll="onScroll"
    >
      <view class="chat-list" id="chatList">
        <!-- 欢迎提示 -->
        <view class="welcome-card" v-if="messageList.length <= 1">
          <view class="welcome-icon">
            <uni-icons type="chatbubble-filled" size="40" color="#8b5cf6" />
          </view>
          <text class="welcome-title">你好，我是你的AI学习助手</text>
          <text class="welcome-desc">我可以帮你解答学习中的各种问题，包括知识点讲解、题目分析、学习方法建议等。</text>
        </view>

        <!-- 消息气泡 -->
        <view
          class="msg-row"
          v-for="(msg, index) in messageList"
          :key="index"
          :class="msg.role === 'user' ? 'msg-right' : 'msg-left'"
        >
          <!-- AI头像 -->
          <view v-if="msg.role === 'assistant'" class="avatar ai-avatar">
            <text class="avatar-text">AI</text>
          </view>

          <view class="msg-content">
            <view class="msg-bubble" :class="msg.role === 'user' ? 'bubble-user' : 'bubble-ai'">
              <!-- Agent 工具调用步骤 -->
              <view v-if="msg.steps && msg.steps.length" class="tool-steps">
                <view class="tool-step" v-for="(s, si) in msg.steps" :key="si">
                  <text class="tool-step-icon">⚙</text>
                  <text class="tool-step-text">{{ toolLabel(s.name) }}</text>
                </view>
              </view>
              <text class="msg-text">{{ msg.content }}<text v-if="msg.typing" class="type-cursor">▌</text></text>
            </view>
            <text class="msg-time">{{ msg.time }}</text>
          </view>

          <!-- 用户头像 -->
          <view v-if="msg.role === 'user'" class="avatar user-avatar">
            <uni-icons type="person-filled" size="20" color="#fff" />
          </view>
        </view>

        <!-- AI思考中(仅在还没有流式气泡时显示) -->
        <view class="msg-row msg-left" v-if="isLoading && !messageList.some(m => m.typing)">
          <view class="avatar ai-avatar">
            <text class="avatar-text">AI</text>
          </view>
          <view class="msg-content">
            <view class="msg-bubble bubble-ai thinking-bubble">
              <view class="thinking-dots">
                <view class="dot"></view>
                <view class="dot"></view>
                <view class="dot"></view>
              </view>
            </view>
          </view>
        </view>

        <!-- 底部占位 -->
        <view style="height: 20rpx;"></view>
      </view>
    </scroll-view>

    <!-- 底部输入区 -->
    <view class="input-area">
      <scroll-view scroll-x class="quick-tags-scroll" v-if="messageList.length <= 2">
        <view class="quick-tags">
          <view class="quick-tag" v-for="(tag, idx) in quickTags" :key="idx" @click="sendQuick(tag)">
            {{ tag }}
          </view>
        </view>
      </scroll-view>
      <view class="input-box">
        <input
          class="chat-input"
          v-model="inputValue"
          placeholder="请输入你的问题..."
          placeholder-class="input-placeholder"
          confirm-type="send"
          @confirm="sendMessage"
          :disabled="isLoading"
        />
        <view
          class="send-btn"
          :class="{ active: inputValue.trim().length > 0 && !isLoading }"
          @click="sendMessage"
        >
          <uni-icons type="paperplane-filled" size="22" color="#fff" />
        </view>
      </view>
      <view class="safe-bottom"></view>
    </view>
  </view>
</template>

<script>
  import { aiChatApi } from '@/api/system/ai.js'
  import { getErrorListApi } from '@/api/errorbook/errorbook.js'

  const CHAT_HISTORY_KEY = 'ai_chat_history'

  export default {
    data() {
      return {
        inputValue: '',
        isLoading: false,
        scrollTop: 0,
        errorCount: 0,
        typingTimer: null,
        messageList: [
          {
            role: 'assistant',
            content: '你好！我是AI学习助手，有什么学习上的问题可以随时问我~',
            time: this.formatTime(new Date())
          }
        ],
        quickTags: ['数学解题技巧', '英语语法讲解', '物理公式推导', '学习方法建议', '根据错题制定复习计划', '帮我总结知识点']
      }
    },
    onLoad() {
      this.loadHistory()
    },
    onShow() {
      this.loadErrorCount()
      // 从错题本跳转过来,自动提问(switchTab 不支持传参,经 storage 中转)
      let ask = ''
      try {
        ask = uni.getStorageSync('ai_pending_ask') || ''
        if (ask) uni.removeStorageSync('ai_pending_ask')
      } catch (e) { ask = '' }
      if (ask) {
        this.$nextTick(() => this.sendMessage(ask))
      }
    },
    onHide() {
      this.saveHistory()
    },
    onUnload() {
      this.saveHistory()
      if (this.typingTimer) {
        clearInterval(this.typingTimer)
        this.typingTimer = null
      }
    },
    methods: {
      goBack() {
        uni.navigateBack()
      },
      // ===== 聊天记录本地持久化 =====
      loadHistory() {
        try {
          const saved = uni.getStorageSync(CHAT_HISTORY_KEY)
          if (saved && Array.isArray(saved) && saved.length > 0) {
            // 最多恢复最近 50 条
            this.messageList = saved.slice(-50).map(m => ({ ...m, typing: false }))
          }
        } catch (e) { /* 忽略本地缓存异常 */ }
      },
      saveHistory() {
        try {
          const list = this.messageList.filter(m => !m.typing)
          if (list.length > 0) {
            uni.setStorageSync(CHAT_HISTORY_KEY, list.slice(-50))
          }
        } catch (e) { /* 忽略本地缓存异常 */ }
      },
      onClearChat() {
        if (this.messageList.length <= 1) return
        uni.showModal({
          title: '清空对话',
          content: '确定要清空当前聊天记录吗？',
          success: (res) => {
            if (res.confirm) {
              try { uni.removeStorageSync(CHAT_HISTORY_KEY) } catch (e) {}
              if (this.typingTimer) {
                clearInterval(this.typingTimer)
                this.typingTimer = null
              }
              this.isLoading = false
              this.messageList = [{
                role: 'assistant',
                content: '你好！我是AI学习助手，有什么学习上的问题可以随时问我~',
                time: this.formatTime(new Date())
              }]
            }
          }
        })
      },
      // ===== 错题数量(后端回答时已注入错题上下文,此处可视化) =====
      loadErrorCount() {
        const stuId = uni.getStorageSync('userInfo')?.stu_id || 1
        getErrorListApi({ stu_id: stuId }).then(res => {
          if (res && res.data && Array.isArray(res.data)) {
            this.errorCount = res.data.length
          }
        }).catch(() => {})
      },
      sendQuick(text) {
        this.inputValue = text
        this.sendMessage()
      },
      sendMessage(text) {
        // 小程序里 @click/@confirm 会把事件对象当首参传入,排除掉避免 event.trim() 报错
        if (text !== undefined && typeof text !== 'string') text = undefined
        const content = (text !== undefined ? text : this.inputValue).trim()
        if (!content || this.isLoading) return
        if (text === undefined) this.inputValue = ''

        this.messageList.push({
          role: 'user',
          content: content,
          time: this.formatTime(new Date())
        })
        this.scrollToBottom()

        this.isLoading = true
        const history = this.messageList.filter(m => !m.typing && m.content).slice(0, -1).map(m => ({
          role: m.role,
          content: m.content
        }))

        // 流式气泡(真流式:后端 SSE 增量推送,前端平滑渲染)
        const msg = {
          role: 'assistant',
          content: '',
          time: this.formatTime(new Date()),
          typing: true,
          steps: []
        }
        this.messageList.push(msg)
        this.scrollToBottom()
        const idx = this.messageList.length - 1
        this._streamIdx = idx
        this._streamBuffer = ''
        this._streamDone = false
        this._meta = null

        // 平滑输出:把到达的字符块按节奏渲染,避免成段闪烁
        if (this.typingTimer) clearInterval(this.typingTimer)
        this.typingTimer = setInterval(() => {
          const m = this.messageList[idx]
          if (!m) return
          if (this._streamBuffer.length > 0) {
            const step = Math.max(2, Math.ceil(this._streamBuffer.length / 6))
            m.content += this._streamBuffer.slice(0, step)
            this._streamBuffer = this._streamBuffer.slice(step)
            this.scrollToBottom()
          } else if (this._streamDone) {
            clearInterval(this.typingTimer)
            this.typingTimer = null
            m.typing = false
            this.isLoading = false
            this.saveHistory()
          }
        }, 24)

        this.doStreamSend(content, history, msg)
      },
      // ===== 真流式请求(POST SSE):小程序 enableChunked 分块接收 / H5 fetch 流式读取;失败自动降级旧接口 =====
      doStreamSend(content, history, msg) {
        let finished = false
        let sseBuf = ''
        const decoder = this.createUtf8Decoder()
        const that = this

        // 90s 无结果降级走非流式接口
        const failTimer = setTimeout(() => {
          if (!finished) {
            finished = true
            that.fallbackToNonStream(content, history, msg)
          }
        }, 90000)

        const handleEvent = (event, data) => {
          if (finished) return
          if (event === 'delta') {
            that._streamBuffer += data.text || ''
          } else if (event === 'tool') {
            msg.steps.push({ name: data.tool, args: data.args })
            that.scrollToBottom()
          } else if (event === 'done') {
            finished = true
            clearTimeout(failTimer)
            that._meta = data
            // 服务端兜底:done 带完整回复,若本地渲染丢失内容则以完整回复续传
            const full = data.reply || ''
            const shown = that.messageList[that._streamIdx] ? that.messageList[that._streamIdx].content : ''
            if (full.length > shown.length + that._streamBuffer.length) {
              that._streamBuffer += full.slice(shown.length + that._streamBuffer.length)
            }
            that._streamDone = true
          } else if (event === 'error') {
            finished = true
            clearTimeout(failTimer)
            if (that.typingTimer) { clearInterval(that.typingTimer); that.typingTimer = null }
            that.isLoading = false
            msg.typing = false
            msg.content = msg.content || ('请求失败：' + (data.msg || '未知错误'))
            that.saveHistory()
          }
        }
        const onText = (t) => {
          sseBuf += t
          const blocks = sseBuf.split('\n\n')
          sseBuf = blocks.pop()
          for (const block of blocks) {
            let evt = 'message'
            let dataStr = ''
            for (const line of block.split('\n')) {
              if (line.indexOf('event:') === 0) evt = line.slice(6).trim()
              else if (line.indexOf('data:') === 0) dataStr += line.slice(5).trim()
            }
            if (!dataStr) continue
            try { handleEvent(evt, JSON.parse(dataStr)) } catch (e) { /* 忽略坏块 */ }
          }
        }
        const onChunk = (buffer) => {
          const t = decoder.feed(buffer)
          if (t) onText(t)
        }

        // #ifdef MP-WEIXIN
        const task = uni.request({
          url: config.baseUrl + '/ai/assistant/chat/stream',
          method: 'POST',
          enableChunked: true,
          timeout: 120000,
          header: { 'Authorization': 'Bearer ' + getToken() },
          data: { message: content, history: history },
          success: () => {},
          fail: () => {
            if (!finished) {
              finished = true
              clearTimeout(failTimer)
              that.fallbackToNonStream(content, history, msg)
            }
          }
        })
        if (task && task.onChunkReceived) {
          task.onChunkReceived(res => {
            try { onChunk(res.data) } catch (e) { /* 忽略单块解码失败 */ }
          })
        } else {
          // 环境不支持分块接收,降级
          if (!finished) {
            finished = true
            clearTimeout(failTimer)
            that.fallbackToNonStream(content, history, msg)
          }
        }
        // #endif

        // #ifdef H5
        fetch(config.baseUrl + '/ai/assistant/chat/stream', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json', 'Authorization': 'Bearer ' + getToken() },
          body: JSON.stringify({ message: content, history: history })
        }).then(res => {
          const reader = res.body.getReader()
          const dec = new TextDecoder('utf-8')
          const pump = () => reader.read().then(({ done, value }) => {
            if (done) return
            onText(dec.decode(value, { stream: true }))
            pump()
          })
          pump()
        }).catch(() => {
          if (!finished) {
            finished = true
            clearTimeout(failTimer)
            that.fallbackToNonStream(content, history, msg)
          }
        })
        // #endif
      },
      // 非流式兜底(旧接口):拿到完整回复后仍走平滑打字机
      fallbackToNonStream(content, history, msg) {
        aiChatApi({ message: content, history: history }).then(res => {
          if (res.code === 200) {
            this._streamBuffer = (this._streamBuffer || '') + (res.data || 'AI返回内容为空')
            this._streamDone = true
          } else {
            if (this.typingTimer) { clearInterval(this.typingTimer); this.typingTimer = null }
            this.isLoading = false
            msg.typing = false
            msg.content = '请求失败：' + (res.msg || '未知错误')
            this.saveHistory()
          }
        }).catch(() => {
          if (this.typingTimer) { clearInterval(this.typingTimer); this.typingTimer = null }
          this.isLoading = false
          msg.typing = false
          msg.content = '网络异常，请稍后重试'
          this.saveHistory()
        })
      },
      // 增量 UTF-8 解码器:处理多字节中文字符被 chunk 边界切断的情况
      createUtf8Decoder() {
        let pending = []
        const that = this
        return {
          feed(buffer) {
            let bytes
            if (buffer instanceof Uint8Array) {
              bytes = Array.from(buffer)
            } else {
              bytes = Array.from(new Uint8Array(buffer))
            }
            bytes = pending.concat(bytes)
            pending = []
            let text = ''
            let i = 0
            while (i < bytes.length) {
              const b = bytes[i]
              let need = 0
              if (b < 0x80) need = 0
              else if (b >= 0xC0 && b < 0xE0) need = 1
              else if (b >= 0xE0 && b < 0xF0) need = 2
              else if (b >= 0xF0 && b < 0xF8) need = 3
              else { i++; continue }
              if (i + need >= bytes.length) {
                pending = bytes.slice(i)
                break
              }
              if (need === 0) {
                text += String.fromCharCode(b)
                i += 1
              } else {
                let code = 0
                if (need === 1) code = (b & 0x1F) << 6 | (bytes[i + 1] & 0x3F)
                else if (need === 2) code = (b & 0x0F) << 12 | (bytes[i + 1] & 0x3F) << 6 | (bytes[i + 2] & 0x3F)
                else {
                  code = (b & 0x07) << 18 | (bytes[i + 1] & 0x3F) << 12 | (bytes[i + 2] & 0x3F) << 6 | (bytes[i + 3] & 0x3F)
                  const offset = code - 0x10000
                  text += String.fromCharCode(0xD800 + (offset >> 10), 0xDC00 + (offset & 0x3FF))
                  i += need + 1
                  continue
                }
                text += String.fromCharCode(code)
                i += need + 1
              }
            }
            return text
          }
        }
      },
      // Agent 工具名转前端文案
      toolLabel(name) {
        const map = {
          query_error_book: '正在查询错题本...',
          query_homework: '正在查询作业情况...',
          recommend_practice: '正在生成练习建议...'
        }
        return map[name] || ('正在调用 ' + (name || '工具') + '...')
      },
      scrollToBottom() {
        this.$nextTick(() => {
          const query = uni.createSelectorQuery().in(this)
          query.select('#chatList').boundingClientRect(rect => {
            if (rect) {
              this.scrollTop = rect.height + 1000
            }
          }).exec()
        })
      },
      onScroll(e) {
        // 保留用于后续扩展
      },
      formatTime(date) {
        const h = String(date.getHours()).padStart(2, '0')
        const m = String(date.getMinutes()).padStart(2, '0')
        return `${h}:${m}`
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
    background: #f6f7fb;
  }
  .header {
    background: #fff;
    padding-top: calc(var(--status-bar-height) + 20rpx);
    padding-bottom: 20rpx;
    padding-left: 30rpx;
    padding-right: 30rpx;
    flex-shrink: 0;
  }
  .nav-bar {
    display: flex;
    align-items: center;
    justify-content: space-between;
  }
  .nav-center {
    display: flex;
    align-items: center;
    gap: 16rpx;
  }
  .ai-avatar-small {
    width: 48rpx;
    height: 48rpx;
    border-radius: 50%;
    background: linear-gradient(135deg, #8b5cf6, #a78bfa);
    display: flex;
    align-items: center;
    justify-content: center;
    color: #fff;
    font-size: 20rpx;
    font-weight: 700;
  }
  .nav-title {
    font-size: 36rpx;
    font-weight: 600;
    color: #222;
  }
  .nav-clear {
    width: 22px;
    display: flex;
    justify-content: flex-end;
  }
  .err-tip {
    display: flex;
    align-items: center;
    gap: 8rpx;
    padding: 10rpx 24rpx 14rpx;
  }
  .err-tip-text {
    font-size: 22rpx;
    color: #8b5cf6;
  }
  .type-cursor {
    color: #8b5cf6;
    animation: blink 0.8s infinite;
  }
  @keyframes blink {
    0%, 100% { opacity: 1; }
    50% { opacity: 0; }
  }
  .chat-scroll {
    flex: 1;
    padding: 0 24rpx;
    overflow: hidden;
  }
  .chat-list {
    padding-top: 24rpx;
    padding-bottom: 24rpx;
  }
  .welcome-card {
    background: #fff;
    border-radius: 24rpx;
    padding: 48rpx 32rpx;
    margin-bottom: 32rpx;
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
  }
  .welcome-icon {
    width: 120rpx;
    height: 120rpx;
    border-radius: 50%;
    background: linear-gradient(135deg, #8b5cf6, #a78bfa);
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 24rpx;
  }
  .welcome-title {
    font-size: 34rpx;
    font-weight: 700;
    color: #222;
    margin-bottom: 16rpx;
  }
  .welcome-desc {
    font-size: 28rpx;
    color: #666;
    line-height: 1.6;
    margin-bottom: 32rpx;
  }
  .quick-tags-scroll {
    margin-bottom: 16rpx;
    white-space: nowrap;
  }
  .quick-tags {
    display: inline-flex;
    flex-wrap: nowrap;
    gap: 16rpx;
    padding: 4rpx 4rpx;
  }
  .quick-tag {
    font-size: 26rpx;
    color: #8b5cf6;
    background: #f3f0ff;
    padding: 14rpx 28rpx;
    border-radius: 999rpx;
    border: 1rpx solid #e9e3ff;
    white-space: nowrap;
    flex-shrink: 0;
  }
  .msg-row {
    display: flex;
    align-items: flex-start;
    margin-bottom: 32rpx;
    gap: 16rpx;
  }
  .msg-left {
    justify-content: flex-start;
  }
  .msg-right {
    justify-content: flex-end;
  }
  .avatar {
    width: 72rpx;
    height: 72rpx;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
  }
  .ai-avatar {
    background: linear-gradient(135deg, #8b5cf6, #a78bfa);
  }
  .user-avatar {
    background: linear-gradient(135deg, #4f7cf7, #3b82f6);
  }
  .avatar-text {
    font-size: 24rpx;
    color: #fff;
    font-weight: 700;
  }
  .msg-content {
    max-width: 70%;
    display: flex;
    flex-direction: column;
  }
  .msg-bubble {
    padding: 24rpx;
    border-radius: 24rpx;
    margin-bottom: 8rpx;
  }
  .bubble-ai {
    background: #fff;
    border: 1rpx solid #f0f0f0;
    box-shadow: 0 2rpx 12rpx rgba(0,0,0,0.04);
    border-top-left-radius: 4rpx;
  }
  .bubble-user {
    background: linear-gradient(135deg, #8b5cf6, #a78bfa);
    color: #fff;
    border-top-right-radius: 4rpx;
  }
  .msg-text {
    font-size: 28rpx;
    line-height: 1.7;
    white-space: pre-wrap;
    word-break: break-all;
  }
  .msg-time {
    font-size: 22rpx;
    color: #999;
    align-self: flex-start;
    padding-left: 8rpx;
  }
  .msg-right .msg-time {
    align-self: flex-end;
    padding-right: 8rpx;
  }
  /* Agent 工具调用步骤（紫色小药丸） */
  .tool-steps {
    display: flex;
    flex-direction: column;
    gap: 10rpx;
    margin-bottom: 16rpx;
  }
  .tool-step {
    display: inline-flex;
    align-items: center;
    gap: 8rpx;
    background: #f3f0ff;
    border: 1rpx solid #e9e3ff;
    border-radius: 999rpx;
    padding: 8rpx 20rpx;
    align-self: flex-start;
  }
  .tool-step-icon {
    font-size: 20rpx;
  }
  .tool-step-text {
    font-size: 22rpx;
    color: #8b5cf6;
  }
  .thinking-bubble {
    padding: 20rpx 32rpx;
  }
  .thinking-dots {
    display: flex;
    align-items: center;
    gap: 12rpx;
  }
  .dot {
    width: 16rpx;
    height: 16rpx;
    border-radius: 50%;
    background: #8b5cf6;
    opacity: 0.4;
    animation: dotPulse 1.4s infinite ease-in-out both;
  }
  .dot:nth-child(1) {
    animation-delay: -0.32s;
  }
  .dot:nth-child(2) {
    animation-delay: -0.16s;
  }
  @keyframes dotPulse {
    0%, 80%, 100% { transform: scale(0.6); opacity: 0.4; }
    40% { transform: scale(1); opacity: 1; }
  }
  .input-area {
    background: #fff;
    border-top: 1rpx solid #f0f0f0;
    padding: 20rpx 24rpx 0;
    flex-shrink: 0;
  }
  .input-box {
    display: flex;
    align-items: center;
    gap: 16rpx;
    background: #f6f7fb;
    border-radius: 999rpx;
    padding: 16rpx 16rpx 16rpx 32rpx;
  }
  .chat-input {
    flex: 1;
    font-size: 28rpx;
    color: #333;
    height: 60rpx;
  }
  .input-placeholder {
    color: #aaa;
    font-size: 28rpx;
  }
  .send-btn {
    width: 64rpx;
    height: 64rpx;
    border-radius: 50%;
    background: #d1d5db;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: background 0.2s;
    flex-shrink: 0;
  }
  .send-btn.active {
    background: linear-gradient(135deg, #8b5cf6, #a78bfa);
  }
  .safe-bottom {
    height: calc(constant(safe-area-inset-bottom) + 20rpx);
    height: calc(env(safe-area-inset-bottom) + 20rpx);
  }
</style>
