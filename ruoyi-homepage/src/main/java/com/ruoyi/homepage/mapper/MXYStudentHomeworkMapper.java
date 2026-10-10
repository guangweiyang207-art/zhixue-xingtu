package com.ruoyi.homepage.mapper;

import com.ruoyi.homepage.domain.StudentHomeworkDetailVO;
import com.ruoyi.homepage.domain.TodoHomework;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface MXYStudentHomeworkMapper {

    /**
     * 查询批改详情:学生信息 + 作业信息 + 题目列表 + 学生作答(JSON)
     */
    StudentHomeworkDetailVO selectDetail(@Param("shId") Long shId);

    /**
     * 提交批改:更新 score/teacher_comment/correct_time/status
     */
    int updateGrade(@Param("shId")    Long   shId,
                    @Param("score")   Double score,
                    @Param("comment") String comment);
}
