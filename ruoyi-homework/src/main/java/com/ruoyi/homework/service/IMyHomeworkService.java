package com.ruoyi.homework.service;

import java.util.List;
import com.ruoyi.homework.domain.MyHomework;

/**
 * 作业Service接口
 * 
 * @author ruoyi
 * @date 2026-05-31
 */
public interface IMyHomeworkService 
{
    public MyHomework selectMyHomeworkByHwId(Long hwId);
    public List<MyHomework> selectMyHomeworkList(MyHomework myHomework);
    public int insertMyHomework(MyHomework myHomework);
    public int updateMyHomework(MyHomework myHomework);
    public int deleteMyHomeworkByHwIds(Long[] hwIds);
    public int deleteMyHomeworkByHwId(Long hwId);

    /**
     * 按作业ID更新 status
     */
    public int updateMyHomeworkStatusByStu(MyHomework myHomework);

    /**
     * 按 (hw_id, std_id) 精确更新 status
     */
    public int updateMyHomeworkStatusByHwIdAndStuId(MyHomework myHomework);
}
