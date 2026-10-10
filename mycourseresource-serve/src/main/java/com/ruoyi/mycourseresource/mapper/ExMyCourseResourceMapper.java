package com.ruoyi.mycourseresource.mapper;

import java.util.List;
import com.ruoyi.mycourseresource.domain.MyCourseResource;

public interface ExMyCourseResourceMapper
{
    public MyCourseResource selectMyCourseResourceById(Long reId);

    public List<MyCourseResource> selectMyCourseResourceList(MyCourseResource myCourseResource);
}
