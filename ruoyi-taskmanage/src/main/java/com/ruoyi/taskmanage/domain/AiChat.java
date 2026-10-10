package com.ruoyi.taskmanage.domain;

import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * AI 聊天对象 my_ai_chat
 *
 * @author 马孝银
 */
@Data
public class AiChat implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 聊天ID */
    private Long chatId;

    /** 学生ID */
    private Long stuId;

    /** 教师ID(未回答时为 null) */
    private Long teacherId;

    /** 会话ID */
    private String sessionId;

    /** 学生问题 */
    private String question;

    /** 教师回答(未回答时为 null 或空字符串) */
    private String answer;

    /** 问题类型 */
    private Integer questionType;

    /** 是否满意(0-否 1-是) */
    private Integer isSatisfied;

    /** 创建时间 */
    private LocalDateTime createTime;
}
