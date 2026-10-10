package com.ruoyi.home.domain;

import jakarta.persistence.*;

@Entity
@Table(name = "home_learning_stats")
public class HomeLearningStats {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Double todayStudyHours;

    @Column(nullable = false)
    private Integer weeklyHomeworkCount;

    @Column(nullable = false)
    private Integer accuracyRate;

    @Column(nullable = false)
    private Integer totalQuestions;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Double getTodayStudyHours() { return todayStudyHours; }
    public void setTodayStudyHours(Double todayStudyHours) { this.todayStudyHours = todayStudyHours; }
    public Integer getWeeklyHomeworkCount() { return weeklyHomeworkCount; }
    public void setWeeklyHomeworkCount(Integer weeklyHomeworkCount) { this.weeklyHomeworkCount = weeklyHomeworkCount; }
    public Integer getAccuracyRate() { return accuracyRate; }
    public void setAccuracyRate(Integer accuracyRate) { this.accuracyRate = accuracyRate; }
    public Integer getTotalQuestions() { return totalQuestions; }
    public void setTotalQuestions(Integer totalQuestions) { this.totalQuestions = totalQuestions; }
}
