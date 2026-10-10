package com.ruoyi.homepage.service;

import com.ruoyi.homepage.domain.TodoCount;

public interface IMXYTeacherTodoService {
    long countHomeworkTodoByTeacherId(Long teacherId);
    long countHomeworkTodoByUserId(Long userId);
    long countUnansweredQuestion(Long teacherId);
    TodoCount selectTodoCount(Long teacherId);
    TodoCount selectTodoCountByUserId(Long userId);
}
