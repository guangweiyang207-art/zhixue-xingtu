package com.ruoyi.studentlist.service;

import com.ruoyi.studentlist.domain.Course;

import java.util.List;

/**
 * 课程信息Service接口（纯 MyBatis）
 *
 * @author ruoyi
 */
public interface LQYICourseService
{
    /**
     * 查询课程列表
     */
    List<Course> selectCourseList(Course course);

    /**
     * 根据ID查询课程
     */
    Course selectCourseById(Long cId);

    /**
     * 新增课程
     */
    int insertCourse(Course course);

    /**
     * 修改课程
     */
    int updateCourse(Course course);

    /**
     * 删除课程
     */
    int deleteCourseById(Long cId);
}
