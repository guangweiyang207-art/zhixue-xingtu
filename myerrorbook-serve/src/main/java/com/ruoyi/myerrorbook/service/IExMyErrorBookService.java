package com.ruoyi.myerrorbook.service;

import java.util.List;
import com.ruoyi.myerrorbook.domain.MyErrorBook;

public interface IExMyErrorBookService
{
    public List<MyErrorBook> selectMyErrorBookByStuId(Long stuId);
}
