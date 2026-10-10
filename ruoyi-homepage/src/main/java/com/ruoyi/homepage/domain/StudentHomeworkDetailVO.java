package com.ruoyi.homepage.domain;

import java.util.List;

/**
 * 学生作业批改详情VO
 * 包含学生信息、作业信息、题目列表
 */
public class StudentHomeworkDetailVO {
    /** 提交记录ID */
    private Long   shId;
    /** 作业ID */
    private Long   hwId;
    /** 课程ID(错题本关联用) */
    private Long   cId;
    /** 作业标题 */
    private String title;
    /** 作业内容 */
    private String content;
    /** 作业总分 */
    private Integer totalScore;
    /** 学生ID */
    private Long   stuId;
    /** 学生姓名 */
    private String studentName;
    /** 学号 */
    private String studentNo;
    /** 班级 */
    private String className;
    /** 提交时间 */
    private String submitTime;
    /** 学生作答(JSON字符串,如 {"1":"A","2":"B,C"}) */
    private String answers;
    /** 题目+标准答案列表(带学生作答) */
    private List<QuestionForGrade> questions;
    /** 已批改得分 */
    private Double score;
    /** 教师评语 */
    private String comment;
    /** 状态 0-未提交 1-已提交待批改 2-已批改 */
    private Integer status;

    public Long getShId() { return shId; }
    public void setShId(Long shId) { this.shId = shId; }

    public Long getHwId() { return hwId; }
    public void setHwId(Long hwId) { this.hwId = hwId; }

    public Long getcId() { return cId; }
    public void setcId(Long cId) { this.cId = cId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public Integer getTotalScore() { return totalScore; }
    public void setTotalScore(Integer totalScore) { this.totalScore = totalScore; }

    public Long getStuId() { return stuId; }
    public void setStuId(Long stuId) { this.stuId = stuId; }

    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }

    public String getStudentNo() { return studentNo; }
    public void setStudentNo(String studentNo) { this.studentNo = studentNo; }

    public String getClassName() { return className; }
    public void setClassName(String className) { this.className = className; }

    public String getSubmitTime() { return submitTime; }
    public void setSubmitTime(String submitTime) { this.submitTime = submitTime; }

    public String getAnswers() { return answers; }
    public void setAnswers(String answers) { this.answers = answers; }

    public List<QuestionForGrade> getQuestions() { return questions; }
    public void setQuestions(List<QuestionForGrade> questions) { this.questions = questions; }

    public Double getScore() { return score; }
    public void setScore(Double score) { this.score = score; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }

    /** 题目(批改视图) */
    public static class QuestionForGrade {
        private Long    qId;
        /** 1-单选 2-多选 3-判断 4-填空 5-简答 */
        private Integer questionType;
        private String  questionContent;
        /** 选项 JSON 字符串 */
        private String  options;
        /** 正确答案 */
        private String  correctAnswer;
        /** 分值 */
        private Integer score;
        /** 难度 1-简单 2-中等 3-困难 */
        private Integer difficulty;
        /** 学生本题作答(原始字符串) */
        private String  studentAnswer;
        /** 是否正确(客观题自动判;主观题为 null) */
        private Boolean correct;

        public Long getQId() { return qId; }
        public void setQId(Long qId) { this.qId = qId; }

        public Integer getQuestionType() { return questionType; }
        public void setQuestionType(Integer questionType) { this.questionType = questionType; }

        public String getQuestionContent() { return questionContent; }
        public void setQuestionContent(String questionContent) { this.questionContent = questionContent; }

        public String getOptions() { return options; }
        public void setOptions(String options) { this.options = options; }

        public String getCorrectAnswer() { return correctAnswer; }
        public void setCorrectAnswer(String correctAnswer) { this.correctAnswer = correctAnswer; }

        public Integer getScore() { return score; }
        public void setScore(Integer score) { this.score = score; }

        public Integer getDifficulty() { return difficulty; }
        public void setDifficulty(Integer difficulty) { this.difficulty = difficulty; }

        public String getStudentAnswer() { return studentAnswer; }
        public void setStudentAnswer(String studentAnswer) { this.studentAnswer = studentAnswer; }

        public Boolean getCorrect() { return correct; }
        public void setCorrect(Boolean correct) { this.correct = correct; }
    }
}
