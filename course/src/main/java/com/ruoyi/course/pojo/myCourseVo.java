package com.ruoyi.course.pojo;

import com.ruoyi.teacher.pojo.myTeacher;
import lombok.Data;

import java.util.Date;

@Data
public class myCourseVo {
    private Long cId;
    private String cName;
    private Long teacherId;
    private myTeacher teacher;
    private String type;
    private String tag;
    private Integer difficulty;
    private Integer maxPerson;
    private Integer currentPerson;
    private String description;
    private String coverImage;
    private Integer status;
    private Date startTime;
    private Date endTime;
    private Long resourceId;
    private String remark;
    private Date createTime;
    private Date updateTime;
}