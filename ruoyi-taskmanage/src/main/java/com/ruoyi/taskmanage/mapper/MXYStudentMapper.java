package com.ruoyi.taskmanage.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 学生 Mapper(最小集合,只用于按班级名查学生ID + 班级下拉)
 *
 * @author 马孝银
 */
@Mapper
public interface MXYStudentMapper {

    /** 按班级名称查所有学生ID */
    List<Long> selectStuIdsByClassName(@Param("className") String className);

    /** 查所有不重复的班级名称(用于教师发布时下拉) */
    List<String> selectDistinctClassNames();
}
