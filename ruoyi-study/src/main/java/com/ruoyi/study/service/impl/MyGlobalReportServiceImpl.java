package com.ruoyi.study.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.study.mapper.MyGlobalReportMapper;
import com.ruoyi.study.domain.MyGlobalReport;
import com.ruoyi.study.service.IMyGlobalReportService;

@Service
public class MyGlobalReportServiceImpl implements IMyGlobalReportService
{
    @Autowired
    private MyGlobalReportMapper myGlobalReportMapper;

    @Override
    public MyGlobalReport selectMyGlobalReportByGrId(Long grId)
    {
        return myGlobalReportMapper.selectMyGlobalReportByGrId(grId);
    }

    @Override
    public List<MyGlobalReport> selectMyGlobalReportList(MyGlobalReport myGlobalReport)
    {
        return myGlobalReportMapper.selectMyGlobalReportList(myGlobalReport);
    }

    @Override
    public int insertMyGlobalReport(MyGlobalReport myGlobalReport)
    {
        return myGlobalReportMapper.insertMyGlobalReport(myGlobalReport);
    }

    @Override
    public int updateMyGlobalReport(MyGlobalReport myGlobalReport)
    {
        return myGlobalReportMapper.updateMyGlobalReport(myGlobalReport);
    }

    @Override
    public int deleteMyGlobalReportByGrIds(Long[] grIds)
    {
        return myGlobalReportMapper.deleteMyGlobalReportByGrIds(grIds);
    }

    @Override
    public int deleteMyGlobalReportByGrId(Long grId)
    {
        return myGlobalReportMapper.deleteMyGlobalReportByGrId(grId);
    }
}
