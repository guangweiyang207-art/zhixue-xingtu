package com.ruoyi.mine.mapper;

import com.ruoyi.mine.domain.Notice;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 消息通知Mapper接口（纯 MyBatis）
 * 数据源：sys_notice（公告）+ sys_notice_read（已读记录）
 *
 * @author ruoyi
 */
@Mapper
public interface LQYNoticeMapper
{
    /**
     * 查询消息通知列表（status='0' 正常公告），带当前用户是否已读
     * 返回 Notice 字段：id/title/content/type/createTime/updateTime/isRead
     */
    @Select("SELECT n.notice_id AS id, "
            + "n.notice_title AS title, "
            + "n.notice_type AS type, "
            + "n.notice_content AS content, "
            + "n.create_time AS createTime, "
            + "n.update_time AS updateTime, "
            + "(CASE WHEN EXISTS(SELECT 1 FROM sys_notice_read r "
            + "                  WHERE r.notice_id = n.notice_id AND r.user_id = #{userId}) "
            + "       THEN 1 ELSE 0 END) AS isRead "
            + "FROM sys_notice n "
            + "WHERE n.status = '0' "
            + "ORDER BY n.create_time DESC")
    List<Notice> selectNoticeList(@Param("userId") Long userId);

    /**
     * 当前用户的未读公告数
     */
    @Select("SELECT COUNT(*) FROM sys_notice n "
            + "WHERE n.status = '0' "
            + "AND NOT EXISTS(SELECT 1 FROM sys_notice_read r "
            + "                WHERE r.notice_id = n.notice_id AND r.user_id = #{userId})")
    int selectUnreadCount(@Param("userId") Long userId);

    /**
     * 标记消息为已读：向 sys_notice_read 插入一条记录（UNIQUE 索引保证幂等）
     */
    @Insert("INSERT IGNORE INTO sys_notice_read(notice_id, user_id, read_time) "
            + "VALUES(#{noticeId}, #{userId}, NOW())")
    int readNotice(@Param("noticeId") Long noticeId, @Param("userId") Long userId);

    /**
     * 标记消息为未读：删除已读记录
     */
    @org.apache.ibatis.annotations.Delete("DELETE FROM sys_notice_read WHERE notice_id = #{noticeId} AND user_id = #{userId}")
    int unreadNotice(@Param("noticeId") Long noticeId, @Param("userId") Long userId);
}
