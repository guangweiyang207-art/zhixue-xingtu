package com.ruoyi.homepage.domain;

import lombok.Data;

import java.io.Serializable;

/**
 * 待办统计(主页展示)
 *
 * @author 马孝银
 */
@Data
public class TodoCount implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 待批改作业数 */
    private long homeworkCount;

    /** 待回答问题数 */
    private long questionCount;
}
