package com.ruoyi.taskmanage.domain;

import lombok.Data;

import java.io.Serializable;
import java.time.LocalDate;

/**
 * 教师"发布课程"请求 DTO
 * 只接收教师实际填写的字段;其余字段由后端默认注入
 *
 * 字段填法(对齐 my_course):
 * <ul>
 *   <li>cName       课程名称 — 必填</li>
 *   <li>type        课程类型 — 必填(手动填)</li>
 *   <li>tag         课程标签 — 必填(手动填)</li>
 *   <li>description 课程描述 — 必填(手动填)</li>
 *   <li>difficulty  难度     — 必填 1-简单 2-中等 3-困难</li>
 *   <li>startTime   上课时间 — 可选</li>
 * </ul>
 *
 * 不用填、由后端默认写入的字段:
 * <ul>
 *   <li>teacher_id     — 来自 SecurityUtils.getTeacherId()</li>
 *   <li>max_person     — 50</li>
 *   <li>current_person — 0</li>
 *   <li>cover_image    — null</li>
 *   <li>status         — 1(上架)</li>
 *   <li>end_time       — null</li>
 *   <li>resource_id    — null</li>
 *   <li>remark         — null</li>
 *   <li>create_time    — DB CURRENT_TIMESTAMP</li>
 *   <li>update_time    — DB 自动维护</li>
 * </ul>
 */
@Data
public class CoursePublishRequest implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 课程名称(必填) */
    private String cName;

    /** 课程类型(必填) */
    private String type;

    /** 课程标签(必填) */
    private String tag;

    /** 课程描述(必填) */
    private String description;

    /** 难度 1-简单 2-中等 3-困难(必填) */
    private Integer difficulty;

    /** 上课时间(可选,仅日期 yyyy-MM-dd) */
    private LocalDate startTime;

    /**
     * 上课时段备注(可选)
     * 例:"周三 09:00 ~ 10:30" —— 写入 my_course.remark
     */
    private String remark;
}
