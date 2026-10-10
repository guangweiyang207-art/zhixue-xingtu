package com.ruoyi.homepage.mapper;

import com.ruoyi.homepage.domain.StudentHomeworkDetailVO.QuestionForGrade;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface MXYQuestionGradeMapper {

    /**
     * 根据作业ID查询题目列表
     */
    List<QuestionForGrade> selectByHwId(@Param("hwId") Long hwId);

    /**
     * 学生作答用题目列表(不含正确答案)
     */
    List<QuestionForGrade> selectQuestionsForAnswer(@Param("hwId") Long hwId);
}
