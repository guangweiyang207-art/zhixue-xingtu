package com.ruoyi.studentlist.controller;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.studentlist.domain.StatsExam;
import com.ruoyi.studentlist.domain.StatsHomework;
import com.ruoyi.studentlist.domain.StatsInfo;
import com.ruoyi.studentlist.domain.StatsOverview;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.math.BigDecimal;

/**
 * 教学统计Controller
 *
 * @author ruoyi
 */
@RestController
@RequestMapping("/mine/stats")
public class LQYStatsController extends BaseController {

    /**
     * 查询统计概览
     */
    @GetMapping("/overview")
    public AjaxResult overview() {
        StatsOverview overview = new StatsOverview();
        overview.setTotalPublish(128);
        overview.setMonthPublish(12);
        return AjaxResult.success(overview);
    }

    /**
     * 查询信息发布统计
     */
    @GetMapping("/info")
    public AjaxResult info() {
        StatsInfo info = new StatsInfo();
        info.setPublished(45);
        info.setDraft(3);
        info.setMonthNew(8);
        info.setReadCount(1256);
        return AjaxResult.success(info);
    }

    /**
     * 查询考试发布统计
     */
    @GetMapping("/exam")
    public AjaxResult exam() {
        StatsExam exam = new StatsExam();
        exam.setPublished(32);
        exam.setInProgress(2);
        exam.setMonthNew(4);
        exam.setParticipantCount(568);
        return AjaxResult.success(exam);
    }

    /**
     * 查询作业发布统计
     */
    @GetMapping("/homework")
    public AjaxResult homework() {
        StatsHomework homework = new StatsHomework();
        homework.setPublished(51);
        homework.setPending(12);
        homework.setMonthNew(15);
        homework.setCompleteRate(new BigDecimal("92.5"));
        return AjaxResult.success(homework);
    }
}
