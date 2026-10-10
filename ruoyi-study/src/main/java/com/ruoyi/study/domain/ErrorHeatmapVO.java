package com.ruoyi.study.domain;

public class ErrorHeatmapVO
{
    private Long stuId;
    private String studentName;
    private String tag;
    private Long errorCount;

    public Long getStuId() { return stuId; }
    public void setStuId(Long stuId) { this.stuId = stuId; }

    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }

    public String getTag() { return tag; }
    public void setTag(String tag) { this.tag = tag; }

    public Long getErrorCount() { return errorCount; }
    public void setErrorCount(Long errorCount) { this.errorCount = errorCount; }
}