package com.ruoyi.mine.controller;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.mine.domain.Notification;
import com.ruoyi.mine.service.LQYINotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 通知发布Controller（纯 MyBatis）
 *
 * @author ruoyi
 */
@RestController
@RequestMapping("/mine/notification")
public class LQYNotificationController extends BaseController
{
    @Autowired
    private LQYINotificationService lqyNotificationService;

    /**
     * 查询通知列表
     */
    @GetMapping("/list")
    public TableDataInfo list(Notification notification)
    {
        List<Notification> list = lqyNotificationService.selectNotificationList(notification);
        return getDataTable(list);
    }

    /**
     * 标记通知为已读
     */
    @PutMapping("/read/{notiId}")
    public AjaxResult read(@PathVariable Long notiId)
    {
        return toAjax(lqyNotificationService.readNotice(notiId));
    }

    /**
     * 标记通知为未读
     */
    @PutMapping("/unread/{notiId}")
    public AjaxResult unread(@PathVariable Long notiId)
    {
        return toAjax(lqyNotificationService.unreadNotice(notiId));
    }

    /**
     * 查询未读通知数量
     */
    @GetMapping("/unreadCount")
    public AjaxResult unreadCount()
    {
        return AjaxResult.success(lqyNotificationService.selectUnreadCount());
    }
}
