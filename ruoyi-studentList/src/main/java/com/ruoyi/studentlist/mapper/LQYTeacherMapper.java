package com.ruoyi.studentlist.mapper;

import com.ruoyi.studentlist.domain.Teacher;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

/**
 * 教师信息Mapper接口（纯 MyBatis）
 *
 * @author ruoyi
 */
@Mapper
public interface LQYTeacherMapper
{

    /**
     * 查询教师信息（单条）
     */
    @Select("SELECT * FROM my_teacher LIMIT 1")
    Teacher selectTeacherInfo();

    /**
     * 根据用户ID查询教师
     */
    @Select("SELECT * FROM my_teacher WHERE user_id = #{userId} LIMIT 1")
    Teacher selectTeacherByUserId(@Param("userId") Long userId);

    /**
     * 根据ID查询教师
     */
    @Select("SELECT * FROM my_teacher WHERE teacher_id = #{teacherId}")
    Teacher selectTeacherById(@Param("teacherId") Long teacherId);

    /**
     * 新增教师
     */
    @Insert("INSERT INTO my_teacher(teacher_id, user_id, teacher_no, department, title, specialty, create_time, update_time) "
            + "VALUES(#{teacherId}, #{userId}, #{teacherNo}, #{department}, #{title}, #{specialty}, #{createTime}, #{updateTime})")
    int insertTeacher(Teacher teacher);

    /**
     * 修改教师
     */
    @Update("UPDATE my_teacher SET user_id=#{userId}, teacher_no=#{teacherNo}, department=#{department}, "
            + "title=#{title}, specialty=#{specialty}, update_time=#{updateTime} "
            + "WHERE teacher_id=#{teacherId}")
    int updateTeacher(Teacher teacher);

    /**
     * 删除教师
     */
    @Delete("DELETE FROM my_teacher WHERE teacher_id = #{teacherId}")
    int deleteTeacherById(@Param("teacherId") Long teacherId);
}
