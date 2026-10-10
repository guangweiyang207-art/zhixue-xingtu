package com.ruoyi.mystudenthomework.service;

import java.util.List;
import com.ruoyi.mystudenthomework.domain.MyStudentHomework;

public interface IMyStudentHomeworkService
{
    public MyStudentHomework selectMyStudentHomeworkById(Long shId);

    public List<MyStudentHomework> selectMyStudentHomeworkList(MyStudentHomework myStudentHomework);

    public int insertMyStudentHomework(MyStudentHomework myStudentHomework);

    public int updateMyStudentHomework(MyStudentHomework myStudentHomework);

    /**
     * 提交作业专用:按 (stu_id, hw_id) 强写 status=1 等关键字段
     * @return 受影响行数,0 表示没有匹配记录
     */
    public int submitMyStudentHomework(MyStudentHomework myStudentHomework);
}
