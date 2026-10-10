package com.ruoyi.userext.mapper;

import java.util.List;
import com.ruoyi.userext.domain.MyTeacher;

public interface MyTeacherMapper
{
    public MyTeacher selectMyTeacherByTeacherId(Long teacherId);
    public List<MyTeacher> selectMyTeacherList(MyTeacher myTeacher);
    public int insertMyTeacher(MyTeacher myTeacher);
    public int updateMyTeacher(MyTeacher myTeacher);
    public int deleteMyTeacherByTeacherId(Long teacherId);
    public int deleteMyTeacherByTeacherIds(Long[] teacherIds);

    /**
     * 更新my_sys_user表real_name
     *
     * @param userId 用户ID
     * @param realName 真实姓名
     * @return 结果
     */
    public int updateMySysUserRealName(Long userId, String realName);

    /**
     * 向my_sys_user插入新教师账号（默认密码123456的BCrypt值），user_type=2教师
     * 使用 useGeneratedKeys，回填 Map.userId 字段
     *
     * @param params 包含 username、password、realName 及待回填的 userId
     * @return 结果
     */
    public int insertMySysUserTeacher(java.util.Map<String, Object> params);

    /**
     * 修正my_sys_user用户名（先以占位插入，再用真实user_id更新）
     *
     * @param userId 用户ID
     * @param username 用户名
     * @return 结果
     */
    public int updateMySysUserUsername(Long userId, String username);

    /**
     * 根据教师ID集合查询其关联的user_id
     *
     * @param teacherIds 教师ID集合
     * @return user_id集合
     */
    public List<Long> selectUserIdsByTeacherIds(Long[] teacherIds);

    /**
     * 根据user_id集合删除my_sys_user记录
     *
     * @param userIds 用户ID集合
     * @return 结果
     */
    public int deleteMySysUserByUserIds(Long[] userIds);
}
