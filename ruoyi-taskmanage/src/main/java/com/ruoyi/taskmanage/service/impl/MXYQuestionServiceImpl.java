package com.ruoyi.taskmanage.service.impl;

import com.ruoyi.taskmanage.domain.Question;
import com.ruoyi.taskmanage.mapper.MXYQuestionMapper;
import com.ruoyi.taskmanage.service.IMXYQuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MXYQuestionServiceImpl implements IMXYQuestionService {

    @Autowired private MXYQuestionMapper mapper;

    @Override public List<Question> selectQuestionList(Question q) { return mapper.selectQuestionList(q); }
    @Override public Question selectQuestionById(Long qId) { return mapper.selectQuestionById(qId); }
    @Override public int insertQuestion(Question q) { return mapper.insertQuestion(q); }
    @Override public int updateQuestion(Question q) { return mapper.updateQuestion(q); }
    @Override public int deleteQuestionById(Long qId) { return mapper.deleteQuestionById(qId); }
}
