package com.ruoyi.mysysuser.service.impl;

import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.mysysuser.domain.MySysUser;
import com.ruoyi.mysysuser.mapper.MySysUserMapper;
import com.ruoyi.mysysuser.service.IMySysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MySysUserServiceImpl implements IMySysUserService
{
    @Autowired
    private MySysUserMapper mySysUserMapper;

    @Override
    public MySysUser selectMySysUserByUsername(String username)
    {
        return mySysUserMapper.selectMySysUserByUsername(username);
    }

    @Override
    public int insertMySysUser(MySysUser user)
    {
        if (user.getPassword() != null && !user.getPassword().startsWith("$2a$"))
        {
            user.setPassword(SecurityUtils.encryptPassword(user.getPassword()));
        }
        return mySysUserMapper.insertMySysUser(user);
    }

    @Override
    public int updateMySysUser(MySysUser user)
    {
        if (user.getPassword() != null && !user.getPassword().startsWith("$2a$"))
        {
            user.setPassword(SecurityUtils.encryptPassword(user.getPassword()));
        }
        return mySysUserMapper.updateMySysUser(user);
    }
}
