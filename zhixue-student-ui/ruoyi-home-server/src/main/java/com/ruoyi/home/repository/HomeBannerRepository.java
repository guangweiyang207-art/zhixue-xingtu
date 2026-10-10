package com.ruoyi.home.repository;

import com.ruoyi.home.domain.HomeBanner;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface HomeBannerRepository extends JpaRepository<HomeBanner, Long> {
    List<HomeBanner> findByStatusOrderBySortOrderAsc(String status);
}
