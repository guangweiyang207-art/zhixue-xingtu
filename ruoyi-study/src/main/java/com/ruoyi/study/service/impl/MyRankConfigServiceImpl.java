package com.ruoyi.study.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.study.mapper.MyRankConfigMapper;
import com.ruoyi.study.domain.MyRankConfig;
import com.ruoyi.study.service.IMyRankConfigService;

@Service
public class MyRankConfigServiceImpl implements IMyRankConfigService
{
    @Autowired
    private MyRankConfigMapper myRankConfigMapper;

    @Override
    public MyRankConfig selectMyRankConfigByRankId(Long rankId)
    {
        return myRankConfigMapper.selectMyRankConfigByRankId(rankId);
    }

    @Override
    public List<MyRankConfig> selectMyRankConfigList(MyRankConfig myRankConfig)
    {
        return myRankConfigMapper.selectMyRankConfigList(myRankConfig);
    }

    @Override
    public int insertMyRankConfig(MyRankConfig myRankConfig)
    {
        return myRankConfigMapper.insertMyRankConfig(myRankConfig);
    }

    @Override
    public int updateMyRankConfig(MyRankConfig myRankConfig)
    {
        return myRankConfigMapper.updateMyRankConfig(myRankConfig);
    }

    @Override
    public int deleteMyRankConfigByRankIds(Long[] rankIds)
    {
        return myRankConfigMapper.deleteMyRankConfigByRankIds(rankIds);
    }

    @Override
    public int deleteMyRankConfigByRankId(Long rankId)
    {
        return myRankConfigMapper.deleteMyRankConfigByRankId(rankId);
    }
}
