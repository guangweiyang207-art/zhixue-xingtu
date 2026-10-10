package com.ruoyi.study.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.study.mapper.MyStudyReportMapper;
import com.ruoyi.study.domain.MyStudyReport;
import com.ruoyi.study.service.IMyStudyReportService;

@Service
public class MyStudyReportServiceImpl implements IMyStudyReportService
{
    @Autowired
    private MyStudyReportMapper myStudyReportMapper;

    @Override
    public MyStudyReport selectMyStudyReportByReportId(Long reportId)
    {
        return myStudyReportMapper.selectMyStudyReportByReportId(reportId);
    }

    @Override
    public List<MyStudyReport> selectMyStudyReportList(MyStudyReport myStudyReport)
    {
        return myStudyReportMapper.selectMyStudyReportList(myStudyReport);
    }

    @Override
    public int insertMyStudyReport(MyStudyReport myStudyReport)
    {
        return myStudyReportMapper.insertMyStudyReport(myStudyReport);
    }

    @Override
    public int updateMyStudyReport(MyStudyReport myStudyReport)
    {
        return myStudyReportMapper.updateMyStudyReport(myStudyReport);
    }

    @Override
    public int deleteMyStudyReportByReportIds(Long[] reportIds)
    {
        return myStudyReportMapper.deleteMyStudyReportByReportIds(reportIds);
    }

    @Override
    public int deleteMyStudyReportByReportId(Long reportId)
    {
        return myStudyReportMapper.deleteMyStudyReportByReportId(reportId);
    }
}
