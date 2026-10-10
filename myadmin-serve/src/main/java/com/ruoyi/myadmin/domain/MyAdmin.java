package com.ruoyi.myadmin.domain;

import com.ruoyi.common.core.domain.BaseEntity;
import java.util.Date;

public class MyAdmin extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long adminId;

    private Long userId;

    private String adminNo;

    private String role;

    private Date createTime;

    public Long getAdminId()
    {
        return adminId;
    }

    public void setAdminId(Long adminId)
    {
        this.adminId = adminId;
    }

    public Long getUserId()
    {
        return userId;
    }

    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public String getAdminNo()
    {
        return adminNo;
    }

    public void setAdminNo(String adminNo)
    {
        this.adminNo = adminNo;
    }

    public String getRole()
    {
        return role;
    }

    public void setRole(String role)
    {
        this.role = role;
    }

    public Date getCreateTime()
    {
        return createTime;
    }

    public void setCreateTime(Date createTime)
    {
        this.createTime = createTime;
    }
}