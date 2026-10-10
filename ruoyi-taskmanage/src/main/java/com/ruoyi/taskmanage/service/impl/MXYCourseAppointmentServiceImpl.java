package com.ruoyi.taskmanage.service.impl;

import com.ruoyi.taskmanage.domain.CourseAppointment;
import com.ruoyi.taskmanage.mapper.MXYCourseAppointmentMapper;
import com.ruoyi.taskmanage.service.IMXYCourseAppointmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MXYCourseAppointmentServiceImpl implements IMXYCourseAppointmentService {

    @Autowired private MXYCourseAppointmentMapper mapper;

    @Override public List<CourseAppointment> selectCourseAppointmentList(CourseAppointment c) { return mapper.selectCourseAppointmentList(c); }
    @Override public CourseAppointment selectCourseAppointmentById(Long appointmentId) { return mapper.selectCourseAppointmentById(appointmentId); }
    @Override public int insertCourseAppointment(CourseAppointment c) { return mapper.insertCourseAppointment(c); }
    @Override public int updateCourseAppointment(CourseAppointment c) { return mapper.updateCourseAppointment(c); }
    @Override public int deleteCourseAppointmentById(Long appointmentId) { return mapper.deleteCourseAppointmentById(appointmentId); }
}
