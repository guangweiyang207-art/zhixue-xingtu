package com.ruoyi.taskmanage.mapper;

import com.ruoyi.taskmanage.domain.Question;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface MXYQuestionMapper {

    List<Question> selectQuestionList(Question question);

    Question selectQuestionById(@Param("qId") Long qId);

    int insertQuestion(Question question);

    int updateQuestion(Question question);

    int deleteQuestionById(@Param("qId") Long qId);
}
