package com.ruoyi.mycourseresource.service;

import java.util.List;
import com.ruoyi.mycourseresource.domain.MyCourseResource;

public interface IExMyCourseResourceService
{
    public MyCourseResource selectMyCourseResourceById(Long reId);

    public List<MyCourseResource> selectMyCourseResourceList(MyCourseResource myCourseResource);
}
