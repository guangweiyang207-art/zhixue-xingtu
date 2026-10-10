package com.ruoyi.student.pojo;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class StudyRecordRow {
    /** 记录ID */
    private Long srId;
    /** 学生ID */
    private Long stuId;
    /** 课程ID */
    private Long cId;
    /** 学习类型 1-视频 2-文档 3-做题 4-其他 */
    private Integer studyType;
    /** 学习时长(分钟) */
    private Integer studyDuration;
    /** 学习日期 */
    private String studyDate;
    /** 进度百分比 */
    private Integer progress;

    // ========== 课程信息 (from my_course) ==========
    /** 课程名称 */
    private String cName;
    /** 课程类型 */
    private String courseType;
    /** 课程标签 */
    private String courseTag;
    /** 课程难度 1-简单 2-中等 3-困难 */
    private Integer difficulty;

    // ========== 资源信息 (from my_course_resource) ==========
    /** 资源标题 */
    private String resourceTitle;
    /** 资源类型 1-视频 2-文档 3-期刊 4-讲座 */
    private Integer resourceType;

    // ========== 学生信息 (from my_student) ==========
    /** 真实姓名 */
    private String realName;
    /** 头像 */
    private String avatar;
    /** 专业/学校 */
    private String major;
    /** 年级 */
    private String grade;
    /** 班级 */
    private String className;
    /** 段位 */
    private String rankLevel;
    /** 段位积分 */
    private Integer rankScore;
    /** 总做题数 */
    private Integer totalQuestions;
    /** 正确题数 */
    private Integer correctQuestions;
    /** 学习时长 */
    private BigDecimal studyHours;

    // ========== 作业提交信息 (from my_student_homework + my_homework) ==========
    /** 作业ID */
    private Long hwId;
    /** 提交记录ID */
    private Long shId;
    /** 提交时间 */
    private LocalDateTime submitTime;
    /** 作业标题 */
    private String title;
    /** 作业内容描述 */
    private String content;
    /** 学生得分 */
    private BigDecimal studentScore;
    /** 作业总分 */
    private Integer totalScore;
    /** 作业状态 0-未提交 1-已提交 2-已批改 */
    private Integer homeworkStatus;
    /** 教师评语 */
    private String teacherComment;
    /** 批改时间 */
    private LocalDateTime correctTime;
    /** 截止时间 */
    private LocalDateTime deadline;
    /** 题目数量 */
    private Integer questionCount;
}