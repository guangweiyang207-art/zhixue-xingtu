package com.ruoyi.studentlist.service.impl;

import com.ruoyi.studentlist.domain.Course;
import com.ruoyi.studentlist.mapper.LQYCourseMapper;
import com.ruoyi.studentlist.service.LQYICourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 课程信息Service业务层处理（纯 MyBatis）
 *
 * @author ruoyi
 */
@Service
public class LQYCourseServiceImpl implements LQYICourseService
{
    @Autowired
    private LQYCourseMapper lqyCourseMapper;

    @Override
    public List<Course> selectCourseList(Course course)
    {
        return lqyCourseMapper.selectCourseList();
    }

    @Override
    public Course selectCourseById(Long cId)
    {
        return lqyCourseMapper.selectCourseById(cId);
    }

    @Override
    public int insertCourse(Course course)
    {
        return lqyCourseMapper.insertCourse(course);
    }

    @Override
    public int updateCourse(Course course)
    {
        return lqyCourseMapper.updateCourse(course);
    }

    @Override
    public int deleteCourseById(Long cId)
    {
        return lqyCourseMapper.deleteCourseById(cId);
    }
}
