package com.ruoyi.taskmanage.mapper;

import com.ruoyi.taskmanage.domain.Teacher;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface MXYTeacherMapper {

    List<Teacher> selectTeacherList(Teacher teacher);

    Teacher selectTeacherById(@Param("teacherId") Long teacherId);

    /** 根据 userId 查教师 */
    Teacher selectTeacherByUserId(@Param("userId") Long userId);

    int insertTeacher(Teacher teacher);

    int updateTeacher(Teacher teacher);

    int deleteTeacherById(@Param("teacherId") Long teacherId);
}
