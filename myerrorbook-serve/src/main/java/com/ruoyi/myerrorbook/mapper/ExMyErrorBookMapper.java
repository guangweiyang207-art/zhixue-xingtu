package com.ruoyi.myerrorbook.mapper;

import java.util.List;
import com.ruoyi.myerrorbook.domain.MyErrorBook;

public interface ExMyErrorBookMapper
{
    public List<MyErrorBook> selectMyErrorBookByStuId(Long stuId);
}
