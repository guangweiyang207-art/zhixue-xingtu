package com.ruoyi.taskmanage.service;

import com.ruoyi.taskmanage.domain.Question;
import java.util.List;

public interface IMXYQuestionService {
    List<Question> selectQuestionList(Question question);
    Question selectQuestionById(Long qId);
    int insertQuestion(Question question);
    int updateQuestion(Question question);
    int deleteQuestionById(Long qId);
}
