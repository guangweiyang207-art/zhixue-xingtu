package com.ruoyi.myhomework.domain;

import com.ruoyi.common.core.domain.BaseEntity;
import java.util.Date;

public class MyHomework extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long hwId;

    private Long stdId;

    private Long cId;

    private Long teacherId;

    private String title;

    private String content;

    private Integer type;

    private Integer totalScore;

    private Date deadline;

    private Integer status;

    private java.math.BigDecimal score;

    private String teacherComment;

    private Date createTime;

    private Date updateTime;

    public Long getHwId()
    {
        return hwId;
    }

    public void setHwId(Long hwId)
    {
        this.hwId = hwId;
    }

    public Long getStdId()
    {
        return stdId;
    }

    public void setStdId(Long stdId)
    {
        this.stdId = stdId;
    }

    public Long getcId()
    {
        return cId;
    }

    public void setcId(Long cId)
    {
        this.cId = cId;
    }

    public Long getTeacherId()
    {
        return teacherId;
    }

    public void setTeacherId(Long teacherId)
    {
        this.teacherId = teacherId;
    }

    public String getTitle()
    {
        return title;
    }

    public void setTitle(String title)
    {
        this.title = title;
    }

    public String getContent()
    {
        return content;
    }

    public void setContent(String content)
    {
        this.content = content;
    }

    public Integer getType()
    {
        return type;
    }

    public void setType(Integer type)
    {
        this.type = type;
    }

    public Integer getTotalScore()
    {
        return totalScore;
    }

    public void setTotalScore(Integer totalScore)
    {
        this.totalScore = totalScore;
    }

    public Date getDeadline()
    {
        return deadline;
    }

    public void setDeadline(Date deadline)
    {
        this.deadline = deadline;
    }

    public Integer getStatus()
    {
        return status;
    }

    public void setStatus(Integer status)
    {
        this.status = status;
    }

    public java.math.BigDecimal getScore()
    {
        return score;
    }

    public void setScore(java.math.BigDecimal score)
    {
        this.score = score;
    }

    public String getTeacherComment()
    {
        return teacherComment;
    }

    public void setTeacherComment(String teacherComment)
    {
        this.teacherComment = teacherComment;
    }

    public Date getCreateTime()
    {
        return createTime;
    }

    public void setCreateTime(Date createTime)
    {
        this.createTime = createTime;
    }

    public Date getUpdateTime()
    {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime)
    {
        this.updateTime = updateTime;
    }
}