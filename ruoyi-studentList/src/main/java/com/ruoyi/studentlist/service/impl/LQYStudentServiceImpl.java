package com.ruoyi.studentlist.service.impl;

import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.studentlist.domain.Student;
import com.ruoyi.studentlist.domain.vo.StudentVO;
import com.ruoyi.studentlist.mapper.LQYStudentMapper;
import com.ruoyi.studentlist.service.LQYIStudentService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 学生信息Service业务层处理（纯 MyBatis）
 *
 * @author ruoyi
 */
@Service
public class LQYStudentServiceImpl implements LQYIStudentService
{
    @Autowired
    private LQYStudentMapper lqyStudentMapper;

    @Override
    public List<StudentVO> selectStudentList(Student student)
    {
        // 直接用 LEFT JOIN 返回带 realName/avatar/phone/email 的 StudentVO
        List<StudentVO> voList = lqyStudentMapper.selectStudentVOList(student);

        // 聚合作业统计数据（MyBatis 返回 Map key 跟列名一致）
        List<Map<String, Object>> statsList = lqyStudentMapper.selectStudentHomeworkStats();
        Map<Long, Map<String, Object>> statsMap = statsList.stream()
                .filter(m -> m.get("stuId") != null || m.get("stu_id") != null)
                .collect(Collectors.toMap(
                        m -> {
                            Object v = m.get("stuId") != null ? m.get("stuId") : m.get("stu_id");
                            return ((Number) v).longValue();
                        },
                        m -> m,
                        (a, b) -> a));

        // 补作业完成率/正确率/活跃度
        for (StudentVO vo : voList)
        {
            fillStudentStats(vo, statsMap.get(vo.getStuId()));
        }
        return voList;
    }

    @Override
    public List<String> selectDistinctClassList()
    {
        return lqyStudentMapper.selectDistinctClassList().stream()
                .map(m -> m.get("className"))
                .collect(Collectors.toList());
    }

    @Override
    public StudentVO selectStudentById(Long stuId)
    {
        // 直接用 JOIN 拿到带 realName/avatar/phone/email 的 StudentVO
        StudentVO vo = lqyStudentMapper.selectStudentVOById(stuId);
        if (vo == null)
        {
            return null;
        }
        // 补统计
        List<Map<String, Object>> statsList = lqyStudentMapper.selectStudentHomeworkStats();
        Map<Long, Map<String, Object>> statsMap = statsList.stream()
                .filter(m -> m.get("stuId") != null || m.get("stu_id") != null)
                .collect(Collectors.toMap(
                        m -> {
                            Object v = m.get("stuId") != null ? m.get("stuId") : m.get("stu_id");
                            return ((Number) v).longValue();
                        },
                        m -> m,
                        (a, b) -> a));
        fillStudentStats(vo, statsMap.get(stuId));
        return vo;
    }

    @Override
    public int insertStudent(Student student)
    {
        return lqyStudentMapper.insertStudent(student);
    }

    @Override
    public int updateStudent(Student student)
    {
        return lqyStudentMapper.updateStudent(student);
    }

    @Override
    public int deleteStudentById(Long stuId)
    {
        return lqyStudentMapper.deleteStudentById(stuId);
    }

    /**
     * 通过学号+姓名"关联"学生到小程序学生列表
     * 流程：JOIN 联查 my_student+my_sys_user 判重 → 学号判重 → 查 my_sys_user 拿 user_id → INSERT my_student
     * 注：不动 my_sys_user，只做"关联"操作
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Long addByStudentNoAndRealName(String studentNo, String realName)
    {
        // 1. 校验参数
        if (studentNo == null || studentNo.trim().isEmpty())
        {
            throw new ServiceException("学号不能为空");
        }
        if (realName == null || realName.trim().isEmpty())
        {
            throw new ServiceException("姓名不能为空");
        }
        String sn = studentNo.trim();
        String rn = realName.trim();
        // 2. 两表联查：my_student 里是否已有关联该姓名的学生
        Map<String, Object> exist = lqyStudentMapper.checkStudentExistsByJoin(rn);
        if (exist != null)
        {
            throw new ServiceException("该学生已添加");
        }
        // 3. 校验学号是否已被其他学生占用
        Map<String, Object> noExist = lqyStudentMapper.checkStudentNoExists(sn);
        if (noExist != null)
        {
            throw new ServiceException("该学号已被其他学生占用");
        }
        // 4. 在 my_sys_user 找该姓名的 user（数据库里必须先有这个用户）
        Map<String, Object> user = lqyStudentMapper.findSysUserIdByRealName(rn);
        if (user == null)
        {
            throw new ServiceException("数据库无此姓名的学生，请先在系统用户表中添加");
        }
        Object userIdObj = user.get("userId");
        if (userIdObj == null)
        {
            throw new ServiceException("用户数据异常，userId为空");
        }
        Long userId = ((Number) userIdObj).longValue();
        // 5. INSERT my_student（不动 my_sys_user，仅做"关联"）
        Student s = new Student();
        s.setUserId(userId);
        s.setStudentNo(sn);
        lqyStudentMapper.insertStudent(s);
        return s.getStuId();
    }

    /**
     * 转换为视图对象
     */
    private StudentVO convertToVO(Student student)
    {
        if (student == null)
        {
            return null;
        }
        StudentVO vo = new StudentVO();
        BeanUtils.copyProperties(student, vo);
        return vo;
    }

    /**
     * 填充统计字段：作业完成率 / 正确率 / 活跃度
     */
    private void fillStudentStats(StudentVO vo, Map<String, Object> stats)
    {
        if (vo == null)
        {
            return;
        }
        if (stats == null)
        {
            vo.setHomeworkCompletion(BigDecimal.ZERO);
            vo.setAccuracyRate(BigDecimal.ZERO);
        }
        else
        {
            // 作业完成率 = gradedCount / totalCount * 100
            Object totalObj = stats.get("totalCount") != null ? stats.get("totalCount") : stats.get("totalCount".toLowerCase());
            Object gradedObj = stats.get("gradedCount") != null ? stats.get("gradedCount") : stats.get("gradedCount".toLowerCase());
            Object avgObj = stats.get("avgScore") != null ? stats.get("avgScore") : stats.get("avgScore".toLowerCase());
            long total = totalObj == null ? 0L : ((Number) totalObj).longValue();
            long graded = gradedObj == null ? 0L : ((Number) gradedObj).longValue();
            BigDecimal completion = total > 0
                    ? BigDecimal.valueOf(graded * 100L).divide(BigDecimal.valueOf(total), 2, RoundingMode.HALF_UP)
                    : BigDecimal.ZERO;
            vo.setHomeworkCompletion(completion);
            vo.setAccuracyRate(avgObj == null ? BigDecimal.ZERO : new BigDecimal(avgObj.toString()).setScale(2, RoundingMode.HALF_UP));
        }
        // 活跃度 = 段位积分 / 100
        if (vo.getRankScore() != null)
        {
            vo.setActivityLevel(BigDecimal.valueOf(vo.getRankScore()).divide(BigDecimal.valueOf(100L), 2, RoundingMode.HALF_UP));
        }
        else
        {
            vo.setActivityLevel(BigDecimal.ZERO);
        }
    }
}
