package com.ruoyi.study.service;

import java.util.List;
import com.ruoyi.study.domain.MyStudyReport;

public interface IMyStudyReportService 
{
    public MyStudyReport selectMyStudyReportByReportId(Long reportId);
    public List<MyStudyReport> selectMyStudyReportList(MyStudyReport myStudyReport);
    public int insertMyStudyReport(MyStudyReport myStudyReport);
    public int updateMyStudyReport(MyStudyReport myStudyReport);
    public int deleteMyStudyReportByReportIds(Long[] reportIds);
    public int deleteMyStudyReportByReportId(Long reportId);
}
