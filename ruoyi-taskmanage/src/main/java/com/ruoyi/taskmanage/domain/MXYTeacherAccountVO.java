package com.ruoyi.taskmanage.domain;

import lombok.Data;

import java.io.Serializable;

/**
 * 教师小程序"账号设置"页面 VO
 *  - my_sys_user 字段:username / realName / phone / email / avatar / sex / age
 *  - my_teacher  字段:teacherNo / department / title / specialty
 *
 * @author 马孝银
 */
@Data
public class MXYTeacherAccountVO implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long teacherId;
    private Long userId;

    // ===== my_sys_user =====
    /** 登录账号(只读) */
    private String username;
    /** 真实姓名 */
    private String realName;
    /** 头像URL */
    private String avatar;
    /** 性别(0-未知 1-男 2-女) */
    private Integer sex;
    /** 年龄 */
    private Integer age;
    /** 手机号 */
    private String phone;
    /** 邮箱 */
    private String email;

    // ===== my_teacher =====
    /** 工号 */
    private String teacherNo;
    /** 所属院系 */
    private String department;
    /** 职称 */
    private String title;
    /** 专长领域 */
    private String specialty;
}
