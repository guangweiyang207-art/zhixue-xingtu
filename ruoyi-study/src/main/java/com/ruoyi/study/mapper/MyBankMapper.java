package com.ruoyi.study.mapper;

import java.util.List;
import com.ruoyi.study.domain.MyBank;

public interface MyBankMapper 
{
    public MyBank selectMyBankByHbId(Long hbId);
    public List<MyBank> selectMyBankList(MyBank myBank);
    public int insertMyBank(MyBank myBank);
    public int updateMyBank(MyBank myBank);
    public int deleteMyBankByHbId(Long hbId);
    public int deleteMyBankByHbIds(Long[] hbIds);
}
