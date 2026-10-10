package com.ruoyi.studentlist.domain;

import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 作业统计对象
 *
 * @author ruoyi
 */
@Data
public class StatsHomework implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 已发布 */
    private Integer published;

    /** 待批改 */
    private Integer pending;

    /** 本月新增 */
    private Integer monthNew;

    /** 完成率 */
    private BigDecimal completeRate;
}
