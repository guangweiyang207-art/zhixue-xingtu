package com.ruoyi.studentlist.service.impl;

import com.ruoyi.studentlist.domain.Teacher;
import com.ruoyi.studentlist.domain.vo.TeacherVO;
import com.ruoyi.studentlist.mapper.LQYTeacherMapper;
import com.ruoyi.studentlist.service.LQYITeacherService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 教师信息Service业务层处理（纯 MyBatis）
 *
 * @author ruoyi
 */
@Service
public class LQYTeacherServiceImpl implements LQYITeacherService
{
    @Autowired
    private LQYTeacherMapper lqyTeacherMapper;

    @Override
    public TeacherVO selectTeacherInfo()
    {
        Teacher teacher = lqyTeacherMapper.selectTeacherInfo();
        return convertToVO(teacher);
    }

    @Override
    public int updateTeacher(Teacher teacher)
    {
        return lqyTeacherMapper.updateTeacher(teacher);
    }

    /**
     * 转换为视图对象
     */
    private TeacherVO convertToVO(Teacher teacher)
    {
        if (teacher == null)
        {
            return null;
        }
        TeacherVO vo = new TeacherVO();
        BeanUtils.copyProperties(teacher, vo);
        return vo;
    }
}
