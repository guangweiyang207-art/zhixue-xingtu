package com.ruoyi.taskmanage.mapper;

import com.ruoyi.taskmanage.domain.QuestionAnswer;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface MXYQuestionAnswerMapper {

    /**
     * 按条件查询(支持 stuId / teacherId / status 过滤,带教师/学生 JOIN 字段)
     */
    List<QuestionAnswer> selectQaList(QuestionAnswer qa);

    /** 单条详情 */
    QuestionAnswer selectQaById(@Param("id") Long id);

    /** 学生提交提问 */
    int insertQa(QuestionAnswer qa);

    /** 老师回答(只更新 answer / status / update_by / update_time) */
    int answerQa(QuestionAnswer qa);

    /** 修改状态(0/1/2) */
    int updateQa(QuestionAnswer qa);

    /** 删除(物理) */
    int deleteQaById(@Param("id") Long id);
}
