package com.ruoyi.student.mapper;

import com.ruoyi.student.pojo.RankConfig;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.Map;

@Mapper
public interface RankMapper {
    Map<String, Object> getStudentScore(@Param("stuId") Long stuId);

    RankConfig getRankByScore(@Param("score") Integer score);

    RankConfig getNextRank(@Param("score") Integer score);
}