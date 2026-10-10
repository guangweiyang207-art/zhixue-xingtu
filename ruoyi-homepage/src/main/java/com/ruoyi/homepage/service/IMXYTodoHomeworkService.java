package com.ruoyi.homepage.service;

import com.ruoyi.homepage.domain.TodoHomework;

import java.util.List;

public interface IMXYTodoHomeworkService {

    /** 教师待批改作业列表(默认 status=1 已提交未批改) */
    List<TodoHomework> listTodoHomework(Long teacherId);
}
