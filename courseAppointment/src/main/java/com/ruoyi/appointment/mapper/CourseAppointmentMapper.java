package com.ruoyi.appointment.mapper;

import com.ruoyi.appointment.pojo.CourseAppointment;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface CourseAppointmentMapper {

    int insertAppointment(CourseAppointment appointment);

    int updateCoursePerson(Long cId);

    int decrementCoursePerson(Long cId);

    int checkDuplicate(CourseAppointment appointment);

    int checkCourseFull(Long cId);

    Map<String, Object> checkStudentByStuNo(@Param("stuNo") String stuNo);

    Map<String, Object> checkStudentByStuId(@Param("stuId") Long stuId);

    List<Map<String, Object>> selectMyCourseList(@Param("stuId") Long stuId,
                                                  @Param("status") Integer status);

    Map<String, Object> selectAppointmentById(@Param("caId") Long caId);

    int cancelAppointment(@Param("caId") Long caId);

    List<Map<String, Object>> selectExpiredPendingAppointments();
}