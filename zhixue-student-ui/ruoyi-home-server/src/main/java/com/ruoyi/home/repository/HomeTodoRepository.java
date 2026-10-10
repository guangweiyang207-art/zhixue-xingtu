package com.ruoyi.home.repository;

import com.ruoyi.home.domain.HomeTodo;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface HomeTodoRepository extends JpaRepository<HomeTodo, Long> {
    List<HomeTodo> findByStatusOrderBySortOrderAsc(String status);
}
