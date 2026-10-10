package com.ruoyi.study.service;

import java.util.List;
import com.ruoyi.study.domain.MyRankConfig;

public interface IMyRankConfigService 
{
    public MyRankConfig selectMyRankConfigByRankId(Long rankId);
    public List<MyRankConfig> selectMyRankConfigList(MyRankConfig myRankConfig);
    public int insertMyRankConfig(MyRankConfig myRankConfig);
    public int updateMyRankConfig(MyRankConfig myRankConfig);
    public int deleteMyRankConfigByRankIds(Long[] rankIds);
    public int deleteMyRankConfigByRankId(Long rankId);
}
