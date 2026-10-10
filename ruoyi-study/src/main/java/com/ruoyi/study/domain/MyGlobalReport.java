package com.ruoyi.study.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 全局报表对象 my_global_report
 * 
 * @author ruoyi
 * @date 2026-05-31
 */
public class MyGlobalReport extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 报表ID */
    private Long grId;

    /** 学生ID */
    @Excel(name = "学生ID")
    private Long stdId;

    /** 教师ID */
    @Excel(name = "教师ID")
    private Long teacherId;

    /** 报表类型 1-日报 2-周报 3-月报 4-年报 */
    @Excel(name = "报表类型", readConverterExp = "1=日报,2=周报,3=月报,4=年报")
    private Long reportType;

    /** 报表日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "报表日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date reportDate;

    /** 总学生数 */
    @Excel(name = "总学生数")
    private Long totalStudents;

    /** 总教师数 */
    @Excel(name = "总教师数")
    private Long totalTeachers;

    /** 总课程数 */
    @Excel(name = "总课程数")
    private Long totalCourses;

    /** 活跃学生数 */
    @Excel(name = "活跃学生数")
    private Long activeStudents;

    /** 新增学生数 */
    @Excel(name = "新增学生数")
    private Long newStudents;

    /** 完成作业数 */
    @Excel(name = "完成作业数")
    private Long completedHomeworkCount;

    /** 平均正确率 */
    @Excel(name = "平均正确率")
    private BigDecimal averageCorrectRate;

    /** 总学习时长 */
    @Excel(name = "总学习时长")
    private BigDecimal totalStudyHours;

    public void setGrId(Long grId)
    {
        this.grId = grId;
    }

    public Long getGrId()
    {
        return grId;
    }

    public void setStdId(Long stdId)
    {
        this.stdId = stdId;
    }

    public Long getStdId()
    {
        return stdId;
    }

    public void setTeacherId(Long teacherId)
    {
        this.teacherId = teacherId;
    }

    public Long getTeacherId()
    {
        return teacherId;
    }

    public void setReportType(Long reportType)
    {
        this.reportType = reportType;
    }

    public Long getReportType()
    {
        return reportType;
    }

    public void setReportDate(Date reportDate)
    {
        this.reportDate = reportDate;
    }

    public Date getReportDate()
    {
        return reportDate;
    }

    public void setTotalStudents(Long totalStudents)
    {
        this.totalStudents = totalStudents;
    }

    public Long getTotalStudents()
    {
        return totalStudents;
    }

    public void setTotalTeachers(Long totalTeachers)
    {
        this.totalTeachers = totalTeachers;
    }

    public Long getTotalTeachers()
    {
        return totalTeachers;
    }

    public void setTotalCourses(Long totalCourses)
    {
        this.totalCourses = totalCourses;
    }

    public Long getTotalCourses()
    {
        return totalCourses;
    }

    public void setActiveStudents(Long activeStudents)
    {
        this.activeStudents = activeStudents;
    }

    public Long getActiveStudents()
    {
        return activeStudents;
    }

    public void setNewStudents(Long newStudents)
    {
        this.newStudents = newStudents;
    }

    public Long getNewStudents()
    {
        return newStudents;
    }

    public void setCompletedHomeworkCount(Long completedHomeworkCount)
    {
        this.completedHomeworkCount = completedHomeworkCount;
    }

    public Long getCompletedHomeworkCount()
    {
        return completedHomeworkCount;
    }

    public void setAverageCorrectRate(BigDecimal averageCorrectRate)
    {
        this.averageCorrectRate = averageCorrectRate;
    }

    public BigDecimal getAverageCorrectRate()
    {
        return averageCorrectRate;
    }

    public void setTotalStudyHours(BigDecimal totalStudyHours)
    {
        this.totalStudyHours = totalStudyHours;
    }

    public BigDecimal getTotalStudyHours()
    {
        return totalStudyHours;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("grId", getGrId())
            .append("stdId", getStdId())
            .append("teacherId", getTeacherId())
            .append("reportType", getReportType())
            .append("reportDate", getReportDate())
            .append("totalStudents", getTotalStudents())
            .append("totalTeachers", getTotalTeachers())
            .append("totalCourses", getTotalCourses())
            .append("activeStudents", getActiveStudents())
            .append("newStudents", getNewStudents())
            .append("completedHomeworkCount", getCompletedHomeworkCount())
            .append("averageCorrectRate", getAverageCorrectRate())
            .append("totalStudyHours", getTotalStudyHours())
            .append("createTime", getCreateTime())
            .toString();
    }
}
