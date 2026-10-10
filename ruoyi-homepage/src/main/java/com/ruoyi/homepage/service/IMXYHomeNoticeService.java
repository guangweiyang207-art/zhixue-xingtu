package com.ruoyi.homepage.service;

import com.ruoyi.taskmanage.domain.Notice;
import java.util.List;

public interface IMXYHomeNoticeService {
    List<Notice> selectLatestNotices(int limit);
    List<Notice> selectNoticesByType(Integer noticeType, int limit);
}
