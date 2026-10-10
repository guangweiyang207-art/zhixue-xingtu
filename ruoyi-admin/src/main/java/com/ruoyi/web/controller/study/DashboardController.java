package com.ruoyi.web.controller.study;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.study.domain.ErrorHeatmapVO;
import com.ruoyi.study.domain.AiChatVO;
import com.ruoyi.study.domain.ClassRadarVO;
import com.ruoyi.study.domain.CourseRankingVO;
import com.ruoyi.study.service.IDashboardService;

@RestController
@RequestMapping("/study/dashboard")
public class DashboardController extends BaseController
{
    @Autowired
    private IDashboardService dashboardService;

    @PreAuthorize("@ss.hasPermi('study:dashboard:query')")
    @GetMapping("/overview")
    public AjaxResult overview()
    {
        Map<String, Object> data = dashboardService.getPlatformOverview();
        return success(data);
    }

    @PreAuthorize("@ss.hasPermi('study:dashboard:query')")
    @GetMapping("/errorHeatmap")
    public AjaxResult errorHeatmap(@RequestParam(required = false) String date)
    {
        List<ErrorHeatmapVO> list = dashboardService.getErrorHeatmap(date);
        return success(list);
    }

    @PreAuthorize("@ss.hasPermi('study:dashboard:query')")
    @GetMapping("/recentChats")
    public AjaxResult recentChats()
    {
        List<AiChatVO> list = dashboardService.getRecentAiChats();
        return success(list);
    }

    @PreAuthorize("@ss.hasPermi('study:dashboard:query')")
    @GetMapping("/activityRing")
    public AjaxResult activityRing(@RequestParam(required = false, defaultValue = "week") String period)
    {
        Map<String, Object> data = dashboardService.getActivityRing(period);
        return success(data);
    }

    @PreAuthorize("@ss.hasPermi('study:dashboard:query')")
    @GetMapping("/classRadar")
    public AjaxResult classRadar()
    {
        List<ClassRadarVO> list = dashboardService.getClassRadar();
        return success(list);
    }

    @PreAuthorize("@ss.hasPermi('study:dashboard:query')")
    @GetMapping("/courseRanking")
    public AjaxResult courseRanking()
    {
        List<CourseRankingVO> list = dashboardService.getCourseRanking();
        return success(list);
    }
}