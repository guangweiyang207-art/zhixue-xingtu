package com.ruoyi.myerrorbook.domain;

import com.ruoyi.common.core.domain.BaseEntity;
import java.util.Date;

public class MyErrorBook extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long ebId;

    private Long stuId;

    private Long hqId;

    private Long cId;

    private String wrongAnswer;

    private String correctAnswer;

    private String analysis;

    private String tag;

    private Integer errorCount;

    private Integer isMastered;

    private Date lastWrongTime;

    private Date createTime;

    private Date updateTime;

    public Long getEbId()
    {
        return ebId;
    }

    public void setEbId(Long ebId)
    {
        this.ebId = ebId;
    }

    public Long getStuId()
    {
        return stuId;
    }

    public void setStuId(Long stuId)
    {
        this.stuId = stuId;
    }

    public Long getHqId()
    {
        return hqId;
    }

    public void setHqId(Long hqId)
    {
        this.hqId = hqId;
    }

    public Long getcId()
    {
        return cId;
    }

    public void setcId(Long cId)
    {
        this.cId = cId;
    }

    public String getWrongAnswer()
    {
        return wrongAnswer;
    }

    public void setWrongAnswer(String wrongAnswer)
    {
        this.wrongAnswer = wrongAnswer;
    }

    public String getCorrectAnswer()
    {
        return correctAnswer;
    }

    public void setCorrectAnswer(String correctAnswer)
    {
        this.correctAnswer = correctAnswer;
    }

    public String getAnalysis()
    {
        return analysis;
    }

    public void setAnalysis(String analysis)
    {
        this.analysis = analysis;
    }

    public String getTag()
    {
        return tag;
    }

    public void setTag(String tag)
    {
        this.tag = tag;
    }

    public Integer getErrorCount()
    {
        return errorCount;
    }

    public void setErrorCount(Integer errorCount)
    {
        this.errorCount = errorCount;
    }

    public Integer getIsMastered()
    {
        return isMastered;
    }

    public void setIsMastered(Integer isMastered)
    {
        this.isMastered = isMastered;
    }

    public Date getLastWrongTime()
    {
        return lastWrongTime;
    }

    public void setLastWrongTime(Date lastWrongTime)
    {
        this.lastWrongTime = lastWrongTime;
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