package com.ruoyi.userext.service;

import java.util.List;
import com.ruoyi.userext.domain.MyTeacher;

public interface IMyTeacherService 
{
    public MyTeacher selectMyTeacherByTeacherId(Long teacherId);
    public List<MyTeacher> selectMyTeacherList(MyTeacher myTeacher);
    public int insertMyTeacher(MyTeacher myTeacher);
    public int updateMyTeacher(MyTeacher myTeacher);
    public int deleteMyTeacherByTeacherIds(Long[] teacherIds);
    public int deleteMyTeacherByTeacherId(Long teacherId);
}
