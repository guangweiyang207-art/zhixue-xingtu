package com.ruoyi.taskmanage.service.impl;

import com.ruoyi.taskmanage.domain.CourseResource;
import com.ruoyi.taskmanage.mapper.MXYCourseResourceMapper;
import com.ruoyi.taskmanage.service.IMXYCourseResourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MXYCourseResourceServiceImpl implements IMXYCourseResourceService {

    @Autowired private MXYCourseResourceMapper mapper;

    @Override public List<CourseResource> selectCourseResourceList(CourseResource c) { return mapper.selectCourseResourceList(c); }
    @Override public CourseResource selectCourseResourceById(Long resourceId) { return mapper.selectCourseResourceById(resourceId); }
    @Override public int insertCourseResource(CourseResource c) { return mapper.insertCourseResource(c); }
    @Override public int updateCourseResource(CourseResource c) { return mapper.updateCourseResource(c); }
    @Override public int deleteCourseResourceById(Long resourceId) { return mapper.deleteCourseResourceById(resourceId); }
}
