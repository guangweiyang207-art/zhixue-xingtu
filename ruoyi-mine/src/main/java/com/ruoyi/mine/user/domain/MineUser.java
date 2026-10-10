package com.ruoyi.mine.user.domain;

import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 用户信息对象 my_sys_user
 *
 * @author ruoyi
 */
@Data
public class MineUser implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 用户ID */
    private Long userId;

    /** 用户名/账号 */
    private String username;

    /** 密码(加密存储) */
    private String password;

    /** 真实姓名 */
    private String realName;

    /** 头像URL */
    private String avatar;

    /** 性别 0-未知 1-男 2-女 */
    private Integer sex;

    /** 年龄 */
    private Integer age;

    /** 手机号 */
    private String phone;

    /** 邮箱 */
    private String email;

    /** 用户类型 1-学生 2-教师 3-管理员 */
    private Integer userType;

    /** 状态 0-禁用 1-启用 */
    private Integer status;

    /** 是否删除 0-否 1-是 */
    private Integer isDeleted;

    /** 创建时间 */
    private LocalDateTime createTime;

    /** 更新时间 */
    private LocalDateTime updateTime;

    /** 备注 */
    private String remark;
}
