package com.ruoyi.ycourse.mapper;

import java.util.List;
import com.ruoyi.ycourse.domain.YCourse;

public interface YCourseMapper
{
    public YCourse selectYCourseById(Long cId);

    public List<YCourse> selectYCourseList(YCourse yCourse);
}