package com.ruoyi.taskmanage.service;

import com.ruoyi.taskmanage.domain.Course;
import com.ruoyi.taskmanage.domain.MXYTeacherAccountVO;
import com.ruoyi.taskmanage.domain.MXYTeacherMineVO;
import com.ruoyi.taskmanage.domain.MXYTeacherStatsVO;
import com.ruoyi.taskmanage.domain.Teacher;

import java.util.List;

public interface IMXYTeacherService {
    List<Teacher> selectTeacherList(Teacher teacher);
    Teacher selectTeacherById(Long teacherId);
    Teacher selectTeacherByUserId(Long userId);
    int insertTeacher(Teacher teacher);
    int updateTeacher(Teacher teacher);
    int deleteTeacherById(Long teacherId);

    /** "我的"页面聚合信息:基本信息 + 教龄 + 班级数 + 学生数 */
    MXYTeacherMineVO selectTeacherMineInfo(Long teacherId);

    /** 我发布的课程列表(小程序"我的课程"用) */
    List<Course> selectMyCourses(Long teacherId);

    /** 教学统计聚合(小程序"教学统计"用) */
    MXYTeacherStatsVO selectTeacherStats(Long teacherId);

    /** 教师完整账号信息(小程序"账号设置"用) */
    MXYTeacherAccountVO selectTeacherAccount(Long teacherId);

    /** 更新教师账号信息(只更新可编辑字段) */
    int updateTeacherAccount(MXYTeacherAccountVO vo);

    /** 更新教师头像(写入 my_sys_user.avatar) */
    int updateTeacherAvatar(Long userId, String avatarUrl);

    /**
     * 修改教师密码
     * @return 是否成功(原密码错误时返回 false)
     */
    boolean updateTeacherPassword(Long userId, String oldPassword, String newPassword);
}
