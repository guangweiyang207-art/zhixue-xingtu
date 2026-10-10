package com.ruoyi.errorbook.service;

import com.ruoyi.errorbook.pojo.ErrorBookVO;

import java.util.List;
import java.util.Map;

public interface ErrorBookService {
    /**
     * 获取学生的错题列表
     */
    List<ErrorBookVO> getErrorBookList(Long stuId, String subject);

    /**
     * 获取错题统计概览
     */
    Map<String, Object> getErrorBookStats(Long stuId);
}