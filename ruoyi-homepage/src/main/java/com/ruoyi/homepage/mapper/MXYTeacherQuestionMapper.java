package com.ruoyi.homepage.mapper;

import com.ruoyi.homepage.domain.TodoQuestion;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface MXYTeacherQuestionMapper {

    /**
     * 列表:某教师待回答的学生提问(answer 为空)
     */
    List<TodoQuestion> selectList(@Param("teacherId") Long teacherId);

    /**
     * 列表:某教师已回答的学生提问(answer 非空)
     */
    List<TodoQuestion> selectReplied(@Param("teacherId") Long teacherId);

    /**
     * 详情
     */
    TodoQuestion selectDetail(@Param("chatId") Long chatId);

    /**
     * 提交回答
     */
    int updateAnswer(@Param("chatId") Long chatId,
                     @Param("answer")  String answer,
                     @Param("teacherId") Long teacherId);
}
