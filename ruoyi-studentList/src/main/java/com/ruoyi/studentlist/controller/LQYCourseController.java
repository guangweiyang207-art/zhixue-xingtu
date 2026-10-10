package com.ruoyi.studentlist.controller;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.studentlist.domain.Course;
import com.ruoyi.studentlist.service.LQYICourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 课程信息Controller（纯 MyBatis）
 *
 * @author ruoyi
 */
@RestController
@RequestMapping("/mine/course")
public class LQYCourseController extends BaseController
{
    @Autowired
    private LQYICourseService lqyCourseService;

    /**
     * 查询课程列表
     */
    @GetMapping("/list")
    public TableDataInfo list(Course course)
    {
        List<Course> list = lqyCourseService.selectCourseList(course);
        return getDataTable(list);
    }

    /**
     * 获取课程详细信息
     */
    @GetMapping(value = "/{cId}")
    public AjaxResult getInfo(@PathVariable Long cId)
    {
        return AjaxResult.success(lqyCourseService.selectCourseById(cId));
    }

    /**
     * 新增课程
     */
    @PostMapping
    public AjaxResult add(@RequestBody Course course)
    {
        return toAjax(lqyCourseService.insertCourse(course));
    }

    /**
     * 修改课程
     */
    @PutMapping
    public AjaxResult edit(@RequestBody Course course)
    {
        return toAjax(lqyCourseService.updateCourse(course));
    }

    /**
     * 删除课程
     */
    @DeleteMapping("/{cId}")
    public AjaxResult remove(@PathVariable Long cId)
    {
        return toAjax(lqyCourseService.deleteCourseById(cId));
    }
}
