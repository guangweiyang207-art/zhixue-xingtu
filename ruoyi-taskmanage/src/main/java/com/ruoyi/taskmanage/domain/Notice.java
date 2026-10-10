package com.ruoyi.taskmanage.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 系统通知对象 my_notification
 * 表实际列:noti_id, sender_id, sender_type, title, content, target_type, target_ids,
 * priority, is_top, status, publish_time, create_time, update_time
 *
 * @author 马孝银
 */
@Data
@Alias("MxyNotice")
public class Notice implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 通知ID(noti_id) */
    private Long noticeId;

    /** 通知标题(title) */
    private String noticeTitle;

    /** 通知内容(content) */
    private String noticeContent;

    /** 通知类型/优先级(priority 1-普通 2-重要 3-紧急) */
    private Integer noticeType;

    /** 创建人ID(sender_id) */
    private Long createBy;

    /** 创建人姓名(由发送者user_id LEFT JOIN得到) */
    private String createByName;

    /** 状态(0-草稿 1-已发布 2-已撤回) */
    private Integer status;

    /** 发布时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime publishTime;

    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;

    /** 更新时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updateTime;
}
