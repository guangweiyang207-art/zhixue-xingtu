package com.ruoyi.study.service;

import java.util.List;
import com.ruoyi.study.domain.MyBank;

public interface IMyBankService 
{
    public MyBank selectMyBankByHbId(Long hbId);
    public List<MyBank> selectMyBankList(MyBank myBank);
    public int insertMyBank(MyBank myBank);
    public int updateMyBank(MyBank myBank);
    public int deleteMyBankByHbIds(Long[] hbIds);
    public int deleteMyBankByHbId(Long hbId);
}
