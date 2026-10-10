package com.ruoyi.homepage.mapper;

import com.ruoyi.homepage.domain.TodoHomework;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface MXYTodoHomeworkMapper {

    /**
     * 查询某位老师待批改的作业列表
     * @param teacherId 教师ID(可选;为空则查询所有)
     * @param status    状态过滤(null 表示默认 status=1 已提交待批改)
     */
    List<TodoHomework> selectTodoHomeworkList(@Param("teacherId") Long teacherId,
                                              @Param("status")    Integer status);
}
