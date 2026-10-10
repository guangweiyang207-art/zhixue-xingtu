package com.ruoyi.taskmanage.mapper;

import com.ruoyi.taskmanage.domain.Homework;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 作业 Mapper 接口(纯 MyBatis,无 MyBatis-Plus)
 *
 * @author 马孝银
 */
@Mapper
public interface MXYHomeworkMapper {

    /** 查询全部 */
    List<Homework> selectHomeworkList(Homework homework);

    /** 按ID查询 */
    Homework selectHomeworkById(@Param("homeworkId") Long homeworkId);

    /** 按教师ID查询 */
    List<Homework> selectHomeworkByTeacherId(@Param("teacherId") Long teacherId);

    /** 统计某教师未批改的作业数(status=0) */
    long countPendingByTeacherId(@Param("teacherId") Long teacherId);

    /** 统计某教师发布的作业总数 */
    long countTotalByTeacherId(@Param("teacherId") Long teacherId);

    /** 新增 */
    int insertHomework(Homework homework);

    /** 批量新增:一次插入多条(foreach),返回影响行数 */
    int insertBatch(java.util.List<Homework> homeworks);

    /** 修改 */
    int updateHomework(Homework homework);

    /** 删除 */
    int deleteHomeworkById(@Param("homeworkId") Long homeworkId);
}
