package com.ruoyi.course.service;

import com.ruoyi.course.pojo.myCourseVo;

import java.util.List;

public interface ICourseService {

    List<myCourseVo> selectHotCourseList();

    List<myCourseVo> selectCourseList(String type);

    List<String> selectCourseTypeList();

    myCourseVo selectCourseDetail(Long cId);
}