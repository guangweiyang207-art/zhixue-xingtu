package com.ruoyi.web.controller.errorbook;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.myerrorbook.service.IExMyErrorBookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/errorbook/errorbook")
public class ExMyErrorBookController extends BaseController
{
    @Autowired
    private IExMyErrorBookService exMyErrorBookService;
}
