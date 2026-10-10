package com.ruoyi.study.service;

import java.util.List;
import com.ruoyi.study.domain.MyErrorBook;

public interface IMyErrorBookService 
{
    public MyErrorBook selectMyErrorBookByEbId(Long ebId);
    public List<MyErrorBook> selectMyErrorBookList(MyErrorBook myErrorBook);
    public int insertMyErrorBook(MyErrorBook myErrorBook);
    public int updateMyErrorBook(MyErrorBook myErrorBook);
    public int deleteMyErrorBookByEbIds(Long[] ebIds);
    public int deleteMyErrorBookByEbId(Long ebId);
}
