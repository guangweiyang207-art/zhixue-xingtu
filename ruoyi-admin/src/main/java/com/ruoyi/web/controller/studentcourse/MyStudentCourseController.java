package com.ruoyi.web.controller.studentcourse;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.mystudentcourse.service.IMyStudentCourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/studentcourse/course")
public class MyStudentCourseController extends BaseController
{
    @Autowired
    private IMyStudentCourseService myStudentCourseService;
}