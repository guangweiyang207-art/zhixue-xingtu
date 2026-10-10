package com.ruoyi.studentlist.domain.vo;

import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * 学生信息视图对象
 *
 * @author ruoyi
 */
@Data
public class StudentVO implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 学生ID */
    private Long stuId;

    /** 关联用户ID */
    private Long userId;

    /** 学号 */
    private String studentNo;

    /** 真实姓名 */
    private String realName;

    /** 头像URL */
    private String avatar;

    /** 手机号 */
    private String phone;

    /** 邮箱 */
    private String email;

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

    /** 作业完成率(%) - 后端从 my_student_homework 聚合 */
    private BigDecimal homeworkCompletion;

    /** 正确率(%) - 后端从 my_student_homework.score 平均分计算 */
    private BigDecimal accuracyRate;

    /** 活跃度 - 段位积分 / 100（前端展示用） */
    private BigDecimal activityLevel;

    /** 创建时间 */
    private LocalDateTime createTime;

    /** 更新时间 */
    private LocalDateTime updateTime;
}
