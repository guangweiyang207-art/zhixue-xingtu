package com.ruoyi.taskmanage.mapper;

import com.ruoyi.taskmanage.domain.QuestionBank;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface MXYQuestionBankMapper {

    List<QuestionBank> selectQuestionBankList(QuestionBank questionBank);

    QuestionBank selectQuestionBankById(@Param("id") Long id);

    /** 统计未启用题库数 */
    long countPending();

    int insertQuestionBank(QuestionBank questionBank);

    int updateQuestionBank(QuestionBank questionBank);

    int deleteQuestionBankById(@Param("questionId") Long questionId);
}
