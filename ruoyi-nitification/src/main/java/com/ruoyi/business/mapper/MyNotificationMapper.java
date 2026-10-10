package com.ruoyi.business.mapper;

import java.util.List;
import com.ruoyi.business.domain.MyNotification;

/**
 * 通知模块Mapper接口
 * 
 * @author lhl
 * @date 2026-05-31
 */
public interface MyNotificationMapper 
{
    /**
     * 查询通知模块
     * 
     * @param notiId 通知模块主键
     * @return 通知模块
     */
    public MyNotification selectMyNotificationByNotiId(Long notiId);

    /**
     * 查询通知模块列表
     * 
     * @param myNotification 通知模块
     * @return 通知模块集合
     */
    public List<MyNotification> selectMyNotificationList(MyNotification myNotification);

    /**
     * 新增通知模块
     * 
     * @param myNotification 通知模块
     * @return 结果
     */
    public int insertMyNotification(MyNotification myNotification);

    /**
     * 修改通知模块
     * 
     * @param myNotification 通知模块
     * @return 结果
     */
    public int updateMyNotification(MyNotification myNotification);

    /**
     * 删除通知模块
     * 
     * @param notiId 通知模块主键
     * @return 结果
     */
    public int deleteMyNotificationByNotiId(Long notiId);

    /**
     * 批量删除通知模块
     * 
     * @param notiIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteMyNotificationByNotiIds(Long[] notiIds);
}
