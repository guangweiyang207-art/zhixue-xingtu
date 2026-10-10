package com.ruoyi.study.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.study.mapper.MyErrorBookMapper;
import com.ruoyi.study.domain.MyErrorBook;
import com.ruoyi.study.service.IMyErrorBookService;

@Service
public class MyErrorBookServiceImpl implements IMyErrorBookService
{
    @Autowired
    private MyErrorBookMapper myErrorBookMapper;

    @Override
    public MyErrorBook selectMyErrorBookByEbId(Long ebId)
    {
        return myErrorBookMapper.selectMyErrorBookByEbId(ebId);
    }

    @Override
    public List<MyErrorBook> selectMyErrorBookList(MyErrorBook myErrorBook)
    {
        return myErrorBookMapper.selectMyErrorBookList(myErrorBook);
    }

    @Override
    public int insertMyErrorBook(MyErrorBook myErrorBook)
    {
        return myErrorBookMapper.insertMyErrorBook(myErrorBook);
    }

    @Override
    public int updateMyErrorBook(MyErrorBook myErrorBook)
    {
        return myErrorBookMapper.updateMyErrorBook(myErrorBook);
    }

    @Override
    public int deleteMyErrorBookByEbIds(Long[] ebIds)
    {
        return myErrorBookMapper.deleteMyErrorBookByEbIds(ebIds);
    }

    @Override
    public int deleteMyErrorBookByEbId(Long ebId)
    {
        return myErrorBookMapper.deleteMyErrorBookByEbId(ebId);
    }
}
