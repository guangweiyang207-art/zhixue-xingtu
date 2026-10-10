package com.ruoyi.homepage.controller;

import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.homepage.service.IMXYSearchService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * 主页全局搜索 Controller
 *
 * @author 马孝银
 */
@Anonymous
@RestController
@RequestMapping("/system/search")
public class MXYSearchController extends BaseController {

    @Autowired
    private IMXYSearchService searchService;

    @GetMapping
    public AjaxResult search(@RequestParam String keyword) {
        return AjaxResult.success(searchService.search(keyword));
    }
}


