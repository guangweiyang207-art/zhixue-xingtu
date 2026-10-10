package com.ruoyi.home.controller;

import com.ruoyi.home.common.AjaxResult;
import com.ruoyi.home.service.HomeService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/edu/home")
public class HomeController {

    private final HomeService homeService;

    public HomeController(HomeService homeService) {
        this.homeService = homeService;
    }

    @GetMapping("/index")
    public AjaxResult index() {
        return AjaxResult.success(homeService.getHomeIndex());
    }

    @GetMapping("/banners")
    public AjaxResult banners() {
        return AjaxResult.success(homeService.getBanners());
    }

    @GetMapping("/quick-links")
    public AjaxResult quickLinks() {
        return AjaxResult.success(homeService.getQuickLinks());
    }

    @GetMapping("/todos")
    public AjaxResult todos() {
        return AjaxResult.success(homeService.getTodos());
    }

    @GetMapping("/courses")
    public AjaxResult courses() {
        return AjaxResult.success(homeService.getCourses());
    }

    @GetMapping("/stats")
    public AjaxResult stats() {
        return AjaxResult.success(homeService.getStats());
    }
}
