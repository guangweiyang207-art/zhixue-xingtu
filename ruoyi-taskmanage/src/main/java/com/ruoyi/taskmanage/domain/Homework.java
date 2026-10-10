package com.ruoyi.taskmanage.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 作业对象 my_homework
 * 表实际列:hw_id, std_id, c_id, teacher_id, title, content, type, total_score, deadline, status, create_time, update_time
 *
 * @author 马孝银
 */
@Data
@Alias("MxyHomework")
public class Homework implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 作业ID(hw_id) */
    private Long homeworkId;

    /** 作业标题(title) */
    private String homeworkName;

    /** 关联学生ID(std_id) */
    private Long stdId;

    /** 课程ID(c_id) */
    private Long courseId;

    /** 教师ID(teacher_id) */
    private Long teacherId;

    /** 作业内容(content) */
    private String content;

    /** 作业类型(type 1-客观题 2-主观题 3-混合) */
    private Integer type;

    /** 总分(total_score) */
    private Integer totalScore;

    /** 截止时间(deadline) */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime deadline;

    /** 状态(0-未发布 1-已发布 2-已批改) */
    private Integer status;

    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;

    /** 更新时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updateTime;

    /** 备注(表内无此列,兼容保留) */
    private String remark;
}
