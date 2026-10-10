package com.ruoyi.ycourse.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.ycourse.mapper.YCourseMapper;
import com.ruoyi.ycourse.domain.YCourse;
import com.ruoyi.ycourse.service.IYCourseService;

@Service
public class YCourseServiceImpl implements IYCourseService
{
    @Autowired
    private YCourseMapper yCourseMapper;

    @Override
    public YCourse selectYCourseById(Long cId)
    {
        return yCourseMapper.selectYCourseById(cId);
    }

    @Override
    public List<YCourse> selectYCourseList(YCourse yCourse)
    {
        return yCourseMapper.selectYCourseList(yCourse);
    }
}