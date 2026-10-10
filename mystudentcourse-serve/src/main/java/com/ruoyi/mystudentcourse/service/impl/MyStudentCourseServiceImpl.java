package com.ruoyi.mystudentcourse.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.mystudentcourse.mapper.MyStudentCourseMapper;
import com.ruoyi.mystudentcourse.service.IMyStudentCourseService;

@Service
public class MyStudentCourseServiceImpl implements IMyStudentCourseService
{
    @Autowired
    private MyStudentCourseMapper myStudentCourseMapper;
}