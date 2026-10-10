package com.ruoyi.myhomework.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.myhomework.mapper.ExMyHomeworkMapper;
import com.ruoyi.myhomework.domain.MyHomework;
import com.ruoyi.myhomework.service.IExMyHomeworkService;

@Service
public class ExMyHomeworkServiceImpl implements IExMyHomeworkService
{
    @Autowired
    private ExMyHomeworkMapper exMyHomeworkMapper;

    @Override
    public MyHomework selectMyHomeworkById(Long hwId)
    {
        return exMyHomeworkMapper.selectMyHomeworkById(hwId);
    }

    @Override
    public List<MyHomework> selectMyHomeworkList(MyHomework myHomework)
    {
        return exMyHomeworkMapper.selectMyHomeworkList(myHomework);
    }

    @Override
    public List<MyHomework> selectMyHomeworkByUserId(Long userId)
    {
        return exMyHomeworkMapper.selectMyHomeworkByUserId(userId);
    }
}
