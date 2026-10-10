package com.ruoyi.mine.user.mapper;

import com.ruoyi.mine.user.domain.MineUser;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

/**
 * 小程序用户信息Mapper接口（纯 MyBatis）
 *
 * @author ruoyi
 */
@Mapper
public interface LQYMineUserMapper
{

    /**
     * 查询用户列表
     */
    @Select("SELECT * FROM my_sys_user")
    List<MineUser> selectMineUserList();

    /**
     * 根据用户名查询
     */
    @Select("SELECT * FROM my_sys_user WHERE username = #{username} LIMIT 1")
    MineUser selectByUsername(@Param("username") String username);

    /**
     * 根据ID查询
     */
    @Select("SELECT * FROM my_sys_user WHERE user_id = #{userId}")
    MineUser selectById(@Param("userId") Long userId);

    /**
     * 新增用户
     */
    @Insert("INSERT INTO my_sys_user(user_id, username, password, real_name, avatar, phone, email, role, status, create_time) "
            + "VALUES(#{userId}, #{username}, #{password}, #{realName}, #{avatar}, #{phone}, #{email}, #{role}, #{status}, #{createTime})")
    int insertMineUser(MineUser mineUser);

    /**
     * 修改用户
     */
    @Update("UPDATE my_sys_user SET username=#{username}, password=#{password}, real_name=#{realName}, "
            + "avatar=#{avatar}, phone=#{phone}, email=#{email}, role=#{role}, status=#{status} "
            + "WHERE user_id=#{userId}")
    int updateMineUser(MineUser mineUser);

    /**
     * 删除用户
     */
    @Delete("DELETE FROM my_sys_user WHERE user_id = #{userId}")
    int deleteMineUserById(@Param("userId") Long userId);
}
