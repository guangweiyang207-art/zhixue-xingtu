package com.ruoyi.study.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.study.mapper.MyTaskReminderMapper;
import com.ruoyi.study.domain.MyTaskReminder;
import com.ruoyi.study.service.IMyTaskReminderService;

@Service
public class MyTaskReminderServiceImpl implements IMyTaskReminderService
{
    @Autowired
    private MyTaskReminderMapper myTaskReminderMapper;

    @Override
    public MyTaskReminder selectMyTaskReminderByTrId(Long trId)
    {
        return myTaskReminderMapper.selectMyTaskReminderByTrId(trId);
    }

    @Override
    public List<MyTaskReminder> selectMyTaskReminderList(MyTaskReminder myTaskReminder)
    {
        return myTaskReminderMapper.selectMyTaskReminderList(myTaskReminder);
    }

    @Override
    public int insertMyTaskReminder(MyTaskReminder myTaskReminder)
    {
        return myTaskReminderMapper.insertMyTaskReminder(myTaskReminder);
    }

    @Override
    public int updateMyTaskReminder(MyTaskReminder myTaskReminder)
    {
        return myTaskReminderMapper.updateMyTaskReminder(myTaskReminder);
    }

    @Override
    public int deleteMyTaskReminderByTrIds(Long[] trIds)
    {
        return myTaskReminderMapper.deleteMyTaskReminderByTrIds(trIds);
    }

    @Override
    public int deleteMyTaskReminderByTrId(Long trId)
    {
        return myTaskReminderMapper.deleteMyTaskReminderByTrId(trId);
    }
}
