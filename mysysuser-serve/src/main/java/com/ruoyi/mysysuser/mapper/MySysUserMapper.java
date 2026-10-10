package com.ruoyi.mysysuser.mapper;

import com.ruoyi.mysysuser.domain.MySysUser;

public interface MySysUserMapper
{
    public MySysUser selectMySysUserByUsername(String username);

    public int insertMySysUser(MySysUser user);

    public int updateMySysUser(MySysUser user);
}
