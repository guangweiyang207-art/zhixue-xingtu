package com.ruoyi.study.mapper;

import java.util.List;
import java.util.Map;
import com.ruoyi.study.domain.ErrorHeatmapVO;
import com.ruoyi.study.domain.AiChatVO;
import com.ruoyi.study.domain.ClassRadarVO;
import com.ruoyi.study.domain.CourseRankingVO;

public interface DashboardMapper
{
    Map<String, Object> selectPlatformOverview();

    List<ErrorHeatmapVO> selectErrorHeatmap(String date);

    List<AiChatVO> selectRecentAiChats();

    Map<String, Object> selectActivityRing(String period);

    List<ClassRadarVO> selectClassRadar();

    List<CourseRankingVO> selectCourseRanking();
}