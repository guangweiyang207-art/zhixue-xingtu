package com.ruoyi.mine.domain;

import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 消息通知对象 my_notice
 *
 * @author ruoyi
 */
@Data
public class Notice implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 消息ID */
    private Long id;

    /** 消息标题 */
    private String title;

    /** 消息摘要 */
    private String summary;

    /** 消息内容 */
    private String content;

    /** 消息类型 */
    private String type;

    /** 是否已读 */
    private Integer isRead;

    /** 创建时间 */
    private LocalDateTime createTime;

    /** 更新时间 */
    private LocalDateTime updateTime;
}
