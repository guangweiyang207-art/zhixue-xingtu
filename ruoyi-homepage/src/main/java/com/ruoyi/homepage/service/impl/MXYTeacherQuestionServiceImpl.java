package com.ruoyi.homepage.service.impl;

import com.ruoyi.homepage.domain.TodoQuestion;
import com.ruoyi.homepage.mapper.MXYTeacherQuestionMapper;
import com.ruoyi.homepage.service.IMXYTeacherQuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MXYTeacherQuestionServiceImpl implements IMXYTeacherQuestionService {

    @Autowired private MXYTeacherQuestionMapper mapper;

    @Override public List<TodoQuestion> list(Long teacherId) {
        return mapper.selectList(teacherId);
    }

    @Override public List<TodoQuestion> listReplied(Long teacherId) {
        return mapper.selectReplied(teacherId);
    }

    @Override public TodoQuestion detail(Long chatId) {
        return mapper.selectDetail(chatId);
    }

    @Override public int answer(Long chatId, String answer, Long teacherId) {
        return mapper.updateAnswer(chatId, answer, teacherId);
    }
}
