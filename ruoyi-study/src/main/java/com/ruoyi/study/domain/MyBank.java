package com.ruoyi.study.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 题库对象 my_bank
 * 
 * @author ruoyi
 * @date 2026-05-31
 */
public class MyBank extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 题库ID */
    private Long hbId;

    /** 题库名称 */
    @Excel(name = "题库名称")
    private String qbName;

    /** 题库描述 */
    @Excel(name = "题库描述")
    private String description;

    /** 题库类型 */
    @Excel(name = "题库类型")
    private String type;

    /** 标签 */
    @Excel(name = "标签")
    private String tag;

    /** 创建教师ID */
    @Excel(name = "创建教师ID")
    private Long teacherId;

    /** 难度 1-简单 2-中等 3-困难 */
    @Excel(name = "难度", readConverterExp = "1=简单,2=中等,3=困难")
    private Integer difficulty;

    /** 状态 0-禁用 1-启用 */
    @Excel(name = "状态", readConverterExp = "0=禁用,1=启用")
    private Integer status;

    /** 是否公开 0-私有 1-公开 */
    @Excel(name = "是否公开", readConverterExp = "0=私有,1=公开")
    private Integer isPublic;

    /** 教师姓名（关联my_teacher表） */
    @Excel(name = "创建教师")
    private String teacherName;

    /** 教师工号（关联my_teacher表） */
    @Excel(name = "教师工号")
    private String teacherNo;

    /** 题目数量（联查统计） */
    @Excel(name = "题目数量")
    private Integer questionCount;

    /** 总分（联查统计） */
    @Excel(name = "总分")
    private Integer totalScore;

    public void setHbId(Long hbId)
    {
        this.hbId = hbId;
    }

    public Long getHbId()
    {
        return hbId;
    }

    public void setQbName(String qbName)
    {
        this.qbName = qbName;
    }

    public String getQbName()
    {
        return qbName;
    }

    public void setDescription(String description)
    {
        this.description = description;
    }

    public String getDescription()
    {
        return description;
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

    public void setTeacherId(Long teacherId)
    {
        this.teacherId = teacherId;
    }

    public Long getTeacherId()
    {
        return teacherId;
    }

    public void setDifficulty(Integer difficulty)
    {
        this.difficulty = difficulty;
    }

    public Integer getDifficulty()
    {
        return difficulty;
    }

    public void setStatus(Integer status)
    {
        this.status = status;
    }

    public Integer getStatus()
    {
        return status;
    }

    public void setIsPublic(Integer isPublic)
    {
        this.isPublic = isPublic;
    }

    public Integer getIsPublic()
    {
        return isPublic;
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

    public Integer getQuestionCount() {
        return questionCount;
    }

    public void setQuestionCount(Integer questionCount) {
        this.questionCount = questionCount;
    }

    public Integer getTotalScore() {
        return totalScore;
    }

    public void setTotalScore(Integer totalScore) {
        this.totalScore = totalScore;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("hbId", getHbId())
            .append("qbName", getQbName())
            .append("description", getDescription())
            .append("type", getType())
            .append("tag", getTag())
            .append("teacherId", getTeacherId())
            .append("difficulty", getDifficulty())
            .append("status", getStatus())
            .append("isPublic", getIsPublic())
            .append("teacherName", getTeacherName())
            .append("teacherNo", getTeacherNo())
            .append("questionCount", getQuestionCount())
            .append("totalScore", getTotalScore())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
