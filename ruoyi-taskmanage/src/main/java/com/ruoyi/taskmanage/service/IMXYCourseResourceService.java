package com.ruoyi.taskmanage.service;

import com.ruoyi.taskmanage.domain.CourseResource;
import java.util.List;

public interface IMXYCourseResourceService {
    List<CourseResource> selectCourseResourceList(CourseResource courseResource);
    CourseResource selectCourseResourceById(Long resourceId);
    int insertCourseResource(CourseResource courseResource);
    int updateCourseResource(CourseResource courseResource);
    int deleteCourseResourceById(Long resourceId);
}
