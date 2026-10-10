package com.ruoyi.mystudyreport.domain;

import com.ruoyi.common.core.domain.BaseEntity;
import java.math.BigDecimal;
import java.util.Date;

public class MyStudyReport extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long reportId;

    private Long stuId;

    private Integer reportType;

    private Date reportDate;

    private Integer studyDuration;

    private Integer completedCourses;

    private Integer completedHomework;

    private BigDecimal correctRate;

    private Integer rankScoreChange;

    private String weakPoints;

    private String strengths;

    private String suggestions;

    private String dataJson;

    private Date createTime;

    public Long getReportId()
    {
        return reportId;
    }

    public void setReportId(Long reportId)
    {
        this.reportId = reportId;
    }

    public Long getStuId()
    {
        return stuId;
    }

    public void setStuId(Long stuId)
    {
        this.stuId = stuId;
    }

    public Integer getReportType()
    {
        return reportType;
    }

    public void setReportType(Integer reportType)
    {
        this.reportType = reportType;
    }

    public Date getReportDate()
    {
        return reportDate;
    }

    public void setReportDate(Date reportDate)
    {
        this.reportDate = reportDate;
    }

    public Integer getStudyDuration()
    {
        return studyDuration;
    }

    public void setStudyDuration(Integer studyDuration)
    {
        this.studyDuration = studyDuration;
    }

    public Integer getCompletedCourses()
    {
        return completedCourses;
    }

    public void setCompletedCourses(Integer completedCourses)
    {
        this.completedCourses = completedCourses;
    }

    public Integer getCompletedHomework()
    {
        return completedHomework;
    }

    public void setCompletedHomework(Integer completedHomework)
    {
        this.completedHomework = completedHomework;
    }

    public BigDecimal getCorrectRate()
    {
        return correctRate;
    }

    public void setCorrectRate(BigDecimal correctRate)
    {
        this.correctRate = correctRate;
    }

    public Integer getRankScoreChange()
    {
        return rankScoreChange;
    }

    public void setRankScoreChange(Integer rankScoreChange)
    {
        this.rankScoreChange = rankScoreChange;
    }

    public String getWeakPoints()
    {
        return weakPoints;
    }

    public void setWeakPoints(String weakPoints)
    {
        this.weakPoints = weakPoints;
    }

    public String getStrengths()
    {
        return strengths;
    }

    public void setStrengths(String strengths)
    {
        this.strengths = strengths;
    }

    public String getSuggestions()
    {
        return suggestions;
    }

    public void setSuggestions(String suggestions)
    {
        this.suggestions = suggestions;
    }

    public String getDataJson()
    {
        return dataJson;
    }

    public void setDataJson(String dataJson)
    {
        this.dataJson = dataJson;
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
