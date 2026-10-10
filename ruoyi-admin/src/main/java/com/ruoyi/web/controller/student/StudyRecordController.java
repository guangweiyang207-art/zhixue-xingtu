package com.ruoyi.web.controller.student;

import com.ruoyi.common.R;
import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.student.mapper.StudyRecordMapper;
import com.ruoyi.student.pojo.StudyRecordRow;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Anonymous
@RestController
@RequestMapping("/mine/study")
public class StudyRecordController {

    private static final String[] WEEK_DAYS = {"周日", "周一", "周二", "周三", "周四", "周五", "周六"};
    private static final String[] STUDY_TYPES = {"", "视频学习", "文档学习", "做题练习", "其他"};
    private static final String[] STUDY_TYPE_ICONS = {"", "📺", "📄", "✏️", "📌"};

    @Autowired
    private StudyRecordMapper studyRecordMapper;

    // ========================================================================
    //  接口1：个人信息
    //  返回：姓名、头像、班级、专业、年级、段位、积分、总做题数、正确率、学时
    // ========================================================================
    @GetMapping("/profile")
    public R getProfile(@RequestParam("stu_id") Long stuId) {
        StudyRecordRow student = studyRecordMapper.getStudentInfo(stuId);
        if (student == null) {
            return R.error("未找到该学生信息");
        }
        Map<String, Object> info = new LinkedHashMap<>();
        info.put("stuId", student.getStuId());
        info.put("realName", defaultStr(student.getRealName()));
        info.put("avatar", defaultStr(student.getAvatar()));
        info.put("major", defaultStr(student.getMajor()));
        info.put("grade", defaultStr(student.getGrade()));
        info.put("className", defaultStr(student.getClassName()));
        info.put("rankLevel", defaultStr(student.getRankLevel()));
        info.put("rankScore", defaultInt(student.getRankScore()));
        info.put("totalQuestions", defaultInt(student.getTotalQuestions()));
        info.put("correctQuestions", defaultInt(student.getCorrectQuestions()));
        info.put("studyHours", student.getStudyHours() != null ? student.getStudyHours() : BigDecimal.ZERO);

        // 正确率
        Integer total = student.getTotalQuestions();
        Integer correct = student.getCorrectQuestions();
        if (total != null && total > 0 && correct != null) {
            info.put("correctRate", correct * 100 / total);
        } else {
            info.put("correctRate", 0);
        }
        return R.success(info);
    }

    // ========================================================================
    //  接口2：学习记录列表
    //  返回：提交时间、课程名称、作业标题、得分/总分、正确率、教师评语
    // ========================================================================
    @GetMapping("/records")
    public R getRecords(@RequestParam("stu_id") Long stuId) {
        List<StudyRecordRow> rows = studyRecordMapper.getAllRecords(stuId);
        List<Map<String, Object>> records = new ArrayList<>();
        DateTimeFormatter dateFmt = DateTimeFormatter.ofPattern("yyyy/MM/dd");
        DateTimeFormatter timeFmt = DateTimeFormatter.ofPattern("HH:mm");
        DateTimeFormatter fullFmt = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

        for (StudyRecordRow row : rows) {
            Map<String, Object> r = new LinkedHashMap<>();
            LocalDateTime submitTime = row.getSubmitTime();
            if (submitTime != null) {
                r.put("submitDate", submitTime.format(dateFmt));
                r.put("submitTime", submitTime.format(timeFmt));
                r.put("fullSubmitTime", submitTime.format(fullFmt));
                int dayOfWeek = submitTime.getDayOfWeek().getValue() % 7;
                r.put("weekDay", WEEK_DAYS[dayOfWeek]);
            } else {
                r.put("submitDate", "");
                r.put("submitTime", "");
                r.put("fullSubmitTime", "");
                r.put("weekDay", "");
            }

            r.put("cName", defaultStr(row.getCName()));
            r.put("courseType", defaultStr(row.getCourseType()));
            r.put("courseTag", defaultStr(row.getCourseTag()));
            r.put("title", defaultStr(row.getTitle()));
            r.put("content", defaultStr(row.getContent()));
            r.put("questionCount", defaultInt(row.getQuestionCount()));
            r.put("studentScore", row.getStudentScore() != null ? row.getStudentScore() : BigDecimal.ZERO);
            r.put("totalScore", defaultInt(row.getTotalScore()));
            r.put("teacherComment", defaultStr(row.getTeacherComment()));
            r.put("deadline", row.getDeadline() != null ? row.getDeadline().format(dateFmt) : "");

            // 正确率
            BigDecimal sScore = row.getStudentScore();
            Integer tScore = row.getTotalScore();
            if (sScore != null && tScore != null && tScore > 0) {
                r.put("accuracyPercent", sScore.intValue() * 100 / tScore);
            } else {
                r.put("accuracyPercent", 0);
            }
            records.add(r);
        }
        return R.success(records);
    }

