package com.ruoyi.study.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 题目对象 my_question
 * 
 * @author ruoyi
 * @date 2026-05-31
 */
public class MyQuestion extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 题目ID */
    private Long qId;

    /** 题型 1-单选 2-多选 3-判断 4-填空 5-简答 */
    @Excel(name = "题型", readConverterExp = "1=单选,2=多选,3=判断,4=填空,5=简答")
    private Integer questionType;

    /** 题目内容 */
    @Excel(name = "题目内容")
    private String questionContent;

    /** 选项(JSON格式) */
    @Excel(name = "选项")
    private String options;

    /** 正确答案 */
    @Excel(name = "正确答案")
    private String correctAnswer;

    /** 分值 */
    @Excel(name = "分值")
    private Integer score;

    /** 难度 1-简单 2-中等 3-困难 */
    @Excel(name = "难度", readConverterExp = "1=简单,2=中等,3=困难")
    private Integer difficulty;

    /** 排序 */
    @Excel(name = "排序")
    private Integer sortOrder;

    /** 所属作业标题（关联my_homework表） */
    @Excel(name = "所属作业")
    private String homeworkTitle;

    /** 所属题库名称（关联my_bank表） */
    @Excel(name = "所属题库")
    private String bankName;

    /** 所属课程名称（关联my_course表） */
    @Excel(name = "所属课程")
    private String courseName;

    public void setQId(Long qId)
    {
        this.qId = qId;
    }

    public Long getQId()
    {
        return qId;
    }

    public void setQuestionType(Integer questionType)
    {
        this.questionType = questionType;
    }

    public Integer getQuestionType()
    {
        return questionType;
    }

    public void setQuestionContent(String questionContent)
    {
        this.questionContent = questionContent;
    }

    public String getQuestionContent()
    {
        return questionContent;
    }

    public void setOptions(String options)
    {
        this.options = options;
    }

    public String getOptions()
    {
        return options;
    }

    public void setCorrectAnswer(String correctAnswer)
    {
        this.correctAnswer = correctAnswer;
    }

    public String getCorrectAnswer()
    {
        return correctAnswer;
    }

    public void setScore(Integer score)
    {
        this.score = score;
    }

    public Integer getScore()
    {
        return score;
    }

    public void setDifficulty(Integer difficulty)
    {
        this.difficulty = difficulty;
    }

    public Integer getDifficulty()
    {
        return difficulty;
    }

    public void setSortOrder(Integer sortOrder)
    {
        this.sortOrder = sortOrder;
    }

    public Integer getSortOrder()
    {
        return sortOrder;
    }

    public String getHomeworkTitle() {
        return homeworkTitle;
    }

    public void setHomeworkTitle(String homeworkTitle) {
        this.homeworkTitle = homeworkTitle;
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("qId", getQId())
            .append("questionType", getQuestionType())
            .append("questionContent", getQuestionContent())
            .append("options", getOptions())
            .append("correctAnswer", getCorrectAnswer())
            .append("score", getScore())
            .append("difficulty", getDifficulty())
            .append("sortOrder", getSortOrder())
            .append("homeworkTitle", getHomeworkTitle())
            .append("bankName", getBankName())
            .append("courseName", getCourseName())
            .toString();
    }
}
