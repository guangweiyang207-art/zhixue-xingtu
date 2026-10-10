package com.ruoyi.taskmanage.mapper;

import com.ruoyi.taskmanage.domain.Course;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface MXYCourseMapper {

    List<Course> selectCourseList(Course course);

    Course selectCourseById(@Param("cId") Long cId);

    int insertCourse(Course course);

    int updateCourse(Course course);

    int deleteCourseById(@Param("cId") Long cId);

    /** 按教师统计课程数 */
    int countByTeacherId(@Param("teacherId") Long teacherId);
}
