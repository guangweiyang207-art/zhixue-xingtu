package com.ruoyi.homepage.service;

import com.ruoyi.homepage.domain.TodoCount;
import com.ruoyi.taskmanage.domain.Notice;

import java.util.List;
import java.util.Map;

/**
 * 主页聚合 Service
 *
 * @author 马孝银
 */
public interface IMXYHomePageService {

    /** 一次拉取主页首屏的所有数据 */
    Map<String, Object> loadHomePage(Long teacherId);

    /** 仅最近通知 */
    List<Notice> listLatestNotices(int limit);

    /** 仅待办统计 */
    TodoCount getTodoCount(Long teacherId);
}
