package com.ruoyi.homepage.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 待回答问题列表项(主页"我的待办-待回答问题"使用)
 * 数据来源:my_ai_chat JOIN my_student JOIN my_sys_user
 */
@Data
public class TodoQuestion implements Serializable {
    private static final long serialVersionUID = 1L;

    /** 对话ID */
    private Long id;
    /** 学生ID */
    private Long stuId;
    /** 学生姓名 */
    private String studentName;
    /** 学号 */
    private String studentNo;
    /** 问题内容 */
    private String question;
    /** 问题类型 1-学习 2-作业 3-其他 */
    private Integer questionType;
    /** 提问时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;
    /** 老师回复内容(已回答列表用) */
    private String answer;
}
