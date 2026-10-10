package com.ruoyi.taskmanage.service.impl;

import com.ruoyi.taskmanage.domain.Admin;
import com.ruoyi.taskmanage.mapper.MXYAdminMapper;
import com.ruoyi.taskmanage.service.IMXYAdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MXYAdminServiceImpl implements IMXYAdminService {

    @Autowired private MXYAdminMapper mapper;

    @Override public List<Admin> selectAdminList(Admin a) { return mapper.selectAdminList(a); }
    @Override public Admin selectAdminById(Long adminId) { return mapper.selectAdminById(adminId); }
    @Override public Admin selectAdminByUserId(Long userId) { return mapper.selectAdminByUserId(userId); }
    @Override public int insertAdmin(Admin a) { return mapper.insertAdmin(a); }
    @Override public int updateAdmin(Admin a) { return mapper.updateAdmin(a); }
    @Override public int deleteAdminById(Long adminId) { return mapper.deleteAdminById(adminId); }
}
