package com.ruoyi.home.config;

import com.ruoyi.home.domain.*;
import com.ruoyi.home.repository.*;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class DataInitializer implements CommandLineRunner {

    private final HomeBannerRepository bannerRepository;
    private final HomeQuickLinkRepository quickLinkRepository;
    private final HomeTodoRepository todoRepository;
    private final HomeCourseRepository courseRepository;
    private final HomeLearningStatsRepository statsRepository;

    public DataInitializer(HomeBannerRepository bannerRepository,
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

    @Override
    public void run(String... args) {
        if (bannerRepository.count() > 0) {
            return;
        }

        HomeBanner banner = new HomeBanner();
        banner.setTitle("暑期AI编程特训营");
        banner.setSubtitle("限时5折优惠，名额有限");
        banner.setImageUrl("https://images.unsplash.com/photo-1503676260728-1c00da094a0b?w=800&h=400&fit=crop");
        banner.setSortOrder(1);
        bannerRepository.save(banner);

        saveQuickLink("教学资源", "images-filled", "#EEF4FF", "#3B82F6", 1);
        saveQuickLink("作业测试", "compose", "#F3F0FF", "#6B5AED", 2);
        saveQuickLink("错题本", "flag-filled", "#FFF7ED", "#F97316", 3);
        saveQuickLink("学习报告", "bars", "#F0FDF4", "#22C55E", 4);

        HomeTodo todo1 = new HomeTodo();
        todo1.setTitle("数学：导数应用习题集");
        todo1.setSubtitle("截止日期：今天 18:00");
        todo1.setAccentColor("#3B82F6");
        todo1.setButtonText("去完成");
        todo1.setButtonColor("#EEF4FF");
        todo1.setSortOrder(1);
        todoRepository.save(todo1);

        HomeTodo todo2 = new HomeTodo();
        todo2.setTitle("英语：听力模拟测试 (Unit 4)");
        todo2.setSubtitle("预计耗时：25分钟");
        todo2.setAccentColor("#6B5AED");
        todo2.setButtonText("开始");
        todo2.setButtonColor("#F3F0FF");
        todo2.setSortOrder(2);
        todoRepository.save(todo2);

        HomeCourse course1 = new HomeCourse();
        course1.setTitle("Python 趣味编程进阶");
        course1.setInstructor("张建国");
        course1.setLessonCount(12);
        course1.setProgress(65);
        course1.setCoverUrl("https://images.unsplash.com/photo-1515879218367-8466d910aaa4?w=200&h=200&fit=crop");
        course1.setSortOrder(1);
        courseRepository.save(course1);

        HomeCourse course2 = new HomeCourse();
        course2.setTitle("数学思维训练营");
        course2.setInstructor("李老师");
        course2.setLessonCount(8);
        course2.setProgress(32);
        course2.setCoverUrl("https://images.unsplash.com/photo-1635070041078-e363dbe005cb?w=200&h=200&fit=crop");
        course2.setSortOrder(2);
        courseRepository.save(course2);

        HomeLearningStats stats = new HomeLearningStats();
        stats.setTodayStudyHours(2.5);
        stats.setWeeklyHomeworkCount(8);
        stats.setAccuracyRate(87);
        stats.setTotalQuestions(356);
        statsRepository.save(stats);
    }

    private void saveQuickLink(String name, String icon, String bgColor, String iconColor, int sort) {
        HomeQuickLink link = new HomeQuickLink();
        link.setName(name);
        link.setIcon(icon);
        link.setBgColor(bgColor);
        link.setIconColor(iconColor);
        link.setSortOrder(sort);
        quickLinkRepository.save(link);
    }
}
