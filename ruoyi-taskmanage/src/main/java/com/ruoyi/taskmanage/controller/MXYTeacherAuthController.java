package com.ruoyi.taskmanage.controller;

import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.constant.Constants;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.uuid.IdUtils;
import com.ruoyi.framework.web.service.SysLoginService;
import com.ruoyi.framework.web.service.TokenService;
import com.ruoyi.taskmanage.domain.Teacher;
import com.ruoyi.taskmanage.mapper.MXYTeacherMapper;
import com.ruoyi.taskmanage.mapper.MXYSysUserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Collections;
import java.util.concurrent.TimeUnit;

/**
 * 小程序教师登录
 *  - 用 my_sys_user (user_type=2 教师) 校验 username/password
 *  - 从 my_teacher 取 teacher_id,一并写入 token
 *  - 走 RuoYi 原生 TokenService.createToken() 流程,与其他接口共用认证
 *  - 登录成功后写入 Redis 记住凭据(30天),本设备下次可免输账号密码自动登录
 *
 * @author 马孝银
 */
@Anonymous
@RestController
@RequestMapping("/teacher")
public class MXYTeacherAuthController {

    /** 记住登录的 Redis key 前缀 */
    private static final String REMEMBER_KEY_PREFIX = "teacher_remember:";

    /** 记住登录有效期(天) */
    private static final Integer REMEMBER_DAYS = 30;

    @Autowired private MXYSysUserMapper sysUserMapper;
    @Autowired private MXYTeacherMapper teacherMapper;
    @Autowired private TokenService tokenService;
    @Autowired private SysLoginService sysLoginService;
    @Autowired private RedisCache redisCache;

    /**
     * 教师登录
     * POST /teacher/login
     * body: { "username": "teacher001", "password": "123456" }
     */
    @PostMapping("/login")
    public AjaxResult login(@RequestBody LoginRequest body) {
        if (body == null || body.getUsername() == null || body.getPassword() == null) {
            return AjaxResult.error("用户名或密码不能为空");
        }

        // 0) 校验图形验证码(若开启)
        try {
            sysLoginService.validateCaptcha(body.getUsername(), body.getCode(), body.getUuid());
        } catch (Exception e) {
            return AjaxResult.error(e.getMessage());
        }

        // 1) 查 my_sys_user (只允许教师 user_type=2)
        com.ruoyi.taskmanage.domain.SysUser user = sysUserMapper.selectSysUserByUsername(body.getUsername());
        if (user == null) {
            return AjaxResult.error("账号不存在");
        }
        if (user.getUserType() == null || user.getUserType() != 2) {
            return AjaxResult.error("非教师账号,禁止登录");
        }
        if (user.getStatus() != null && user.getStatus() == 0) {
            return AjaxResult.error("账号已被禁用");
        }
        if (user.getIsDeleted() != null && user.getIsDeleted() == 1) {
            return AjaxResult.error("账号已注销");
        }

        // 2) 校验密码(兼容明文 + BCrypt)
        String dbPwd = user.getPassword();
        boolean passOk = false;
        if (dbPwd != null) {
            if (dbPwd.startsWith("$2a$") || dbPwd.startsWith("$2b$") || dbPwd.startsWith("$2y$")) {
                // BCrypt 加密
                passOk = SecurityUtils.matchesPassword(body.getPassword(), dbPwd);
            } else {
                // 明文(历史数据),直接比对;匹配成功顺便用 BCrypt 重写
                passOk = body.getPassword().equals(dbPwd);
                if (passOk) {
                    try {
                        user.setPassword(SecurityUtils.encryptPassword(body.getPassword()));
                        user.setUpdateTime(java.time.LocalDateTime.now());
                        sysUserMapper.updateSysUserPassword(user);
                    } catch (Exception ignore) { /* 重写失败不影响登录 */ }
                }
            }
        }
        if (!passOk) {
            return AjaxResult.error("用户名或密码错误");
        }

        // 3) 查 teacher_id
        Teacher teacher = teacherMapper.selectTeacherByUserId(user.getUserId());
        if (teacher == null) {
            // 自愈:账号是教师身份但 my_teacher 没有档案,自动补一条最小记录,
            //      避免教师账号登录被卡住。后续可在"账号设置"或管理端补全院系/职称等。
            Teacher auto = new Teacher();
            auto.setUserId(user.getUserId());
            auto.setTeacherNo(generateTeacherNo(user.getUserId()));
            auto.setDepartment("未分配");
            auto.setTitle("");
            auto.setSpecialty("");
            auto.setCreateTime(java.time.LocalDateTime.now());
            auto.setUpdateTime(java.time.LocalDateTime.now());
            teacherMapper.insertTeacher(auto);
            teacher = teacherMapper.selectTeacherByUserId(user.getUserId());
            if (teacher == null) {
                return AjaxResult.error("该账号尚未绑定教师档案,请联系管理员");
            }
        }

        // 4) 构造 LoginUser,teacherId 写入其中
        LoginUser loginUser = new LoginUser();
        loginUser.setUserId(user.getUserId());
        loginUser.setTeacherId(teacher.getTeacherId());
        // 包装一个轻量 SysUser 占位,避免 token 序列化/反序列化时 NPE
        // LoginUser 没有 setUsername,username 从 user.userName 解析
        SysUser sysUserHolder = new SysUser();
        sysUserHolder.setUserId(user.getUserId());
        sysUserHolder.setUserName(user.getUsername());
        sysUserHolder.setPassword(user.getPassword());
        loginUser.setUser(sysUserHolder);
        loginUser.setPermissions(Collections.emptySet());

        // 5) 生成 token
        String token = tokenService.createToken(loginUser);

        // 6) Redis 写入记住凭据(30天):本设备下次打开可凭 rememberToken 自动登录
        String rememberToken = IdUtils.simpleUUID();
        redisCache.setCacheObject(REMEMBER_KEY_PREFIX + rememberToken, user.getUserId(), REMEMBER_DAYS, TimeUnit.DAYS);

        // 7) 返回 token + teacherId + rememberToken
        return AjaxResult.success()
                .put(Constants.TOKEN, token)
                .put("teacherId", teacher.getTeacherId())
                .put("teacherNo", teacher.getTeacherNo())
                .put("realName", user.getRealName())
                .put("userId", user.getUserId())
                .put("username", user.getUsername())
                .put("rememberToken", rememberToken);
    }

