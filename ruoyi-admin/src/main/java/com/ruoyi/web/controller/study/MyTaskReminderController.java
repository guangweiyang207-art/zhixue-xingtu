package com.ruoyi.web.controller.study;

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
import com.ruoyi.study.domain.MyTaskReminder;
import com.ruoyi.study.service.IMyTaskReminderService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 任务提醒Controller
 * 
 * @author ruoyi
 * @date 2026-05-31
 */
@RestController
@RequestMapping("/study/myTaskReminder")
public class MyTaskReminderController extends BaseController
{
    @Autowired
    private IMyTaskReminderService myTaskReminderService;

    @PreAuthorize("@ss.hasPermi('study:myTaskReminder:list')")
    @GetMapping("/list")
    public TableDataInfo list(MyTaskReminder myTaskReminder)
    {
        startPage();
        List<MyTaskReminder> list = myTaskReminderService.selectMyTaskReminderList(myTaskReminder);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('study:myTaskReminder:export')")
    @Log(title = "任务提醒", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, MyTaskReminder myTaskReminder)
    {
        List<MyTaskReminder> list = myTaskReminderService.selectMyTaskReminderList(myTaskReminder);
        ExcelUtil<MyTaskReminder> util = new ExcelUtil<MyTaskReminder>(MyTaskReminder.class);
        util.exportExcel(response, list, "任务提醒数据");
    }

    @PreAuthorize("@ss.hasPermi('study:myTaskReminder:query')")
    @GetMapping(value = "/{trId}")
    public AjaxResult getInfo(@PathVariable("trId") Long trId)
    {
        return success(myTaskReminderService.selectMyTaskReminderByTrId(trId));
    }

    @PreAuthorize("@ss.hasPermi('study:myTaskReminder:add')")
    @Log(title = "任务提醒", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody MyTaskReminder myTaskReminder)
    {
        return toAjax(myTaskReminderService.insertMyTaskReminder(myTaskReminder));
    }

    @PreAuthorize("@ss.hasPermi('study:myTaskReminder:edit')")
    @Log(title = "任务提醒", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody MyTaskReminder myTaskReminder)
    {
        return toAjax(myTaskReminderService.updateMyTaskReminder(myTaskReminder));
    }

    @PreAuthorize("@ss.hasPermi('study:myTaskReminder:remove')")
    @Log(title = "任务提醒", businessType = BusinessType.DELETE)
    @DeleteMapping("/{trIds}")
    public AjaxResult remove(@PathVariable Long[] trIds)
    {
        return toAjax(myTaskReminderService.deleteMyTaskReminderByTrIds(trIds));
    }
}
