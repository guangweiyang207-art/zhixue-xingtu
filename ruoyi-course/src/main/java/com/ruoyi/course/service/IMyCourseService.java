package com.ruoyi.course.service;

import java.util.List;
import com.ruoyi.course.domain.MyCourse;

/**
 * 课程Service接口
 * 
 * @author ruoyi
 * @date 2026-05-31
 */
public interface IMyCourseService 
{
    /**
     * 查询课程
     * 
     * @param cId 课程主键
     * @return 课程
     */
    public MyCourse selectMyCourseByCId(Long cId);

    /**
     * 查询课程列表
     * 
     * @param myCourse 课程
     * @return 课程集合
     */
    public List<MyCourse> selectMyCourseList(MyCourse myCourse);

    /**
     * 新增课程
     * 
     * @param myCourse 课程
     * @return 结果
     */
    public int insertMyCourse(MyCourse myCourse);

    /**
     * 修改课程
     * 
     * @param myCourse 课程
     * @return 结果
     */
    public int updateMyCourse(MyCourse myCourse);

    /**
     * 批量删除课程
     * 
     * @param cIds 需要删除的课程主键集合
     * @return 结果
     */
    public int deleteMyCourseByCIds(Long[] cIds);

    /**
     * 删除课程信息
     * 
     * @param cId 课程主键
     * @return 结果
     */
    public int deleteMyCourseByCId(Long cId);
}
