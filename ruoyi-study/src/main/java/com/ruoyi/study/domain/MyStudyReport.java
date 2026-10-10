package com.ruoyi.study.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.apache.ibatis.type.Alias;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 学情报表对象 my_study_report
 *
 * @author ruoyi
 * @date 2026-05-31
 */
@Alias("StudyReport")
public class MyStudyReport extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 报表ID */
    private Long reportId;

    /** 学生ID */
    @Excel(name = "学生ID")
    private Long stuId;

    /** 报表类型 1-日报 2-周报 3-月报 */
    @Excel(name = "报表类型", readConverterExp = "1=日报,2=周报,3=月报")
    private Long reportType;

    /** 报表日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "报表日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date reportDate;

    /** 学习时长(分钟) */
    @Excel(name = "学习时长(分钟)")
    private Long studyDuration;

    /** 完成课程数 */
    @Excel(name = "完成课程数")
    private Long completedCourses;

    /** 完成作业数 */
    @Excel(name = "完成作业数")
    private Long completedHomework;

    /** 正确率 */
    @Excel(name = "正确率")
    private BigDecimal correctRate;

    /** 积分变化 */
    @Excel(name = "积分变化")
    private Long rankScoreChange;

    public void setReportId(Long reportId)
    {
        this.reportId = reportId;
    }

    public Long getReportId()
    {
        return reportId;
    }

    public void setStuId(Long stuId)
    {
        this.stuId = stuId;
    }

    public Long getStuId()
    {
        return stuId;
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

    public void setStudyDuration(Long studyDuration)
    {
        this.studyDuration = studyDuration;
    }

    public Long getStudyDuration()
    {
        return studyDuration;
    }

    public void setCompletedCourses(Long completedCourses)
    {
        this.completedCourses = completedCourses;
    }

    public Long getCompletedCourses()
    {
        return completedCourses;
    }

    public void setCompletedHomework(Long completedHomework)
    {
        this.completedHomework = completedHomework;
    }

    public Long getCompletedHomework()
    {
        return completedHomework;
    }

    public void setCorrectRate(BigDecimal correctRate)
    {
        this.correctRate = correctRate;
    }

    public BigDecimal getCorrectRate()
    {
        return correctRate;
    }

    public void setRankScoreChange(Long rankScoreChange)
    {
        this.rankScoreChange = rankScoreChange;
    }

    public Long getRankScoreChange()
    {
        return rankScoreChange;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("reportId", getReportId())
            .append("stuId", getStuId())
            .append("reportType", getReportType())
            .append("reportDate", getReportDate())
            .append("studyDuration", getStudyDuration())
            .append("completedCourses", getCompletedCourses())
            .append("completedHomework", getCompletedHomework())
            .append("correctRate", getCorrectRate())
            .append("rankScoreChange", getRankScoreChange())
            .append("createTime", getCreateTime())
            .toString();
    }
}
