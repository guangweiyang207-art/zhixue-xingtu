package com.ruoyi.mystudent.domain;

import com.ruoyi.common.core.domain.BaseEntity;
import java.util.Date;
import java.math.BigDecimal;

public class MyStudent extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long stuId;

    private Long userId;

    private String studentNo;

    private String major;

    private String grade;

    private String className;

    private Date birthday;

    private Long teacherId;

    private String rankLevel;

    private Integer rankScore;

    private Integer totalQuestions;

    private Integer correctQuestions;

    private BigDecimal studyHours;

    private Date createTime;

    private Date updateTime;

    public Long getStuId()
    {
        return stuId;
    }

    public void setStuId(Long stuId)
    {
        this.stuId = stuId;
    }

    public Long getUserId()
    {
        return userId;
    }

    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public String getStudentNo()
    {
        return studentNo;
    }

    public void setStudentNo(String studentNo)
    {
        this.studentNo = studentNo;
    }

    public String getMajor()
    {
        return major;
    }

    public void setMajor(String major)
    {
        this.major = major;
    }

    public String getGrade()
    {
        return grade;
    }

    public void setGrade(String grade)
    {
        this.grade = grade;
    }

    public String getClassName()
    {
        return className;
    }

    public void setClassName(String className)
    {
        this.className = className;
    }

    public Date getBirthday()
    {
        return birthday;
    }

    public void setBirthday(Date birthday)
    {
        this.birthday = birthday;
    }

    public Long getTeacherId()
    {
        return teacherId;
    }

    public void setTeacherId(Long teacherId)
    {
        this.teacherId = teacherId;
    }

    public String getRankLevel()
    {
        return rankLevel;
    }

    public void setRankLevel(String rankLevel)
    {
        this.rankLevel = rankLevel;
    }

    public Integer getRankScore()
    {
        return rankScore;
    }

    public void setRankScore(Integer rankScore)
    {
        this.rankScore = rankScore;
    }

    public Integer getTotalQuestions()
    {
        return totalQuestions;
    }

    public void setTotalQuestions(Integer totalQuestions)
    {
        this.totalQuestions = totalQuestions;
    }

    public Integer getCorrectQuestions()
    {
        return correctQuestions;
    }

    public void setCorrectQuestions(Integer correctQuestions)
    {
        this.correctQuestions = correctQuestions;
    }

    public BigDecimal getStudyHours()
    {
        return studyHours;
    }

    public void setStudyHours(BigDecimal studyHours)
    {
        this.studyHours = studyHours;
    }

    public Date getCreateTime()
    {
        return createTime;
    }

    public void setCreateTime(Date createTime)
    {
        this.createTime = createTime;
    }

    public Date getUpdateTime()
    {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime)
    {
        this.updateTime = updateTime;
    }
}