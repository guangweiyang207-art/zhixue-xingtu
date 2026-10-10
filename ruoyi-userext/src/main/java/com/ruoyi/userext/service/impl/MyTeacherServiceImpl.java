package com.ruoyi.userext.service.impl;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.userext.mapper.MyTeacherMapper;
import com.ruoyi.userext.domain.MyTeacher;
import com.ruoyi.userext.service.IMyTeacherService;

@Service
public class MyTeacherServiceImpl implements IMyTeacherService
{
    @Autowired
    private MyTeacherMapper myTeacherMapper;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Override
    public MyTeacher selectMyTeacherByTeacherId(Long teacherId)
    {
        return myTeacherMapper.selectMyTeacherByTeacherId(teacherId);
    }

    @Override
    public List<MyTeacher> selectMyTeacherList(MyTeacher myTeacher)
    {
        return myTeacherMapper.selectMyTeacherList(myTeacher);
    }

    /**
     * 新增教师：
     * 1) 同步在 my_sys_user 中插入一条账号（user_type=2），
     *    密码默认 123456（BCrypt加密），用户名按 user_id 自动生成 "teacher{userId}"；
     * 2) 用上面生成的 user_id 写回 my_teacher.user_id。
     * 若 my_teacher 写入失败，my_sys_user 也会回滚（@Transactional）。
     */
    @Override
    @Transactional
    public int insertMyTeacher(MyTeacher myTeacher)
    {
        // 1. 先在 my_sys_user 插入账号（user_id 由 AUTO_INCREMENT 产生，MyBatis 会回填到 Map.userId）
        Map<String, Object> params = new HashMap<>();
        params.put("username", "tmp_" + System.currentTimeMillis()); // 占位名，拿到 userId 后会立即更新
        params.put("password", bCryptPasswordEncoder.encode("123456"));
        params.put("realName", myTeacher.getUserName());
        myTeacherMapper.insertMySysUserTeacher(params);

        // MySQL JDBC 驱动回填的是 BigInteger，部分驱动/版本可能是 Long，兼容两种类型
        Object rawUserId = params.get("userId");
        Long newUserId = null;
        if (rawUserId instanceof Long) {
            newUserId = (Long) rawUserId;
        } else if (rawUserId instanceof BigInteger) {
            newUserId = ((BigInteger) rawUserId).longValue();
        } else if (rawUserId instanceof Number) {
            newUserId = ((Number) rawUserId).longValue();
        }
        if (newUserId == null) {
            throw new RuntimeException("创建教师账号失败：未获取到 user_id，原始值=" + rawUserId);
        }

        // 2. 把规范化的用户名写回（格式：teacher + 3位补零 user_id，与历史数据风格保持一致）
        String finalUsername = String.format("teacher%03d", newUserId);
        myTeacherMapper.updateMySysUserUsername(newUserId, finalUsername);

        // 3. 写 my_teacher
        myTeacher.setUserId(newUserId);
        int rows = myTeacherMapper.insertMyTeacher(myTeacher);
        return rows;
    }

    /**
     * 修改教师：如果姓名变更，同步更新 my_sys_user.real_name（user_id 不可修改）
     */
    @Override
    @Transactional
    public int updateMyTeacher(MyTeacher myTeacher)
    {
        int rows = myTeacherMapper.updateMyTeacher(myTeacher);
        if (rows > 0 && myTeacher.getUserId() != null && myTeacher.getUserName() != null)
        {
            myTeacherMapper.updateMySysUserRealName(myTeacher.getUserId(), myTeacher.getUserName());
        }
        return rows;
    }

    /**
     * 批量删除教师：先查出对应的 user_id 集合，先删 my_teacher 再删 my_sys_user，保持两表一致
     */
    @Override
    @Transactional
    public int deleteMyTeacherByTeacherIds(Long[] teacherIds)
    {
        List<Long> userIds = myTeacherMapper.selectUserIdsByTeacherIds(teacherIds);
        int rows = myTeacherMapper.deleteMyTeacherByTeacherIds(teacherIds);
        if (rows > 0 && userIds != null && !userIds.isEmpty())
        {
            myTeacherMapper.deleteMySysUserByUserIds(userIds.toArray(new Long[0]));
        }
        return rows;
    }

    @Override
    public int deleteMyTeacherByTeacherId(Long teacherId)
    {
        return myTeacherMapper.deleteMyTeacherByTeacherId(teacherId);
    }
}
