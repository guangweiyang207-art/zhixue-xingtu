package com.ruoyi.study.service.impl;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.study.mapper.DashboardMapper;
import com.ruoyi.study.domain.ErrorHeatmapVO;
import com.ruoyi.study.domain.AiChatVO;
import com.ruoyi.study.domain.ClassRadarVO;
import com.ruoyi.study.domain.CourseRankingVO;
import com.ruoyi.study.service.IDashboardService;

@Service
public class DashboardServiceImpl implements IDashboardService
{
    @Autowired
    private DashboardMapper dashboardMapper;

    @Override
    public Map<String, Object> getPlatformOverview()
    {
        return dashboardMapper.selectPlatformOverview();
    }

    @Override
    public List<ErrorHeatmapVO> getErrorHeatmap(String date)
    {
        return dashboardMapper.selectErrorHeatmap(date);
    }

    @Override
    public List<AiChatVO> getRecentAiChats()
    {
        return dashboardMapper.selectRecentAiChats();
    }

    @Override
    public Map<String, Object> getActivityRing(String period)
    {
        return dashboardMapper.selectActivityRing(period);
    }

    @Override
    public List<ClassRadarVO> getClassRadar()
    {
        return dashboardMapper.selectClassRadar();
    }

    @Override
    public List<CourseRankingVO> getCourseRanking()
    {
        return dashboardMapper.selectCourseRanking();
    }
}