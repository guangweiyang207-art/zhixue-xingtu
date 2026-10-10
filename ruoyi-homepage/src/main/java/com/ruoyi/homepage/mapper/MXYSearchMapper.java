package com.ruoyi.homepage.mapper;

import com.ruoyi.taskmanage.domain.Course;
import com.ruoyi.taskmanage.domain.Homework;
import com.ruoyi.taskmanage.domain.Notice;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 主页全局搜索 Mapper
 *
 * @author 马孝银
 */
@Mapper
public interface MXYSearchMapper {

    /** 模糊搜课程 */
    List<Course> searchCourse(@Param("keyword") String keyword, @Param("limit") int limit);

    /** 模糊搜作业 */
    List<Homework> searchHomework(@Param("keyword") String keyword, @Param("limit") int limit);

    /** 模糊搜通知 */
    List<Notice> searchNotice(@Param("keyword") String keyword, @Param("limit") int limit);
}
