package com.ruoyi.taskmanage.service.impl;

import com.ruoyi.taskmanage.domain.QuestionAnswer;
import com.ruoyi.taskmanage.mapper.MXYQuestionAnswerMapper;
import com.ruoyi.taskmanage.service.IMXYQuestionAnswerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MXYQuestionAnswerServiceImpl implements IMXYQuestionAnswerService {

    @Autowired private MXYQuestionAnswerMapper mapper;

    @Override public List<QuestionAnswer> selectQaList(QuestionAnswer qa) { return mapper.selectQaList(qa); }
    @Override public QuestionAnswer selectQaById(Long id) { return mapper.selectQaById(id); }
    @Override public int insertQa(QuestionAnswer qa) { return mapper.insertQa(qa); }
    @Override public int answerQa(QuestionAnswer qa) { return mapper.answerQa(qa); }
    @Override public int updateQa(QuestionAnswer qa) { return mapper.updateQa(qa); }
    @Override public int deleteQaById(Long id) { return mapper.deleteQaById(id); }
}
