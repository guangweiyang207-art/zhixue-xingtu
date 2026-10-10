package com.ruoyi.study.mapper;

import java.util.List;
import com.ruoyi.study.domain.MyQuestion;

public interface MyQuestionMapper 
{
    public MyQuestion selectMyQuestionByQId(Long qId);
    public List<MyQuestion> selectMyQuestionList(MyQuestion myQuestion);
    public int insertMyQuestion(MyQuestion myQuestion);
    public int updateMyQuestion(MyQuestion myQuestion);
    public int deleteMyQuestionByQId(Long qId);
    public int deleteMyQuestionByQIds(Long[] qIds);
}
