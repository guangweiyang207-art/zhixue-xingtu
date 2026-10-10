package com.ruoyi.mystudent.mapper;

import java.util.List;
import com.ruoyi.mystudent.domain.MyStudent;

public interface ExMyStudentMapper
{
    public MyStudent selectMyStudentById(Long stuId);

    public List<MyStudent> selectMyStudentList(MyStudent myStudent);

    public MyStudent selectMyStudentByUserId(Long userId);
}
