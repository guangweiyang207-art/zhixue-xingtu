package com.ruoyi.mycourseresource.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.mycourseresource.mapper.ExMyCourseResourceMapper;
import com.ruoyi.mycourseresource.domain.MyCourseResource;
import com.ruoyi.mycourseresource.service.IExMyCourseResourceService;

@Service
public class ExMyCourseResourceServiceImpl implements IExMyCourseResourceService
{
    @Autowired
    private ExMyCourseResourceMapper exMyCourseResourceMapper;

    @Override
    public MyCourseResource selectMyCourseResourceById(Long reId)
    {
        return exMyCourseResourceMapper.selectMyCourseResourceById(reId);
    }

    @Override
    public List<MyCourseResource> selectMyCourseResourceList(MyCourseResource myCourseResource)
    {
        return exMyCourseResourceMapper.selectMyCourseResourceList(myCourseResource);
    }
}
