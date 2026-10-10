package com.ruoyi.web.controller.userext;

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
import com.ruoyi.userext.domain.MyTeacher;
import com.ruoyi.userext.service.IMyTeacherService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 教师Controller
 * 
 * @author ruoyi
 * @date 2026-05-31
 */
@RestController
@RequestMapping("/userext/myTeacher")
public class MyTeacherController extends BaseController
{
    @Autowired
    private IMyTeacherService myTeacherService;

    @PreAuthorize("@ss.hasPermi('userext:myTeacher:list')")
    @GetMapping("/list")
    public TableDataInfo list(MyTeacher myTeacher)
    {
        startPage();
        List<MyTeacher> list = myTeacherService.selectMyTeacherList(myTeacher);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('userext:myTeacher:export')")
    @Log(title = "教师", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, MyTeacher myTeacher)
    {
        List<MyTeacher> list = myTeacherService.selectMyTeacherList(myTeacher);
        ExcelUtil<MyTeacher> util = new ExcelUtil<MyTeacher>(MyTeacher.class);
        util.exportExcel(response, list, "教师数据");
    }

    @PreAuthorize("@ss.hasPermi('userext:myTeacher:query')")
    @GetMapping(value = "/{teacherId}")
    public AjaxResult getInfo(@PathVariable("teacherId") Long teacherId)
    {
        return success(myTeacherService.selectMyTeacherByTeacherId(teacherId));
    }

    @PreAuthorize("@ss.hasPermi('userext:myTeacher:add')")
    @Log(title = "教师", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody MyTeacher myTeacher)
    {
        return toAjax(myTeacherService.insertMyTeacher(myTeacher));
    }

    @PreAuthorize("@ss.hasPermi('userext:myTeacher:edit')")
    @Log(title = "教师", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody MyTeacher myTeacher)
    {
        return toAjax(myTeacherService.updateMyTeacher(myTeacher));
    }

    @PreAuthorize("@ss.hasPermi('userext:myTeacher:remove')")
    @Log(title = "教师", businessType = BusinessType.DELETE)
    @DeleteMapping("/{teacherIds}")
    public AjaxResult remove(@PathVariable Long[] teacherIds)
    {
        return toAjax(myTeacherService.deleteMyTeacherByTeacherIds(teacherIds));
    }
}
