package com.ruoyi.homepage.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * 主页模块对 my_homework 表状态的写操作(批改时同步 status)
 *
 * 注:类名特意避开了 MXYHomeworkMapper,避免与 ruoyi-taskmanage 模块同名 Bean 冲突。
 *
 * @author assistant
 */
@Mapper
public interface MXYHomeworkStatusMapper
{
    /**
     * 批改作业时,精确按 (hw_id, std_id) 把 my_homework 的 status 改成 2(已批改)
     * @return 受影响行数
     */
    int updateStatusToGraded(@Param("hwId") Long hwId, @Param("stuId") Long stuId);

    /**
     * 兜底:只按 hw_id 更新(对应该作业的所有学生行都改 2)
     * 用于 (hw_id, std_id) 精确匹配影响 0 行时的兼容方案
     * @return 受影响行数
     */
    int updateStatusToGradedByHwId(@Param("hwId") Long hwId);
}
