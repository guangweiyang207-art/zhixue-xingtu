package com.ruoyi.taskmanage.mapper;

import com.ruoyi.taskmanage.domain.Admin;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface MXYAdminMapper {

    List<Admin> selectAdminList(Admin admin);

    Admin selectAdminById(@Param("adminId") Long adminId);

    Admin selectAdminByUserId(@Param("userId") Long userId);

    int insertAdmin(Admin admin);

    int updateAdmin(Admin admin);

    int deleteAdminById(@Param("adminId") Long adminId);
}
