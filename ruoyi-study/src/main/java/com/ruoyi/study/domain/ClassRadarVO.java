package com.ruoyi.study.domain;

import java.math.BigDecimal;

public class ClassRadarVO
{
    private String className;
    private BigDecimal avgCorrectRate;
    private Long avgStudyDuration;
    private Long avgCompletedHomework;
    private Long avgRankScore;
    private Long avgTotalQuestions;

    public String getClassName() { return className; }
    public void setClassName(String className) { this.className = className; }

    public BigDecimal getAvgCorrectRate() { return avgCorrectRate; }
    public void setAvgCorrectRate(BigDecimal avgCorrectRate) { this.avgCorrectRate = avgCorrectRate; }

    public Long getAvgStudyDuration() { return avgStudyDuration; }
    public void setAvgStudyDuration(Long avgStudyDuration) { this.avgStudyDuration = avgStudyDuration; }

    public Long getAvgCompletedHomework() { return avgCompletedHomework; }
    public void setAvgCompletedHomework(Long avgCompletedHomework) { this.avgCompletedHomework = avgCompletedHomework; }

    public Long getAvgRankScore() { return avgRankScore; }
    public void setAvgRankScore(Long avgRankScore) { this.avgRankScore = avgRankScore; }

    public Long getAvgTotalQuestions() { return avgTotalQuestions; }
    public void setAvgTotalQuestions(Long avgTotalQuestions) { this.avgTotalQuestions = avgTotalQuestions; }
}