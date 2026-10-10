package com.ruoyi.studentlist.domain;

import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * 学生信息对象 my_student
 *
 * @author ruoyi
 */
@Data
public class Student implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 学生ID */
    private Long stuId;

    /** 搜索关键字（不存库，仅供 MyBatis 动态 SQL 过滤用） */
    private String searchValue;

    /** 关联用户ID */
    private Long userId;

    /** 学号 */
    private String studentNo;

    /** 专业 */
    private String major;

    /** 年级 */
    private String grade;

    /** 班级 */
    private String className;

    /** 生日 */
    private LocalDate birthday;

    /** 关联教师ID */
    private Long teacherId;

    /** 当前段位 */
    private String rankLevel;

    /** 段位积分 */
    private Integer rankScore;

    /** 总做题数 */
    private Integer totalQuestions;

    /** 正确题数 */
    private Integer correctQuestions;

    /** 学习时长(小时) */
    private BigDecimal studyHours;

    /** 创建时间 */
    private LocalDateTime createTime;

    /** 更新时间 */
    private LocalDateTime updateTime;
}
