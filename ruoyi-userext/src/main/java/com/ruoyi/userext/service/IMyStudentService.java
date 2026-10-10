package com.ruoyi.userext.service;

import java.util.List;
import com.ruoyi.userext.domain.MyStudent;

/**
 * 学生Service接口
 * 
 * @author ruoyi
 * @date 2026-05-31
 */
public interface IMyStudentService 
{
    /**
     * 查询学生
     * 
     * @param stuId 学生主键
     * @return 学生
     */
    public MyStudent selectMyStudentByStuId(Long stuId);

    /**
     * 查询学生列表
     * 
     * @param myStudent 学生
     * @return 学生集合
     */
    public List<MyStudent> selectMyStudentList(MyStudent myStudent);

    /**
     * 新增学生
     * 
     * @param myStudent 学生
     * @return 结果
     */
    public int insertMyStudent(MyStudent myStudent);

    /**
     * 修改学生
     * 
     * @param myStudent 学生
     * @return 结果
     */
    public int updateMyStudent(MyStudent myStudent);

    /**
     * 批量删除学生
     * 
     * @param stuIds 需要删除的学生主键集合
     * @return 结果
     */
    public int deleteMyStudentByStuIds(Long[] stuIds);

    /**
     * 删除学生信息
     * 
     * @param stuId 学生主键
     * @return 结果
     */
    public int deleteMyStudentByStuId(Long stuId);
}
