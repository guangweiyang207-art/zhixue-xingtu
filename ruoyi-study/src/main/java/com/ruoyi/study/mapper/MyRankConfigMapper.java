package com.ruoyi.study.mapper;

import java.util.List;
import com.ruoyi.study.domain.MyRankConfig;

public interface MyRankConfigMapper 
{
    public MyRankConfig selectMyRankConfigByRankId(Long rankId);
    public List<MyRankConfig> selectMyRankConfigList(MyRankConfig myRankConfig);
    public int insertMyRankConfig(MyRankConfig myRankConfig);
    public int updateMyRankConfig(MyRankConfig myRankConfig);
    public int deleteMyRankConfigByRankId(Long rankId);
    public int deleteMyRankConfigByRankIds(Long[] rankIds);
}
