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
import com.ruoyi.study.domain.MyStudyReport;
import com.ruoyi.study.service.IMyStudyReportService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 学情报表Controller
 * 
 * @author ruoyi
 * @date 2026-05-31
 */
@RestController
@RequestMapping("/study/myStudyReport")
public class MyStudyReportController extends BaseController
{
    @Autowired
    private IMyStudyReportService myStudyReportService;

    @PreAuthorize("@ss.hasPermi('study:myStudyReport:list')")
    @GetMapping("/list")
    public TableDataInfo list(MyStudyReport myStudyReport)
    {
        startPage();
        List<MyStudyReport> list = myStudyReportService.selectMyStudyReportList(myStudyReport);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('study:myStudyReport:export')")
    @Log(title = "学情报表", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, MyStudyReport myStudyReport)
    {
        List<MyStudyReport> list = myStudyReportService.selectMyStudyReportList(myStudyReport);
        ExcelUtil<MyStudyReport> util = new ExcelUtil<MyStudyReport>(MyStudyReport.class);
        util.exportExcel(response, list, "学情报表数据");
    }

    @PreAuthorize("@ss.hasPermi('study:myStudyReport:query')")
    @GetMapping(value = "/{reportId}")
    public AjaxResult getInfo(@PathVariable("reportId") Long reportId)
    {
        return success(myStudyReportService.selectMyStudyReportByReportId(reportId));
    }

    @PreAuthorize("@ss.hasPermi('study:myStudyReport:add')")
    @Log(title = "学情报表", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody MyStudyReport myStudyReport)
    {
        return toAjax(myStudyReportService.insertMyStudyReport(myStudyReport));
    }

    @PreAuthorize("@ss.hasPermi('study:myStudyReport:edit')")
    @Log(title = "学情报表", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody MyStudyReport myStudyReport)
    {
        return toAjax(myStudyReportService.updateMyStudyReport(myStudyReport));
    }

    @PreAuthorize("@ss.hasPermi('study:myStudyReport:remove')")
    @Log(title = "学情报表", businessType = BusinessType.DELETE)
    @DeleteMapping("/{reportIds}")
    public AjaxResult remove(@PathVariable Long[] reportIds)
    {
        return toAjax(myStudyReportService.deleteMyStudyReportByReportIds(reportIds));
    }
}
