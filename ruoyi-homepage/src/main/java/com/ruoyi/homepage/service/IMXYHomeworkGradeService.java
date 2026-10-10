package com.ruoyi.homepage.service;

import com.ruoyi.homepage.domain.StudentHomeworkDetailVO;

public interface IMXYHomeworkGradeService {
    /**
     * 批改详情
     */
    StudentHomeworkDetailVO getDetail(Long shId);

    /**
     * 提交批改
     */
    int submitGrade(Long shId, Double score, String comment);
}
