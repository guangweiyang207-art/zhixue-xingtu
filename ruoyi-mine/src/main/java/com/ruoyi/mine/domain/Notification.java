package com.ruoyi.mine.domain;

import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 消息通知对象 my_notification
 *
 * @author ruoyi
 */
@Data
public class Notification implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 通知ID */
    private Long notiId;

    /** 发送者ID */
    private Long senderId;

    /** 发送者类型 1-系统 2-教师 3-管理员 */
    private Integer senderType;

    /** 通知标题 */
    private String title;

    /** 通知内容 */
    private String content;

    /** 目标类型 1-全部 2-指定学生 3-指定班级 */
    private Integer targetType;

    /** 目标对象ID列表 */
    private String targetIds;

    /** 优先级 1-普通 2-重要 3-紧急 */
    private Integer priority;

    /** 是否置顶 0-否 1-是 */
    private Integer isTop;

    /** 状态 0-草稿 1-已发布 2-已撤回 */
    private Integer status;

    /** 发布时间 */
    private LocalDateTime publishTime;

    /** 创建时间 */
    private LocalDateTime createTime;

    /** 更新时间 */
    private LocalDateTime updateTime;
}
