package com.ruoyi.taskmanage.service;

import com.ruoyi.taskmanage.domain.Notice;
import java.util.List;

public interface IMXYNoticeService {
    List<Notice> selectNoticeList(Notice notice);
    Notice selectNoticeById(Long noticeId);
    int insertNotice(Notice notice);
    int updateNotice(Notice notice);
    int deleteNoticeById(Long noticeId);
}
