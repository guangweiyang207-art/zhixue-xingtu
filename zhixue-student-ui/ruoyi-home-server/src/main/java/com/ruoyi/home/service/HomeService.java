package com.ruoyi.home.service;

import com.ruoyi.home.domain.*;
import com.ruoyi.home.repository.*;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class HomeService {

    private final HomeBannerRepository bannerRepository;
    private final HomeQuickLinkRepository quickLinkRepository;
    private final HomeTodoRepository todoRepository;
    private final HomeCourseRepository courseRepository;
    private final HomeLearningStatsRepository statsRepository;

    public HomeService(HomeBannerRepository bannerRepository,
                       HomeQuickLinkRepository quickLinkRepository,
                       HomeTodoRepository todoRepository,
                       HomeCourseRepository courseRepository,
                       HomeLearningStatsRepository statsRepository) {
        this.bannerRepository = bannerRepository;
        this.quickLinkRepository = quickLinkRepository;
        this.todoRepository = todoRepository;
        this.courseRepository = courseRepository;
        this.statsRepository = statsRepository;
    }

    public Map<String, Object> getHomeIndex() {
        Map<String, Object> data = new HashMap<>();
        data.put("banners", getBanners());
        data.put("quickLinks", getQuickLinks());
        data.put("todos", getTodos());
        data.put("courses", getCourses());
        data.put("stats", getStats());
        return data;
    }

    public List<HomeBanner> getBanners() {
        return bannerRepository.findByStatusOrderBySortOrderAsc("0");
    }

    public List<HomeQuickLink> getQuickLinks() {
        return quickLinkRepository.findAllByOrderBySortOrderAsc();
    }

    public List<HomeTodo> getTodos() {
        return todoRepository.findByStatusOrderBySortOrderAsc("0");
    }

    public List<HomeCourse> getCourses() {
        return courseRepository.findByStatusOrderBySortOrderAsc("0");
    }

    public HomeLearningStats getStats() {
        return statsRepository.findAll().stream().findFirst().orElse(null);
    }
}
