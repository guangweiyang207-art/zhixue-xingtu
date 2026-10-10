package com.ruoyi.taskmanage.service;

import com.ruoyi.taskmanage.domain.Course;
import com.ruoyi.taskmanage.domain.CoursePublishRequest;
import java.util.List;

public interface IMXYCourseService {
    List<Course> selectCourseList(Course course);
    Course selectCourseById(Long cId);
    int insertCourse(Course course);
    int updateCourse(Course course);
    int deleteCourseById(Long cId);

    /**
     * 教师发布课程(注入 teacher_id + 默认值)
     * @return 新建课程的主键 c_id
     */
    Long publish(CoursePublishRequest req);
}
