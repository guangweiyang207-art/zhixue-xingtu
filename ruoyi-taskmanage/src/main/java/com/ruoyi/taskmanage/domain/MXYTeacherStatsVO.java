package com.ruoyi.taskmanage.domain;

import lombok.Data;

import java.io.Serializable;

/**
 * 教师小程序"教学统计"页面聚合 VO
 *
 * 字段命名风格(camelCase)对齐小程序前端
 *
 * @author 马孝银
 */
@Data
public class MXYTeacherStatsVO implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 课程数(我发布的) */
    private Integer totalCourses;

    /** 学生总数(报了我课的) */
    private Integer totalStudents;

    /** 活跃学生数(近 7 天有学习/预约记录) */
    private Integer activeStudents;

    /** 作业发布总数 */
    private Integer totalHomeworks;

    /** 待批改作业数 */
    private Integer pendingHomeworks;

    /** 通知/公告发布数 */
    private Integer totalNotices;
}
