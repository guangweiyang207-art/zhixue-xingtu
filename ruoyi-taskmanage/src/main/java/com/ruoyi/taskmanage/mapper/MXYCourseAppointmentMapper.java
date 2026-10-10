package com.ruoyi.taskmanage.mapper;

import com.ruoyi.taskmanage.domain.CourseAppointment;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface MXYCourseAppointmentMapper {

    List<CourseAppointment> selectCourseAppointmentList(CourseAppointment courseAppointment);

    CourseAppointment selectCourseAppointmentById(@Param("appointmentId") Long appointmentId);

    int insertCourseAppointment(CourseAppointment courseAppointment);

    int updateCourseAppointment(CourseAppointment courseAppointment);

    int deleteCourseAppointmentById(@Param("appointmentId") Long appointmentId);

    /** 按教师统计去重学生数(关联 my_course) */
    int countDistinctStudentsByTeacherId(@Param("teacherId") Long teacherId);

    /**
     * 按教师统计近 N 天活跃学生数(去重)
     *  - 依据:my_course_appointment.create_time 在 [from, now]
     */
    int countActiveStudentsByTeacherId(@Param("teacherId") Long teacherId, @Param("fromDays") int fromDays);
}
