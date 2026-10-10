package com.ruoyi.notification.service.impl;

import com.ruoyi.notification.mapper.ReminderMapper;
import com.ruoyi.notification.pojo.ReminderAddVO;
import com.ruoyi.notification.pojo.ReminderRow;
import com.ruoyi.notification.pojo.ReminderVO;
import com.ruoyi.notification.service.ReminderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@Service
public class ReminderServiceImpl implements ReminderService {

    @Autowired
    private ReminderMapper reminderMapper;

    @Override
    public List<ReminderVO> getReminders(Long stuId) {
        List<ReminderRow> rows = reminderMapper.getReminders(stuId);
        List<ReminderVO> result = new ArrayList<>();

        for (ReminderRow row : rows) {
            ReminderVO vo = new ReminderVO();
            vo.setTrId(row.getTrId());

            LocalDateTime remindTime = row.getRemindTime();
            if (remindTime != null) {
                int h = remindTime.getHour();
                vo.setHour(String.format("%02d", h % 12 == 0 ? 12 : h % 12));
                vo.setMinute(String.format("%02d", remindTime.getMinute()));
                vo.setAmpm(h < 12 ? "上午" : "下午");
            } else {
                vo.setHour("00");
                vo.setMinute("00");
                vo.setAmpm("上午");
            }

            vo.setTitle(row.getTaskTitle() != null ? row.getTaskTitle() : "");
            vo.setDesc(row.getTaskContent() != null ? row.getTaskContent() : "");

            Integer repeatType = row.getRepeatType();
            if (repeatType == null || repeatType == 0) {
                vo.setRepeat("仅一次");
            } else if (repeatType == 1) {
                vo.setRepeat("每天");
            } else if (repeatType == 2) {
                vo.setRepeat("每周");
            } else if (repeatType == 3) {
                vo.setRepeat("每月");
            } else {
                vo.setRepeat("");
            }

            vo.setEnabled(row.getStatus() != null && row.getStatus() == 1);
            result.add(vo);
        }

        return result;
    }

    @Override
    @Transactional
    public void addReminder(Long stuId, ReminderAddVO vo) {
        LocalDate today = LocalDate.now();
        String[] parts = vo.getTime().split(":");
        int hour = Integer.parseInt(parts[0]);
        int minute = Integer.parseInt(parts[1]);
        LocalDateTime remindTime = LocalDateTime.of(today, LocalTime.of(hour, minute));

        int repeatType = mapRepeat(vo.getRepeat());
        reminderMapper.addReminder(stuId, vo,
                remindTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")), repeatType);
    }

    @Override
    @Transactional
    public void deleteReminder(Long trId) {
        reminderMapper.deleteReminder(trId);
    }

    @Override
    public ReminderAddVO getReminderForUpdate(Long trId) {
        ReminderRow row = reminderMapper.getReminderById(trId);
        if (row == null) return null;

        ReminderAddVO vo = new ReminderAddVO();
        vo.setTitle(row.getTaskTitle());
        vo.setDesc(row.getTaskContent());

        if (row.getRemindTime() != null) {
            vo.setTime(String.format("%02d:%02d", row.getRemindTime().getHour(), row.getRemindTime().getMinute()));
        }

        Integer repeatType = row.getRepeatType();
        if (repeatType == null || repeatType == 0) vo.setRepeat("仅一次");
        else if (repeatType == 1) vo.setRepeat("每天");
        else if (repeatType == 2) vo.setRepeat("每周");
        else if (repeatType == 3) vo.setRepeat("每月");
        else vo.setRepeat("仅一次");

        return vo;
    }

    @Override
    @Transactional
    public void updateReminder(Long trId, ReminderAddVO vo) {
        LocalDate today = LocalDate.now();
        String[] parts = vo.getTime().split(":");
        int hour = Integer.parseInt(parts[0]);
        int minute = Integer.parseInt(parts[1]);
        LocalDateTime remindTime = LocalDateTime.of(today, LocalTime.of(hour, minute));

        int repeatType = mapRepeat(vo.getRepeat());
        reminderMapper.updateReminder(trId, vo,
                remindTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")), repeatType);
    }

    @Override
    public int countReminders(Long stuId) {
        return reminderMapper.countReminders(stuId);
    }

    private int mapRepeat(String repeat) {
        switch (repeat) {
            case "每天":    return 1;
            case "周一至周五":
            case "每周":    return 2;
            case "每月":    return 3;
            default:        return 0;
        }
    }
}