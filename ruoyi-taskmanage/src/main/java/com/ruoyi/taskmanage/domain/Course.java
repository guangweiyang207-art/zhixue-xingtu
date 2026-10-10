package com.ruoyi.taskmanage.domain;

import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 课程对象 my_course
 *
 * @author 马孝银
 */
@Data
@Alias("MxyCourse")
public class Course implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 课程ID */
    private Long cId;

    /** 课程名称 */
    private String cName;

    /** 教师ID */
    private Long teacherId;

    /** 类型 */
    private String type;

    /** 标签 */
    private String tag;

    /** 难度(1-5) */
    private Integer difficulty;

    /** 最大人数 */
    private Integer maxPerson;

    /** 当前人数 */
    private Integer currentPerson;

    /** 描述 */
    private String description;

    /** 封面图 */
    private String coverImage;

    /** 状态 */
    private Integer status;

    /** 开始时间 */
    private LocalDateTime startTime;

    /** 结束时间 */
    private LocalDateTime endTime;

    /** 资源ID */
    private Long resourceId;

    /** 备注 */
    private String remark;

    /** 创建时间 */
    private LocalDateTime createTime;

    /** 更新时间 */
    private LocalDateTime updateTime;
}
