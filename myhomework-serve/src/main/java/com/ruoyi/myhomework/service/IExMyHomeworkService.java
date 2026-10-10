package com.ruoyi.myhomework.service;

import java.util.List;
import com.ruoyi.myhomework.domain.MyHomework;

public interface IExMyHomeworkService
{
    public MyHomework selectMyHomeworkById(Long hwId);

    public List<MyHomework> selectMyHomeworkList(MyHomework myHomework);

    public List<MyHomework> selectMyHomeworkByUserId(Long userId);
}
