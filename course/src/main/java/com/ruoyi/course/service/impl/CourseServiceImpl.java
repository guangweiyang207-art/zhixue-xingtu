package com.ruoyi.course.service.impl;

import com.ruoyi.course.pojo.myCourseVo;
import com.ruoyi.course.mapper.CourseMapper;
import com.ruoyi.course.service.ICourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CourseServiceImpl implements ICourseService {

    @Autowired
    private CourseMapper courseMapper;

    @Override
    public List<myCourseVo> selectHotCourseList() {
        return courseMapper.selectHotCourseList();
    }

    @Override
    public List<myCourseVo> selectCourseList(String type) {
        return courseMapper.selectCourseList(type);
    }

    @Override
    public List<String> selectCourseTypeList() {
        return courseMapper.selectCourseTypeList();
    }

    @Override
    public myCourseVo selectCourseDetail(Long cId) {
        return courseMapper.selectCourseDetail(cId);
    }

}