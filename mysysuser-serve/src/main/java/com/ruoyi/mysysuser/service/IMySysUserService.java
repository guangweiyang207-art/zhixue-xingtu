package com.ruoyi.mysysuser.service;

import com.ruoyi.mysysuser.domain.MySysUser;

public interface IMySysUserService
{
    public MySysUser selectMySysUserByUsername(String username);

    public int insertMySysUser(MySysUser user);

    public int updateMySysUser(MySysUser user);
}
