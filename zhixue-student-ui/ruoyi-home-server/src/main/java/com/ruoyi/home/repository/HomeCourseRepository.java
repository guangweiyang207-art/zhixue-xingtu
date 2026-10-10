package com.ruoyi.home.repository;

import com.ruoyi.home.domain.HomeCourse;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface HomeCourseRepository extends JpaRepository<HomeCourse, Long> {
    List<HomeCourse> findByStatusOrderBySortOrderAsc(String status);
}
