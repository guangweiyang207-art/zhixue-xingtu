package com.ruoyi.taskmanage.service;

import com.ruoyi.taskmanage.domain.CourseAppointment;
import java.util.List;

public interface IMXYCourseAppointmentService {
    List<CourseAppointment> selectCourseAppointmentList(CourseAppointment courseAppointment);
    CourseAppointment selectCourseAppointmentById(Long appointmentId);
    int insertCourseAppointment(CourseAppointment courseAppointment);
    int updateCourseAppointment(CourseAppointment courseAppointment);
    int deleteCourseAppointmentById(Long appointmentId);
}
