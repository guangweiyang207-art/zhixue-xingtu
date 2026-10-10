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
import com.ruoyi.study.domain.MyErrorBook;
import com.ruoyi.study.service.IMyErrorBookService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 错题本Controller
 * 
 * @author ruoyi
 * @date 2026-05-31
 */
@RestController
@RequestMapping("/study/myErrorBook")
public class MyErrorBookController extends BaseController
{
    @Autowired
    private IMyErrorBookService myErrorBookService;

    @PreAuthorize("@ss.hasPermi('study:myErrorBook:list')")
    @GetMapping("/list")
    public TableDataInfo list(MyErrorBook myErrorBook)
    {
        startPage();
        List<MyErrorBook> list = myErrorBookService.selectMyErrorBookList(myErrorBook);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('study:myErrorBook:export')")
    @Log(title = "错题本", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, MyErrorBook myErrorBook)
    {
        List<MyErrorBook> list = myErrorBookService.selectMyErrorBookList(myErrorBook);
        ExcelUtil<MyErrorBook> util = new ExcelUtil<MyErrorBook>(MyErrorBook.class);
        util.exportExcel(response, list, "错题本数据");
    }

    @PreAuthorize("@ss.hasPermi('study:myErrorBook:query')")
    @GetMapping(value = "/{ebId}")
    public AjaxResult getInfo(@PathVariable("ebId") Long ebId)
    {
        return success(myErrorBookService.selectMyErrorBookByEbId(ebId));
    }

    @PreAuthorize("@ss.hasPermi('study:myErrorBook:add')")
    @Log(title = "错题本", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody MyErrorBook myErrorBook)
    {
        return toAjax(myErrorBookService.insertMyErrorBook(myErrorBook));
    }

    @PreAuthorize("@ss.hasPermi('study:myErrorBook:edit')")
    @Log(title = "错题本", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody MyErrorBook myErrorBook)
    {
        return toAjax(myErrorBookService.updateMyErrorBook(myErrorBook));
    }

    @PreAuthorize("@ss.hasPermi('study:myErrorBook:remove')")
    @Log(title = "错题本", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ebIds}")
    public AjaxResult remove(@PathVariable Long[] ebIds)
    {
        return toAjax(myErrorBookService.deleteMyErrorBookByEbIds(ebIds));
    }
}
