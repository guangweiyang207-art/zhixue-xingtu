package com.ruoyi.course.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.course.mapper.MyCourseMapper;
import com.ruoyi.course.domain.MyCourse;
import com.ruoyi.course.service.IMyCourseService;

/**
 * 课程Service业务层处理
 * 
 * @author ruoyi
 * @date 2026-05-31
 */
@Service
public class MyCourseServiceImpl implements IMyCourseService
{
    @Autowired
    private MyCourseMapper myCourseMapper;

    /**
     * 查询课程
     * 
     * @param cId 课程主键
     * @return 课程
     */
    @Override
    public MyCourse selectMyCourseByCId(Long cId)
    {
        return myCourseMapper.selectMyCourseByCId(cId);
    }

    /**
     * 查询课程列表
     * 
     * @param myCourse 课程
     * @return 课程
     */
    @Override
    public List<MyCourse> selectMyCourseList(MyCourse myCourse)
    {
        return myCourseMapper.selectMyCourseList(myCourse);
    }

    /**
     * 新增课程
     * 
     * @param myCourse 课程
     * @return 结果
     */
    @Override
    public int insertMyCourse(MyCourse myCourse)
    {
        return myCourseMapper.insertMyCourse(myCourse);
    }

    /**
     * 修改课程
     * 
     * @param myCourse 课程
     * @return 结果
     */
    @Override
    public int updateMyCourse(MyCourse myCourse)
    {
        return myCourseMapper.updateMyCourse(myCourse);
    }

    /**
     * 批量删除课程
     * 
     * @param cIds 需要删除的课程主键
     * @return 结果
     */
    @Override
    public int deleteMyCourseByCIds(Long[] cIds)
    {
        return myCourseMapper.deleteMyCourseByCIds(cIds);
    }

    /**
     * 删除课程信息
     * 
     * @param cId 课程主键
     * @return 结果
     */
    @Override
    public int deleteMyCourseByCId(Long cId)
    {
        return myCourseMapper.deleteMyCourseByCId(cId);
    }
}
