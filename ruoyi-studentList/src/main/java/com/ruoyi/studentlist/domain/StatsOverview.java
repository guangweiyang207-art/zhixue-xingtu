package com.ruoyi.studentlist.domain;

import lombok.Data;

import java.io.Serializable;

/**
 * 统计概览对象
 *
 * @author ruoyi
 */
@Data
public class StatsOverview implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 总发布数 */
    private Integer totalPublish;

    /** 本月发布数 */
    private Integer monthPublish;
}
