package com.ruoyi.business.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.business.mapper.MyNotificationMapper;
import com.ruoyi.business.domain.MyNotification;
import com.ruoyi.business.service.IMyNotificationService;

/**
 * 通知模块Service业务层处理
 * 
 * @author lhl
 * @date 2026-05-31
 */
@Service
public class MyNotificationServiceImpl implements IMyNotificationService 
{
    @Autowired
    private MyNotificationMapper myNotificationMapper;

    /**
     * 查询通知模块
     * 
     * @param notiId 通知模块主键
     * @return 通知模块
     */
    @Override
    public MyNotification selectMyNotificationByNotiId(Long notiId)
    {
        return myNotificationMapper.selectMyNotificationByNotiId(notiId);
    }

    /**
     * 查询通知模块列表
     * 
     * @param myNotification 通知模块
     * @return 通知模块
     */
    @Override
    public List<MyNotification> selectMyNotificationList(MyNotification myNotification)
    {
        return myNotificationMapper.selectMyNotificationList(myNotification);
    }

    /**
     * 新增通知模块
     * 
     * @param myNotification 通知模块
     * @return 结果
     */
    @Override
    public int insertMyNotification(MyNotification myNotification)
    {
        myNotification.setCreateTime(DateUtils.getNowDate());
        return myNotificationMapper.insertMyNotification(myNotification);
    }

    /**
     * 修改通知模块
     * 
     * @param myNotification 通知模块
     * @return 结果
     */
    @Override
    public int updateMyNotification(MyNotification myNotification)
    {
        myNotification.setUpdateTime(DateUtils.getNowDate());
        return myNotificationMapper.updateMyNotification(myNotification);
    }

    /**
     * 批量删除通知模块
     * 
     * @param notiIds 需要删除的通知模块主键
     * @return 结果
     */
    @Override
    public int deleteMyNotificationByNotiIds(Long[] notiIds)
    {
        return myNotificationMapper.deleteMyNotificationByNotiIds(notiIds);
    }

    /**
     * 删除通知模块信息
     * 
     * @param notiId 通知模块主键
     * @return 结果
     */
    @Override
    public int deleteMyNotificationByNotiId(Long notiId)
    {
        return myNotificationMapper.deleteMyNotificationByNotiId(notiId);
    }
}
