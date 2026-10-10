package com.ruoyi.mine.service;

import com.ruoyi.mine.domain.Notification;

import java.util.List;

/**
 * 通知发布Service接口（纯 MyBatis）
 *
 * @author ruoyi
 */
public interface LQYINotificationService
{
    /**
     * 查询通知列表
     */
    List<Notification> selectNotificationList(Notification notification);

    /**
     * 标记通知为已读
     */
    boolean readNotice(Long notiId);

    /**
     * 标记通知为未读
     */
    boolean unreadNotice(Long notiId);

    /**
     * 查询未读通知数量
     */
    int selectUnreadCount();
}
