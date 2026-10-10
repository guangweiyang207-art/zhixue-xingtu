package com.ruoyi.taskmanage.controller;

import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.taskmanage.domain.Course;
import com.ruoyi.taskmanage.domain.CoursePublishRequest;
import com.ruoyi.taskmanage.service.IMXYCourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Anonymous
@RestController
@RequestMapping("/mxy/course")
public class MXYCourseController extends BaseController {

    @Autowired private IMXYCourseService courseService;

    @GetMapping("/list")
    public AjaxResult list(Course course) { return AjaxResult.success(courseService.selectCourseList(course)); }

    @GetMapping("/{cId}")
    public AjaxResult getInfo(@PathVariable Long cId) { return AjaxResult.success(courseService.selectCourseById(cId)); }

    /**
     * 教师"发布课程"专用接口(推荐小程序使用)
     * 入参只需 课程名称 / 班级 / 上课时间;其余字段后端自动注入
     */
    @PostMapping("/publish")
    public AjaxResult publish(@RequestBody CoursePublishRequest req) {
        Long cId = courseService.publish(req);
        return cId != null
                ? AjaxResult.success("发布成功").put("cId", cId)
                : AjaxResult.error("发布失败");
    }

    @PostMapping
    public AjaxResult add(@RequestBody Course course) {
        // 教师登录后 token 中带 teacher_id,自动写入发布人
        if (course.getTeacherId() == null) {
            course.setTeacherId(SecurityUtils.getTeacherId());
        }
        return toAjax(courseService.insertCourse(course));
    }

    @PutMapping
    public AjaxResult edit(@RequestBody Course course) {
        if (course.getTeacherId() == null) {
            course.setTeacherId(SecurityUtils.getTeacherId());
        }
        return toAjax(courseService.updateCourse(course));
    }

    @DeleteMapping("/{cId}")
    public AjaxResult remove(@PathVariable Long cId) { return toAjax(courseService.deleteCourseById(cId)); }
}


