package com.ruoyi.taskmanage.service;

import com.ruoyi.taskmanage.domain.QuestionBank;
import java.util.List;

public interface IMXYQuestionBankService {
    List<QuestionBank> selectQuestionBankList(QuestionBank questionBank);
    QuestionBank selectQuestionBankById(Long questionId);
    long countPending();
    int insertQuestionBank(QuestionBank questionBank);
    int updateQuestionBank(QuestionBank questionBank);
    int deleteQuestionBankById(Long questionId);
}
