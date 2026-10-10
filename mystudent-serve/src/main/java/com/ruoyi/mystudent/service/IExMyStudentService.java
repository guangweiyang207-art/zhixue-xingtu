package com.ruoyi.mystudent.service;

import java.util.List;
import com.ruoyi.mystudent.domain.MyStudent;

public interface IExMyStudentService
{
    public MyStudent selectMyStudentById(Long stuId);

    public List<MyStudent> selectMyStudentList(MyStudent myStudent);

    public MyStudent selectMyStudentByUserId(Long userId);
}
