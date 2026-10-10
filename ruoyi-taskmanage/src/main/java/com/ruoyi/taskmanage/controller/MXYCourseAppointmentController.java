package com.ruoyi.taskmanage.controller;

import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.taskmanage.domain.CourseAppointment;
import com.ruoyi.taskmanage.service.IMXYCourseAppointmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Anonymous
@RestController
@RequestMapping("/course/appointment")
public class MXYCourseAppointmentController extends BaseController {

    @Autowired private IMXYCourseAppointmentService service;

    @GetMapping("/list")
    public AjaxResult list(CourseAppointment c) { return AjaxResult.success(service.selectCourseAppointmentList(c)); }

    @GetMapping("/{id}")
    public AjaxResult getInfo(@PathVariable Long id) { return AjaxResult.success(service.selectCourseAppointmentById(id)); }

    @PostMapping
    public AjaxResult add(@RequestBody CourseAppointment c) { return toAjax(service.insertCourseAppointment(c)); }

    @PutMapping
    public AjaxResult edit(@RequestBody CourseAppointment c) { return toAjax(service.updateCourseAppointment(c)); }

    @DeleteMapping("/{id}")
    public AjaxResult remove(@PathVariable Long id) { return toAjax(service.deleteCourseAppointmentById(id)); }
}


