package com.ruoyi.homepage.service.impl;

import com.ruoyi.homepage.domain.TodoCount;
import com.ruoyi.homepage.mapper.MXYTeacherTodoMapper;
import com.ruoyi.homepage.service.IMXYTeacherTodoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MXYTeacherTodoServiceImpl implements IMXYTeacherTodoService {

    @Autowired private MXYTeacherTodoMapper mapper;

    @Override public long countHomeworkTodoByTeacherId(Long teacherId) {
        return teacherId == null ? 0L : mapper.countHomeworkTodoByTeacherId(teacherId);
    }

    @Override public long countHomeworkTodoByUserId(Long userId) {
        return userId == null ? 0L : mapper.countHomeworkTodoByUserId(userId);
    }

    @Override public long countUnansweredQuestion(Long teacherId) {
        return mapper.countUnansweredQuestion(teacherId);
    }

    @Override public TodoCount selectTodoCount(Long teacherId) {
        TodoCount t = new TodoCount();
        t.setHomeworkCount(countHomeworkTodoByTeacherId(teacherId));
        t.setQuestionCount(countUnansweredQuestion(teacherId));
        return t;
    }

    @Override public TodoCount selectTodoCountByUserId(Long userId) {
        TodoCount t = new TodoCount();
        t.setHomeworkCount(countHomeworkTodoByUserId(userId));
        t.setQuestionCount(countUnansweredQuestion(null));
        return t;
    }
}
