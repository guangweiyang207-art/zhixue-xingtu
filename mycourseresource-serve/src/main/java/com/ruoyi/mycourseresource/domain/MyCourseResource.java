package com.ruoyi.mycourseresource.domain;

import com.ruoyi.common.core.domain.BaseEntity;
import java.util.Date;

public class MyCourseResource extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long reId;

    private Long cId;

    private Integer resourceType;

    private String title;

    private String content;

    private String fileUrl;

    private String videoUrl;

    private String homework;

    private Integer sortOrder;

    private Date createTime;

    private String tag;

    public Long getReId()
    {
        return reId;
    }

    public void setReId(Long reId)
    {
        this.reId = reId;
    }

    public Long getcId()
    {
        return cId;
    }

    public void setcId(Long cId)
    {
        this.cId = cId;
    }

    public Integer getResourceType()
    {
        return resourceType;
    }

    public void setResourceType(Integer resourceType)
    {
        this.resourceType = resourceType;
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

    public String getFileUrl()
    {
        return fileUrl;
    }

    public void setFileUrl(String fileUrl)
    {
        this.fileUrl = fileUrl;
    }

    public String getVideoUrl()
    {
        return videoUrl;
    }

    public void setVideoUrl(String videoUrl)
    {
        this.videoUrl = videoUrl;
    }

    public String getHomework()
    {
        return homework;
    }

    public void setHomework(String homework)
    {
        this.homework = homework;
    }

    public Integer getSortOrder()
    {
        return sortOrder;
    }

    public void setSortOrder(Integer sortOrder)
    {
        this.sortOrder = sortOrder;
    }

    public Date getCreateTime()
    {
        return createTime;
    }

    public void setCreateTime(Date createTime)
    {
        this.createTime = createTime;
    }

    public String getTag()
    {
        return tag;
    }

    public void setTag(String tag)
    {
        this.tag = tag;
    }
}
