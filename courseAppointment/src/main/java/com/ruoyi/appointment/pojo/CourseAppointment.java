package com.ruoyi.appointment.pojo;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.util.Date;

@Data
public class CourseAppointment {
    private Long caId;
    @JsonProperty("stu_id")
    private Long stuId;
    @JsonProperty("stu_no")
    private String stuNo;
    private String name;
    private String phone;
    @JsonProperty("c_id")
    private Long cId;
    private Date appointmentTime;
    private Integer status;
    private String remark;
    private Date createTime;
    private Date updateTime;
}