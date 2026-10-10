package com.ruoyi.studentlist.domain.vo;

import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 教师信息视图对象
 *
 * @author ruoyi
 */
@Data
public class TeacherVO implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 教师ID */
    private Long teacherId;

    /** 关联用户ID */
    private Long userId;

    /** 用户名/账号 */
    private String username;

    /** 真实姓名 */
    private String realName;

    /** 头像URL */
    private String avatar;

    /** 手机号 */
    private String phone;

    /** 邮箱 */
    private String email;

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
