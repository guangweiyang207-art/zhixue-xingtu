package com.ruoyi.study.service;

import java.util.List;
import com.ruoyi.study.domain.MyTaskReminder;

public interface IMyTaskReminderService 
{
    public MyTaskReminder selectMyTaskReminderByTrId(Long trId);
    public List<MyTaskReminder> selectMyTaskReminderList(MyTaskReminder myTaskReminder);
    public int insertMyTaskReminder(MyTaskReminder myTaskReminder);
    public int updateMyTaskReminder(MyTaskReminder myTaskReminder);
    public int deleteMyTaskReminderByTrIds(Long[] trIds);
    public int deleteMyTaskReminderByTrId(Long trId);
}