    // ========================================================================
    //  接口3：课程进度
    //  返回：课程名称、类型、进度百分比、状态、成绩、资源数
    // ========================================================================
    @GetMapping("/progress")
    public R getProgress(@RequestParam("stu_id") Long stuId) {
        return R.success(studyRecordMapper.getCourseProgress(stuId));
    }

    // ========================================================================
    //  接口4：学情报告
    //  返回：报告类型(日报/周报/月报)、日期、学习时长、完成课程/作业、正确率、薄弱点
    // ========================================================================
    @GetMapping("/reports")
    public R getReports(@RequestParam("stu_id") Long stuId) {
        Map<String, Object> result = new LinkedHashMap<>();
        result.put("reports", studyRecordMapper.getStudyReports(stuId));
        result.put("latest", studyRecordMapper.getLatestReport(stuId));
        result.put("rankConfigs", studyRecordMapper.getRankConfigs());
        return R.success(result);
    }

    // ==================== 以下为原有的聚合接口，保留不动 ====================
    @GetMapping("/dashboard")
    public R getDashboard(@RequestParam("stu_id") Long stuId) {
        Map<String, Object> dashboard = new LinkedHashMap<>();

        // ====== 1. 基础展示：学生信息 ======
        StudyRecordRow student = studyRecordMapper.getStudentInfo(stuId);
        if (student != null) {
            Map<String, Object> studentInfo = new LinkedHashMap<>();
            studentInfo.put("stuId", student.getStuId());
            studentInfo.put("realName", student.getRealName() != null ? student.getRealName() : "");
            studentInfo.put("avatar", student.getAvatar() != null ? student.getAvatar() : "");
            studentInfo.put("major", student.getMajor() != null ? student.getMajor() : "");
            studentInfo.put("grade", student.getGrade() != null ? student.getGrade() : "");
            studentInfo.put("rankLevel", student.getRankLevel() != null ? student.getRankLevel() : "");
            studentInfo.put("rankScore", student.getRankScore() != null ? student.getRankScore() : 0);
            studentInfo.put("totalQuestions", student.getTotalQuestions() != null ? student.getTotalQuestions() : 0);
            studentInfo.put("correctQuestions", student.getCorrectQuestions() != null ? student.getCorrectQuestions() : 0);
            studentInfo.put("studyHours", student.getStudyHours() != null ? student.getStudyHours() : 0);

            // 正确率
            if (student.getTotalQuestions() != null && student.getTotalQuestions() > 0) {
                int correctRate = student.getCorrectQuestions() * 100 / student.getTotalQuestions();
                studentInfo.put("correctRate", correctRate);
            } else {
                studentInfo.put("correctRate", 0);
            }
            dashboard.put("studentInfo", studentInfo);
        }

        // ====== 1. 基础展示：课程列表 ======
        List<StudyRecordRow> courses = studyRecordMapper.getStudentCourses(stuId);
        List<Map<String, Object>> courseList = new ArrayList<>();
        for (StudyRecordRow c : courses) {
            Map<String, Object> cm = new LinkedHashMap<>();
            cm.put("cId", c.getCId());
            cm.put("cName", c.getCName());
            cm.put("courseType", c.getCourseType());
            cm.put("courseTag", c.getCourseTag());
            cm.put("difficulty", c.getDifficulty());
            cm.put("progress", c.getProgress() != null ? c.getProgress() : 0);
            dashboard.put("studyingCourse", cm);
            break; // 只取第一个进行中的课程
        }
        dashboard.put("courseCount", courses.size());

        // ====== 2. 做题业务：全部做题记录（学习记录页主列表） ======
        List<StudyRecordRow> rows = studyRecordMapper.getAllRecords(stuId);
        List<Map<String, Object>> records = new ArrayList<>();
        DateTimeFormatter dateFmt = DateTimeFormatter.ofPattern("yyyy/MM/dd");
        DateTimeFormatter timeFmt = DateTimeFormatter.ofPattern("HH:mm");
        DateTimeFormatter fullFmt = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

        for (StudyRecordRow row : rows) {
            Map<String, Object> record = new LinkedHashMap<>();
            LocalDateTime submitTime = row.getSubmitTime();
            if (submitTime != null) {
                record.put("fullSubmitTime", submitTime.format(fullFmt));
                record.put("submitDate", submitTime.format(dateFmt));
                record.put("submitTime", submitTime.format(timeFmt));
                int dayOfWeek = submitTime.getDayOfWeek().getValue() % 7;
                record.put("weekDay", WEEK_DAYS[dayOfWeek]);
            } else {
                record.put("fullSubmitTime", "");
                record.put("submitDate", "未知日期");
                record.put("submitTime", "");
                record.put("weekDay", "");
            }

            record.put("cName", row.getCName() != null ? row.getCName() : "");
            record.put("courseType", row.getCourseType() != null ? row.getCourseType() : "");
            record.put("courseTag", row.getCourseTag() != null ? row.getCourseTag() : "");
            record.put("title", row.getTitle() != null ? row.getTitle() : "");
            record.put("homeworkContent", row.getContent() != null ? row.getContent() : "");

            String cName = row.getCName();
            String title = row.getTitle();
            if (cName != null) {
                String shortName = cName.contains("：") ? cName.split("：")[0] : cName;
                record.put("subject", shortName + " · " + (title != null ? title : ""));
            } else {
                record.put("subject", title != null ? title : "");
            }

            Integer questionCount = row.getQuestionCount();
            record.put("questionCount", questionCount != null ? questionCount : 0);
            record.put("count", (questionCount != null ? questionCount : 0) + "题");

            BigDecimal studentScore = row.getStudentScore();
            Integer totalScore = row.getTotalScore();
            record.put("studentScore", studentScore != null ? studentScore : 0);
            record.put("totalScore", totalScore != null ? totalScore : 0);

            if (studentScore != null && totalScore != null && totalScore > 0) {
                int rate = studentScore.intValue() * 100 / totalScore;
                record.put("accuracyPercent", rate);
                record.put("rate", "正确率 " + rate + "%");
            } else {
                record.put("accuracyPercent", 0);
                record.put("rate", "正确率 0%");
            }

            record.put("teacherComment", row.getTeacherComment() != null ? row.getTeacherComment() : "");
            LocalDateTime correctTime = row.getCorrectTime();
            record.put("correctTime", correctTime != null ? correctTime.format(DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm")) : "");
            LocalDateTime deadline = row.getDeadline();
            record.put("deadline", deadline != null ? deadline.format(dateFmt) : "");

            records.add(record);
        }
        dashboard.put("records", records);

        // ====== 2. 做题业务：错题本统计 ======
        List<Map<String, Object>> errorStats = studyRecordMapper.getErrorBookStats(stuId);
        dashboard.put("errorBookStats", errorStats);

        // ====== 3. 课程进度 ======
        List<Map<String, Object>> courseProgress = studyRecordMapper.getCourseProgress(stuId);
        dashboard.put("courseProgress", courseProgress);

        // ====== 4. 统计业务：学情报表 ======
        List<Map<String, Object>> reports = studyRecordMapper.getStudyReports(stuId);
        dashboard.put("studyReports", reports);

        // ====== 4. 统计业务：段位配置 ======
        List<Map<String, Object>> rankConfigs = studyRecordMapper.getRankConfigs();
        dashboard.put("rankConfigs", rankConfigs);

        // ====== 4. 最新学情摘要 ======
        Map<String, Object> latestReport = studyRecordMapper.getLatestReport(stuId);
        dashboard.put("latestReport", latestReport);

        // ====== 5. 辅助：任务提醒 ======
        List<Map<String, Object>> reminders = studyRecordMapper.getTaskReminders(stuId);
        dashboard.put("taskReminders", reminders);

        // ====== 5. 辅助：待提交作业 ======
        List<Map<String, Object>> pendingHw = studyRecordMapper.getPendingHomework(stuId);
        dashboard.put("pendingHomework", pendingHw);

        return R.success(dashboard);
    }

    /**
     * 获取最近做题记录（我的页面展示用）
     */
    @GetMapping("/recent")
    public R getRecentRecords(@RequestParam("stu_id") Long stuId) {
        List<StudyRecordRow> rows = studyRecordMapper.getRecentRecords(stuId);
        List<Map<String, Object>> records = new ArrayList<>();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/dd");

        for (StudyRecordRow row : rows) {
            Map<String, Object> record = new LinkedHashMap<>();
            LocalDateTime submitTime = row.getSubmitTime();

            if (submitTime != null) {
                int dayOfWeek = submitTime.getDayOfWeek().getValue() % 7;
                record.put("date", submitTime.format(formatter) + " " + WEEK_DAYS[dayOfWeek]);
            } else {
                record.put("date", "未知时间");
            }

            String cName = row.getCName();
            String title = row.getTitle();
            String subject = "";
            if (cName != null) {
                String shortName = cName.contains("：") ? cName.split("：")[0] : cName;
                subject = shortName + " · " + (title != null ? title : "");
            } else {
                subject = title != null ? title : "";
            }
            record.put("subject", subject);

            int qCount = row.getQuestionCount() != null ? row.getQuestionCount() : 0;
            record.put("count", qCount + "题");

            if (row.getStudentScore() != null && row.getTotalScore() != null && row.getTotalScore() > 0) {
                int rate = row.getStudentScore().intValue() * 100 / row.getTotalScore();
                record.put("rate", "正确率 " + rate + "%");
            } else {
                record.put("rate", "正确率 0%");
            }

            records.add(record);
        }
        return R.success(records);
    }

    /**
     * 获取全部做题记录（学习记录页面用）
     */
    @GetMapping("/all")
    public R getAllRecords(@RequestParam("stu_id") Long stuId) {
        List<StudyRecordRow> rows = studyRecordMapper.getAllRecords(stuId);
        List<Map<String, Object>> records = new ArrayList<>();
        DateTimeFormatter dateFmt = DateTimeFormatter.ofPattern("yyyy/MM/dd");
        DateTimeFormatter timeFmt = DateTimeFormatter.ofPattern("HH:mm");
        DateTimeFormatter fullFmt = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

        for (StudyRecordRow row : rows) {
            Map<String, Object> record = new LinkedHashMap<>();

            LocalDateTime submitTime = row.getSubmitTime();
            if (submitTime != null) {
                record.put("fullSubmitTime", submitTime.format(fullFmt));
                record.put("submitDate", submitTime.format(dateFmt));
                record.put("submitTime", submitTime.format(timeFmt));
                int dayOfWeek = submitTime.getDayOfWeek().getValue() % 7;
                record.put("weekDay", WEEK_DAYS[dayOfWeek]);
            } else {
                record.put("fullSubmitTime", "");
                record.put("submitDate", "未知日期");
                record.put("submitTime", "");
                record.put("weekDay", "");
            }

            record.put("cName", row.getCName() != null ? row.getCName() : "");
            record.put("courseType", row.getCourseType() != null ? row.getCourseType() : "");
            record.put("courseTag", row.getCourseTag() != null ? row.getCourseTag() : "");
            record.put("title", row.getTitle() != null ? row.getTitle() : "");
            record.put("homeworkContent", row.getContent() != null ? row.getContent() : "");

            String cName = row.getCName();
            String title = row.getTitle();
            if (cName != null) {
                String shortName = cName.contains("：") ? cName.split("：")[0] : cName;
                record.put("subject", shortName + " · " + (title != null ? title : ""));
            } else {
                record.put("subject", title != null ? title : "");
            }

            Integer questionCount = row.getQuestionCount();
            record.put("questionCount", questionCount != null ? questionCount : 0);
            record.put("count", (questionCount != null ? questionCount : 0) + "题");

            BigDecimal studentScore = row.getStudentScore();
            Integer totalScore = row.getTotalScore();
            record.put("studentScore", studentScore != null ? studentScore : 0);
            record.put("totalScore", totalScore != null ? totalScore : 0);

            if (studentScore != null && totalScore != null && totalScore > 0) {
                int rate = studentScore.intValue() * 100 / totalScore;
                record.put("accuracyPercent", rate);
                record.put("rate", "正确率 " + rate + "%");
            } else {
                record.put("accuracyPercent", 0);
                record.put("rate", "正确率 0%");
            }

            record.put("teacherComment", row.getTeacherComment() != null ? row.getTeacherComment() : "");
            LocalDateTime correctTime = row.getCorrectTime();
            record.put("correctTime", correctTime != null ? correctTime.format(DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm")) : "");
            LocalDateTime deadline = row.getDeadline();
            record.put("deadline", deadline != null ? deadline.format(dateFmt) : "");

            records.add(record);
        }
        return R.success(records);
    }

    /**
     * 获取错题本统计
     */
    @GetMapping("/errors")
    public R getErrorStats(@RequestParam("stu_id") Long stuId) {
        return R.success(studyRecordMapper.getErrorBookStats(stuId));
    }

    /**
     * 获取任务提醒
     */
    @GetMapping("/tasks")
    public R getTaskReminders(@RequestParam("stu_id") Long stuId) {
        return R.success(studyRecordMapper.getTaskReminders(stuId));
    }

    /**
     * 获取待提交作业
     */
    @GetMapping("/pending")
    public R getPendingHomework(@RequestParam("stu_id") Long stuId) {
        return R.success(studyRecordMapper.getPendingHomework(stuId));
    }

    // ========================================================================
    //  接口5：学习报告实时统计(由做题/作业数据实时计算,非静态报表)
    // ========================================================================
    @GetMapping("/reportSummary")
    public R getReportSummary(@RequestParam("stu_id") Long stuId) {
        Map<String, Object> result = new LinkedHashMap<>();

        // 已批改作业数
        Integer gradedCount = studyRecordMapper.countGradedHomework(stuId);
        result.put("completedHomework", gradedCount != null ? gradedCount : 0);

        // 平均正确率
        Integer avgRate = studyRecordMapper.getAvgCorrectRate(stuId);
        result.put("correctRate", avgRate != null ? avgRate : 0);

        // 累计学习时长(分钟)
        Integer duration = studyRecordMapper.getStudyDurationSum(stuId);
        result.put("studyDuration", duration != null ? duration : 0);

        // 近7天每日完成作业数(补齐缺失日期为0)
        List<Map<String, Object>> trendRows = studyRecordMapper.getWeekHomeworkTrend(stuId);
        Map<String, Integer> cntByDay = new HashMap<>();
        if (trendRows != null) {
            for (Map<String, Object> row : trendRows) {
                Object day = row.get("day");
                Object cnt = row.get("cnt");
                if (day != null && cnt != null) {
                    cntByDay.put(day.toString(), Integer.parseInt(cnt.toString()));
                }
            }
        }
        DateTimeFormatter dayFmt = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate today = LocalDate.now();
        String[] WEEK_ABBR = {"周日", "周一", "周二", "周三", "周四", "周五", "周六"};
        List<Map<String, Object>> weekTrend = new ArrayList<>();
        for (int i = 6; i >= 0; i--) {
            LocalDate d = today.minusDays(i);
            int cnt = cntByDay.getOrDefault(d.format(dayFmt), 0);
            Map<String, Object> item = new LinkedHashMap<>();
            item.put("day", d.format(dayFmt));
            item.put("label", WEEK_ABBR[d.getDayOfWeek().getValue() % 7]);
            item.put("value", cnt);
            weekTrend.add(item);
        }
        result.put("weekTrend", weekTrend);

        // 各科掌握情况
        List<Map<String, Object>> masteryRows = studyRecordMapper.getSubjectMastery(stuId);
        Map<String, Integer> rateByType = new HashMap<>();
        if (masteryRows != null) {
            for (Map<String, Object> row : masteryRows) {
                Object type = row.get("course_type");
                Object rate = row.get("avg_rate");
                if (type != null && rate != null) {
                    rateByType.put(type.toString(), Integer.parseInt(rate.toString()));
                }
            }
        }
        Map<String, String> TYPE_TO_NAME = new LinkedHashMap<>();
        TYPE_TO_NAME.put("math", "数学");
        TYPE_TO_NAME.put("physics", "物理");
        TYPE_TO_NAME.put("english", "英语");
        TYPE_TO_NAME.put("chemistry", "化学");
        List<Map<String, Object>> subjects = new ArrayList<>();
        for (Map.Entry<String, String> e : TYPE_TO_NAME.entrySet()) {
            Map<String, Object> item = new LinkedHashMap<>();
            item.put("type", e.getKey());
            item.put("name", e.getValue());
            item.put("percent", rateByType.getOrDefault(e.getKey(), 0));
            subjects.add(item);
        }
        // 课程类型非预置四科(如"算法")时,直接用类型原文作为科目名,展示真实数据
        for (Map.Entry<String, Integer> e : rateByType.entrySet()) {
            if (!TYPE_TO_NAME.containsKey(e.getKey())) {
                Map<String, Object> item = new LinkedHashMap<>();
                item.put("type", e.getKey());
                item.put("name", e.getKey());
                item.put("percent", e.getValue());
                subjects.add(item);
            }
        }
        result.put("subjects", subjects);

        return R.success(result);
    }

    // ==================== 工具方法 ====================
    private String defaultStr(String s) {
        return s != null ? s : "";
    }
    private Integer defaultInt(Integer i) {
        return i != null ? i : 0;
    }
}