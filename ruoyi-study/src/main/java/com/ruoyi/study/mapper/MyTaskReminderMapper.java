package com.ruoyi.study.mapper;

import java.util.List;
import com.ruoyi.study.domain.MyTaskReminder;

public interface MyTaskReminderMapper 
{
    public MyTaskReminder selectMyTaskReminderByTrId(Long trId);
    public List<MyTaskReminder> selectMyTaskReminderList(MyTaskReminder myTaskReminder);
    public int insertMyTaskReminder(MyTaskReminder myTaskReminder);
    public int updateMyTaskReminder(MyTaskReminder myTaskReminder);
    public int deleteMyTaskReminderByTrId(Long trId);
    public int deleteMyTaskReminderByTrIds(Long[] trIds);
}
