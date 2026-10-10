package com.ruoyi.taskmanage.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 教师"我的"页面聚合信息 VO
 *  - 关联 sys_user 取姓名/头像
 *  - 关联 my_teacher 取部门/专业方向
 *  - 关联 my_course 统计授课班级
 *  - 关联 my_course_appointment 统计在读学生
 *
 * @author 马孝银
 */
@Data
public class MXYTeacherMineVO implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 教师ID */
    private Long teacherId;

    /** 姓名(来自 sys_user.nick_name,无则取 user_name) */
    private String name;

    /** 头像(来自 sys_user.avatar) */
    private String avatar;

    /** 岗位/角色名(写死"老师") */
    private String postTitle;

    /** 职称(来自 my_teacher.title) */
    private String professionTitle;

    /** 所属组/部门(来自 my_teacher.department) */
    private String groupName;

    /** 教龄(由 create_time 到当前年计算) */
    private Integer teachingYears;

    /** 授课班级数 */
    private Integer classCount;

    /** 在读学生数(去重) */
    private Integer studentCount;

    /** 账号创建时间(冗余返回,前端可显示) */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;
}
