package com.ruoyi.notification.pojo;

import lombok.Data;

/**
 * 前端提醒展示 VO
 */
@Data
public class ReminderVO {
    private Long trId;
    private String hour;
    private String minute;
    private String ampm;
    private String title;
    private String desc;
    private String repeat;
    private boolean enabled;
}