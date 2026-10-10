package com.ruoyi.web.controller.notification;

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
import com.ruoyi.business.domain.MyNotification;
import com.ruoyi.business.service.IMyNotificationService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 通知模块Controller
 * 
 * @author lhl
 * @date 2026-05-31
 */
@RestController
@RequestMapping("/business/notification")
public class MyNotificationController extends BaseController
{
    @Autowired
    private IMyNotificationService myNotificationService;

    /**
     * 查询通知模块列表
     */
    @PreAuthorize("@ss.hasPermi('business:notification:list')")
    @GetMapping("/list")
    public TableDataInfo list(MyNotification myNotification)
    {
        startPage();
        List<MyNotification> list = myNotificationService.selectMyNotificationList(myNotification);
        return getDataTable(list);
    }

    /**
     * 导出通知模块列表
     */
    @PreAuthorize("@ss.hasPermi('business:notification:export')")
    @Log(title = "通知模块", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, MyNotification myNotification)
    {
        List<MyNotification> list = myNotificationService.selectMyNotificationList(myNotification);
        ExcelUtil<MyNotification> util = new ExcelUtil<MyNotification>(MyNotification.class);
        util.exportExcel(response, list, "通知模块数据");
    }

    /**
     * 获取通知模块详细信息
     */
    @PreAuthorize("@ss.hasPermi('business:notification:query')")
    @GetMapping(value = "/{notiId}")
    public AjaxResult getInfo(@PathVariable("notiId") Long notiId)
    {
        return success(myNotificationService.selectMyNotificationByNotiId(notiId));
    }

    /**
     * 新增通知模块
     */
    @PreAuthorize("@ss.hasPermi('business:notification:add')")
    @Log(title = "通知模块", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody MyNotification myNotification)
    {
        return toAjax(myNotificationService.insertMyNotification(myNotification));
    }

    /**
     * 修改通知模块
     */
    @PreAuthorize("@ss.hasPermi('business:notification:edit')")
    @Log(title = "通知模块", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody MyNotification myNotification)
    {
        return toAjax(myNotificationService.updateMyNotification(myNotification));
    }

    /**
     * 删除通知模块
     */
    @PreAuthorize("@ss.hasPermi('business:notification:remove')")
    @Log(title = "通知模块", businessType = BusinessType.DELETE)
	@DeleteMapping("/{notiIds}")
    public AjaxResult remove(@PathVariable Long[] notiIds)
    {
        return toAjax(myNotificationService.deleteMyNotificationByNotiIds(notiIds));
    }
}
