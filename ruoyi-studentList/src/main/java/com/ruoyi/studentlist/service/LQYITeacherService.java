package com.ruoyi.studentlist.service;

import com.ruoyi.studentlist.domain.Teacher;
import com.ruoyi.studentlist.domain.vo.TeacherVO;

/**
 * 教师信息Service接口（纯 MyBatis）
 *
 * @author ruoyi
 */
public interface LQYITeacherService
{
    /**
     * 查询教师信息
     */
    TeacherVO selectTeacherInfo();

    /**
     * 修改教师
     */
    int updateTeacher(Teacher teacher);
}
