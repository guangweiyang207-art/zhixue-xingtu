package com.ruoyi.mine.controller;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.mine.domain.Notice;
import com.ruoyi.mine.service.LQYINoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 消息通知Controller（纯 MyBatis）
 *
 * @author ruoyi
 */
@RestController
@RequestMapping("/mine/notice")
public class LQYNoticeController extends BaseController
{
    @Autowired
    private LQYINoticeService lqyNoticeService;

    /**
     * 查询消息通知列表
     */
    @GetMapping("/list")
    public TableDataInfo list(Notice notice)
    {
        Long userId = getCurrentUserIdSafe();
        List<Notice> list = lqyNoticeService.selectNoticeList(notice, userId);
        return getDataTable(list);
    }

    /**
     * 标记消息为已读
     */
    @PutMapping("/read/{noticeId}")
    public AjaxResult read(@PathVariable Long noticeId)
    {
        Long userId = getCurrentUserIdSafe();
        return toAjax(lqyNoticeService.readNotice(noticeId, userId) ? 1 : 0);
    }

    /**
     * 标记消息为未读
     */
    @PutMapping("/unread/{noticeId}")
    public AjaxResult unread(@PathVariable Long noticeId)
    {
        Long userId = getCurrentUserIdSafe();
        return toAjax(lqyNoticeService.unreadNotice(noticeId, userId) ? 1 : 0);
    }

    /**
     * 查询未读消息数量
     */
    @GetMapping("/unreadCount")
    public AjaxResult unreadCount()
    {
        Long userId = getCurrentUserIdSafe();
        return AjaxResult.success(lqyNoticeService.selectUnreadCount(userId));
    }

    /**
     * 安全获取当前用户ID（未登录返回 null，service 用 0 兜底）
     */
    private Long getCurrentUserIdSafe()
    {
        try
        {
            return SecurityUtils.getUserId();
        }
        catch (Exception e)
        {
            return 0L;
        }
    }
}
