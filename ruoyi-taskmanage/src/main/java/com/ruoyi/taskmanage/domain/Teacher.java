package com.ruoyi.taskmanage.domain;

import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 教师对象 my_teacher
 *
 * @author 马孝银
 */
@Data
@Alias("MxyTeacher")
public class Teacher implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 教师ID */
    private Long teacherId;

    /** 关联用户ID */
    private Long userId;

    /** 教师编号 */
    private String teacherNo;

    /** 院系 */
    private String department;

    /** 职称 */
    private String title;

    /** 专业方向 */
    private String specialty;

    /** 创建时间 */
    private LocalDateTime createTime;

    /** 更新时间 */
    private LocalDateTime updateTime;

    // ===== 关联展示字段(JOIN my_sys_user 写出,不入库) =====
    /** 教师真实姓名 */
    private String realName;
    /** 教师登录名 */
    private String username;
    /** 教师头像 */
    private String avatar;
}
