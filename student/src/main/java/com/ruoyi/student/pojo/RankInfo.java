package com.ruoyi.student.pojo;

import lombok.Data;

@Data
public class RankInfo {
    private String rankLevel;
    private Integer rankScore;
    private Integer totalQuestions;
    private Integer correctQuestions;

    private String currentRankName;
    private String currentRankIcon;
    private String currentRankColor;
    private String currentRankDesc;
    private Integer currentMinScore;
    private Integer currentMaxScore;

    private String nextRankName;
    private Integer nextMinScore;

    private Integer progress;
}