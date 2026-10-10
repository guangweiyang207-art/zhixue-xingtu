package com.ruoyi.homework.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.apache.ibatis.type.Alias;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 作业对象 my_homework
 *
 * @author ruoyi
 * @date 2026-05-31
 */
@Alias("Homework")
public class MyHomework extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 作业ID */
    private Long hwId;

    /** 学生ID(按学生维度作业状态) */
    private Long stdId;

    /** 课程ID */
    @Excel(name = "课程ID")
    private Long cId;

    /** 发布教师ID */
    @Excel(name = "发布教师ID")
    private Long teacherId;

    /** 作业标题 */
    @Excel(name = "作业标题")
    private String title;

    /** 作业内容 */
    @Excel(name = "作业内容")
    private String content;

    /** 作业类型 1-客观题 2-主观题 3-混合 */
    @Excel(name = "作业类型", readConverterExp = "1=客观题,2=主观题,3=混合")
    private Long type;

    /** 总分 */
    @Excel(name = "总分")
    private Long totalScore;

    /** 截止时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "截止时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date deadline;

    /** 状态 0-草稿 1-已发布 2-已截止 */
    @Excel(name = "状态", readConverterExp = "0=草稿,1=已发布,2=已截止")
    private Long status;

    /** 学生姓名（关联my_student表） */
    @Excel(name = "学生姓名")
    private String studentName;

    /** 课程名称（关联my_course表） */
    @Excel(name = "课程名称")
    private String courseName;

    /** 教师姓名（关联my_teacher表） */
    @Excel(name = "教师姓名")
    private String teacherName;

    /** 题目数量（联查统计） */
    @Excel(name = "题目数量")
    private Integer questionCount;

    /** 提交人数（联查统计） */
    @Excel(name = "提交人数")
    private Integer submitCount;

    public void setHwId(Long hwId)
    {
        this.hwId = hwId;
    }

    public Long getHwId()
    {
        return hwId;
    }

    public Long getStdId() {
        return stdId;
    }

    public void setStdId(Long stdId) {
        this.stdId = stdId;
    }

    public void setcId(Long cId)
    {
        this.cId = cId;
    }

    public Long getcId()
    {
        return cId;
    }

    public Long getCId()
    {
        return cId;
    }

    public void setCId(Long cId)
    {
        this.cId = cId;
    }

    public void setTeacherId(Long teacherId)
    {
        this.teacherId = teacherId;
    }

    public Long getTeacherId()
    {
        return teacherId;
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

    public void setType(Long type)
    {
        this.type = type;
    }

    public Long getType()
    {
        return type;
    }

    public void setTotalScore(Long totalScore)
    {
        this.totalScore = totalScore;
    }

    public Long getTotalScore()
    {
        return totalScore;
    }

    public void setDeadline(Date deadline)
    {
        this.deadline = deadline;
    }

    public Date getDeadline()
    {
        return deadline;
    }

    public void setStatus(Long status)
    {
        this.status = status;
    }

    public Long getStatus()
    {
        return status;
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

    public void setTeacherName(String teacherName)
    {
        this.teacherName = teacherName;
    }

    public String getTeacherName()
    {
        return teacherName;
    }

    public Integer getQuestionCount() {
        return questionCount;
    }

    public void setQuestionCount(Integer questionCount) {
        this.questionCount = questionCount;
    }

    public Integer getSubmitCount() {
        return submitCount;
    }

    public void setSubmitCount(Integer submitCount) {
        this.submitCount = submitCount;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("hwId", getHwId())
            .append("cId", getcId())
            .append("teacherId", getTeacherId())
            .append("title", getTitle())
            .append("content", getContent())
            .append("type", getType())
            .append("totalScore", getTotalScore())
            .append("deadline", getDeadline())
            .append("status", getStatus())
            .append("studentName", getStudentName())
            .append("courseName", getCourseName())
            .append("teacherName", getTeacherName())
            .append("questionCount", getQuestionCount())
            .append("submitCount", getSubmitCount())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
