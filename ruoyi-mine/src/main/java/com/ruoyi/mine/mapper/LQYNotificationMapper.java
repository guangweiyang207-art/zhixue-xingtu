package com.ruoyi.mine.mapper;

import com.ruoyi.mine.domain.Notification;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

/**
 * 通知发布Mapper接口（纯 MyBatis）
 *
 * @author ruoyi
 */
@Mapper
public interface LQYNotificationMapper
{
    /**
     * 查询通知列表
     */
    @Select("SELECT * FROM my_notification")
    List<Notification> selectNotificationList();

    /**
     * 标记通知为已读
     */
    @Update("UPDATE my_notification SET status = 1 WHERE noti_id = #{notiId}")
    int readNotice(@Param("notiId") Long notiId);

    /**
     * 标记通知为未读
     */
    @Update("UPDATE my_notification SET status = 0 WHERE noti_id = #{notiId}")
    int unreadNotice(@Param("notiId") Long notiId);

    /**
     * 查询未读通知数量
     */
    @Select("SELECT COUNT(*) FROM my_notification WHERE status = 0")
    int selectUnreadCount();
}
