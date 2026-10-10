package com.ruoyi.taskmanage.service.impl;

import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.taskmanage.domain.Course;
import com.ruoyi.taskmanage.domain.MXYTeacherAccountVO;
import com.ruoyi.taskmanage.domain.MXYTeacherMineVO;
import com.ruoyi.taskmanage.domain.MXYTeacherStatsVO;
import com.ruoyi.taskmanage.domain.SysUser;
import com.ruoyi.taskmanage.domain.Teacher;
import com.ruoyi.taskmanage.mapper.MXYCourseAppointmentMapper;
import com.ruoyi.taskmanage.mapper.MXYCourseMapper;
import com.ruoyi.taskmanage.mapper.MXYHomeworkMapper;
import com.ruoyi.taskmanage.mapper.MXYNoticeMapper;
import com.ruoyi.taskmanage.mapper.MXYTeacherMapper;
import com.ruoyi.taskmanage.mapper.MXYSysUserMapper;
import com.ruoyi.taskmanage.service.IMXYTeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;

@Service
public class MXYTeacherServiceImpl implements IMXYTeacherService {

    @Autowired private MXYTeacherMapper teacherMapper;
    @Autowired private MXYSysUserMapper sysUserMapper;
    @Autowired private MXYCourseMapper courseMapper;
    @Autowired private MXYCourseAppointmentMapper appointmentMapper;
    @Autowired private MXYHomeworkMapper homeworkMapper;
    @Autowired private MXYNoticeMapper noticeMapper;

    @Override public List<Teacher> selectTeacherList(Teacher t) { return teacherMapper.selectTeacherList(t); }
    @Override public Teacher selectTeacherById(Long teacherId) { return teacherMapper.selectTeacherById(teacherId); }
    @Override public Teacher selectTeacherByUserId(Long userId) { return teacherMapper.selectTeacherByUserId(userId); }
    @Override public int insertTeacher(Teacher t) { return teacherMapper.insertTeacher(t); }
    @Override public int updateTeacher(Teacher t) { return teacherMapper.updateTeacher(t); }
    @Override public int deleteTeacherById(Long teacherId) { return teacherMapper.deleteTeacherById(teacherId); }

    /**
     * "我的"页面聚合:
     *  - 教师档案:department / title / specialty
     *  - 登录用户:昵称/头像(LoginUser.user)
     *  - 授课班级数 = my_course.teacher_id 计数
     *  - 在读学生数 = 该教师课程下 my_course_appointment.stu_id 去重
     *  - 教龄 = 自 create_time 起算到当前的整年数
     */
    @Override
    public MXYTeacherMineVO selectTeacherMineInfo(Long teacherId) {
        Teacher teacher = teacherId == null ? null : teacherMapper.selectTeacherById(teacherId);
        if (teacher == null) {
            throw new ServiceException("未找到教师档案");
        }

        LoginUser loginUser = SecurityUtils.getLoginUser();
        SysUser sysUser = (loginUser == null || loginUser.getUser() == null)
                ? null
                : sysUserMapper.selectSysUserById(loginUser.getUser().getUserId());

        MXYTeacherMineVO vo = new MXYTeacherMineVO();
        vo.setTeacherId(teacher.getTeacherId());
        vo.setName(sysUser == null ? "" : nullToEmpty(sysUser.getRealName(), sysUser.getUsername()));
        vo.setAvatar(sysUser == null ? "" : sysUser.getAvatar());
        vo.setPostTitle("老师");
        vo.setProfessionTitle(teacher.getTitle());
        vo.setGroupName(teacher.getDepartment());
        vo.setCreateTime(teacher.getCreateTime());
        vo.setClassCount(teacherId == null ? 0 : courseMapper.countByTeacherId(teacherId));
        vo.setStudentCount(teacherId == null ? 0 : appointmentMapper.countDistinctStudentsByTeacherId(teacherId));
        vo.setTeachingYears(calcTeachingYears(teacher.getCreateTime()));
        return vo;
    }

    /**
     * 我发布的课程列表
     *  - 直接用 courseMapper.selectCourseList 传 teacherId 过滤
     */
    @Override
    public List<Course> selectMyCourses(Long teacherId) {
        if (teacherId == null) return java.util.Collections.emptyList();
        Course filter = new Course();
        filter.setTeacherId(teacherId);
        return courseMapper.selectCourseList(filter);
    }

    /**
     * 教学统计聚合:
     *  - totalCourses  : my_course.teacher_id 计数
     *  - totalStudents : my_course_appointment 去重学生数
     *  - activeStudents: 近 7 天活跃学生数
     *  - totalHomeworks: my_homework.teacher_id 计数
     *  - pendingHomeworks: 待批改数
     *  - totalNotices  : my_notification.sender_id 计数
     */
    @Override
    public MXYTeacherStatsVO selectTeacherStats(Long teacherId) {
        MXYTeacherStatsVO vo = new MXYTeacherStatsVO();
        if (teacherId == null) {
            vo.setTotalCourses(0);
            vo.setTotalStudents(0);
            vo.setActiveStudents(0);
            vo.setTotalHomeworks(0);
            vo.setPendingHomeworks(0);
            vo.setTotalNotices(0);
            return vo;
        }
        vo.setTotalCourses(courseMapper.countByTeacherId(teacherId));
        vo.setTotalStudents(appointmentMapper.countDistinctStudentsByTeacherId(teacherId));
        vo.setActiveStudents(appointmentMapper.countActiveStudentsByTeacherId(teacherId, 7));
        vo.setTotalHomeworks((int) homeworkMapper.countTotalByTeacherId(teacherId));
        vo.setPendingHomeworks((int) homeworkMapper.countPendingByTeacherId(teacherId));
        vo.setTotalNotices(noticeMapper.countByCreateBy(teacherId));
        return vo;
    }

