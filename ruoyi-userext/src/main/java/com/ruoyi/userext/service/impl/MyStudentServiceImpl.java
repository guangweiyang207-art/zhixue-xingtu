package com.ruoyi.userext.service.impl;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.userext.mapper.MyStudentMapper;
import com.ruoyi.userext.domain.MyStudent;
import com.ruoyi.userext.service.IMyStudentService;

/**
 * 学生Service业务层处理
 *
 * @author ruoyi
 * @date 2026-05-31
 */
@Service
public class MyStudentServiceImpl implements IMyStudentService
{
    @Autowired
    private MyStudentMapper myStudentMapper;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Override
    public MyStudent selectMyStudentByStuId(Long stuId)
    {
        return myStudentMapper.selectMyStudentByStuId(stuId);
    }

    @Override
    public List<MyStudent> selectMyStudentList(MyStudent myStudent)
    {
        return myStudentMapper.selectMyStudentList(myStudent);
    }

    /**
     * 新增学生：
     * 1) 同步在 my_sys_user 中插入一条账号（user_type=1），
     *    密码默认 123456（BCrypt加密），用户名按 user_id 自动生成 "student{userId}"；
     * 2) 用上面生成的 user_id 写回 my_student.user_id。
     * 若 my_student 写入失败，my_sys_user 也会回滚（@Transactional）。
     */
    @Override
    @Transactional
    public int insertMyStudent(MyStudent myStudent)
    {
        // 1. 先在 my_sys_user 插入账号（user_id 由 AUTO_INCREMENT 产生，MyBatis 会回填到 Map.userId）
        Map<String, Object> params = new HashMap<>();
        params.put("username", "tmp_" + System.currentTimeMillis()); // 占位名，拿到 userId 后会立即更新
        params.put("password", bCryptPasswordEncoder.encode("123456"));
        params.put("realName", myStudent.getUserName());
        myStudentMapper.insertMySysUserStudent(params);

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
            throw new RuntimeException("创建学生账号失败：未获取到 user_id，原始值=" + rawUserId);
        }

        // 2. 把规范化的用户名写回（格式：student + 3位补零 user_id，与历史数据风格保持一致）
        String finalUsername = String.format("student%03d", newUserId);
        myStudentMapper.updateMySysUserUsername(newUserId, finalUsername);

        // 3. 写 my_student
        myStudent.setUserId(newUserId);
        int rows = myStudentMapper.insertMyStudent(myStudent);
        return rows;
    }

    /**
     * 修改学生：如果姓名变更，同步更新 my_sys_user.real_name（user_id 不可修改）
     */
    @Override
    @Transactional
    public int updateMyStudent(MyStudent myStudent)
    {
        int rows = myStudentMapper.updateMyStudent(myStudent);
        if (rows > 0 && myStudent.getUserId() != null && myStudent.getUserName() != null)
        {
            myStudentMapper.updateMySysUserRealName(myStudent.getUserId(), myStudent.getUserName());
        }
        return rows;
    }

    /**
     * 批量删除学生：先查出对应的 user_id 集合，先删 my_student 再删 my_sys_user，保持两表一致
     */
    @Override
    @Transactional
    public int deleteMyStudentByStuIds(Long[] stuIds)
    {
        List<Long> userIds = myStudentMapper.selectUserIdsByStuIds(stuIds);
        int rows = myStudentMapper.deleteMyStudentByStuIds(stuIds);
        if (rows > 0 && userIds != null && !userIds.isEmpty())
        {
            myStudentMapper.deleteMySysUserByUserIds(userIds.toArray(new Long[0]));
        }
        return rows;
    }

    @Override
    public int deleteMyStudentByStuId(Long stuId)
    {
        return myStudentMapper.deleteMyStudentByStuId(stuId);
    }
}
