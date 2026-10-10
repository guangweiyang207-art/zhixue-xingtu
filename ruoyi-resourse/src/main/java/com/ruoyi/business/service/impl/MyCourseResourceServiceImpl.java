package com.ruoyi.business.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.business.mapper.MyCourseResourceMapper;
import com.ruoyi.business.domain.MyCourseResource;
import com.ruoyi.business.service.IMyCourseResourceService;

/**
 * 资源模块Service业务层处理
 * 
 * @author llhl
 * @date 2026-06-02
 */
@Service
public class MyCourseResourceServiceImpl implements IMyCourseResourceService 
{
    @Autowired
    private MyCourseResourceMapper myCourseResourceMapper;

    /**
     * 查询资源模块
     * 
     * @param reId 资源模块主键
     * @return 资源模块
     */
    @Override
    public MyCourseResource selectMyCourseResourceByReId(Long reId)
    {
        return myCourseResourceMapper.selectMyCourseResourceByReId(reId);
    }

    /**
     * 查询资源模块列表
     * 
     * @param myCourseResource 资源模块
     * @return 资源模块
     */
    @Override
    public List<MyCourseResource> selectMyCourseResourceList(MyCourseResource myCourseResource)
    {
        return myCourseResourceMapper.selectMyCourseResourceList(myCourseResource);
    }

    /**
     * 新增资源模块
     * 
     * @param myCourseResource 资源模块
     * @return 结果
     */
    @Override
    public int insertMyCourseResource(MyCourseResource myCourseResource)
    {
        myCourseResource.setCreateTime(DateUtils.getNowDate());
        return myCourseResourceMapper.insertMyCourseResource(myCourseResource);
    }

    /**
     * 修改资源模块
     * 
     * @param myCourseResource 资源模块
     * @return 结果
     */
    @Override
    public int updateMyCourseResource(MyCourseResource myCourseResource)
    {
        return myCourseResourceMapper.updateMyCourseResource(myCourseResource);
    }

    /**
     * 批量删除资源模块
     * 
     * @param reIds 需要删除的资源模块主键
     * @return 结果
     */
    @Override
    public int deleteMyCourseResourceByReIds(Long[] reIds)
    {
        return myCourseResourceMapper.deleteMyCourseResourceByReIds(reIds);
    }

    /**
     * 删除资源模块信息
     * 
     * @param reId 资源模块主键
     * @return 结果
     */
    @Override
    public int deleteMyCourseResourceByReId(Long reId)
    {
        return myCourseResourceMapper.deleteMyCourseResourceByReId(reId);
    }
}
