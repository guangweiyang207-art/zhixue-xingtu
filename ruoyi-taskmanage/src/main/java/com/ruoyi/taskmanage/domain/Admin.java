package com.ruoyi.taskmanage.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 管理员对象 my_admin
 * 表实际列:admin_id, user_id, admin_no, role, create_time
 *
 * @author 马孝银
 */
@Data
public class Admin implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 管理员ID */
    private Long adminId;

    /** 关联用户ID */
    private Long userId;

    /** 管理员编号 */
    private String adminNo;

    /** 角色 super-超级管理员 normal-普通管理员 */
    private String role;

    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;
}
