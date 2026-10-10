package com.ruoyi.student.pojo;

import lombok.Data;

@Data
public class StudentInfo {
    private Long stuId;
    private String major;
    private String grade;
    private String className;
    private UserInfo user;
}