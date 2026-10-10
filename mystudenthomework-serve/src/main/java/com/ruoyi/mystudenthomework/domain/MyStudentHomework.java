package com.ruoyi.mystudenthomework.domain;

import com.ruoyi.common.core.domain.BaseEntity;
import java.util.Date;
import java.math.BigDecimal;

public class MyStudentHomework extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long shId;

    private Long stuId;

    private Long hwId;

    private String answers;

    private BigDecimal score;

    private String teacherComment;

    private Integer status;

    private Date submitTime;

    private Date correctTime;

    private Date createTime;

    private Date updateTime;

    public Long getShId()
    {
        return shId;
    }

    public void setShId(Long shId)
    {
        this.shId = shId;
    }

    public Long getStuId()
    {
        return stuId;
    }

    public void setStuId(Long stuId)
    {
        this.stuId = stuId;
    }

    public Long getHwId()
    {
        return hwId;
    }

    public void setHwId(Long hwId)
    {
        this.hwId = hwId;
    }

    public String getAnswers()
    {
        return answers;
    }

    public void setAnswers(String answers)
    {
        this.answers = answers;
    }

    public BigDecimal getScore()
    {
        return score;
    }

    public void setScore(BigDecimal score)
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

    public Integer getStatus()
    {
        return status;
    }

    public void setStatus(Integer status)
    {
        this.status = status;
    }

    public Date getSubmitTime()
    {
        return submitTime;
    }

    public void setSubmitTime(Date submitTime)
    {
        this.submitTime = submitTime;
    }

    public Date getCorrectTime()
    {
        return correctTime;
    }

    public void setCorrectTime(Date correctTime)
    {
        this.correctTime = correctTime;
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