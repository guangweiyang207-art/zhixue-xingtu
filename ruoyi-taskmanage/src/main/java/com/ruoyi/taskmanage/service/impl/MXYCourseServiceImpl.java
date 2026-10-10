package com.ruoyi.taskmanage.service.impl;

import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.taskmanage.domain.Course;
import com.ruoyi.taskmanage.domain.CoursePublishRequest;
import com.ruoyi.taskmanage.mapper.MXYCourseMapper;
import com.ruoyi.taskmanage.service.IMXYCourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class MXYCourseServiceImpl implements IMXYCourseService {

    @Autowired private MXYCourseMapper courseMapper;

    @Override public List<Course> selectCourseList(Course course) { return courseMapper.selectCourseList(course); }
    @Override public Course selectCourseById(Long cId) { return courseMapper.selectCourseById(cId); }
    @Override public int insertCourse(Course course) { return courseMapper.insertCourse(course); }
    @Override public int updateCourse(Course course) { return courseMapper.updateCourse(course); }
    @Override public int deleteCourseById(Long cId) { return courseMapper.deleteCourseById(cId); }

    /**
     * 教师发布课程
     * 业务规则:
     *   1. cName / type / tag / description / difficulty 必填
     *   2. 自动从 token 取 teacher_id
     *   3. max_person 默认 50 / status 默认 1(上架) / current_person 默认 0
     */
    @Override
    public Long publish(CoursePublishRequest req) {
        if (req == null) {
            throw new ServiceException("请求不能为空");
        }
        if (req.getCName() == null || req.getCName().trim().isEmpty()) {
            throw new ServiceException("课程名称不能为空");
        }
        if (req.getType() == null || req.getType().trim().isEmpty()) {
            throw new ServiceException("课程类型不能为空");
        }
        if (req.getTag() == null || req.getTag().trim().isEmpty()) {
            throw new ServiceException("课程标签不能为空");
        }
        if (req.getDescription() == null || req.getDescription().trim().isEmpty()) {
            throw new ServiceException("课程描述不能为空");
        }
        if (req.getDifficulty() == null
                || req.getDifficulty() < 1 || req.getDifficulty() > 3) {
            throw new ServiceException("难度取值必须是 1-简单 / 2-中等 / 3-困难");
        }
        Long teacherId = SecurityUtils.getTeacherId();
        if (teacherId == null) {
            throw new ServiceException("无法获取当前教师信息,请重新登录");
        }

        Course c = new Course();
        c.setCName(req.getCName().trim());
        c.setTeacherId(teacherId);
        c.setType(req.getType().trim());
        c.setTag(req.getTag().trim());
        c.setDescription(req.getDescription().trim());
        c.setDifficulty(req.getDifficulty());
        c.setStartTime(req.getStartTime() == null ? null : LocalDateTime.of(req.getStartTime(), LocalDateTime.now().toLocalTime().withNano(0)));
        c.setMaxPerson(50);
        c.setCurrentPerson(0);
        c.setStatus(1);
        // 上课时段备注,例: "周三 09:00 ~ 10:30"
        if (req.getRemark() != null && !req.getRemark().trim().isEmpty()) {
            c.setRemark(req.getRemark().trim());
        }

        int rows = courseMapper.insertCourse(c);
        return rows > 0 ? c.getCId() : null;
    }
}