    /**
     * 免密自动登录
     * POST /teacher/autoLogin
     * body: { "rememberToken": "xxx" }
     * 校验 Redis 中的记住凭据,有效则签发新 token 并顺延 30 天;无效提示重新登录。
     */
    @PostMapping("/autoLogin")
    public AjaxResult autoLogin(@RequestBody AutoLoginRequest body) {
        if (body == null || body.getRememberToken() == null || body.getRememberToken().isEmpty()) {
            return AjaxResult.error("登录状态无效,请重新登录");
        }
        String key = REMEMBER_KEY_PREFIX + body.getRememberToken();
        Long userId = redisCache.getCacheObject(key);
        if (userId == null) {
            return AjaxResult.error("登录状态已过期,请重新登录");
        }

        // 1) 查用户并做状态校验(与密码登录一致)
        com.ruoyi.taskmanage.domain.SysUser user = sysUserMapper.selectSysUserById(userId);
        if (user == null || (user.getIsDeleted() != null && user.getIsDeleted() == 1)) {
            redisCache.deleteObject(key);
            return AjaxResult.error("账号不存在或已注销,请重新登录");
        }
        if (user.getUserType() == null || user.getUserType() != 2) {
            redisCache.deleteObject(key);
            return AjaxResult.error("非教师账号,禁止登录");
        }
        if (user.getStatus() != null && user.getStatus() == 0) {
            redisCache.deleteObject(key);
            return AjaxResult.error("账号已被禁用");
        }

        // 2) 查 teacher_id
        Teacher teacher = teacherMapper.selectTeacherByUserId(userId);
        if (teacher == null) {
            redisCache.deleteObject(key);
            return AjaxResult.error("该账号尚未绑定教师档案,请联系管理员");
        }

        // 3) 顺延记住凭据有效期
        redisCache.setCacheObject(key, userId, REMEMBER_DAYS, TimeUnit.DAYS);

        // 4) 签发新 token(与密码登录相同的流程)
        LoginUser loginUser = new LoginUser();
        loginUser.setUserId(user.getUserId());
        loginUser.setTeacherId(teacher.getTeacherId());
        SysUser sysUserHolder = new SysUser();
        sysUserHolder.setUserId(user.getUserId());
        sysUserHolder.setUserName(user.getUsername());
        sysUserHolder.setPassword(user.getPassword());
        loginUser.setUser(sysUserHolder);
        loginUser.setPermissions(Collections.emptySet());
        String token = tokenService.createToken(loginUser);

        return AjaxResult.success()
                .put(Constants.TOKEN, token)
                .put("teacherId", teacher.getTeacherId())
                .put("teacherNo", teacher.getTeacherNo())
                .put("realName", user.getRealName())
                .put("userId", user.getUserId())
                .put("username", user.getUsername());
    }

    /** 自动登录入参 */
    public static class AutoLoginRequest {
        private String rememberToken;
        public String getRememberToken() { return rememberToken; }
        public void setRememberToken(String rememberToken) { this.rememberToken = rememberToken; }
    }

    /** 登录入参 */
    public static class LoginRequest {
        private String username;
        private String password;
        private String code;
        private String uuid;
        public String getUsername() { return username; }
        public void setUsername(String username) { this.username = username; }
        public String getPassword() { return password; }
        public void setPassword(String password) { this.password = password; }
        public String getCode() { return code; }
        public void setCode(String code) { this.code = code; }
        public String getUuid() { return uuid; }
        public void setUuid(String uuid) { this.uuid = uuid; }
    }

    /**
     * 给新增档案生成一个唯一的工号
     * 格式: T + 年份 + userId(补零)
     * 例: userId=3 -> "T202600003"
     */
    private String generateTeacherNo(Long userId) {
        String year = String.valueOf(java.time.LocalDate.now().getYear());
        return "T" + year + String.format("%06d", userId == null ? 0L : userId);
    }
}
