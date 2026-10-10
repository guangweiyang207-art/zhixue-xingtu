package com.ruoyi.myadmin.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.myadmin.mapper.MyAdminMapper;
import com.ruoyi.myadmin.service.IMyAdminService;

@Service
public class MyAdminServiceImpl implements IMyAdminService
{
    @Autowired
    private MyAdminMapper myAdminMapper;
}