package com.ruoyi.study.domain;

public class CourseRankingVO
{
    private Long cId;
    private String cName;
    private Long currentPerson;
    private String type;
    private String teacherName;

    public Long getCId() { return cId; }
    public void setCId(Long cId) { this.cId = cId; }

    public String getCName() { return cName; }
    public void setCName(String cName) { this.cName = cName; }

    public Long getCurrentPerson() { return currentPerson; }
    public void setCurrentPerson(Long currentPerson) { this.currentPerson = currentPerson; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getTeacherName() { return teacherName; }
    public void setTeacherName(String teacherName) { this.teacherName = teacherName; }
}