package com.ruoyi.homepage.service.impl;

import com.ruoyi.homepage.domain.TodoHomework;
import com.ruoyi.homepage.mapper.MXYTodoHomeworkMapper;
import com.ruoyi.homepage.service.IMXYTodoHomeworkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MXYTodoHomeworkServiceImpl implements IMXYTodoHomeworkService {

    @Autowired
    private MXYTodoHomeworkMapper mapper;

    @Override
    public List<TodoHomework> listTodoHomework(Long teacherId) {
        return mapper.selectTodoHomeworkList(teacherId, 1);
    }
}
