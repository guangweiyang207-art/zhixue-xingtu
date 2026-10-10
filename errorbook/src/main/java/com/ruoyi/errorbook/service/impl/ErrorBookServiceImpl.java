package com.ruoyi.errorbook.service.impl;

import com.ruoyi.errorbook.mapper.ErrorBookMapper;
import com.ruoyi.errorbook.pojo.ErrorBookRow;
import com.ruoyi.errorbook.pojo.ErrorBookVO;
import com.ruoyi.errorbook.service.ErrorBookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ErrorBookServiceImpl implements ErrorBookService {

    @Autowired
    private ErrorBookMapper errorBookMapper;

    /** 课程类型 -> 科目标识映射 */
    private static final Map<String, String> TYPE_TO_SUBJECT = new HashMap<>();
    /** 科目标识 -> 中文名映射 */
    private static final Map<String, String> SUBJECT_TO_NAME = new HashMap<>();

    static {
        TYPE_TO_SUBJECT.put("math", "math");
        TYPE_TO_SUBJECT.put("physics", "physics");
        TYPE_TO_SUBJECT.put("english", "english");
        TYPE_TO_SUBJECT.put("chemistry", "chemistry");

        SUBJECT_TO_NAME.put("math", "数学");
        SUBJECT_TO_NAME.put("physics", "物理");
        SUBJECT_TO_NAME.put("english", "英语");
        SUBJECT_TO_NAME.put("chemistry", "化学");
    }

    @Override
    public List<ErrorBookVO> getErrorBookList(Long stuId, String subject) {
        List<ErrorBookRow> rows;
        if (subject == null || subject.isEmpty() || "all".equals(subject)) {
            rows = errorBookMapper.getErrorBookList(stuId);
        } else {
            // 将前端subject映射为course.type
            String courseType = mapSubjectToType(subject);
            rows = errorBookMapper.getErrorBookListBySubject(stuId, courseType);
        }

        List<ErrorBookVO> result = new ArrayList<>();
        for (ErrorBookRow row : rows) {
            result.add(convertToVO(row));
        }
        return result;
    }

    @Override
    public Map<String, Object> getErrorBookStats(Long stuId) {
        int total = errorBookMapper.countErrorBook(stuId);
        int pending = errorBookMapper.countPendingErrors(stuId);
        int mastered = errorBookMapper.countMasteredErrors(stuId);
        int masteryRate = total > 0 ? (mastered * 100 / total) : 0;

        Map<String, Object> stats = new HashMap<>();
        stats.put("total", total);
        stats.put("pending", pending);
        stats.put("mastered", mastered);
        stats.put("masteryRate", masteryRate);
        return stats;
    }

    private ErrorBookVO convertToVO(ErrorBookRow row) {
        ErrorBookVO vo = new ErrorBookVO();
        vo.setEbId(row.getEbId());

        // 设置科目标识
        String courseType = row.getCourseType();
        String subject = TYPE_TO_SUBJECT.getOrDefault(courseType, "other");
        vo.setSubject(subject);
        vo.setSubjectName(SUBJECT_TO_NAME.getOrDefault(subject, "其他"));

        // 设置课程名称
        vo.setCourseName(row.getCourseName() != null ? row.getCourseName() : "");

        // 使用tag作为题目描述（my_error_book没有直接存储题目内容）
        vo.setQuestion(row.getTag() != null ? row.getTag() : "");

        // 设置答案
        vo.setWrongAnswer(row.getWrongAnswer() != null ? row.getWrongAnswer() : "");
        vo.setCorrectAnswer(row.getCorrectAnswer() != null ? row.getCorrectAnswer() : "");
        vo.setAnalysis(row.getAnalysis() != null ? row.getAnalysis() : "");
        vo.setTag(row.getTag() != null ? row.getTag() : "");
        vo.setErrorCount(row.getErrorCount() != null ? row.getErrorCount() : 0);

        // 掌握状态
        Integer isMastered = row.getIsMastered();
        vo.setIsMastered(isMastered != null ? isMastered : 0);
        vo.setStatus((isMastered != null && isMastered == 1) ? "mastered" : "pending");

        // 最后错误时间
        LocalDateTime lastTime = row.getLastWrongTime();
        if (lastTime != null) {
            vo.setDate(lastTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
        } else {
            vo.setDate("未知");
        }

        // 掌握率：单个错题的掌握率，已掌握为100，待复习为0
        vo.setMasteryRate((isMastered != null && isMastered == 1) ? 100 : 0);

        return vo;
    }

    private String mapSubjectToType(String subject) {
        switch (subject) {
            case "math": return "math";
            case "physics": return "physics";
            case "english": return "english";
            case "chemistry": return "chemistry";
            default: return subject;
        }
    }
}