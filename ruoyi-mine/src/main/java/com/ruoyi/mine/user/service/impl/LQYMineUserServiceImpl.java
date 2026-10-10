package com.ruoyi.mine.user.service.impl;

import com.ruoyi.mine.user.domain.MineUser;
import com.ruoyi.mine.user.mapper.LQYMineUserMapper;
import com.ruoyi.mine.user.service.LQYIMineUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 小程序用户信息Service业务层处理（纯 MyBatis）
 *
 * @author ruoyi
 */
@Service
public class LQYMineUserServiceImpl implements LQYIMineUserService
{
    @Autowired
    private LQYMineUserMapper lqyMineUserMapper;

    public List<MineUser> selectMineUserList()
    {
        return lqyMineUserMapper.selectMineUserList();
    }

    public MineUser selectById(Long userId)
    {
        return lqyMineUserMapper.selectById(userId);
    }

    public MineUser selectByUsername(String username)
    {
        return lqyMineUserMapper.selectByUsername(username);
    }

    public int insertMineUser(MineUser mineUser)
    {
        return lqyMineUserMapper.insertMineUser(mineUser);
    }

    public int updateMineUser(MineUser mineUser)
    {
        return lqyMineUserMapper.updateMineUser(mineUser);
    }

    public int deleteMineUserById(Long userId)
    {
        return lqyMineUserMapper.deleteMineUserById(userId);
    }
}
