package com.ruoyi.web.controller.studyreport;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.mystudyreport.domain.MyStudyReport;
import com.ruoyi.mystudyreport.service.IExMyStudyReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/studyreport/report")
public class ExMyStudyReportController extends BaseController
{
    @Autowired
    private IExMyStudyReportService exMyStudyReportService;

    @GetMapping("/latestDaily")
    public AjaxResult latestDaily()
    {
        Long userId = SecurityUtils.getUserId();
        MyStudyReport report = exMyStudyReportService.selectLatestDailyReportByUserId(userId);
        return success(report);
    }
}
