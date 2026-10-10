package com.ruoyi.study.mapper;

import java.util.List;
import com.ruoyi.study.domain.MyGlobalReport;

public interface MyGlobalReportMapper 
{
    public MyGlobalReport selectMyGlobalReportByGrId(Long grId);
    public List<MyGlobalReport> selectMyGlobalReportList(MyGlobalReport myGlobalReport);
    public int insertMyGlobalReport(MyGlobalReport myGlobalReport);
    public int updateMyGlobalReport(MyGlobalReport myGlobalReport);
    public int deleteMyGlobalReportByGrId(Long grId);
    public int deleteMyGlobalReportByGrIds(Long[] grIds);
}
