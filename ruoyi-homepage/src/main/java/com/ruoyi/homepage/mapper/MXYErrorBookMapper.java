package com.ruoyi.homepage.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * 错题本 Mapper(教师批改后自动收录错题)
 */
@Mapper
public interface MXYErrorBookMapper {

    /** 查询该学生是否已有此题的错题记录 */
    Integer countByStuAndQid(@Param("stuId") Long stuId, @Param("qId") Long qId);

    /** 新增错题记录 */
    int insertError(@Param("stuId") Long stuId,
                    @Param("qId") Long qId,
                    @Param("cId") Long cId,
                    @Param("wrongAnswer") String wrongAnswer,
                    @Param("correctAnswer") String correctAnswer,
                    @Param("tag") String tag);

    /** 重复错题:错误次数+1,重置为待复习 */
    int updateWrongAgain(@Param("stuId") Long stuId,
                         @Param("qId") Long qId,
                         @Param("wrongAnswer") String wrongAnswer);
}
