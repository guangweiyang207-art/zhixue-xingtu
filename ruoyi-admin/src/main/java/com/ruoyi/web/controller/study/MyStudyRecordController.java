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
import com.ruoyi.study.domain.MyStudyRecord;
import com.ruoyi.study.service.IMyStudyRecordService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 学习记录Controller
 * 
 * @author ruoyi
 * @date 2026-05-31
 */
@RestController
@RequestMapping("/study/myStudyRecord")
public class MyStudyRecordController extends BaseController
{
    @Autowired
    private IMyStudyRecordService myStudyRecordService;

    @PreAuthorize("@ss.hasPermi('study:myStudyRecord:list')")
    @GetMapping("/list")
    public TableDataInfo list(MyStudyRecord myStudyRecord)
    {
        startPage();
        List<MyStudyRecord> list = myStudyRecordService.selectMyStudyRecordList(myStudyRecord);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('study:myStudyRecord:export')")
    @Log(title = "学习记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, MyStudyRecord myStudyRecord)
    {
        List<MyStudyRecord> list = myStudyRecordService.selectMyStudyRecordList(myStudyRecord);
        ExcelUtil<MyStudyRecord> util = new ExcelUtil<MyStudyRecord>(MyStudyRecord.class);
        util.exportExcel(response, list, "学习记录数据");
    }

    @PreAuthorize("@ss.hasPermi('study:myStudyRecord:query')")
    @GetMapping(value = "/{srId}")
    public AjaxResult getInfo(@PathVariable("srId") Long srId)
    {
        return success(myStudyRecordService.selectMyStudyRecordBySrId(srId));
    }

    @PreAuthorize("@ss.hasPermi('study:myStudyRecord:add')")
    @Log(title = "学习记录", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody MyStudyRecord myStudyRecord)
    {
        return toAjax(myStudyRecordService.insertMyStudyRecord(myStudyRecord));
    }

    @PreAuthorize("@ss.hasPermi('study:myStudyRecord:edit')")
    @Log(title = "学习记录", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody MyStudyRecord myStudyRecord)
    {
        return toAjax(myStudyRecordService.updateMyStudyRecord(myStudyRecord));
    }

    @PreAuthorize("@ss.hasPermi('study:myStudyRecord:remove')")
    @Log(title = "学习记录", businessType = BusinessType.DELETE)
    @DeleteMapping("/{srIds}")
    public AjaxResult remove(@PathVariable Long[] srIds)
    {
        return toAjax(myStudyRecordService.deleteMyStudyRecordBySrIds(srIds));
    }
}
