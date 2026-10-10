package com.ruoyi.study.service;

import java.util.List;
import com.ruoyi.study.domain.MyStudyRecord;

/**
 * 学习记录Service接口
 * 
 * @author ruoyi
 * @date 2026-05-31
 */
public interface IMyStudyRecordService 
{
    public MyStudyRecord selectMyStudyRecordBySrId(Long srId);
    public List<MyStudyRecord> selectMyStudyRecordList(MyStudyRecord myStudyRecord);
    public int insertMyStudyRecord(MyStudyRecord myStudyRecord);
    public int updateMyStudyRecord(MyStudyRecord myStudyRecord);
    public int deleteMyStudyRecordBySrIds(Long[] srIds);
    public int deleteMyStudyRecordBySrId(Long srId);
}
