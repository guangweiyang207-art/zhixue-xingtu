package com.ruoyi.homepage.service.impl;

import com.ruoyi.homepage.mapper.MXYHomeNoticeMapper;
import com.ruoyi.homepage.service.IMXYHomeNoticeService;
import com.ruoyi.taskmanage.domain.Notice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MXYHomeNoticeServiceImpl implements IMXYHomeNoticeService {

    @Autowired private MXYHomeNoticeMapper mapper;

    @Override public List<Notice> selectLatestNotices(int limit) { return mapper.selectLatestNotices(limit); }

    @Override public List<Notice> selectNoticesByType(Integer noticeType, int limit) {
        return mapper.selectNoticesByType(noticeType, limit);
    }
}
