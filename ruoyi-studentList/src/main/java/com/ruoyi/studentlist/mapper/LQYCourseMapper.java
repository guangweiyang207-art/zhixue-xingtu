package com.ruoyi.studentlist.mapper;

import com.ruoyi.studentlist.domain.Course;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

/**
 * 课程信息Mapper接口（纯 MyBatis）
 *
 * @author ruoyi
 */
@Mapper
public interface LQYCourseMapper
{

    /**
     * 查询课程列表
     */
    @Select("SELECT * FROM my_course")
    List<Course> selectCourseList();

    /**
     * 根据ID查询课程
     */
    @Select("SELECT * FROM my_course WHERE c_id = #{cId}")
    Course selectCourseById(@Param("cId") Long cId);

    /**
     * 新增课程
     */
    @Insert("INSERT INTO my_course(c_id, c_name, teacher_id, type, tag, difficulty, max_person, current_person, description, cover, create_time, update_time) "
            + "VALUES(#{cId}, #{cName}, #{teacherId}, #{type}, #{tag}, #{difficulty}, #{maxPerson}, #{currentPerson}, #{description}, #{cover}, #{createTime}, #{updateTime})")
    int insertCourse(Course course);

    /**
     * 修改课程
     */
    @Update("UPDATE my_course SET c_name=#{cName}, teacher_id=#{teacherId}, type=#{type}, tag=#{tag}, "
            + "difficulty=#{difficulty}, max_person=#{maxPerson}, current_person=#{currentPerson}, "
            + "description=#{description}, cover=#{cover}, update_time=#{updateTime} "
            + "WHERE c_id=#{cId}")
    int updateCourse(Course course);

    /**
     * 删除课程
     */
    @Delete("DELETE FROM my_course WHERE c_id = #{cId}")
    int deleteCourseById(@Param("cId") Long cId);
}
