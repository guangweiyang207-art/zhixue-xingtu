package com.ruoyi.errorbook.mapper;

import com.ruoyi.errorbook.pojo.ErrorBookRow;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ErrorBookMapper {
    /**
     * 根据学生ID查询错题列表，关联课程表获取课程名称和类型
     */
    List<ErrorBookRow> getErrorBookList(@Param("stuId") Long stuId);

    /**
     * 根据学生ID和课程类型筛选错题列表
     */
    List<ErrorBookRow> getErrorBookListBySubject(@Param("stuId") Long stuId, @Param("courseType") String courseType);

    /**
     * 获取错题总数
     */
    int countErrorBook(@Param("stuId") Long stuId);

    /**
     * 获取待复习错题数（is_mastered = 0）
     */
    int countPendingErrors(@Param("stuId") Long stuId);

    /**
     * 获取已掌握错题数（is_mastered = 1）
     */
    int countMasteredErrors(@Param("stuId") Long stuId);
}