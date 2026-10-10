package com.ruoyi.myerrorbook.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.myerrorbook.domain.MyErrorBook;
import com.ruoyi.myerrorbook.mapper.ExMyErrorBookMapper;
import com.ruoyi.myerrorbook.service.IExMyErrorBookService;

@Service
public class ExMyErrorBookServiceImpl implements IExMyErrorBookService
{
    @Autowired
    private ExMyErrorBookMapper exMyErrorBookMapper;

    @Override
    public List<MyErrorBook> selectMyErrorBookByStuId(Long stuId)
    {
        return exMyErrorBookMapper.selectMyErrorBookByStuId(stuId);
    }
}
