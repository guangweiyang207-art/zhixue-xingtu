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
import com.ruoyi.study.domain.MyGlobalReport;
import com.ruoyi.study.service.IMyGlobalReportService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 全局报表Controller
 * 
 * @author ruoyi
 * @date 2026-05-31
 */
@RestController
@RequestMapping("/study/myGlobalReport")
public class MyGlobalReportController extends BaseController
{
    @Autowired
    private IMyGlobalReportService myGlobalReportService;

    @PreAuthorize("@ss.hasPermi('study:myGlobalReport:list')")
    @GetMapping("/list")
    public TableDataInfo list(MyGlobalReport myGlobalReport)
    {
        startPage();
        List<MyGlobalReport> list = myGlobalReportService.selectMyGlobalReportList(myGlobalReport);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('study:myGlobalReport:export')")
    @Log(title = "全局报表", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, MyGlobalReport myGlobalReport)
    {
        List<MyGlobalReport> list = myGlobalReportService.selectMyGlobalReportList(myGlobalReport);
        ExcelUtil<MyGlobalReport> util = new ExcelUtil<MyGlobalReport>(MyGlobalReport.class);
        util.exportExcel(response, list, "全局报表数据");
    }

    @PreAuthorize("@ss.hasPermi('study:myGlobalReport:query')")
    @GetMapping(value = "/{grId}")
    public AjaxResult getInfo(@PathVariable("grId") Long grId)
    {
        return success(myGlobalReportService.selectMyGlobalReportByGrId(grId));
    }

    @PreAuthorize("@ss.hasPermi('study:myGlobalReport:add')")
    @Log(title = "全局报表", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody MyGlobalReport myGlobalReport)
    {
        return toAjax(myGlobalReportService.insertMyGlobalReport(myGlobalReport));
    }

    @PreAuthorize("@ss.hasPermi('study:myGlobalReport:edit')")
    @Log(title = "全局报表", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody MyGlobalReport myGlobalReport)
    {
        return toAjax(myGlobalReportService.updateMyGlobalReport(myGlobalReport));
    }

    @PreAuthorize("@ss.hasPermi('study:myGlobalReport:remove')")
    @Log(title = "全局报表", businessType = BusinessType.DELETE)
    @DeleteMapping("/{grIds}")
    public AjaxResult remove(@PathVariable Long[] grIds)
    {
        return toAjax(myGlobalReportService.deleteMyGlobalReportByGrIds(grIds));
    }
}
