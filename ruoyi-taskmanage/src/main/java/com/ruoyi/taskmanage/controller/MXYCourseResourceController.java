package com.ruoyi.taskmanage.controller;

import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.taskmanage.domain.CourseResource;
import com.ruoyi.taskmanage.service.IMXYCourseResourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Anonymous
@RestController
@RequestMapping("/course/resource")
public class MXYCourseResourceController extends BaseController {

    @Autowired private IMXYCourseResourceService service;

    @GetMapping("/list")
    public AjaxResult list(CourseResource c) { return AjaxResult.success(service.selectCourseResourceList(c)); }

    @GetMapping("/{id}")
    public AjaxResult getInfo(@PathVariable Long id) { return AjaxResult.success(service.selectCourseResourceById(id)); }

    @PostMapping
    public AjaxResult add(@RequestBody CourseResource c) { return toAjax(service.insertCourseResource(c)); }

    @PutMapping
    public AjaxResult edit(@RequestBody CourseResource c) { return toAjax(service.updateCourseResource(c)); }

    @DeleteMapping("/{id}")
    public AjaxResult remove(@PathVariable Long id) { return toAjax(service.deleteCourseResourceById(id)); }
}


