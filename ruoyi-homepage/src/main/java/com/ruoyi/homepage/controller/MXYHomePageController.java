package com.ruoyi.homepage.controller;

import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.homepage.service.IMXYHomePageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * 主页聚合 Controller
 * 前端首屏调用: GET /homePage/load?teacherId=xxx
 *
 * @author 马孝银
 */
@Anonymous
@RestController
@RequestMapping("/homePage")
public class MXYHomePageController extends BaseController {

    @Autowired
    private IMXYHomePageService homePageService;

    /** 主页首屏聚合数据 */
    @GetMapping("/load")
    public AjaxResult load(@RequestParam(value = "teacherId", required = false) Long teacherId) {
        return AjaxResult.success(homePageService.loadHomePage(teacherId));
    }

    /** 最近通知 */
    @GetMapping("/notices")
    public AjaxResult notices(@RequestParam(value = "limit", defaultValue = "5") int limit) {
        return AjaxResult.success(homePageService.listLatestNotices(limit));
    }
}


