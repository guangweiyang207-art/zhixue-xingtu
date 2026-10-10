package com.ruoyi.studentlist.domain;

import lombok.Data;

import java.io.Serializable;

/**
 * 信息统计对象
 *
 * @author ruoyi
 */
@Data
public class StatsInfo implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 已发布 */
    private Integer published;

    /** 草稿 */
    private Integer draft;

    /** 本月新增 */
    private Integer monthNew;

    /** 阅读量 */
    private Integer readCount;
}
