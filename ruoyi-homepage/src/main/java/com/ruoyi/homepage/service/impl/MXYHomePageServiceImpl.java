package com.ruoyi.homepage.service.impl;

import com.ruoyi.homepage.domain.TodoCount;
import com.ruoyi.homepage.service.IMXYHomeNoticeService;
import com.ruoyi.homepage.service.IMXYHomePageService;
import com.ruoyi.homepage.service.IMXYTeacherTodoService;
import com.ruoyi.taskmanage.domain.Notice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MXYHomePageServiceImpl implements IMXYHomePageService {

    @Autowired private IMXYHomeNoticeService    noticeService;
    @Autowired private IMXYTeacherTodoService   todoService;

    @Override
    public Map<String, Object> loadHomePage(Long teacherId) {
        Map<String, Object> data = new HashMap<>();
        data.put("notices",     noticeService.selectLatestNotices(5));
        data.put("todoCount",   todoService.selectTodoCount(teacherId));
        return data;
    }

    @Override public List<Notice> listLatestNotices(int limit) { return noticeService.selectLatestNotices(limit); }
    @Override public TodoCount getTodoCount(Long teacherId) { return todoService.selectTodoCount(teacherId); }
}
