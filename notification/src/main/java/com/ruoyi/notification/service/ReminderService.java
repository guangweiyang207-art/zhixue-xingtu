package com.ruoyi.notification.service;

import com.ruoyi.notification.pojo.ReminderAddVO;
import com.ruoyi.notification.pojo.ReminderVO;

import java.util.List;

public interface ReminderService {
    List<ReminderVO> getReminders(Long stuId);
    void addReminder(Long stuId, ReminderAddVO vo);
    void deleteReminder(Long trId);
    ReminderAddVO getReminderForUpdate(Long trId);
    void updateReminder(Long trId, ReminderAddVO vo);
    int countReminders(Long stuId);
}