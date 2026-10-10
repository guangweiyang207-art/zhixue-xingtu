package com.ruoyi.mine.service;

import com.ruoyi.mine.domain.Notice;

import java.util.List;

/**
 * 消息通知Service接口（纯 MyBatis）
 *
 * @author ruoyi
 */
public interface LQYINoticeService
{
    /**
     * 查询消息通知列表
     */
    List<Notice> selectNoticeList(Notice notice, Long userId);

    /**
     * 标记消息为已读
     */
    boolean readNotice(Long noticeId, Long userId);

    /**
     * 标记消息为未读
     */
    boolean unreadNotice(Long noticeId, Long userId);

    /**
     * 查询未读消息数量
     */
    int selectUnreadCount(Long userId);
}
