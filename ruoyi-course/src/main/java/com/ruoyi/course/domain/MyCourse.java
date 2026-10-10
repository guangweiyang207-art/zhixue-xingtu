package com.ruoyi.course.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 课程对象 my_course
 * 
 * @author ruoyi
 * @date 2026-05-31
 */
public class MyCourse extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 课程ID */
    private Long cId;

    /** 课程名称 */
    @Excel(name = "课程名称")
    private String cName;

    /** 授课教师ID */
    @Excel(name = "授课教师ID")
    private Long teacherId;

    /** 课程类型 */
    @Excel(name = "课程类型")
    private String type;

    /** 课程标签 */
    @Excel(name = "课程标签")
    private String tag;

    /** 难度 1-简单 2-中等 3-困难 */
    @Excel(name = "难度", readConverterExp = "1=简单,2=中等,3=困难")
    private Long difficulty;

    /** 最大人数 */
    @Excel(name = "最大人数")
    private Long maxPerson;

    /** 课程描述 */
    @Excel(name = "课程描述")
    private String description;

    /** 封面图 */
    @Excel(name = "封面图")
    private String coverImage;

    /** 状态 0-下架 1-上架 */
    @Excel(name = "状态", readConverterExp = "0=下架,1=上架")
    private Long status;

    /** 开课时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "开课时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date startTime;

    /** 结课时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "结课时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date endTime;

    /** 授课教师姓名（关联my_teacher表） */
    @Excel(name = "授课教师")
    private String teacherName;

    /** 教师工号（关联my_teacher表） */
    @Excel(name = "教师工号")
    private String teacherNo;

    /** 当前人数（联查统计） */
    @Excel(name = "当前人数")
    private Long currentPerson;

    /** 作业数量（联查统计） */
    @Excel(name = "作业数量")
    private Integer homeworkCount;

    public void setCId(Long cId)
    {
        this.cId = cId;
    }

    public Long getCId()
    {
        return cId;
    }

    public void setCName(String cName)
    {
        this.cName = cName;
    }

    public String getCName()
    {
        return cName;
    }

    public void setTeacherId(Long teacherId)
    {
        this.teacherId = teacherId;
    }

    public Long getTeacherId()
    {
        return teacherId;
    }

    public void setType(String type)
    {
        this.type = type;
    }

    public String getType()
    {
        return type;
    }

    public void setTag(String tag)
    {
        this.tag = tag;
    }

    public String getTag()
    {
        return tag;
    }

    public void setDifficulty(Long difficulty)
    {
        this.difficulty = difficulty;
    }

    public Long getDifficulty()
    {
        return difficulty;
    }

    public void setMaxPerson(Long maxPerson)
    {
        this.maxPerson = maxPerson;
    }

    public Long getMaxPerson()
    {
        return maxPerson;
    }

    public void setDescription(String description)
    {
        this.description = description;
    }

    public String getDescription()
    {
        return description;
    }

    public void setCoverImage(String coverImage)
    {
        this.coverImage = coverImage;
    }

    public String getCoverImage()
    {
        return coverImage;
    }

    public void setStatus(Long status)
    {
        this.status = status;
    }

    public Long getStatus()
    {
        return status;
    }

    public void setStartTime(Date startTime)
    {
        this.startTime = startTime;
    }

    public Date getStartTime()
    {
        return startTime;
    }

    public void setEndTime(Date endTime)
    {
        this.endTime = endTime;
    }

    public Date getEndTime()
    {
        return endTime;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public String getTeacherNo() {
        return teacherNo;
    }

    public void setTeacherNo(String teacherNo) {
        this.teacherNo = teacherNo;
    }

    public Long getCurrentPerson() {
        return currentPerson;
    }

    public void setCurrentPerson(Long currentPerson) {
        this.currentPerson = currentPerson;
    }

    public Integer getHomeworkCount() {
        return homeworkCount;
    }

    public void setHomeworkCount(Integer homeworkCount) {
        this.homeworkCount = homeworkCount;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("cId", getCId())
            .append("cName", getCName())
            .append("teacherId", getTeacherId())
            .append("type", getType())
            .append("tag", getTag())
            .append("difficulty", getDifficulty())
            .append("maxPerson", getMaxPerson())
            .append("description", getDescription())
            .append("coverImage", getCoverImage())
            .append("status", getStatus())
            .append("startTime", getStartTime())
            .append("endTime", getEndTime())
            .append("teacherName", getTeacherName())
            .append("teacherNo", getTeacherNo())
            .append("currentPerson", getCurrentPerson())
            .append("homeworkCount", getHomeworkCount())
            .append("remark", getRemark())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
