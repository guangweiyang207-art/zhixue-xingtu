package com.ruoyi.study.service;

import java.util.List;
import java.util.Map;
import com.ruoyi.study.domain.ErrorHeatmapVO;
import com.ruoyi.study.domain.AiChatVO;
import com.ruoyi.study.domain.ClassRadarVO;
import com.ruoyi.study.domain.CourseRankingVO;

public interface IDashboardService
{
    Map<String, Object> getPlatformOverview();

    List<ErrorHeatmapVO> getErrorHeatmap(String date);

    List<AiChatVO> getRecentAiChats();

    Map<String, Object> getActivityRing(String period);

    List<ClassRadarVO> getClassRadar();

    List<CourseRankingVO> getCourseRanking();
}