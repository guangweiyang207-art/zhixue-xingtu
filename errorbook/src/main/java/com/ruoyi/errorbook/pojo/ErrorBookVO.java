package com.ruoyi.errorbook.pojo;

import lombok.Data;

/**
 * 错题本前端展示 VO
 */
@Data
public class ErrorBookVO {
    /** 错题记录ID */
    private Long ebId;
    /** 科目标识 math/physics/english/chemistry */
    private String subject;
    /** 科目中文名 */
    private String subjectName;
    /** 课程名称 */
    private String courseName;
    /** 题目内容（tag字段作为题目描述） */
    private String question;
    /** 错误答案 */
    private String wrongAnswer;
    /** 正确答案 */
    private String correctAnswer;
    /** 解析 */
    private String analysis;
    /** 标签 */
    private String tag;
    /** 错误次数 */
    private Integer errorCount;
    /** 是否已掌握 0-否 1-是 */
    private Integer isMastered;
    /** 最后错误时间 */
    private String date;
    /** 状态 pending-待复习 mastered-已掌握 */
    private String status;
    /** 掌握率百分比（0-100） */
    private Integer masteryRate;
}