package com.ruoyi.notification.pojo;

import lombok.Data;

/**
 * 添加提醒请求体 VO
 */
@Data
public class ReminderAddVO {
    private String title;
    private String desc;
    private String time;
    private String repeat;
}