package com.ruoyi.mystudyreport.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.mystudyreport.domain.MyStudyReport;
import com.ruoyi.mystudyreport.mapper.ExMyStudyReportMapper;
import com.ruoyi.mystudyreport.service.IExMyStudyReportService;

@Service
public class ExMyStudyReportServiceImpl implements IExMyStudyReportService
{
    @Autowired
    private ExMyStudyReportMapper exMyStudyReportMapper;

    @Override
    public MyStudyReport selectLatestDailyReportByUserId(Long userId)
    {
        return exMyStudyReportMapper.selectLatestDailyReportByUserId(userId);
    }
}
