package com.ruoyi.mystudyreport.service;

import com.ruoyi.mystudyreport.domain.MyStudyReport;

public interface IExMyStudyReportService
{
    public MyStudyReport selectLatestDailyReportByUserId(Long userId);
}
