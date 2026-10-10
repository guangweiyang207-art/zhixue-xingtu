package com.ruoyi.study.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 学习记录对象 my_study_record
 * 
 * @author ruoyi
 * @date 2026-05-31
 */
public class MyStudyRecord extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 记录ID */
    private Long srId;

    /** 学生ID */
    @Excel(name = "学生ID")
    private Long stuId;

    /** 课程ID */
    @Excel(name = "课程ID")
    private Long cId;

    /** 学习类型 1-视频 2-文档 3-做题 4-其他 */
    @Excel(name = "学习类型", readConverterExp = "1=视频,2=文档,3=做题,4=其他")
    private Long studyType;

    /** 学习时长(分钟) */
    @Excel(name = "学习时长(分钟)")
    private Long studyDuration;

    /** 学习日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "学习日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date studyDate;

    /** 进度百分比 */
    @Excel(name = "进度百分比")
    private Long progress;

    /** 学生姓名（关联my_sys_user表） */
    private String studentName;

    /** 课程名称（关联my_course表） */
    private String courseName;

    public void setSrId(Long srId)
    {
        this.srId = srId;
    }

    public Long getSrId()
    {
        return srId;
    }

    public void setStuId(Long stuId)
    {
        this.stuId = stuId;
    }

    public Long getStuId()
    {
        return stuId;
    }

    public void setcId(Long cId)
    {
        this.cId = cId;
    }

    public Long getcId()
    {
        return cId;
    }

    public void setStudyType(Long studyType)
    {
        this.studyType = studyType;
    }

    public Long getStudyType()
    {
        return studyType;
    }

    public void setStudyDuration(Long studyDuration)
    {
        this.studyDuration = studyDuration;
    }

    public Long getStudyDuration()
    {
        return studyDuration;
    }

    public void setStudyDate(Date studyDate)
    {
        this.studyDate = studyDate;
    }

    public Date getStudyDate()
    {
        return studyDate;
    }

    public void setProgress(Long progress)
    {
        this.progress = progress;
    }

    public Long getProgress()
    {
        return progress;
    }

    public void setStudentName(String studentName)
    {
        this.studentName = studentName;
    }

    public String getStudentName()
    {
        return studentName;
    }

    public void setCourseName(String courseName)
    {
        this.courseName = courseName;
    }

    public String getCourseName()
    {
        return courseName;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("srId", getSrId())
            .append("stuId", getStuId())
            .append("cId", getcId())
            .append("studyType", getStudyType())
            .append("studyDuration", getStudyDuration())
            .append("studyDate", getStudyDate())
            .append("progress", getProgress())
            .append("createTime", getCreateTime())
            .toString();
    }
}
