package com.ruoyi.student.pojo;

import lombok.Data;

@Data
public class RankConfig {
    private Integer rankId;
    private String rankName;
    private String rankIcon;
    private Integer minScore;
    private Integer maxScore;
    private String color;
    private String description;
    private Integer sortOrder;
}