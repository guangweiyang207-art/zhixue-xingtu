package com.ruoyi.taskmanage.service.impl;

import com.ruoyi.taskmanage.domain.QuestionBank;
import com.ruoyi.taskmanage.mapper.MXYQuestionBankMapper;
import com.ruoyi.taskmanage.service.IMXYQuestionBankService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MXYQuestionBankServiceImpl implements IMXYQuestionBankService {

    @Autowired private MXYQuestionBankMapper mapper;

    @Override public List<QuestionBank> selectQuestionBankList(QuestionBank q) { return mapper.selectQuestionBankList(q); }
    @Override public QuestionBank selectQuestionBankById(Long questionId) { return mapper.selectQuestionBankById(questionId); }
    @Override public long countPending() { return mapper.countPending(); }
    @Override public int insertQuestionBank(QuestionBank q) { return mapper.insertQuestionBank(q); }
    @Override public int updateQuestionBank(QuestionBank q) { return mapper.updateQuestionBank(q); }
    @Override public int deleteQuestionBankById(Long questionId) { return mapper.deleteQuestionBankById(questionId); }
}
