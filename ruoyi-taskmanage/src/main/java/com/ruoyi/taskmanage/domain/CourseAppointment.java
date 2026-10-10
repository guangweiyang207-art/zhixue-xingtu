package com.ruoyi.taskmanage.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 课程预约对象 my_course_appointment
 * 表实际列:ca_id, stu_id, c_id, appointment_time, status, remark, create_time, update_time
 *
 * @author 马孝银
 */
@Data
public class CourseAppointment implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 预约ID(ca_id) */
    private Long appointmentId;

    /** 课程ID(c_id) */
    private Long courseId;

    /** 学生ID(stu_id),这里沿用userId字段名 */
    private Long userId;

    /** 预约时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime appointmentTime;

    /** 状态(0-待确认 1-已确认 2-已取消 3-已完成) */
    private Integer status;

    /** 备注 */
    private String remark;

    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;

    /** 更新时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updateTime;
}
