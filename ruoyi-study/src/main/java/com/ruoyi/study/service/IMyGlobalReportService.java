package com.ruoyi.study.service;

import java.util.List;
import com.ruoyi.study.domain.MyGlobalReport;

public interface IMyGlobalReportService 
{
    public MyGlobalReport selectMyGlobalReportByGrId(Long grId);
    public List<MyGlobalReport> selectMyGlobalReportList(MyGlobalReport myGlobalReport);
    public int insertMyGlobalReport(MyGlobalReport myGlobalReport);
    public int updateMyGlobalReport(MyGlobalReport myGlobalReport);
    public int deleteMyGlobalReportByGrIds(Long[] grIds);
    public int deleteMyGlobalReportByGrId(Long grId);
}
