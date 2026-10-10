package com.ruoyi.teacher.pojo;

import lombok.Data;

import java.util.Date;

@Data
public class myTeacher {
    private Long teacherId;
    private Long userId;
    private String teacherNo;
    private String department;
    private String title;
    private String specialty;
    private String teacherName;
    private Date createTime;
    private Date updateTime;
}