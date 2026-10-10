package com.ruoyi.studentlist.service;

import com.ruoyi.studentlist.domain.Student;
import com.ruoyi.studentlist.domain.vo.StudentVO;

import java.util.List;

/**
 * 学生信息Service接口（纯 MyBatis）
 *
 * @author ruoyi
 */
public interface LQYIStudentService
{
    /**
     * 条件查询学生列表（关联用户信息和作业统计）
     */
    List<StudentVO> selectStudentList(Student student);

    /**
     * 查询所有不重复的班级列表（用于前端分类标签）
     */
    List<String> selectDistinctClassList();

    /**
     * 根据ID查询学生（关联用户信息）
     */
    StudentVO selectStudentById(Long stuId);

    /**
     * 新增学生
     */
    int insertStudent(Student student);

    /**
     * 通过学号+姓名添加学生（先在 my_sys_user 匹配用户，再检查 my_student 是否已存在）
     * @return 新插入的 stuId
     */
    Long addByStudentNoAndRealName(String studentNo, String realName);

    /**
     * 修改学生
     */
    int updateStudent(Student student);

    /**
     * 删除学生
     */
    int deleteStudentById(Long stuId);
}
