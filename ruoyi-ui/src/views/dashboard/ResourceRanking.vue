<template>
  <div class="resource-ranking">
    <div class="ranking-header">
      <svg-icon icon-class="shopping" class-name="ranking-icon" />
      <span class="ranking-title">课程热度排行</span>
      <el-tag size="mini" type="warning">实时热度</el-tag>
    </div>
    <div class="ranking-list">
      <div
        v-for="(item, index) in displayList"
        :key="item.name"
        class="ranking-item"
        :class="{ 'top-three': index < 3 }"
      >
        <div class="rank-badge" :class="'rank-' + (index + 1)">
          <span v-if="index < 3" class="rank-icon">🏆</span>
          <span v-else class="rank-num">{{ index + 1 }}</span>
        </div>
        <div class="resource-info">
          <div class="resource-name">
            <span>{{ item.name }}</span>
            <el-tag v-if="item.tag" :type="item.tagType" size="mini">{{ item.tag }}</el-tag>
          </div>
          <div class="resource-meta">
            <span class="meta-type">{{ item.type }}</span>
            <span class="meta-divider">|</span>
            <span class="meta-author">{{ item.author }}</span>
          </div>
        </div>
        <div class="resource-stats">
          <div class="heat-bar">
            <div class="heat-fill" :style="{ width: item.heatPercent + '%' }" />
          </div>
          <span class="heat-value">{{ item.visits }}人</span>
        </div>
      </div>
    </div>
    <div class="ranking-footer">
      <span>总选课人数 {{ totalVisits }} 人</span>
    </div>
  </div>
</template>

<script>
import { getCourseRanking } from '@/api/study/dashboard'

export default {
  name: 'ResourceRanking',
  data() {
    return {
      rankedResources: []
    }
  },
  computed: {
    totalVisits() {
      return this.rankedResources.reduce((sum, item) => sum + item.visits, 0)
    },
    displayList() {
      return this.rankedResources.slice(0, 3)
    }
  },
  created() {
    this.fetchData()
  },
  methods: {
    fetchData() {
      getCourseRanking().then(res => {
        const list = res.data || []
        // #region debug-point course-ranking
        console.log('[DEBUG] courseRanking raw data:', JSON.stringify(list, null, 2))
        // #endregion debug-point course-ranking
        const maxPerson = Math.max(...list.map(c => Number(c.currentPerson)), 1)
        this.rankedResources = list.map((item, index) => ({
          name: item.cName || item.cname || '未知课程',
          type: item.type || '未分类',
          author: item.teacherName || item.teachername || '未知教师',
          visits: Number(item.currentPerson) || 0,
          heatPercent: Math.round((Number(item.currentPerson) / maxPerson) * 100),
          tag: index < 3 ? (index === 0 ? 'HOT' : '推荐') : null,
          tagType: index === 0 ? 'danger' : 'success'
        }))
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.resource-ranking {
  background: #fff;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);

  .ranking-header {
    display: flex;
    align-items: center;
    margin-bottom: 16px;

    .ranking-icon {
      font-size: 20px;
      color: #F56C6C;
      margin-right: 8px;
    }

    .ranking-title {
      font-size: 16px;
      font-weight: 600;
      color: #303133;
      flex: 1;
    }
  }

  .ranking-list {
    max-height: 220px;
    overflow-y: auto;

    &::-webkit-scrollbar {
      width: 4px;
    }

    &::-webkit-scrollbar-thumb {
      background: #dcdfe6;
      border-radius: 2px;
    }

    .ranking-item {
      display: flex;
      align-items: center;
      padding: 10px 0;
      border-bottom: 1px solid #f5f5f5;
      transition: background 0.2s;

      &:hover {
        background: #fafafa;
        border-radius: 4px;
        padding-left: 4px;
        padding-right: 4px;
      }

      &:last-child { border-bottom: none; }

      .rank-badge {
        width: 32px;
        height: 32px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-right: 12px;
        flex-shrink: 0;

        .rank-icon { font-size: 18px; }

        .rank-num {
          font-size: 14px;
          font-weight: 600;
          color: #C0C4CC;
        }
      }

      .resource-info {
        flex: 1;
        min-width: 0;

        .resource-name {
          display: flex;
          align-items: center;
          gap: 6px;
          font-size: 14px;
          font-weight: 500;
          color: #303133;
          white-space: nowrap;
          overflow: hidden;
          text-overflow: ellipsis;

          .el-tag { flex-shrink: 0; }
        }

        .resource-meta {
          margin-top: 4px;
          font-size: 12px;
          color: #909399;

          .meta-divider {
            margin: 0 6px;
            color: #e4e7ed;
          }
        }
      }

      .resource-stats {
        display: flex;
        align-items: center;
        gap: 8px;
        flex-shrink: 0;
        margin-left: 12px;

        .heat-bar {
          width: 60px;
          height: 6px;
          background: #f0f0f0;
          border-radius: 3px;
          overflow: hidden;

          .heat-fill {
            height: 100%;
            background: linear-gradient(90deg, #409EFF, #337ecc);
            border-radius: 3px;
            transition: width 0.6s ease;
          }
        }

        .heat-value {
          font-size: 12px;
          color: #909399;
          min-width: 40px;
        }

        .trend {
          font-size: 11px;
          font-weight: 500;
          min-width: 36px;
          text-align: right;

          &.up { color: #67C23A; }
          &.down { color: #F56C6C; }
        }
      }
    }
  }

  .ranking-footer {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-top: 12px;
    padding-top: 12px;
    border-top: 1px solid #f0f0f0;
    font-size: 12px;
    color: #909399;
  }
}
</style>