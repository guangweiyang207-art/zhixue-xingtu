<template>
  <div class="dashboard-editor-container">
    <el-row :gutter="20">
      <el-col :xs="24" :sm="24" :lg="14">
        <div class="left-column">
          <ai-plan-stats />
          <div class="section-spacing" />
          <error-heatmap />
          <div class="section-spacing" />
          <ai-chat-carousel />
        </div>
      </el-col>
      <el-col :xs="24" :sm="24" :lg="10">
        <div class="right-column">
          <activity-ring />
          <div class="section-spacing" />
          <class-radar />
          <div class="section-spacing" />
          <resource-ranking />
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import AiPlanStats from './dashboard/AiPlanStats'
import ErrorHeatmap from './dashboard/ErrorHeatmap'
import AiChatCarousel from './dashboard/AiChatCarousel'
import ActivityRing from './dashboard/ActivityRing'
import ClassRadar from './dashboard/ClassRadar'
import ResourceRanking from './dashboard/ResourceRanking'

export default {
  name: 'Index',
  components: {
    AiPlanStats,
    ErrorHeatmap,
    AiChatCarousel,
    ActivityRing,
    ClassRadar,
    ResourceRanking
  }
}
</script>

<style lang="scss" scoped>
.dashboard-editor-container {
  padding: 24px;
  background-color: #f0f2f5;
  min-height: calc(100vh - 84px);

  .left-column,
  .right-column {
    display: flex;
    flex-direction: column;
  }

  .section-spacing {
    height: 20px;
    flex-shrink: 0;
  }
}

@media (max-width: 1024px) {
  .dashboard-editor-container {
    padding: 16px;

    .section-spacing {
      height: 16px;
    }
  }
}
</style>