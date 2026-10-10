package com.ruoyi.homework.mapper;

import java.util.List;
import com.ruoyi.homework.domain.MyHomework;

/**
 * 作业Mapper接口
 * 
 * @author ruoyi
 * @date 2026-05-31
 */
public interface MyHomeworkMapper 
{
    public MyHomework selectMyHomeworkByHwId(Long hwId);
    public List<MyHomework> selectMyHomeworkList(MyHomework myHomework);
    public int insertMyHomework(MyHomework myHomework);
    public int updateMyHomework(MyHomework myHomework);
    public int deleteMyHomeworkByHwId(Long hwId);
    public int deleteMyHomeworkByHwIds(Long[] hwIds);

    /**
     * 按作业ID更新 status(对应该作业的所有学生)
     * @return 受影响行数
     */
    public int updateMyHomeworkStatusByStu(MyHomework myHomework);

    /**
     * 按 (hw_id, std_id) 精确更新 status
     * @return 受影响行数
     */
    public int updateMyHomeworkStatusByHwIdAndStuId(MyHomework myHomework);
}