    /**
     * 教师完整账号信息:合并 my_sys_user + my_teacher
     */
    @Override
    public MXYTeacherAccountVO selectTeacherAccount(Long teacherId) {
        Teacher teacher = teacherId == null ? null : teacherMapper.selectTeacherById(teacherId);
        if (teacher == null) {
            throw new ServiceException("未找到教师档案");
        }
        SysUser sysUser = teacher.getUserId() == null ? null : sysUserMapper.selectSysUserById(teacher.getUserId());
        if (sysUser == null) {
            throw new ServiceException("未找到关联账号");
        }

        MXYTeacherAccountVO vo = new MXYTeacherAccountVO();
        vo.setTeacherId(teacher.getTeacherId());
        vo.setUserId(sysUser.getUserId());
        vo.setUsername(sysUser.getUsername());
        vo.setRealName(sysUser.getRealName());
        vo.setAvatar(sysUser.getAvatar());
        vo.setSex(sysUser.getSex());
        vo.setAge(sysUser.getAge());
        vo.setPhone(sysUser.getPhone());
        vo.setEmail(sysUser.getEmail());
        vo.setTeacherNo(teacher.getTeacherNo());
        vo.setDepartment(teacher.getDepartment());
        vo.setTitle(teacher.getTitle());
        vo.setSpecialty(teacher.getSpecialty());
        return vo;
    }

    /**
     * 更新账号信息:
     *  - my_sys_user: realName / phone / email / avatar / sex / age
     *  - my_teacher : teacherNo / department / title / specialty
     */
    @Override
    public int updateTeacherAccount(MXYTeacherAccountVO vo) {
        if (vo == null || vo.getUserId() == null || vo.getTeacherId() == null) {
            throw new ServiceException("参数缺失");
        }
        // 1) 更新 my_sys_user
        SysUser sys = new SysUser();
        sys.setUserId(vo.getUserId());
        sys.setRealName(vo.getRealName());
        sys.setPhone(vo.getPhone());
        sys.setEmail(vo.getEmail());
        sys.setAvatar(vo.getAvatar());
        sys.setSex(vo.getSex());
        sys.setAge(vo.getAge());
        sys.setUpdateTime(java.time.LocalDateTime.now());
        sysUserMapper.updateSysUser(sys);

        // 2) 更新 my_teacher
        Teacher t = new Teacher();
        t.setTeacherId(vo.getTeacherId());
        t.setTeacherNo(vo.getTeacherNo());
        t.setDepartment(vo.getDepartment());
        t.setTitle(vo.getTitle());
        t.setSpecialty(vo.getSpecialty());
        t.setUpdateTime(java.time.LocalDateTime.now());
        return teacherMapper.updateTeacher(t);
    }

    @Override
    public int updateTeacherAvatar(Long userId, String avatarUrl) {
        if (userId == null) return 0;
        SysUser sys = new SysUser();
        sys.setUserId(userId);
        sys.setAvatar(avatarUrl);
        sys.setUpdateTime(java.time.LocalDateTime.now());
        return sysUserMapper.updateSysUser(sys);
    }

    /**
     * 修改教师密码:校验原密码 → BCrypt → 写回
     */
    @Override
    public boolean updateTeacherPassword(Long userId, String oldPassword, String newPassword) {
        if (userId == null) return false;
        SysUser db = sysUserMapper.selectSysUserById(userId);
        if (db == null) return false;
        String stored = db.getPassword();
        boolean matches = false;
        if (stored != null && stored.startsWith("$2a$")) {
            matches = SecurityUtils.matchesPassword(oldPassword, stored);
        } else {
            // 历史明文
            matches = stored != null && stored.equals(oldPassword);
            if (matches) {
                // 重写成 BCrypt
                SysUser enc = new SysUser();
                enc.setUserId(userId);
                enc.setPassword(SecurityUtils.encryptPassword(newPassword));
                enc.setUpdateTime(java.time.LocalDateTime.now());
                sysUserMapper.updateSysUserPassword(enc);
                return true;
            }
        }
        if (!matches) return false;

        SysUser upd = new SysUser();
        upd.setUserId(userId);
        upd.setPassword(SecurityUtils.encryptPassword(newPassword));
        upd.setUpdateTime(java.time.LocalDateTime.now());
        return sysUserMapper.updateSysUserPassword(upd) > 0;
    }

    /** 教龄:按年向下取整,最少 0 年 */
    private static Integer calcTeachingYears(java.time.LocalDateTime from) {
        if (from == null) return 0;
        long years = ChronoUnit.YEARS.between(from.toLocalDate(), LocalDate.now());
        return (int) Math.max(0, years);
    }

    private static String nullToEmpty(String primary, String fallback) {
        if (primary != null && !primary.isEmpty()) return primary;
        return fallback == null ? "" : fallback;
    }
}
