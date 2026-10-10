package com.ruoyi.web.controller.CourseAppoinment;

import com.ruoyi.appointment.pojo.CourseAppointment;
import com.ruoyi.appointment.service.ICourseAppointmentService;
import com.ruoyi.common.R;
import com.ruoyi.common.annotation.Anonymous;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Anonymous
@RestController
@RequestMapping("/course/appointment")
public class CourseAppointmentController {

    @Autowired
    private ICourseAppointmentService appointmentService;

    /**
     * 提交预约（status=1确认, status=0待确认）
     */
    @PostMapping("/add")
    public R add(@RequestBody CourseAppointment appointment) {
        try {
            appointmentService.addAppointment(appointment);
            return R.success(null);
        } catch (RuntimeException e) {
            return R.error(e.getMessage());
        }
    }

    /**
     * 我的课程列表
     * @param stu_id 学生ID
     * @param status 可选筛选：null-全部, 0-待确认, 1-已确认
     */
    @GetMapping("/myList")
    public R myList(@RequestParam("stu_id") Long stuId,
                    @RequestParam(value = "status", required = false) Integer status) {
        List<Map<String, Object>> list = appointmentService.getMyCourseList(stuId, status);
        return R.success(list);
    }

    /**
     * 取消预约
     */
    @PostMapping("/cancel")
    public R cancel(@RequestBody Map<String, Object> body) {
        Long caId = ((Number) body.get("ca_id")).longValue();
        try {
            appointmentService.cancelAppointment(caId);
            return R.success(null);
        } catch (RuntimeException e) {
            return R.error(e.getMessage());
        }
    }
}