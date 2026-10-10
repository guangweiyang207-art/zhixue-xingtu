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
import com.ruoyi.study.domain.MyRankConfig;
import com.ruoyi.study.service.IMyRankConfigService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 段位配置Controller
 * 
 * @author ruoyi
 * @date 2026-05-31
 */
@RestController
@RequestMapping("/study/myRankConfig")
public class MyRankConfigController extends BaseController
{
    @Autowired
    private IMyRankConfigService myRankConfigService;

    @PreAuthorize("@ss.hasPermi('study:myRankConfig:list')")
    @GetMapping("/list")
    public TableDataInfo list(MyRankConfig myRankConfig)
    {
        startPage();
        List<MyRankConfig> list = myRankConfigService.selectMyRankConfigList(myRankConfig);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('study:myRankConfig:export')")
    @Log(title = "段位配置", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, MyRankConfig myRankConfig)
    {
        List<MyRankConfig> list = myRankConfigService.selectMyRankConfigList(myRankConfig);
        ExcelUtil<MyRankConfig> util = new ExcelUtil<MyRankConfig>(MyRankConfig.class);
        util.exportExcel(response, list, "段位配置数据");
    }

    @PreAuthorize("@ss.hasPermi('study:myRankConfig:query')")
    @GetMapping(value = "/{rankId}")
    public AjaxResult getInfo(@PathVariable("rankId") Long rankId)
    {
        return success(myRankConfigService.selectMyRankConfigByRankId(rankId));
    }

    @PreAuthorize("@ss.hasPermi('study:myRankConfig:add')")
    @Log(title = "段位配置", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody MyRankConfig myRankConfig)
    {
        return toAjax(myRankConfigService.insertMyRankConfig(myRankConfig));
    }

    @PreAuthorize("@ss.hasPermi('study:myRankConfig:edit')")
    @Log(title = "段位配置", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody MyRankConfig myRankConfig)
    {
        return toAjax(myRankConfigService.updateMyRankConfig(myRankConfig));
    }

    @PreAuthorize("@ss.hasPermi('study:myRankConfig:remove')")
    @Log(title = "段位配置", businessType = BusinessType.DELETE)
    @DeleteMapping("/{rankIds}")
    public AjaxResult remove(@PathVariable Long[] rankIds)
    {
        return toAjax(myRankConfigService.deleteMyRankConfigByRankIds(rankIds));
    }
}
