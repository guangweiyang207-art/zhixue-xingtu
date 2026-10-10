package com.ruoyi.mystudyreport.mapper;

import com.ruoyi.mystudyreport.domain.MyStudyReport;

public interface ExMyStudyReportMapper
{
    public MyStudyReport selectLatestDailyReportByUserId(Long userId);
}
