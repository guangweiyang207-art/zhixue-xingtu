package com.ruoyi.web.controller.course;

import java.util.List;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.course.domain.MyCourse;
import com.ruoyi.course.service.IMyCourseService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 课程Controller
 * 
 * @author ruoyi
 * @date 2026-05-31
 */
@RestController
@RequestMapping("/course/myCourse")
public class MyCourseController extends BaseController
{
    @Autowired
    private IMyCourseService myCourseService;

    /**
     * 查询课程列表
     */
    @PreAuthorize("@ss.hasPermi('course:myCourse:list')")
    @GetMapping("/list")
    public TableDataInfo list(MyCourse myCourse)
    {
        startPage();
        List<MyCourse> list = myCourseService.selectMyCourseList(myCourse);
        return getDataTable(list);
    }

    /**
     * 导出课程列表
     */
    @PreAuthorize("@ss.hasPermi('course:myCourse:export')")
    @Log(title = "课程", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, MyCourse myCourse)
    {
        List<MyCourse> list = myCourseService.selectMyCourseList(myCourse);
        ExcelUtil<MyCourse> util = new ExcelUtil<MyCourse>(MyCourse.class);
        util.exportExcel(response, list, "课程数据");
    }

    /**
     * 获取课程详细信息
     */
    @PreAuthorize("@ss.hasPermi('course:myCourse:query')")
    @GetMapping(value = "/{cId}")
    public AjaxResult getInfo(@PathVariable("cId") Long cId)
    {
        return success(myCourseService.selectMyCourseByCId(cId));
    }

    /**
     * 新增课程
     */
    @PreAuthorize("@ss.hasPermi('course:myCourse:add')")
    @Log(title = "课程", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody MyCourse myCourse)
    {
        return toAjax(myCourseService.insertMyCourse(myCourse));
    }

    /**
     * 修改课程
     */
    @PreAuthorize("@ss.hasPermi('course:myCourse:edit')")
    @Log(title = "课程", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody MyCourse myCourse)
    {
        return toAjax(myCourseService.updateMyCourse(myCourse));
    }

    /**
     * 删除课程
     */
    @PreAuthorize("@ss.hasPermi('course:myCourse:remove')")
    @Log(title = "课程", businessType = BusinessType.DELETE)
    @DeleteMapping("/{cIds}")
    public AjaxResult remove(@PathVariable Long[] cIds)
    {
        return toAjax(myCourseService.deleteMyCourseByCIds(cIds));
    }
}
