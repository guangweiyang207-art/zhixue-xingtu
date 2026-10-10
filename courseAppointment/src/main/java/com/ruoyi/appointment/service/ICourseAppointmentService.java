package com.ruoyi.appointment.service;

import com.ruoyi.appointment.pojo.CourseAppointment;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public interface ICourseAppointmentService {

    void addAppointment(CourseAppointment appointment);

    List<Map<String, Object>> getMyCourseList(Long stuId, Integer status);

    void cancelAppointment(Long caId);
}