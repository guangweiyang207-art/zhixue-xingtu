package com.ruoyi.taskmanage.mapper;

import com.ruoyi.taskmanage.domain.Notice;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface MXYNoticeMapper {

    List<Notice> selectNoticeList(Notice notice);

    Notice selectNoticeById(@Param("noticeId") Long noticeId);

    int insertNotice(Notice notice);

    int updateNotice(Notice notice);

    int deleteNoticeById(@Param("noticeId") Long noticeId);

    /** 按发送人(create_by=teacherId)统计通知发布总数 */
    int countByCreateBy(@Param("createBy") Long createBy);
}
