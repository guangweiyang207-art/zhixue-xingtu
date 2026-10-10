package com.ruoyi.home.repository;

import com.ruoyi.home.domain.HomeQuickLink;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface HomeQuickLinkRepository extends JpaRepository<HomeQuickLink, Long> {
    List<HomeQuickLink> findAllByOrderBySortOrderAsc();
}
