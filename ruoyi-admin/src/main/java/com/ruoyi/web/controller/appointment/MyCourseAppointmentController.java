package com.ruoyi.web.controller.appointment;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.mycourserappointment.service.IMyCourseAppointmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/appointment/appointment")
public class MyCourseAppointmentController extends BaseController
{
    @Autowired
    private IMyCourseAppointmentService myCourseAppointmentService;
}