package com.ruoyi.course.mapper;

import com.ruoyi.course.pojo.myCourseVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
@Mapper
public interface CourseMapper {

    List<myCourseVo> selectHotCourseList();

    List<myCourseVo> selectCourseList(String type);

    List<String> selectCourseTypeList();

    myCourseVo selectCourseDetail(Long cId);
}