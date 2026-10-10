<template>
  <div class="ai-chat-carousel">
    <div class="carousel-header">
      <svg-icon icon-class="message" class-name="carousel-icon" />
      <span class="carousel-title">AI 智能答疑实时对话</span>
      <span class="carousel-badge">实时</span>
    </div>
    <el-carousel :interval="4000" height="200px" indicator-position="outside" arrow="always">
      <el-carousel-item v-for="(item, index) in conversations" :key="index">
        <div class="conversation-card">
          <div class="conversation-header">
            <div class="user-info">
              <span class="user-avatar" :style="{ background: item.avatarColor }">{{ item.name.charAt(0) }}</span>
              <div class="user-meta">
                <span class="user-name">{{ item.name }}</span>
                <span class="user-subject">{{ item.subject }}</span>
              </div>
            </div>
            <span class="conversation-time">{{ item.time }}</span>
          </div>
          <div class="conversation-body">
            <div class="question-bubble">
              <span class="bubble-label">问</span>
              <span>{{ item.question }}</span>
            </div>
            <div class="answer-bubble">
              <span class="bubble-label ai-label">AI</span>
              <span>{{ item.answer }}</span>
            </div>
          </div>
          <div class="conversation-footer">
            <span class="helpful-rate">有帮助率 {{ item.helpfulRate }}%</span>
            <span class="like-btn">
              <svg-icon icon-class="like" />
              {{ item.likes }}
            </span>
          </div>
        </div>
      </el-carousel-item>
    </el-carousel>
  </div>
</template>

<script>
import { getRecentChats } from '@/api/study/dashboard'

const avatarColors = ['#409EFF', '#67C23A', '#E6A23C', '#F56C6C', '#909399', '#722ed1']

export default {
  name: 'AiChatCarousel',
  data() {
    return {
      conversations: []
    }
  },
  created() {
    this.fetchData()
  },
  methods: {
    fetchData() {
      getRecentChats().then(res => {
        const list = res.data || []
        this.conversations = list.map((item, index) => ({
          name: item.studentName || '未知用户',
          subject: 'AI智能答疑',
          time: item.createTime ? this.formatTime(item.createTime) : '刚刚',
          question: item.question || '',
          answer: item.answer || '',
          helpfulRate: 95,
          likes: Math.round(Math.random() * 30 + 10),
          avatarColor: avatarColors[index % avatarColors.length]
        }))
      })
    },
    formatTime(timeStr) {
      const now = new Date()
      const time = new Date(timeStr)
      const diff = Math.floor((now - time) / 1000)
      if (diff < 60) return '刚刚'
      if (diff < 3600) return Math.floor(diff / 60) + '分钟前'
      if (diff < 86400) return Math.floor(diff / 3600) + '小时前'
      return Math.floor(diff / 86400) + '天前'
    }
  }
}
</script>

<style lang="scss" scoped>
.ai-chat-carousel {
  background: #fff;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);

  .carousel-header {
    display: flex;
    align-items: center;
    margin-bottom: 16px;

    .carousel-icon {
      font-size: 20px;
      color: #409EFF;
      margin-right: 8px;
    }

    .carousel-title {
      font-size: 16px;
      font-weight: 600;
      color: #303133;
      flex: 1;
    }

    .carousel-badge {
      font-size: 11px;
      color: #fff;
      background: linear-gradient(135deg, #F56C6C, #E6A23C);
      padding: 2px 10px;
      border-radius: 10px;
      animation: pulse 2s infinite;
    }
  }

  .conversation-card {
    padding: 0 8px;

    .conversation-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 12px;

      .user-info {
        display: flex;
        align-items: center;

        .user-avatar {
          width: 36px;
          height: 36px;
          border-radius: 50%;
          display: flex;
          align-items: center;
          justify-content: center;
          color: #fff;
          font-weight: 600;
          font-size: 14px;
          margin-right: 10px;
        }

        .user-meta {
          display: flex;
          flex-direction: column;

          .user-name {
            font-size: 14px;
            font-weight: 500;
            color: #303133;
          }

          .user-subject {
            font-size: 12px;
            color: #909399;
          }
        }
      }

      .conversation-time {
        font-size: 12px;
        color: #C0C4CC;
      }
    }

    .conversation-body {
      margin-bottom: 10px;

      .question-bubble, .answer-bubble {
        display: flex;
        align-items: flex-start;
        margin-bottom: 8px;
        font-size: 13px;
        line-height: 1.6;
        color: #606266;

        .bubble-label, .ai-label {
          width: 20px;
          height: 20px;
          border-radius: 4px;
          display: inline-flex;
          align-items: center;
          justify-content: center;
          font-size: 11px;
          font-weight: 600;
          color: #fff;
          margin-right: 8px;
          flex-shrink: 0;
          margin-top: 2px;
        }

        .bubble-label {
          background: #F56C6C;
        }

        .ai-label {
          background: linear-gradient(135deg, #409EFF, #337ecc);
        }
      }
    }

    .conversation-footer {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding-top: 8px;
      border-top: 1px solid #f0f0f0;

      .helpful-rate {
        font-size: 12px;
        color: #67C23A;
      }

      .like-btn {
        font-size: 12px;
        color: #909399;
        display: flex;
        align-items: center;

        .svg-icon {
          margin-right: 4px;
          font-size: 14px;
        }
      }
    }
  }
}

@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.6; }
}
</style>