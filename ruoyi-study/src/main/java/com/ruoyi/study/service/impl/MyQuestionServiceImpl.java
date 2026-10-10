package com.ruoyi.study.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.study.mapper.MyQuestionMapper;
import com.ruoyi.study.domain.MyQuestion;
import com.ruoyi.study.service.IMyQuestionService;

@Service
public class MyQuestionServiceImpl implements IMyQuestionService
{
    @Autowired
    private MyQuestionMapper myQuestionMapper;

    @Override
    public MyQuestion selectMyQuestionByQId(Long qId)
    {
        return myQuestionMapper.selectMyQuestionByQId(qId);
    }

    @Override
    public List<MyQuestion> selectMyQuestionList(MyQuestion myQuestion)
    {
        return myQuestionMapper.selectMyQuestionList(myQuestion);
    }

    @Override
    public int insertMyQuestion(MyQuestion myQuestion)
    {
        return myQuestionMapper.insertMyQuestion(myQuestion);
    }

    @Override
    public int updateMyQuestion(MyQuestion myQuestion)
    {
        return myQuestionMapper.updateMyQuestion(myQuestion);
    }

    @Override
    public int deleteMyQuestionByQIds(Long[] qIds)
    {
        return myQuestionMapper.deleteMyQuestionByQIds(qIds);
    }

    @Override
    public int deleteMyQuestionByQId(Long qId)
    {
        return myQuestionMapper.deleteMyQuestionByQId(qId);
    }
}
