package com.ruoyi.mycourserappointment.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.mycourserappointment.mapper.MyCourseAppointmentMapper;
import com.ruoyi.mycourserappointment.service.IMyCourseAppointmentService;

@Service
public class MyCourseAppointmentServiceImpl implements IMyCourseAppointmentService
{
    @Autowired
    private MyCourseAppointmentMapper myCourseAppointmentMapper;
}