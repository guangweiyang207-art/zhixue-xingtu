package com.ruoyi.taskmanage.service.impl;

import com.ruoyi.taskmanage.domain.Notice;
import com.ruoyi.taskmanage.mapper.MXYNoticeMapper;
import com.ruoyi.taskmanage.service.IMXYNoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MXYNoticeServiceImpl implements IMXYNoticeService {

    @Autowired private MXYNoticeMapper mapper;

    @Override public List<Notice> selectNoticeList(Notice n) { return mapper.selectNoticeList(n); }
    @Override public Notice selectNoticeById(Long noticeId) { return mapper.selectNoticeById(noticeId); }
    @Override public int insertNotice(Notice n) { return mapper.insertNotice(n); }
    @Override public int updateNotice(Notice n) { return mapper.updateNotice(n); }
    @Override public int deleteNoticeById(Long noticeId) { return mapper.deleteNoticeById(noticeId); }
}
