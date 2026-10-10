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
import com.ruoyi.study.domain.MyBank;
import com.ruoyi.study.service.IMyBankService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 题库Controller
 * 
 * @author ruoyi
 * @date 2026-05-31
 */
@RestController
@RequestMapping("/study/myBank")
public class MyBankController extends BaseController
{
    @Autowired
    private IMyBankService myBankService;

    @PreAuthorize("@ss.hasPermi('study:myBank:list')")
    @GetMapping("/list")
    public TableDataInfo list(MyBank myBank)
    {
        startPage();
        List<MyBank> list = myBankService.selectMyBankList(myBank);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('study:myBank:export')")
    @Log(title = "题库", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, MyBank myBank)
    {
        List<MyBank> list = myBankService.selectMyBankList(myBank);
        ExcelUtil<MyBank> util = new ExcelUtil<MyBank>(MyBank.class);
        util.exportExcel(response, list, "题库数据");
    }

    @PreAuthorize("@ss.hasPermi('study:myBank:query')")
    @GetMapping(value = "/{hbId}")
    public AjaxResult getInfo(@PathVariable("hbId") Long hbId)
    {
        return success(myBankService.selectMyBankByHbId(hbId));
    }

    @PreAuthorize("@ss.hasPermi('study:myBank:add')")
    @Log(title = "题库", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody MyBank myBank)
    {
        return toAjax(myBankService.insertMyBank(myBank));
    }

    @PreAuthorize("@ss.hasPermi('study:myBank:edit')")
    @Log(title = "题库", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody MyBank myBank)
    {
        return toAjax(myBankService.updateMyBank(myBank));
    }

    @PreAuthorize("@ss.hasPermi('study:myBank:remove')")
    @Log(title = "题库", businessType = BusinessType.DELETE)
    @DeleteMapping("/{hbIds}")
    public AjaxResult remove(@PathVariable Long[] hbIds)
    {
        return toAjax(myBankService.deleteMyBankByHbIds(hbIds));
    }
}
