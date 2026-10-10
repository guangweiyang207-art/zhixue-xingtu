package com.ruoyi.studentlist.domain;

import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 课程信息对象 my_course
 *
 * @author ruoyi
 */
@Data
@Alias("LqyCourse")
public class Course implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 课程ID */
    private Long cId;

    /** 课程名称 */
    private String cName;

    /** 授课教师ID */
    private Long teacherId;

    /** 课程类型 */
    private String type;

    /** 课程标签 */
    private String tag;

    /** 难度 1-简单 2-中等 3-困难 */
    private Integer difficulty;

    /** 最大人数 */
    private Integer maxPerson;

    /** 当前人数 */
    private Integer currentPerson;

    /** 课程描述 */
    private String description;

    /** 封面图 */
    private String coverImage;

    /** 状态 0-下架 1-上架 */
    private Integer status;

    /** 开课时间 */
    private LocalDateTime startTime;

    /** 结课时间 */
    private LocalDateTime endTime;

    /** 关联资源ID */
    private Long resourceId;

    /** 备注 */
    private String remark;

    /** 创建时间 */
    private LocalDateTime createTime;

    /** 更新时间 */
    private LocalDateTime updateTime;
}
