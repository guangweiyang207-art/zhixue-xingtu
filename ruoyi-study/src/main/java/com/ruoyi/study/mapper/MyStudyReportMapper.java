package com.ruoyi.study.mapper;

import java.util.List;
import com.ruoyi.study.domain.MyStudyReport;

public interface MyStudyReportMapper 
{
    public MyStudyReport selectMyStudyReportByReportId(Long reportId);
    public List<MyStudyReport> selectMyStudyReportList(MyStudyReport myStudyReport);
    public int insertMyStudyReport(MyStudyReport myStudyReport);
    public int updateMyStudyReport(MyStudyReport myStudyReport);
    public int deleteMyStudyReportByReportId(Long reportId);
    public int deleteMyStudyReportByReportIds(Long[] reportIds);
}
