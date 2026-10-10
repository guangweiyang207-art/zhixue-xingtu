package com.ruoyi.study.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 段位配置对象 my_rank_config
 * 
 * @author ruoyi
 * @date 2026-05-31
 */
public class MyRankConfig extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 段位ID */
    private Long rankId;

    /** 段位名称 */
    @Excel(name = "段位名称")
    private String rankName;

    /** 段位图标 */
    @Excel(name = "段位图标")
    private String rankIcon;

    /** 最低积分 */
    @Excel(name = "最低积分")
    private Long minScore;

    /** 最高积分 */
    @Excel(name = "最高积分")
    private Long maxScore;

    /** 段位颜色 */
    @Excel(name = "段位颜色")
    private String color;

    /** 段位描述 */
    @Excel(name = "段位描述")
    private String description;

    /** 排序 */
    @Excel(name = "排序")
    private Long sortOrder;

    public void setRankId(Long rankId)
    {
        this.rankId = rankId;
    }

    public Long getRankId()
    {
        return rankId;
    }

    public void setRankName(String rankName)
    {
        this.rankName = rankName;
    }

    public String getRankName()
    {
        return rankName;
    }

    public void setRankIcon(String rankIcon)
    {
        this.rankIcon = rankIcon;
    }

    public String getRankIcon()
    {
        return rankIcon;
    }

    public void setMinScore(Long minScore)
    {
        this.minScore = minScore;
    }

    public Long getMinScore()
    {
        return minScore;
    }

    public void setMaxScore(Long maxScore)
    {
        this.maxScore = maxScore;
    }

    public Long getMaxScore()
    {
        return maxScore;
    }

    public void setColor(String color)
    {
        this.color = color;
    }

    public String getColor()
    {
        return color;
    }

    public void setDescription(String description)
    {
        this.description = description;
    }

    public String getDescription()
    {
        return description;
    }

    public void setSortOrder(Long sortOrder)
    {
        this.sortOrder = sortOrder;
    }

    public Long getSortOrder()
    {
        return sortOrder;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("rankId", getRankId())
            .append("rankName", getRankName())
            .append("rankIcon", getRankIcon())
            .append("minScore", getMinScore())
            .append("maxScore", getMaxScore())
            .append("color", getColor())
            .append("description", getDescription())
            .append("sortOrder", getSortOrder())
            .toString();
    }
}
