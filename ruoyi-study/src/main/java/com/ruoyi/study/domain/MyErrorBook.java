package com.ruoyi.study.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.apache.ibatis.type.Alias;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 错题本对象 my_error_book
 *
 * @author ruoyi
 * @date 2026-05-31
 */
@Alias("ErrorBook")
public class MyErrorBook extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 错题记录ID */
    private Long ebId;

    /** 学生ID */
    @Excel(name = "学生ID")
    private Long stuId;

    /** 题目ID */
    @Excel(name = "题目ID")
    private Long hqId;

    /** 课程ID */
    @Excel(name = "课程ID")
    private Long cId;

    /** 错误答案 */
    @Excel(name = "错误答案")
    private String wrongAnswer;

    /** 正确答案 */
    @Excel(name = "正确答案")
    private String correctAnswer;

    /** 解析 */
    @Excel(name = "解析")
    private String analysis;

    /** 标签/知识点 */
    @Excel(name = "标签/知识点")
    private String tag;

    /** 错误次数 */
    @Excel(name = "错误次数")
    private Long errorCount;

    /** 是否已掌握 0-否 1-是 */
    @Excel(name = "是否已掌握", readConverterExp = "0=否,1=是")
    private Long isMastered;

    /** 最后错误时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "最后错误时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date lastWrongTime;

    public void setEbId(Long ebId)
    {
        this.ebId = ebId;
    }

    public Long getEbId()
    {
        return ebId;
    }

    public void setStuId(Long stuId)
    {
        this.stuId = stuId;
    }

    public Long getStuId()
    {
        return stuId;
    }

    public void setHqId(Long hqId)
    {
        this.hqId = hqId;
    }

    public Long getHqId()
    {
        return hqId;
    }

    public void setcId(Long cId)
    {
        this.cId = cId;
    }

    public Long getcId()
    {
        return cId;
    }

    public void setWrongAnswer(String wrongAnswer)
    {
        this.wrongAnswer = wrongAnswer;
    }

    public String getWrongAnswer()
    {
        return wrongAnswer;
    }

    public void setCorrectAnswer(String correctAnswer)
    {
        this.correctAnswer = correctAnswer;
    }

    public String getCorrectAnswer()
    {
        return correctAnswer;
    }

    public void setAnalysis(String analysis)
    {
        this.analysis = analysis;
    }

    public String getAnalysis()
    {
        return analysis;
    }

    public void setTag(String tag)
    {
        this.tag = tag;
    }

    public String getTag()
    {
        return tag;
    }

    public void setErrorCount(Long errorCount)
    {
        this.errorCount = errorCount;
    }

    public Long getErrorCount()
    {
        return errorCount;
    }

    public void setIsMastered(Long isMastered)
    {
        this.isMastered = isMastered;
    }

    public Long getIsMastered()
    {
        return isMastered;
    }

    public void setLastWrongTime(Date lastWrongTime)
    {
        this.lastWrongTime = lastWrongTime;
    }

    public Date getLastWrongTime()
    {
        return lastWrongTime;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("ebId", getEbId())
            .append("stuId", getStuId())
            .append("hqId", getHqId())
            .append("cId", getcId())
            .append("wrongAnswer", getWrongAnswer())
            .append("correctAnswer", getCorrectAnswer())
            .append("analysis", getAnalysis())
            .append("tag", getTag())
            .append("errorCount", getErrorCount())
            .append("isMastered", getIsMastered())
            .append("lastWrongTime", getLastWrongTime())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
