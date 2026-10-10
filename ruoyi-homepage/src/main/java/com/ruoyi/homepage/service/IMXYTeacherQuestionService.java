package com.ruoyi.homepage.service;

import com.ruoyi.homepage.domain.TodoQuestion;

import java.util.List;

public interface IMXYTeacherQuestionService {
    List<TodoQuestion> list(Long teacherId);
    List<TodoQuestion> listReplied(Long teacherId);
    TodoQuestion detail(Long chatId);
    int  answer(Long chatId, String answer, Long teacherId);
}
