package com.ruoyi.study.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.study.mapper.MyStudyRecordMapper;
import com.ruoyi.study.domain.MyStudyRecord;
import com.ruoyi.study.service.IMyStudyRecordService;

/**
 * 学习记录Service业务层处理
 * 
 * @author ruoyi
 * @date 2026-05-31
 */
@Service
public class MyStudyRecordServiceImpl implements IMyStudyRecordService
{
    @Autowired
    private MyStudyRecordMapper myStudyRecordMapper;

    @Override
    public MyStudyRecord selectMyStudyRecordBySrId(Long srId)
    {
        return myStudyRecordMapper.selectMyStudyRecordBySrId(srId);
    }

    @Override
    public List<MyStudyRecord> selectMyStudyRecordList(MyStudyRecord myStudyRecord)
    {
        return myStudyRecordMapper.selectMyStudyRecordList(myStudyRecord);
    }

    @Override
    public int insertMyStudyRecord(MyStudyRecord myStudyRecord)
    {
        return myStudyRecordMapper.insertMyStudyRecord(myStudyRecord);
    }

    @Override
    public int updateMyStudyRecord(MyStudyRecord myStudyRecord)
    {
        return myStudyRecordMapper.updateMyStudyRecord(myStudyRecord);
    }

    @Override
    public int deleteMyStudyRecordBySrIds(Long[] srIds)
    {
        return myStudyRecordMapper.deleteMyStudyRecordBySrIds(srIds);
    }

    @Override
    public int deleteMyStudyRecordBySrId(Long srId)
    {
        return myStudyRecordMapper.deleteMyStudyRecordBySrId(srId);
    }
}
