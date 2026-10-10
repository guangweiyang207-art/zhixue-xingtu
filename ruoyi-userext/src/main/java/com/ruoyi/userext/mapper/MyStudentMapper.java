package com.ruoyi.userext.mapper;

import java.util.List;
import com.ruoyi.userext.domain.MyStudent;

/**
 * 学生Mapper接口
 * 
 * @author ruoyi
 * @date 2026-05-31
 */
public interface MyStudentMapper 
{
    /**
     * 查询学生
     * 
     * @param stuId 学生主键
     * @return 学生
     */
    public MyStudent selectMyStudentByStuId(Long stuId);

    /**
     * 查询学生列表
     * 
     * @param myStudent 学生
     * @return 学生集合
     */
    public List<MyStudent> selectMyStudentList(MyStudent myStudent);

    /**
     * 新增学生
     * 
     * @param myStudent 学生
     * @return 结果
     */
    public int insertMyStudent(MyStudent myStudent);

    /**
     * 修改学生
     * 
     * @param myStudent 学生
     * @return 结果
     */
    public int updateMyStudent(MyStudent myStudent);

    /**
     * 删除学生
     * 
     * @param stuId 学生主键
     * @return 结果
     */
    public int deleteMyStudentByStuId(Long stuId);

    /**
     * 批量删除学生
     * 
     * @param stuIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteMyStudentByStuIds(Long[] stuIds);

    /**
     * 更新my_sys_user表real_name
     *
     * @param userId 用户ID
     * @param realName 真实姓名
     * @return 结果
     */
    public int updateMySysUserRealName(Long userId, String realName);

    /**
     * 向my_sys_user插入新学生账号（默认密码123456的BCrypt值），user_type=1学生
     * 使用 useGeneratedKeys，回填 Map.userId 字段
     *
     * @param params 包含 username、password、realName 及待回填的 userId
     * @return 结果
     */
    public int insertMySysUserStudent(java.util.Map<String, Object> params);

    /**
     * 修正my_sys_user用户名（先以占位插入，再用真实user_id更新）
     *
     * @param userId 用户ID
     * @param username 用户名
     * @return 结果
     */
    public int updateMySysUserUsername(Long userId, String username);

    /**
     * 根据学生ID集合查询其关联的user_id
     *
     * @param stuIds 学生ID集合
     * @return user_id集合
     */
    public List<Long> selectUserIdsByStuIds(Long[] stuIds);

    /**
     * 根据user_id集合删除my_sys_user记录
     *
     * @param userIds 用户ID集合
     * @return 结果
     */
    public int deleteMySysUserByUserIds(Long[] userIds);
}
