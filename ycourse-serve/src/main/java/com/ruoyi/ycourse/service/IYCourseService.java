package com.ruoyi.ycourse.service;

import java.util.List;
import com.ruoyi.ycourse.domain.YCourse;

public interface IYCourseService
{
    public YCourse selectYCourseById(Long cId);

    public List<YCourse> selectYCourseList(YCourse yCourse);
}