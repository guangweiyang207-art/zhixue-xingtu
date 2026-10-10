package com.ruoyi.homepage.service.impl;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ruoyi.homepage.domain.StudentHomeworkDetailVO;
import com.ruoyi.homepage.domain.StudentHomeworkDetailVO.QuestionForGrade;
import com.ruoyi.homepage.mapper.MXYErrorBookMapper;
import com.ruoyi.homepage.mapper.MXYHomeworkStatusMapper;
import com.ruoyi.homepage.mapper.MXYQuestionGradeMapper;
import com.ruoyi.homepage.mapper.MXYStudentHomeworkMapper;
import com.ruoyi.homepage.service.IMXYHomeworkGradeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class MXYHomeworkGradeServiceImpl implements IMXYHomeworkGradeService {

    @Autowired
    private MXYStudentHomeworkMapper shMapper;

    @Autowired
    private MXYQuestionGradeMapper questionMapper;

    @Autowired
    private MXYHomeworkStatusMapper homeworkStatusMapper;

    @Autowired
    private MXYErrorBookMapper errorBookMapper;

    @Override
    public StudentHomeworkDetailVO getDetail(Long shId) {
        StudentHomeworkDetailVO vo = shMapper.selectDetail(shId);
        if (vo == null) return null;
        // 1) 拉题目
        List<QuestionForGrade> qs = questionMapper.selectByHwId(vo.getHwId());
        // 2) 解析学生作答
        Map<String, String> answerMap = new HashMap<>();
        if (vo.getAnswers() != null && !vo.getAnswers().isEmpty()) {
            try {
                ObjectMapper om = new ObjectMapper();
                Map<?,?> m = om.readValue(vo.getAnswers(), Map.class);
                for (Map.Entry<?,?> e : m.entrySet()) {
                    answerMap.put(String.valueOf(e.getKey()), String.valueOf(e.getValue()));
                }
            } catch (Exception ignore) {}
        }
        // 3) 拼装并自动判分(客观题)
        for (QuestionForGrade q : qs) {
            String sa = answerMap.get(String.valueOf(q.getQId()));
            q.setStudentAnswer(sa);
            if (q.getCorrectAnswer() != null && sa != null) {
                Integer type = q.getQuestionType();
                if (type != null && (type == 1 || type == 2 || type == 3)) {
                    // 1-单选 2-多选 3-判断:统一去空白、逗号分隔后排序比较
                    String ca = normalize(q.getCorrectAnswer());
                    String ua = normalize(sa);
                    q.setCorrect(ca.equalsIgnoreCase(ua));
                }
            }
        }
        vo.setQuestions(qs);
        return vo;
    }

    private String normalize(String s) {
        if (s == null) return "";
        // 多选用 , ; 或中文逗号分隔
        String[] arr = s.trim().toUpperCase()
                .split("[,;\\s，；]+");
        Arrays.sort(arr);
        return String.join(",", arr);
    }

    @Override
    public int submitGrade(Long shId, Double score, String comment) {
        // 1) 先把 my_student_homework 状态改成 2(已批改)+ 写分数/评语
        int rows = shMapper.updateGrade(shId, score, comment);
        if (rows == 0) {
            return 0;
        }
        // 2) ★ 同步更新 my_homework.status = 2(已批改)
        //    先取 shId 对应的 (hw_id, stu_id)
        StudentHomeworkDetailVO vo = shMapper.selectDetail(shId);
        if (vo != null && vo.getHwId() != null) {
            Long hwId = vo.getHwId();
            Long stuId = vo.getStuId();
            // 主路径:按 (hw_id, std_id) 精确更新
            int hwAffected = (stuId != null)
                    ? homeworkStatusMapper.updateStatusToGraded(hwId, stuId)
                    : 0;
            System.out.println("[grade] my_homework 同步 status=2 主路径, hwId=" + hwId + ", stuId=" + stuId + ", affected=" + hwAffected);
            // 兜底:主路径影响 0 行时,按 hw_id 全量更新(兼容历史脏数据)
            if (hwAffected == 0) {
                int hwFallback = homeworkStatusMapper.updateStatusToGradedByHwId(hwId);
                System.out.println("[grade] my_homework 同步 status=2 兜底路径, hwId=" + hwId + ", affected=" + hwFallback);
            }
            // 3) ★ 闭环:批改后将客观题错题/未答题自动收录进错题本
            syncErrorBook(shId);
        }
        return rows;
    }

    /**
     * 批改完成后,把客观题(单选/多选/判断)中答错或未作答的题目写入 my_error_book。
     * 已有记录则错误次数+1 并重置为待复习。
     */
    private void syncErrorBook(Long shId) {
        try {
            StudentHomeworkDetailVO vo = getDetail(shId);
            if (vo == null || vo.getStuId() == null) return;
            List<QuestionForGrade> qs = vo.getQuestions();
            if (qs == null || qs.isEmpty()) return;

            int added = 0;
            for (QuestionForGrade q : qs) {
                Integer type = q.getQuestionType();
                boolean objective = type != null && (type == 1 || type == 2 || type == 3);
                // 只处理客观题,且有标准答案,且答错或未作答
                if (!objective || q.getCorrectAnswer() == null) continue;
                if (q.getCorrect() != null && q.getCorrect()) continue;

                String wrong = (q.getStudentAnswer() == null || q.getStudentAnswer().trim().isEmpty())
                        ? "未作答" : q.getStudentAnswer();
                String tag = q.getQuestionContent();
                if (tag != null && tag.length() > 100) {
                    tag = tag.substring(0, 100);
                }
                Integer exists = errorBookMapper.countByStuAndQid(vo.getStuId(), q.getQId());
                if (exists != null && exists > 0) {
                    errorBookMapper.updateWrongAgain(vo.getStuId(), q.getQId(), wrong);
                } else {
                    errorBookMapper.insertError(vo.getStuId(), q.getQId(), vo.getcId(),
                            wrong, q.getCorrectAnswer(), tag);
                }
                added++;
            }
            System.out.println("[grade] 错题本同步完成, shId=" + shId + ", stuId=" + vo.getStuId() + ", 新增/更新错题=" + added);
        } catch (Exception e) {
            // 错题本收录失败不影响批改主流程
            System.err.println("[grade] 错题本同步失败, shId=" + shId + ": " + e.getMessage());
        }
    }
}
