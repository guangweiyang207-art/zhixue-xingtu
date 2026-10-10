package com.ruoyi.mystudentcourse.domain;

import com.ruoyi.common.core.domain.BaseEntity;
import java.util.Date;
import java.math.BigDecimal;

public class MyStudentCourse extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long scId;

    private Long stuId;

    private Long cId;

    private Date signTime;

    private Integer status;

    private Integer progress;

    private BigDecimal score;

    private String remark;

    private Date createTime;

    private Date updateTime;

    public Long getScId()
    {
        return scId;
    }

    public void setScId(Long scId)
    {
        this.scId = scId;
    }

    public Long getStuId()
    {
        return stuId;
    }

    public void setStuId(Long stuId)
    {
        this.stuId = stuId;
    }

    public Long getcId()
    {
        return cId;
    }

    public void setcId(Long cId)
    {
        this.cId = cId;
    }

    public Date getSignTime()
    {
        return signTime;
    }

    public void setSignTime(Date signTime)
    {
        this.signTime = signTime;
    }

    public Integer getStatus()
    {
        return status;
    }

    public void setStatus(Integer status)
    {
        this.status = status;
    }

    public Integer getProgress()
    {
        return progress;
    }

    public void setProgress(Integer progress)
    {
        this.progress = progress;
    }

    public BigDecimal getScore()
    {
        return score;
    }

    public void setScore(BigDecimal score)
    {
        this.score = score;
    }

    public String getRemark()
    {
        return remark;
    }

    public void setRemark(String remark)
    {
        this.remark = remark;
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