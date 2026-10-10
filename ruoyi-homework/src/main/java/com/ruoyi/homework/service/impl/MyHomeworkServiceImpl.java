package com.ruoyi.homework.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.homework.mapper.MyHomeworkMapper;
import com.ruoyi.homework.domain.MyHomework;
import com.ruoyi.homework.service.IMyHomeworkService;

/**
 * 作业Service业务层处理
 * 
 * @author ruoyi
 * @date 2026-05-31
 */
@Service
public class MyHomeworkServiceImpl implements IMyHomeworkService
{
    @Autowired
    private MyHomeworkMapper myHomeworkMapper;

    @Override
    public MyHomework selectMyHomeworkByHwId(Long hwId)
    {
        return myHomeworkMapper.selectMyHomeworkByHwId(hwId);
    }

    @Override
    public List<MyHomework> selectMyHomeworkList(MyHomework myHomework)
    {
        return myHomeworkMapper.selectMyHomeworkList(myHomework);
    }

    @Override
    public int insertMyHomework(MyHomework myHomework)
    {
        return myHomeworkMapper.insertMyHomework(myHomework);
    }

    @Override
    public int updateMyHomework(MyHomework myHomework)
    {
        return myHomeworkMapper.updateMyHomework(myHomework);
    }

    @Override
    public int deleteMyHomeworkByHwIds(Long[] hwIds)
    {
        return myHomeworkMapper.deleteMyHomeworkByHwIds(hwIds);
    }

    @Override
    public int updateMyHomeworkStatusByStu(MyHomework myHomework)
    {
        return myHomeworkMapper.updateMyHomeworkStatusByStu(myHomework);
    }

    @Override
    public int updateMyHomeworkStatusByHwIdAndStuId(MyHomework myHomework)
    {
        return myHomeworkMapper.updateMyHomeworkStatusByHwIdAndStuId(myHomework);
    }

    @Override
    public int deleteMyHomeworkByHwId(Long hwId)
    {
        return myHomeworkMapper.deleteMyHomeworkByHwId(hwId);
    }
}
