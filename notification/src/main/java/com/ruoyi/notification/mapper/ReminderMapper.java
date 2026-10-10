package com.ruoyi.notification.mapper;

import com.ruoyi.notification.pojo.ReminderAddVO;
import com.ruoyi.notification.pojo.ReminderRow;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ReminderMapper {
    List<ReminderRow> getReminders(@Param("stuId") Long stuId);
    int addReminder(@Param("stuId") Long stuId, @Param("vo") ReminderAddVO vo,
                    @Param("remindTime") String remindTime, @Param("repeatType") Integer repeatType);
    int deleteReminder(@Param("trId") Long trId);
    ReminderRow getReminderById(@Param("trId") Long trId);
    int updateReminder(@Param("trId") Long trId, @Param("vo") ReminderAddVO vo,
                       @Param("remindTime") String remindTime, @Param("repeatType") Integer repeatType);
    int countReminders(@Param("stuId") Long stuId);
}