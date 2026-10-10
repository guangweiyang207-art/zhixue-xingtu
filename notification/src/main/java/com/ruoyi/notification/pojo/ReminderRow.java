package com.ruoyi.notification.pojo;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * my_task_reminder 表数据库映射
 */
@Data
public class ReminderRow {
    private Long trId;
    private String taskTitle;
    private String taskContent;
    private LocalDateTime remindTime;
    private Integer repeatType;
    private Integer status;
}