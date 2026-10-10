package com.ruoyi.errorbook.pojo;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * my_error_book 表数据库映射实体类
 */
@Data
public class ErrorBookRow {
    /** 错题记录ID */
    private Long ebId;
    /** 学生ID */
    private Long stuId;
    /** 题目ID */
    private Long hqId;
    /** 课程ID */
    private Long cId;
    /** 错误答案 */
    private String wrongAnswer;
    /** 正确答案 */
    private String correctAnswer;
    /** 解析 */
    private String analysis;
    /** 标签/知识点 */
    private String tag;
    /** 错误次数 */
    private Integer errorCount;
    /** 是否已掌握 0-否 1-是 */
    private Integer isMastered;
    /** 最后错误时间 */
    private LocalDateTime lastWrongTime;
    /** 创建时间 */
    private LocalDateTime createTime;
    /** 更新时间 */
    private LocalDateTime updateTime;
    /** 课程名称（关联my_course表） */
    private String courseName;
    /** 课程类型（关联my_course表） */
    private String courseType;
}