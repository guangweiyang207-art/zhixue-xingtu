package com.ruoyi.mycourserappointment.domain;

import com.ruoyi.common.core.domain.BaseEntity;
import java.util.Date;

public class MyCourseAppointment extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long caId;

    private Long stuId;

    private Long cId;

    private Date appointmentTime;

    private Integer status;

    private String remark;

    private Date createTime;

    private Date updateTime;

    public Long getCaId()
    {
        return caId;
    }

    public void setCaId(Long caId)
    {
        this.caId = caId;
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

    public Date getAppointmentTime()
    {
        return appointmentTime;
    }

    public void setAppointmentTime(Date appointmentTime)
    {
        this.appointmentTime = appointmentTime;
    }

    public Integer getStatus()
    {
        return status;
    }

    public void setStatus(Integer status)
    {
        this.status = status;
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