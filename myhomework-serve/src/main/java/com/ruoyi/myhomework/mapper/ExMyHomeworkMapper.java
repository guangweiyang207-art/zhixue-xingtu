package com.ruoyi.myhomework.mapper;

import java.util.List;
import com.ruoyi.myhomework.domain.MyHomework;

public interface ExMyHomeworkMapper
{
    public MyHomework selectMyHomeworkById(Long hwId);

    public List<MyHomework> selectMyHomeworkList(MyHomework myHomework);

    public List<MyHomework> selectMyHomeworkByUserId(Long userId);
}
