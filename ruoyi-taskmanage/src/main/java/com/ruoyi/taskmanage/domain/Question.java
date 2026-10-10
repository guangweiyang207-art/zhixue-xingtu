package com.ruoyi.taskmanage.domain;

import lombok.Data;

import java.io.Serializable;

/**
 * 题目对象 my_question
 * 表实际列:q_id, hw_id, question_type, question_content, options, correct_answer, score, difficulty, sort_order
 *
 * @author 马孝银
 */
@Data
public class Question implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 题目ID(q_id) */
    private Long qId;

    /** 作业ID(hw_id) */
    private Long hwId;

    /** 题目类型(1-单选 2-多选 3-判断 4-填空 5-简答) */
    private Integer questionType;

    /** 题目内容 */
    private String questionContent;

    /** 选项(JSON) */
    private String options;

    /** 正确答案 */
    private String correctAnswer;

    /** 分值 */
    private Integer score;

    /** 难度(1-简单 2-中等 3-困难) */
    private Integer difficulty;

    /** 排序 */
    private Integer sortOrder;
}
