package com.ruoyi.taskmanage.service;

import com.ruoyi.taskmanage.domain.SysUser;
import java.util.List;

public interface IMXYSysUserService {
    List<SysUser> selectSysUserList(SysUser sysUser);
    SysUser selectSysUserById(Long userId);
    SysUser selectSysUserByUsername(String username);
    int insertSysUser(SysUser sysUser);
    int updateSysUser(SysUser sysUser);
    int deleteSysUserById(Long userId);
}
