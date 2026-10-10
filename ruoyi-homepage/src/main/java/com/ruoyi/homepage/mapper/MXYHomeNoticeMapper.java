package com.ruoyi.homepage.mapper;

import com.ruoyi.taskmanage.domain.Notice;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 主页通知 Mapper(读 sys_notice)
 *
 * @author 马孝银
 */
@Mapper
public interface MXYHomeNoticeMapper {

    /** 主页展示的最近通知 */
    List<Notice> selectLatestNotices(@Param("limit") int limit);

    /** 主页按类型查询通知 */
    List<Notice> selectNoticesByType(@Param("noticeType") Integer noticeType, @Param("limit") int limit);
}
