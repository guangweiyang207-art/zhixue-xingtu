package com.ruoyi.homepage.mapper;

import com.ruoyi.homepage.domain.TodoCount;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * 主页待办统计 Mapper(跨模块聚合)
 *
 * @author 马孝银
 */
@Mapper
public interface MXYTeacherTodoMapper {

    /**
     * 教师待批改作业数
     * 关联 my_homework + my_student_homework (status=1 已提交未批改)
     */
    long countHomeworkTodoByTeacherId(@Param("teacherId") Long teacherId);

    /**
     * 通过当前用户ID获取该教师的待批改作业数
     * 内部用子查询从 my_teacher 解析 teacher_id
     */
    long countHomeworkTodoByUserId(@Param("userId") Long userId);

    /**
     * 待回答的提问数
     * 关联 my_ai_chat (answer 为空,按教师过滤)
     */
    long countUnansweredQuestion(@Param("teacherId") Long teacherId);

    /**
     * 一次性聚合返回
     */
    TodoCount selectTodoCount(@Param("teacherId") Long teacherId);
}
