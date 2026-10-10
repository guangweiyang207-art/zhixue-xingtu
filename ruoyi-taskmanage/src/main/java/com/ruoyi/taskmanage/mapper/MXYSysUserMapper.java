package com.ruoyi.taskmanage.mapper;

import com.ruoyi.taskmanage.domain.SysUser;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface MXYSysUserMapper {

    List<SysUser> selectSysUserList(SysUser sysUser);

    SysUser selectSysUserById(@Param("userId") Long userId);

    /** 登录:按用户名查询 */
    SysUser selectSysUserByUsername(@Param("username") String username);

    int insertSysUser(SysUser sysUser);

    int updateSysUser(SysUser sysUser);

    /** 仅更新密码(明文转 BCrypt 后写回) */
    int updateSysUserPassword(SysUser sysUser);

    int deleteSysUserById(@Param("userId") Long userId);
}
