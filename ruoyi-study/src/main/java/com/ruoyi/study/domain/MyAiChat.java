package com.ruoyi.study.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * AI问答记录对象 my_ai_chat
 * 
 * @author ruoyi
 * @date 2026-05-31
 */
public class MyAiChat extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 对话ID */
    private Long chatId;

    /** 学生ID */
    @Excel(name = "学生ID")
    private Long stuId;

    /** 学生姓名（关联my_student表） */
    private String userName;

    /** 会话ID */
    @Excel(name = "会话ID")
    private String sessionId;

    /** 问题内容 */
    @Excel(name = "问题内容")
    private String question;

    /** 回答内容 */
    @Excel(name = "回答内容")
    private String answer;

    /** 问题类型 1-学习 2-作业 3-其他 */
    @Excel(name = "问题类型", readConverterExp = "1=学习,2=作业,3=其他")
    private Long questionType;

    /** 是否满意 0-否 1-是 */
    @Excel(name = "是否满意", readConverterExp = "0=否,1=是")
    private Long isSatisfied;

    public void setChatId(Long chatId)
    {
        this.chatId = chatId;
    }

    public Long getChatId()
    {
        return chatId;
    }

    public void setStuId(Long stuId)
    {
        this.stuId = stuId;
    }

    public Long getStuId()
    {
        return stuId;
    }

    public void setUserName(String userName)
    {
        this.userName = userName;
    }

    public String getUserName()
    {
        return userName;
    }

    public void setSessionId(String sessionId)
    {
        this.sessionId = sessionId;
    }

    public String getSessionId()
    {
        return sessionId;
    }

    public void setQuestion(String question)
    {
        this.question = question;
    }

    public String getQuestion()
    {
        return question;
    }

    public void setAnswer(String answer)
    {
        this.answer = answer;
    }

    public String getAnswer()
    {
        return answer;
    }

    public void setQuestionType(Long questionType)
    {
        this.questionType = questionType;
    }

    public Long getQuestionType()
    {
        return questionType;
    }

    public void setIsSatisfied(Long isSatisfied)
    {
        this.isSatisfied = isSatisfied;
    }

    public Long getIsSatisfied()
    {
        return isSatisfied;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("chatId", getChatId())
            .append("stuId", getStuId())
            .append("userName", getUserName())
            .append("sessionId", getSessionId())
            .append("question", getQuestion())
            .append("answer", getAnswer())
            .append("questionType", getQuestionType())
            .append("isSatisfied", getIsSatisfied())
            .append("createTime", getCreateTime())
            .toString();
    }
}
