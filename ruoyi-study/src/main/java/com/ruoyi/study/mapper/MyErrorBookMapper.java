package com.ruoyi.study.mapper;

import java.util.List;
import com.ruoyi.study.domain.MyErrorBook;

public interface MyErrorBookMapper 
{
    public MyErrorBook selectMyErrorBookByEbId(Long ebId);
    public List<MyErrorBook> selectMyErrorBookList(MyErrorBook myErrorBook);
    public int insertMyErrorBook(MyErrorBook myErrorBook);
    public int updateMyErrorBook(MyErrorBook myErrorBook);
    public int deleteMyErrorBookByEbId(Long ebId);
    public int deleteMyErrorBookByEbIds(Long[] ebIds);
}
