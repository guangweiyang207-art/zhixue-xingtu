package com.ruoyi.mine.user.service;

import com.ruoyi.mine.user.domain.MineUser;

import java.util.List;

/**
 * 小程序用户信息Service接口（纯 MyBatis）
 *
 * @author ruoyi
 */
public interface LQYIMineUserService
{
    /**
     * 查询用户列表
     */
    List<MineUser> selectMineUserList();

    /**
     * 根据ID查询
     */
    MineUser selectById(Long userId);

    /**
     * 根据用户名查询
     */
    MineUser selectByUsername(String username);

    /**
     * 新增用户
     */
    int insertMineUser(MineUser mineUser);

    /**
     * 修改用户
     */
    int updateMineUser(MineUser mineUser);

    /**
     * 删除用户
     */
    int deleteMineUserById(Long userId);
}
