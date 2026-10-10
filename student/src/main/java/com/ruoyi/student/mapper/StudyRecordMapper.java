package com.ruoyi.student.mapper;

import com.ruoyi.student.pojo.StudyRecordRow;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface StudyRecordMapper {
    // ==================== 1. 基础展示 ====================
    StudyRecordRow getStudentInfo(@Param("stuId") Long stuId);
    List<StudyRecordRow> getStudentCourses(@Param("stuId") Long stuId);
    List<StudyRecordRow> getCourseResources(@Param("cId") Long cId);

    // ==================== 2. 做题业务 ====================
    List<StudyRecordRow> getPracticeRecords(@Param("stuId") Long stuId);
    List<StudyRecordRow> getRecentRecords(@Param("stuId") Long stuId);
    List<StudyRecordRow> getAllRecords(@Param("stuId") Long stuId);
    List<Map<String, Object>> getErrorBookStats(@Param("stuId") Long stuId);

    // ==================== 3. 课程进度 ====================
    List<Map<String, Object>> getCourseProgress(@Param("stuId") Long stuId);

    // ==================== 4. 统计业务 ====================
    List<Map<String, Object>> getStudyReports(@Param("stuId") Long stuId);
    List<Map<String, Object>> getRankConfigs();
    Map<String, Object> getLatestReport(@Param("stuId") Long stuId);

    // ==================== 5. 辅助 ====================
    List<Map<String, Object>> getTaskReminders(@Param("stuId") Long stuId);
    List<Map<String, Object>> getPendingHomework(@Param("stuId") Long stuId);

    // ==================== 6. 学习报告实时统计 ====================
    /** 已批改作业数 */
    Integer countGradedHomework(@Param("stuId") Long stuId);
    /** 平均正确率(score/total_score) */
    Integer getAvgCorrectRate(@Param("stuId") Long stuId);
    /** 累计学习时长(分钟,来自 my_study_record) */
    Integer getStudyDurationSum(@Param("stuId") Long stuId);
    /** 近7天每日完成作业数: day(yyyy-MM-dd), cnt */
    List<Map<String, Object>> getWeekHomeworkTrend(@Param("stuId") Long stuId);
    /** 各科掌握情况: course_type, avgRate */
    List<Map<String, Object>> getSubjectMastery(@Param("stuId") Long stuId);
}