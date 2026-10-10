package com.ruoyi.taskmanage.service;

import com.ruoyi.taskmanage.domain.Admin;
import java.util.List;

public interface IMXYAdminService {
    List<Admin> selectAdminList(Admin admin);
    Admin selectAdminById(Long adminId);
    Admin selectAdminByUserId(Long userId);
    int insertAdmin(Admin admin);
    int updateAdmin(Admin admin);
    int deleteAdminById(Long adminId);
}
