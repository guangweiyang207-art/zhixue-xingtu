package com.ruoyi.userext.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.apache.ibatis.type.Alias;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 学生对象 my_student
 *
 * @author ruoyi
 * @date 2026-05-31
 */
@Alias("UserExtStudent")
public class MyStudent extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 学生ID */
    private Long stuId;

    /** 关联用户ID */
    @Excel(name = "关联用户ID")
    private Long userId;

    /** 学号 */
    @Excel(name = "学号")
    private String studentNo;

    /** 专业 */
    @Excel(name = "专业")
    private String major;

    /** 年级 */
    @Excel(name = "年级")
    private String grade;

    /** 班级 */
    @Excel(name = "班级")
    private String className;

    /** 生日 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "生日", width = 30, dateFormat = "yyyy-MM-dd")
    private Date birthday;

    /** 关联教师ID */
    @Excel(name = "关联教师ID")
    private Long teacherId;

    /** 当前段位 */
    @Excel(name = "当前段位")
    private String rankLevel;

    /** 段位积分 */
    @Excel(name = "段位积分")
    private Long rankScore;

    /** 学生姓名（关联my_sys_user表） */
    @Excel(name = "学生姓名")
    private String userName;

    /** 指导教师姓名（关联my_teacher表） */
    @Excel(name = "指导教师")
    private String teacherName;

    /** 选课数量（联查统计） */
    @Excel(name = "选课数量")
    private Integer courseCount;

    /** 作业完成数（联查统计） */
    @Excel(name = "作业完成数")
    private Integer homeworkCount;

    /** 总做题数（联查统计） */
    @Excel(name = "总做题数")
    private Long totalQuestions;

    /** 正确题数（联查统计） */
    @Excel(name = "正确题数")
    private Long correctQuestions;

    /** 学习时长/小时（联查统计） */
    @Excel(name = "学习时长(小时)")
    private BigDecimal studyHours;

    public void setStuId(Long stuId)
    {
        this.stuId = stuId;
    }

    public Long getStuId()
    {
        return stuId;
    }

    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public Long getUserId()
    {
        return userId;
    }

    public void setStudentNo(String studentNo)
    {
        this.studentNo = studentNo;
    }

    public String getStudentNo()
    {
        return studentNo;
    }

    public void setMajor(String major)
    {
        this.major = major;
    }

    public String getMajor()
    {
        return major;
    }

    public void setGrade(String grade)
    {
        this.grade = grade;
    }

    public String getGrade()
    {
        return grade;
    }

    public void setClassName(String className)
    {
        this.className = className;
    }

    public String getClassName()
    {
        return className;
    }

    public void setBirthday(Date birthday)
    {
        this.birthday = birthday;
    }

    public Date getBirthday()
    {
        return birthday;
    }

    public void setTeacherId(Long teacherId)
    {
        this.teacherId = teacherId;
    }

    public Long getTeacherId()
    {
        return teacherId;
    }

    public void setRankLevel(String rankLevel)
    {
        this.rankLevel = rankLevel;
    }

    public String getRankLevel()
    {
        return rankLevel;
    }

    public void setRankScore(Long rankScore)
    {
        this.rankScore = rankScore;
    }

    public Long getRankScore()
    {
        return rankScore;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public Integer getCourseCount() {
        return courseCount;
    }

    public void setCourseCount(Integer courseCount) {
        this.courseCount = courseCount;
    }

    public Integer getHomeworkCount() {
        return homeworkCount;
    }

    public void setHomeworkCount(Integer homeworkCount) {
        this.homeworkCount = homeworkCount;
    }

    public Long getTotalQuestions() {
        return totalQuestions;
    }

    public void setTotalQuestions(Long totalQuestions) {
        this.totalQuestions = totalQuestions;
    }

    public Long getCorrectQuestions() {
        return correctQuestions;
    }

    public void setCorrectQuestions(Long correctQuestions) {
        this.correctQuestions = correctQuestions;
    }

    public BigDecimal getStudyHours() {
        return studyHours;
    }

    public void setStudyHours(BigDecimal studyHours) {
        this.studyHours = studyHours;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("stuId", getStuId())
            .append("userId", getUserId())
            .append("studentNo", getStudentNo())
            .append("major", getMajor())
            .append("grade", getGrade())
            .append("className", getClassName())
            .append("birthday", getBirthday())
            .append("teacherId", getTeacherId())
            .append("rankLevel", getRankLevel())
            .append("rankScore", getRankScore())
            .append("userName", getUserName())
            .append("teacherName", getTeacherName())
            .append("courseCount", getCourseCount())
            .append("homeworkCount", getHomeworkCount())
            .append("totalQuestions", getTotalQuestions())
            .append("correctQuestions", getCorrectQuestions())
            .append("studyHours", getStudyHours())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
