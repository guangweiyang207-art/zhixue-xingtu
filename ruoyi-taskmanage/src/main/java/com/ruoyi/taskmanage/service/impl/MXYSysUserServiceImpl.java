package com.ruoyi.taskmanage.service.impl;

import com.ruoyi.taskmanage.domain.SysUser;
import com.ruoyi.taskmanage.mapper.MXYSysUserMapper;
import com.ruoyi.taskmanage.service.IMXYSysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MXYSysUserServiceImpl implements IMXYSysUserService {

    @Autowired private MXYSysUserMapper mapper;

    @Override public List<SysUser> selectSysUserList(SysUser u) { return mapper.selectSysUserList(u); }
    @Override public SysUser selectSysUserById(Long userId) { return mapper.selectSysUserById(userId); }
    @Override public SysUser selectSysUserByUsername(String username) { return mapper.selectSysUserByUsername(username); }
    @Override public int insertSysUser(SysUser u) { return mapper.insertSysUser(u); }
    @Override public int updateSysUser(SysUser u) { return mapper.updateSysUser(u); }
    @Override public int deleteSysUserById(Long userId) { return mapper.deleteSysUserById(userId); }
}
