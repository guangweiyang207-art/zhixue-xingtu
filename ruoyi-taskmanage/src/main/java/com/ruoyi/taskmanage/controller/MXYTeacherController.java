package com.ruoyi.taskmanage.controller;

import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.taskmanage.domain.Teacher;
import com.ruoyi.taskmanage.service.IMXYTeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Anonymous
@RestController
@RequestMapping("/teacher")
public class MXYTeacherController extends BaseController {

    @Autowired private IMXYTeacherService service;

    @GetMapping("/list")
    public AjaxResult list(Teacher t) { return AjaxResult.success(service.selectTeacherList(t)); }

    @GetMapping("/{teacherId}")
    public AjaxResult getInfo(@PathVariable Long teacherId) { return AjaxResult.success(service.selectTeacherById(teacherId)); }

    @GetMapping("/byUser/{userId}")
    public AjaxResult getByUserId(@PathVariable Long userId) { return AjaxResult.success(service.selectTeacherByUserId(userId)); }

    @PostMapping
    public AjaxResult add(@RequestBody Teacher t) { return toAjax(service.insertTeacher(t)); }

    @PutMapping
    public AjaxResult edit(@RequestBody Teacher t) { return toAjax(service.updateTeacher(t)); }

    @DeleteMapping("/{teacherId}")
    public AjaxResult remove(@PathVariable Long teacherId) { return toAjax(service.deleteTeacherById(teacherId)); }
}


