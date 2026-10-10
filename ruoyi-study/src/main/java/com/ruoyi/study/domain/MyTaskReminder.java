package com.ruoyi.study.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 任务提醒对象 my_task_reminder
 * 
 * @author ruoyi
 * @date 2026-05-31
 */
public class MyTaskReminder extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 提醒ID */
    private Long trId;

    /** 学生ID */
    @Excel(name = "学生ID")
    private Long stuId;

    /** 任务类型 1-作业截止 2-课程开始 3-自定义 */
    @Excel(name = "任务类型", readConverterExp = "1=作业截止,2=课程开始,3=自定义")
    private Long taskType;

    /** 任务标题 */
    @Excel(name = "任务标题")
    private String taskTitle;

    /** 任务内容 */
    @Excel(name = "任务内容")
    private String taskContent;

    /** 提醒时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "提醒时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date remindTime;

    /** 重复类型 0-不重复 1-每天 2-每周 3-每月 */
    @Excel(name = "重复类型", readConverterExp = "0=不重复,1=每天,2=每周,3=每月")
    private Long repeatType;

    /** 是否已读 0-否 1-是 */
    @Excel(name = "是否已读", readConverterExp = "0=否,1=是")
    private Long isRead;

    /** 状态 0-取消 1-有效 */
    @Excel(name = "状态", readConverterExp = "0=取消,1=有效")
    private Long status;

    /** 关联ID(作业ID/课程ID) */
    @Excel(name = "关联ID")
    private Long relatedId;

    /** 学生姓名（关联my_student表） */
    @Excel(name = "学生姓名")
    private String studentName;

    public void setTrId(Long trId)
    {
        this.trId = trId;
    }

    public Long getTrId()
    {
        return trId;
    }

    public void setStuId(Long stuId)
    {
        this.stuId = stuId;
    }

    public Long getStuId()
    {
        return stuId;
    }

    public void setTaskType(Long taskType)
    {
        this.taskType = taskType;
    }

    public Long getTaskType()
    {
        return taskType;
    }

    public void setTaskTitle(String taskTitle)
    {
        this.taskTitle = taskTitle;
    }

    public String getTaskTitle()
    {
        return taskTitle;
    }

    public void setTaskContent(String taskContent)
    {
        this.taskContent = taskContent;
    }

    public String getTaskContent()
    {
        return taskContent;
    }

    public void setRemindTime(Date remindTime)
    {
        this.remindTime = remindTime;
    }

    public Date getRemindTime()
    {
        return remindTime;
    }

    public void setRepeatType(Long repeatType)
    {
        this.repeatType = repeatType;
    }

    public Long getRepeatType()
    {
        return repeatType;
    }

    public void setIsRead(Long isRead)
    {
        this.isRead = isRead;
    }

    public Long getIsRead()
    {
        return isRead;
    }

    public void setStatus(Long status)
    {
        this.status = status;
    }

    public Long getStatus()
    {
        return status;
    }

    public void setRelatedId(Long relatedId)
    {
        this.relatedId = relatedId;
    }

    public Long getRelatedId()
    {
        return relatedId;
    }

    public void setStudentName(String studentName)
    {
        this.studentName = studentName;
    }

    public String getStudentName()
    {
        return studentName;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("trId", getTrId())
            .append("stuId", getStuId())
            .append("taskType", getTaskType())
            .append("taskTitle", getTaskTitle())
            .append("taskContent", getTaskContent())
            .append("remindTime", getRemindTime())
            .append("repeatType", getRepeatType())
            .append("isRead", getIsRead())
            .append("status", getStatus())
            .append("relatedId", getRelatedId())
            .append("studentName", getStudentName())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
