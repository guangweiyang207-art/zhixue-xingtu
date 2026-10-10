package com.ruoyi.taskmanage.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 学生向老师请教的问答对象 my_question_answer
 *  - 字段:id / stu_id / teacher_id / question / answer / status
 *  - status: 0-待回复 1-已回复 2-已关闭
 *  - 通用字段:create_by / update_by / remark / create_time / update_time
 *
 * @author 马孝银
 */
@Data
@Alias("MxyQuestionAnswer")
public class QuestionAnswer implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 学生ID(my_student.stu_id) */
    private Long stuId;

    /** 教师ID(my_teacher.teacher_id) */
    private Long teacherId;

    /** 学生提交的问题 */
    private String question;

    /** 老师的回复 */
    private String answer;

    /** 状态 0-待回复 1-已回复 2-已关闭 */
    private Integer status;

    /** 创建人(学生user_id) */
    private Long createBy;

    /** 更新人(老师user_id) */
    private Long updateBy;

    /** 备注 */
    private String remark;

    // ===== 关联展示字段(由 SQL JOIN 写出,不入库) =====
    /** 学生姓名(my_sys_user.real_name / username) */
    private String stuName;
    /** 学生头像(my_sys_user.avatar) */
    private String stuAvatar;
    /** 学号(my_student.student_no) */
    private String stuNo;
    /** 班级(my_student.class_name) */
    private String className;
    /** 年级 */
    private String grade;
    /** 专业 */
    private String major;
    /** 教师姓名(my_sys_user.real_name / username) */
    private String teacherName;
    /** 教师工号(my_teacher.teacher_no) */
    private String teacherNo;
    /** 教师所属院系 */
    private String department;
    /** 教师职称 */
    private String title;
    /** 教师专长 */
    private String specialty;
    /** 教师头像(my_sys_user.avatar) */
    private String teacherAvatar;

    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;

    /** 更新时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updateTime;
}
