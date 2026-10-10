package com.ruoyi.userext.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 教师对象 my_teacher
 * 
 * @author ruoyi
 * @date 2026-05-31
 */
public class MyTeacher extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 教师ID */
    private Long teacherId;

    /** 关联用户ID */
    @Excel(name = "关联用户ID")
    private Long userId;

    /** 工号 */
    @Excel(name = "工号")
    private String teacherNo;

    /** 所属院系 */
    @Excel(name = "所属院系")
    private String department;

    /** 职称 */
    @Excel(name = "职称")
    private String title;

    /** 专长领域 */
    @Excel(name = "专长领域")
    private String specialty;

    /** 教师姓名（关联my_sys_user表） */
    private String userName;

    public void setTeacherId(Long teacherId)
    {
        this.teacherId = teacherId;
    }

    public Long getTeacherId()
    {
        return teacherId;
    }

    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public Long getUserId()
    {
        return userId;
    }

    public void setTeacherNo(String teacherNo)
    {
        this.teacherNo = teacherNo;
    }

    public String getTeacherNo()
    {
        return teacherNo;
    }

    public void setDepartment(String department)
    {
        this.department = department;
    }

    public String getDepartment()
    {
        return department;
    }

    public void setTitle(String title)
    {
        this.title = title;
    }

    public String getTitle()
    {
        return title;
    }

    public void setSpecialty(String specialty)
    {
        this.specialty = specialty;
    }

    public String getSpecialty()
    {
        return specialty;
    }

    public void setUserName(String userName)
    {
        this.userName = userName;
    }

    public String getUserName()
    {
        return userName;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("teacherId", getTeacherId())
            .append("userId", getUserId())
            .append("teacherNo", getTeacherNo())
            .append("department", getDepartment())
            .append("title", getTitle())
            .append("specialty", getSpecialty())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
