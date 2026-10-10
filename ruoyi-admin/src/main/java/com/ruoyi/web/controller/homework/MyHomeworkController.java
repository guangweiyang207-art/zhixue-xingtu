package com.ruoyi.web.controller.homework;

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
import com.ruoyi.homework.domain.MyHomework;
import com.ruoyi.homework.service.IMyHomeworkService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 作业Controller
 * 
 * @author ruoyi
 * @date 2026-05-31
 */
@RestController
@RequestMapping("/homework/myHomework")
public class MyHomeworkController extends BaseController
{
    @Autowired
    private IMyHomeworkService myHomeworkService;

    @PreAuthorize("@ss.hasPermi('homework:myHomework:list')")
    @GetMapping("/list")
    public TableDataInfo list(MyHomework myHomework)
    {
        startPage();
        List<MyHomework> list = myHomeworkService.selectMyHomeworkList(myHomework);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('homework:myHomework:export')")
    @Log(title = "作业", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, MyHomework myHomework)
    {
        List<MyHomework> list = myHomeworkService.selectMyHomeworkList(myHomework);
        ExcelUtil<MyHomework> util = new ExcelUtil<MyHomework>(MyHomework.class);
        util.exportExcel(response, list, "作业数据");
    }

    @PreAuthorize("@ss.hasPermi('homework:myHomework:query')")
    @GetMapping(value = "/{hwId}")
    public AjaxResult getInfo(@PathVariable("hwId") Long hwId)
    {
        return success(myHomeworkService.selectMyHomeworkByHwId(hwId));
    }

    @PreAuthorize("@ss.hasPermi('homework:myHomework:add')")
    @Log(title = "作业", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody MyHomework myHomework)
    {
        // 老师发布作业时,默认状态 0-未提交
        if (myHomework.getStatus() == null) {
            myHomework.setStatus(0L);
        }
        return toAjax(myHomeworkService.insertMyHomework(myHomework));
    }

    @PreAuthorize("@ss.hasPermi('homework:myHomework:edit')")
    @Log(title = "作业", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody MyHomework myHomework)
    {
        return toAjax(myHomeworkService.updateMyHomework(myHomework));
    }

    @PreAuthorize("@ss.hasPermi('homework:myHomework:remove')")
    @Log(title = "作业", businessType = BusinessType.DELETE)
    @DeleteMapping("/{hwIds}")
    public AjaxResult remove(@PathVariable Long[] hwIds)
    {
        return toAjax(myHomeworkService.deleteMyHomeworkByHwIds(hwIds));
    }
}
