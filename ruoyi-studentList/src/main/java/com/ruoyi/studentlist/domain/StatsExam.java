package com.ruoyi.studentlist.domain;

import lombok.Data;

import java.io.Serializable;

/**
 * 考试统计对象
 *
 * @author ruoyi
 */
@Data
public class StatsExam implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 已发布 */
    private Integer published;

    /** 进行中 */
    private Integer inProgress;

    /** 本月新增 */
    private Integer monthNew;

    /** 参与人数 */
    private Integer participantCount;
}
