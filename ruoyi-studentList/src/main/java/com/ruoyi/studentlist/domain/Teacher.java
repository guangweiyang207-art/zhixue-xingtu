package com.ruoyi.studentlist.domain;

import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 教师信息对象 my_teacher
 *
 * @author ruoyi
 */
@Data
public class Teacher implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 教师ID */
    private Long teacherId;

    /** 关联用户ID */
    private Long userId;

    /** 工号 */
    private String teacherNo;

    /** 所属院系 */
    private String department;

    /** 职称 */
    private String title;

    /** 专长领域 */
    private String specialty;

    /** 创建时间 */
    private LocalDateTime createTime;

    /** 更新时间 */
    private LocalDateTime updateTime;
}
