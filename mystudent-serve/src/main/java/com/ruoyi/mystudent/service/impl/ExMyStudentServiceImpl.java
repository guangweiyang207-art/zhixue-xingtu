package com.ruoyi.mystudent.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.mystudent.mapper.ExMyStudentMapper;
import com.ruoyi.mystudent.domain.MyStudent;
import com.ruoyi.mystudent.service.IExMyStudentService;

@Service
public class ExMyStudentServiceImpl implements IExMyStudentService
{
    @Autowired
    private ExMyStudentMapper exMyStudentMapper;

    @Override
    public MyStudent selectMyStudentById(Long stuId)
    {
        return exMyStudentMapper.selectMyStudentById(stuId);
    }

    @Override
    public List<MyStudent> selectMyStudentList(MyStudent myStudent)
    {
        return exMyStudentMapper.selectMyStudentList(myStudent);
    }

    @Override
    public MyStudent selectMyStudentByUserId(Long userId)
    {
        return exMyStudentMapper.selectMyStudentByUserId(userId);
    }
}
