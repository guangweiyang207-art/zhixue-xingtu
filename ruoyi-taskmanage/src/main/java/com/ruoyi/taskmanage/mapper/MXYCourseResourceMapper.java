package com.ruoyi.taskmanage.mapper;

import com.ruoyi.taskmanage.domain.CourseResource;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface MXYCourseResourceMapper {

    List<CourseResource> selectCourseResourceList(CourseResource courseResource);

    CourseResource selectCourseResourceById(@Param("resourceId") Long resourceId);

    int insertCourseResource(CourseResource courseResource);

    int updateCourseResource(CourseResource courseResource);

    int deleteCourseResourceById(@Param("resourceId") Long resourceId);
}
