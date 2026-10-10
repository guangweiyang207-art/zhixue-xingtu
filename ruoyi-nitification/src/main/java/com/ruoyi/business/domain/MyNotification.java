package com.ruoyi.business.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 通知模块对象 my_notification
 * 
 * @author lhl
 * @date 2026-05-31
 */
public class MyNotification extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 通知ID */
    private Long notiId;

    /** 发送者ID */
    @Excel(name = "发送者ID")
    private Long senderId;

    /** 发送者类型 1-系统 2-教师 3-管理员 */
    @Excel(name = "发送者类型 1-系统 2-教师 3-管理员")
    private Long senderType;

    /** 通知标题 */
    @Excel(name = "通知标题")
    private String title;

    /** 通知内容 */
    @Excel(name = "通知内容")
    private String content;

    /** 目标类型 1-全部 2-指定学生 3-指定班级 */
    @Excel(name = "目标类型 1-全部 2-指定学生 3-指定班级")
    private Long targetType;

    /** 目标对象ID列表 */
    @Excel(name = "目标对象ID列表")
    private String targetIds;

    /** 优先级 1-普通 2-重要 3-紧急 */
    @Excel(name = "优先级 1-普通 2-重要 3-紧急")
    private Long priority;

    /** 是否置顶 0-否 1-是 */
    @Excel(name = "是否置顶 0-否 1-是")
    private Long isTop;

    /** 状态 0-草稿 1-已发布 2-已撤回 */
    @Excel(name = "状态 0-草稿 1-已发布 2-已撤回")
    private Long status;

    /** 发布时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "发布时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date publishTime;

    public void setNotiId(Long notiId) 
    {
        this.notiId = notiId;
    }

    public Long getNotiId() 
    {
        return notiId;
    }

    public void setSenderId(Long senderId) 
    {
        this.senderId = senderId;
    }

    public Long getSenderId() 
    {
        return senderId;
    }

    public void setSenderType(Long senderType) 
    {
        this.senderType = senderType;
    }

    public Long getSenderType() 
    {
        return senderType;
    }

    public void setTitle(String title) 
    {
        this.title = title;
    }

    public String getTitle() 
    {
        return title;
    }

    public void setContent(String content) 
    {
        this.content = content;
    }

    public String getContent() 
    {
        return content;
    }

    public void setTargetType(Long targetType) 
    {
        this.targetType = targetType;
    }

    public Long getTargetType() 
    {
        return targetType;
    }

    public void setTargetIds(String targetIds) 
    {
        this.targetIds = targetIds;
    }

    public String getTargetIds() 
    {
        return targetIds;
    }

    public void setPriority(Long priority) 
    {
        this.priority = priority;
    }

    public Long getPriority() 
    {
        return priority;
    }

    public void setIsTop(Long isTop) 
    {
        this.isTop = isTop;
    }

    public Long getIsTop() 
    {
        return isTop;
    }

    public void setStatus(Long status) 
    {
        this.status = status;
    }

    public Long getStatus() 
    {
        return status;
    }

    public void setPublishTime(Date publishTime) 
    {
        this.publishTime = publishTime;
    }

    public Date getPublishTime() 
    {
        return publishTime;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("notiId", getNotiId())
            .append("senderId", getSenderId())
            .append("senderType", getSenderType())
            .append("title", getTitle())
            .append("content", getContent())
            .append("targetType", getTargetType())
            .append("targetIds", getTargetIds())
            .append("priority", getPriority())
            .append("isTop", getIsTop())
            .append("status", getStatus())
            .append("publishTime", getPublishTime())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
