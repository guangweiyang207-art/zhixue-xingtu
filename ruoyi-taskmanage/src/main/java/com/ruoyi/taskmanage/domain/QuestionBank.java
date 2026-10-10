package com.ruoyi.taskmanage.domain;

import lombok.Data;

import java.io.Serializable;

/**
 * 题库对象 my_question_bank
 * 表实际列:id, b_id, q_id, score
 *
 * @author 马孝银
 */
@Data
public class QuestionBank implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 题库ID */
    private Long bId;

    /** 题目ID */
    private Long qId;

    /** 分数 */
    private String score;
}
