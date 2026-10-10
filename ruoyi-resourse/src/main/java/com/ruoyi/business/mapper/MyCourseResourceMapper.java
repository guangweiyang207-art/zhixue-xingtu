package com.ruoyi.business.mapper;

import java.util.List;
import com.ruoyi.business.domain.MyCourseResource;

/**
 * 资源模块Mapper接口
 * 
 * @author llhl
 * @date 2026-06-02
 */
public interface MyCourseResourceMapper 
{
    /**
     * 查询资源模块
     * 
     * @param reId 资源模块主键
     * @return 资源模块
     */
    public MyCourseResource selectMyCourseResourceByReId(Long reId);

    /**
     * 查询资源模块列表
     * 
     * @param myCourseResource 资源模块
     * @return 资源模块集合
     */
    public List<MyCourseResource> selectMyCourseResourceList(MyCourseResource myCourseResource);

    /**
     * 新增资源模块
     * 
     * @param myCourseResource 资源模块
     * @return 结果
     */
    public int insertMyCourseResource(MyCourseResource myCourseResource);

    /**
     * 修改资源模块
     * 
     * @param myCourseResource 资源模块
     * @return 结果
     */
    public int updateMyCourseResource(MyCourseResource myCourseResource);

    /**
     * 删除资源模块
     * 
     * @param reId 资源模块主键
     * @return 结果
     */
    public int deleteMyCourseResourceByReId(Long reId);

    /**
     * 批量删除资源模块
     * 
     * @param reIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteMyCourseResourceByReIds(Long[] reIds);
}
