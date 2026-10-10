package com.ruoyi.study.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.study.mapper.MyBankMapper;
import com.ruoyi.study.domain.MyBank;
import com.ruoyi.study.service.IMyBankService;

@Service
public class MyBankServiceImpl implements IMyBankService
{
    @Autowired
    private MyBankMapper myBankMapper;

    @Override
    public MyBank selectMyBankByHbId(Long hbId)
    {
        return myBankMapper.selectMyBankByHbId(hbId);
    }

    @Override
    public List<MyBank> selectMyBankList(MyBank myBank)
    {
        return myBankMapper.selectMyBankList(myBank);
    }

    @Override
    public int insertMyBank(MyBank myBank)
    {
        return myBankMapper.insertMyBank(myBank);
    }

    @Override
    public int updateMyBank(MyBank myBank)
    {
        return myBankMapper.updateMyBank(myBank);
    }

    @Override
    public int deleteMyBankByHbIds(Long[] hbIds)
    {
        return myBankMapper.deleteMyBankByHbIds(hbIds);
    }

    @Override
    public int deleteMyBankByHbId(Long hbId)
    {
        return myBankMapper.deleteMyBankByHbId(hbId);
    }
}
