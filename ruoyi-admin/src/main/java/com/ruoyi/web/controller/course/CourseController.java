package com.ruoyi.web.controller.course;

import com.ruoyi.common.R;
import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.course.pojo.myCourseVo;
import com.ruoyi.course.service.ICourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Anonymous
@RestController
@RequestMapping("/course")
public class CourseController {

    @Autowired
    private ICourseService courseService;

    @GetMapping("/hot")
    public R hot() {
        List<myCourseVo> list = courseService.selectHotCourseList();
        return R.success(list);
    }

    @GetMapping("/list")
    public R list(String type) {
        List<myCourseVo> list = courseService.selectCourseList(type);
        return R.success(list);
    }

    @GetMapping("/types")
    public R types() {
        List<String> list = courseService.selectCourseTypeList();
        return R.success(list);
    }

    @GetMapping("/detail")
    public R detail(@RequestParam("c_id") Long cId) {
        myCourseVo detail = courseService.selectCourseDetail(cId);
        return R.success(detail);
    }

}