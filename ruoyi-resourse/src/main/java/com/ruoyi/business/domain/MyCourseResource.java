package com.ruoyi.business.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.apache.ibatis.type.Alias;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 资源模块对象 my_course_resource
 *
 * @author llhl
 * @date 2026-06-02
 */
@Alias("ResourseCourseResource")
public class MyCourseResource extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 资源ID */
    private Long reId;

    /** 关联课程ID */
    @Excel(name = "关联课程ID")
    private Long cId;

    /** 资源类型 1-视频 2-文档 3-图书 4-期刊 5-讲座 */
    @Excel(name = "资源类型 1-视频 2-文档 3-图书 4-期刊 5-讲座")
    private Long resourceType;

    /** 资源标题 */
    @Excel(name = "资源标题")
    private String title;

    /** 资源内容/描述 */
    @Excel(name = "资源内容/描述")
    private String content;

    /** 文件链接 */
    @Excel(name = "文件链接")
    private String fileUrl;

    /** 视频链接 */
    @Excel(name = "视频链接")
    private String videoUrl;

    /** 作业内容 */
    @Excel(name = "作业内容")
    private String homework;

    /** 排序 */
    @Excel(name = "排序")
    private Long sortOrder;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private String tag;

    public void setReId(Long reId) 
    {
        this.reId = reId;
    }

    public Long getReId() 
    {
        return reId;
    }

    public void setCId(Long cId) 
    {
        this.cId = cId;
    }

    public Long getCId() 
    {
        return cId;
    }

    public void setResourceType(Long resourceType) 
    {
        this.resourceType = resourceType;
    }

    public Long getResourceType() 
    {
        return resourceType;
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

    public void setFileUrl(String fileUrl) 
    {
        this.fileUrl = fileUrl;
    }

    public String getFileUrl() 
    {
        return fileUrl;
    }

    public void setVideoUrl(String videoUrl) 
    {
        this.videoUrl = videoUrl;
    }

    public String getVideoUrl() 
    {
        return videoUrl;
    }

    public void setHomework(String homework) 
    {
        this.homework = homework;
    }

    public String getHomework() 
    {
        return homework;
    }

    public void setSortOrder(Long sortOrder) 
    {
        this.sortOrder = sortOrder;
    }

    public Long getSortOrder() 
    {
        return sortOrder;
    }

    public void setTag(String tag) 
    {
        this.tag = tag;
    }

    public String getTag() 
    {
        return tag;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("reId", getReId())
            .append("cId", getCId())
            .append("resourceType", getResourceType())
            .append("title", getTitle())
            .append("content", getContent())
            .append("fileUrl", getFileUrl())
            .append("videoUrl", getVideoUrl())
            .append("homework", getHomework())
            .append("sortOrder", getSortOrder())
            .append("createTime", getCreateTime())
            .append("tag", getTag())
            .toString();
    }
}
