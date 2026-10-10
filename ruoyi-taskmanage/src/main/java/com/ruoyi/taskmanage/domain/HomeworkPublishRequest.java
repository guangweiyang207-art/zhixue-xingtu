package com.ruoyi.taskmanage.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDate;

/**
 * 教师"发布作业"请求 DTO
 * 只接收教师实际填写的字段;其余字段由后端默认注入
 *
 * 字段填法(对齐 my_homework):
 * <ul>
 *   <li>title       作业标题 — 必填</li>
 *   <li>content     作业内容 — 必填</li>
 *   <li>courseId    所属课程 — 必填(写入 c_id)</li>
 *   <li>className   班级     — 必填(按班级自动派发到所在班级所有学生)</li>
 *   <li>type        作业类型 — 必填 1-客观题 2-主观题 3-混合</li>
 *   <li>totalScore  总分     — 可选(默认 100)</li>
 *   <li>deadline    截止时间 — 必填(仅日期 yyyy-MM-dd)</li>
 * </ul>
 *
 * 不用填、由后端默认写入的字段(my_homework):
 * <ul>
 *   <li>hw_id       — AUTO_INCREMENT</li>
 *   <li>std_id      — null(作业面向整个班级,具体学生由 my_student_homework 关联)</li>
 *   <li>teacher_id  — 来自 SecurityUtils.getTeacherId()</li>
 *   <li>status      — 1(已发布)</li>
 *   <li>create_time / update_time — DB CURRENT_TIMESTAMP</li>
 * </ul>
 *
 * 联动写入:按 class_name 查 my_student 拿到该班所有 stu_id,逐条插入 my_student_homework(status=0 未提交)
 */
@Data
public class HomeworkPublishRequest implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 作业标题(必填) */
    private String title;

    /** 作业内容(必填) */
    private String content;

    /** 所属课程ID(必填) */
    private Long courseId;

    /** 班级名称(必填,如 计科1班) */
    private String className;

    /** 作业类型 1-客观题 2-主观题 3-混合(必填) */
    private Integer type;

    /** 总分(可选,默认 100) */
    private Integer totalScore;

    /** 截止时间(必填,仅日期 yyyy-MM-dd) */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate deadline;
}
