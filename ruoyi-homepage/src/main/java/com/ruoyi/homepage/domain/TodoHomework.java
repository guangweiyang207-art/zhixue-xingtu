package com.ruoyi.homepage.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 待批改作业(用于首页"我的待办"列表)
 * 数据来源:my_student_homework JOIN my_homework JOIN my_student JOIN my_sys_user
 */
@Data
public class TodoHomework implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 学生作业提交ID(sh_id) */
    private Long id;

    /** 作业ID */
    private Long hwId;

    /** 作业标题 */
    private String title;

    /** 学生ID */
    private Long stuId;

    /** 学生姓名 */
    private String studentName;

    /** 学号 */
    private String studentNo;

    /** 学生班级 */
    private String className;

    /** 提交时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date submitTime;

    /** 状态 0-未提交 1-已提交 2-已批改 */
    private Integer status;
}
