package com.ruoyi.appointment.service.impl;

import com.ruoyi.appointment.mapper.CourseAppointmentMapper;
import com.ruoyi.appointment.pojo.CourseAppointment;
import com.ruoyi.appointment.service.ICourseAppointmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class CourseAppointmentServiceImpl implements ICourseAppointmentService {

    @Autowired
    private CourseAppointmentMapper appointmentMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void addAppointment(CourseAppointment appointment) {
        if (appointment.getStuId() == null) {
            throw new RuntimeException("学生ID不能为空");
        }

        // 根据登录学生ID查询学生信息,自动补全学号等字段
        Map<String, Object> student = appointmentMapper.checkStudentByStuId(appointment.getStuId());
        if (student == null || student.isEmpty()) {
            throw new RuntimeException("无此用户");
        }

        // 自动补全学号(用于历史兼容字段,数据库中不存储)
        Object studentNo = student.get("student_no");
        if (studentNo != null) {
            appointment.setStuNo(studentNo.toString());
        }

        int duplicate = appointmentMapper.checkDuplicate(appointment);
        if (duplicate > 0) {
            throw new RuntimeException("该课程已预约");
        }

        // 已确认(status=1)才校验课程人数并更新 current_person
        if (appointment.getStatus() != null && appointment.getStatus() == 1) {
            int full = appointmentMapper.checkCourseFull(appointment.getCId());
            if (full > 0) {
                throw new RuntimeException("课程已满，无法预约");
            }
            appointmentMapper.insertAppointment(appointment);
            appointmentMapper.updateCoursePerson(appointment.getCId());
        } else {
            // 待确认(status=0),直接插入,不占名额
            appointmentMapper.insertAppointment(appointment);
        }
    }

    @Override
    public List<Map<String, Object>> getMyCourseList(Long stuId, Integer status) {
        return appointmentMapper.selectMyCourseList(stuId, status);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void cancelAppointment(Long caId) {
        // 查询当前预约状态
        Map<String, Object> appt = appointmentMapper.selectAppointmentById(caId);
        if (appt == null) {
            throw new RuntimeException("预约记录不存在");
        }
        int curStatus = ((Number) appt.get("status")).intValue();
        Long cId = ((Number) appt.get("c_id")).longValue();

        // 已确认的预约取消时才减少人数
        if (curStatus == 1) {
            appointmentMapper.decrementCoursePerson(cId);
        }

        appointmentMapper.cancelAppointment(caId);
    }
}