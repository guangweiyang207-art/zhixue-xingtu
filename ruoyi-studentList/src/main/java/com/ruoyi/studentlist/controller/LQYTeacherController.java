package com.ruoyi.studentlist.controller;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.studentlist.domain.Teacher;
import com.ruoyi.studentlist.service.LQYITeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 教师信息Controller（纯 MyBatis）
 *
 * @author ruoyi
 */
@RestController
@RequestMapping("/mine/teacher")
public class LQYTeacherController extends BaseController
{
    @Autowired
    private LQYITeacherService lqyTeacherService;

    /**
     * 查询教师信息
     */
    @GetMapping("/info")
    public AjaxResult info()
    {
        return AjaxResult.success(lqyTeacherService.selectTeacherInfo());
    }

    /**
     * 修改教师信息
     */
    @PutMapping("/info")
    public AjaxResult edit(@RequestBody Teacher teacher)
    {
        return toAjax(lqyTeacherService.updateTeacher(teacher));
    }
}
