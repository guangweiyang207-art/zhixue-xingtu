package com.ruoyi.mystudenthomework.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.mystudenthomework.mapper.MyStudentHomeworkMapper;
import com.ruoyi.mystudenthomework.domain.MyStudentHomework;
import com.ruoyi.mystudenthomework.service.IMyStudentHomeworkService;

@Service
public class MyStudentHomeworkServiceImpl implements IMyStudentHomeworkService
{
    @Autowired
    private MyStudentHomeworkMapper myStudentHomeworkMapper;

    @Override
    public MyStudentHomework selectMyStudentHomeworkById(Long shId)
    {
        return myStudentHomeworkMapper.selectMyStudentHomeworkById(shId);
    }

    @Override
    public List<MyStudentHomework> selectMyStudentHomeworkList(MyStudentHomework myStudentHomework)
    {
        return myStudentHomeworkMapper.selectMyStudentHomeworkList(myStudentHomework);
    }

    @Override
    public int insertMyStudentHomework(MyStudentHomework myStudentHomework)
    {
        return myStudentHomeworkMapper.insertMyStudentHomework(myStudentHomework);
    }

    @Override
    public int updateMyStudentHomework(MyStudentHomework myStudentHomework)
    {
        return myStudentHomeworkMapper.updateMyStudentHomework(myStudentHomework);
    }

    @Override
    public int submitMyStudentHomework(MyStudentHomework myStudentHomework)
    {
        return myStudentHomeworkMapper.submitMyStudentHomework(myStudentHomework);
    }
}
