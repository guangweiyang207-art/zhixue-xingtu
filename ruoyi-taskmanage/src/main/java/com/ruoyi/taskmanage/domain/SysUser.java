package com.ruoyi.taskmanage.domain;

import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 系统用户对象 my_sys_user
 *  - 用 @Alias 强制别名,避免与 ruoyi 内置 SysUser (com.ruoyi.common.core.domain.entity.SysUser) 冲突
 *
 * @author 马孝银
 */
@Data
@Alias("MxySysUser")
public class SysUser implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 用户ID */
    private Long userId;

    /** 用户名 */
    private String username;

    /** 密码 */
    private String password;

    /** 真实姓名 */
    private String realName;

    /** 头像 */
    private String avatar;

    /** 性别(0-未知 1-男 2-女) */
    private Integer sex;

    /** 年龄 */
    private Integer age;

    /** 手机号 */
    private String phone;

    /** 邮箱 */
    private String email;

    /** 用户类型(1-管理员 2-教师 3-学生) */
    private Integer userType;

    /** 状态(0-禁用 1-启用) */
    private Integer status;

    /** 是否删除(0-否 1-是) */
    private Integer isDeleted;

    /** 创建时间 */
    private LocalDateTime createTime;

    /** 更新时间 */
    private LocalDateTime updateTime;

    /** 备注 */
    private String remark;
}
