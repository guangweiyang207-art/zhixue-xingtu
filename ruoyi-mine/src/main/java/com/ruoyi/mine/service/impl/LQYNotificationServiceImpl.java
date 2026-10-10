package com.ruoyi.mine.service.impl;

import com.ruoyi.mine.domain.Notification;
import com.ruoyi.mine.mapper.LQYNotificationMapper;
import com.ruoyi.mine.service.LQYINotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 消息通知Service业务层处理（纯 MyBatis）
 *
 * @author ruoyi
 */
@Service
public class LQYNotificationServiceImpl implements LQYINotificationService
{
    @Autowired
    private LQYNotificationMapper lqyNotificationMapper;

    @Override
    public List<Notification> selectNotificationList(Notification notification)
    {
        return lqyNotificationMapper.selectNotificationList();
    }

    @Override
    public boolean readNotice(Long notiId)
    {
        return lqyNotificationMapper.readNotice(notiId) > 0;
    }

    @Override
    public boolean unreadNotice(Long notiId)
    {
        return lqyNotificationMapper.unreadNotice(notiId) > 0;
    }

    @Override
    public int selectUnreadCount()
    {
        return lqyNotificationMapper.selectUnreadCount();
    }
}
