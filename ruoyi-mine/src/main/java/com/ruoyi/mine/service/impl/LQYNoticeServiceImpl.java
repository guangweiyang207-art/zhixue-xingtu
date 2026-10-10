package com.ruoyi.mine.service.impl;

import com.ruoyi.mine.domain.Notice;
import com.ruoyi.mine.mapper.LQYNoticeMapper;
import com.ruoyi.mine.service.LQYINoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 消息通知Service业务层处理（纯 MyBatis）
 *
 * @author ruoyi
 */
@Service
public class LQYNoticeServiceImpl implements LQYINoticeService
{
    @Autowired
    private LQYNoticeMapper lqyNoticeMapper;

    @Override
    public List<Notice> selectNoticeList(Notice notice, Long userId)
    {
        return lqyNoticeMapper.selectNoticeList(userId);
    }

    @Override
    public boolean readNotice(Long noticeId, Long userId)
    {
        return lqyNoticeMapper.readNotice(noticeId, userId) >= 0;
    }

    @Override
    public boolean unreadNotice(Long noticeId, Long userId)
    {
        return lqyNoticeMapper.unreadNotice(noticeId, userId) > 0;
    }

    @Override
    public int selectUnreadCount(Long userId)
    {
        return lqyNoticeMapper.selectUnreadCount(userId);
    }
}
