package com.ruoyi.web.controller.myadmin;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.myadmin.service.IMyAdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/myadmin/admin")
public class MyAdminController extends BaseController
{
    @Autowired
    private IMyAdminService myAdminService;
}