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
import com.ruoyi.userext.domain.MyStudent;
import com.ruoyi.userext.service.IMyStudentService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 学生Controller
 * 
 * @author ruoyi
 * @date 2026-05-31
 */
@RestController
@RequestMapping("/userext/myStudent")
public class MyStudentController extends BaseController
{
    @Autowired
    private IMyStudentService myStudentService;

    /**
     * 查询学生列表
     */
    @PreAuthorize("@ss.hasPermi('userext:myStudent:list')")
    @GetMapping("/list")
    public TableDataInfo list(MyStudent myStudent)
    {
        startPage();
        List<MyStudent> list = myStudentService.selectMyStudentList(myStudent);
        return getDataTable(list);
    }

    /**
     * 导出学生列表
     */
    @PreAuthorize("@ss.hasPermi('userext:myStudent:export')")
    @Log(title = "学生", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, MyStudent myStudent)
    {
        List<MyStudent> list = myStudentService.selectMyStudentList(myStudent);
        ExcelUtil<MyStudent> util = new ExcelUtil<MyStudent>(MyStudent.class);
        util.exportExcel(response, list, "学生数据");
    }

    /**
     * 获取学生详细信息
     */
    @PreAuthorize("@ss.hasPermi('userext:myStudent:query')")
    @GetMapping(value = "/{stuId}")
    public AjaxResult getInfo(@PathVariable("stuId") Long stuId)
    {
        return success(myStudentService.selectMyStudentByStuId(stuId));
    }

    /**
     * 新增学生
     */
    @PreAuthorize("@ss.hasPermi('userext:myStudent:add')")
    @Log(title = "学生", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody MyStudent myStudent)
    {
        return toAjax(myStudentService.insertMyStudent(myStudent));
    }

    /**
     * 修改学生
     */
    @PreAuthorize("@ss.hasPermi('userext:myStudent:edit')")
    @Log(title = "学生", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody MyStudent myStudent)
    {
        return toAjax(myStudentService.updateMyStudent(myStudent));
    }

    /**
     * 删除学生
     */
    @PreAuthorize("@ss.hasPermi('userext:myStudent:remove')")
    @Log(title = "学生", businessType = BusinessType.DELETE)
    @DeleteMapping("/{stuIds}")
    public AjaxResult remove(@PathVariable Long[] stuIds)
    {
        return toAjax(myStudentService.deleteMyStudentByStuIds(stuIds));
    }
}
