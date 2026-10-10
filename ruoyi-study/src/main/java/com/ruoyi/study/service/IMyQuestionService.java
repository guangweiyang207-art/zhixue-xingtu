package com.ruoyi.study.service;

import java.util.List;
import com.ruoyi.study.domain.MyQuestion;

public interface IMyQuestionService 
{
    public MyQuestion selectMyQuestionByQId(Long qId);
    public List<MyQuestion> selectMyQuestionList(MyQuestion myQuestion);
    public int insertMyQuestion(MyQuestion myQuestion);
    public int updateMyQuestion(MyQuestion myQuestion);
    public int deleteMyQuestionByQIds(Long[] qIds);
    public int deleteMyQuestionByQId(Long qId);
}
