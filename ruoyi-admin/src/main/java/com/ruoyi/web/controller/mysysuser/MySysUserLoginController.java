package com.ruoyi.web.controller.mysysuser;

import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.config.RuoYiConfig;
import com.ruoyi.common.constant.CacheConstants;
import com.ruoyi.common.constant.Constants;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.file.FileUploadUtils;
import com.ruoyi.common.utils.file.MimeTypeUtils;
import com.ruoyi.framework.web.service.TokenService;
import com.ruoyi.mysysuser.domain.MySysUser;
import com.ruoyi.mysysuser.service.IMySysUserService;
import com.ruoyi.student.mapper.StudentMapper;
import com.ruoyi.system.service.ISysConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.Map;
import java.util.Date;

@RestController
@RequestMapping("/myauth")
public class MySysUserLoginController
{
    @Autowired
    private IMySysUserService mySysUserService;

    @Autowired
    private StudentMapper studentMapper;

    @Autowired
    private TokenService tokenService;

    @Autowired
    private ISysConfigService configService;

    @Autowired
    private RedisCache redisCache;

    @Anonymous
    @PostMapping("/login")
    public AjaxResult login(@RequestBody Map<String, String> loginBody)
    {
        String username = loginBody.get("username");
        String password = loginBody.get("password");
        String code = loginBody.get("code");
        String uuid = loginBody.get("uuid");

        if (StringUtils.isEmpty(username))
        {
            return AjaxResult.error("请输入账号");
        }
        if (StringUtils.isEmpty(password))
        {
            return AjaxResult.error("请输入密码");
        }

        // 验证码校验
        boolean captchaEnabled = configService.selectCaptchaEnabled();
        if (captchaEnabled)
        {
            if (StringUtils.isEmpty(code))
            {
                return AjaxResult.error("请输入验证码");
            }
            String verifyKey = CacheConstants.CAPTCHA_CODE_KEY + StringUtils.nvl(uuid, "");
            String captcha = redisCache.getCacheObject(verifyKey);
            if (captcha == null)
            {
                return AjaxResult.error("验证码已过期");
            }
            redisCache.deleteObject(verifyKey);
            if (!code.equalsIgnoreCase(captcha))
            {
                return AjaxResult.error("验证码错误");
            }
        }

        MySysUser user = mySysUserService.selectMySysUserByUsername(username);
        if (user == null)
        {
            return AjaxResult.error("用户不存在");
        }
        if (user.getStatus() != null && user.getStatus() == 0)
        {
            return AjaxResult.error("账号已被禁用");
        }
        if (user.getIsDeleted() != null && user.getIsDeleted() == 1)
        {
            return AjaxResult.error("账号已被删除");
        }

        // 密码校验：兼容 BCrypt 加密和明文密码
        boolean passwordMatch = SecurityUtils.matchesPassword(password, user.getPassword());
        if (!passwordMatch && !password.equals(user.getPassword()))
        {
            return AjaxResult.error("密码错误");
        }

        SysUser sysUser = new SysUser();
        sysUser.setUserId(user.getUserId());
        sysUser.setUserName(user.getUsername());
        sysUser.setNickName(user.getRealName());
        sysUser.setAvatar(user.getAvatar());

        LoginUser loginUser = new LoginUser();
        loginUser.setUserId(user.getUserId());
        loginUser.setUser(sysUser);

        String token = tokenService.createToken(loginUser);

        Map<String, Object> result = new HashMap<>();
        result.put(Constants.TOKEN, token);
        result.put("userId", user.getUserId());
        result.put("username", user.getUsername());
        result.put("realName", user.getRealName());
        result.put("avatar", user.getAvatar());
        result.put("userType", user.getUserType());

        // 关联 my_student,补充 stu_id(预约等业务需要)
        Long stuId = studentMapper.selectStuIdByUserId(user.getUserId());
        if (stuId != null) {
            result.put("stuId", stuId);
            result.put("stu_id", stuId);
        }

        return AjaxResult.success("登录成功", result);
    }

    @Anonymous
    @PostMapping("/register")
    public AjaxResult register(@RequestBody MySysUser user)
    {
        if (StringUtils.isEmpty(user.getUsername()))
        {
            return AjaxResult.error("请输入账号");
        }
        if (StringUtils.isEmpty(user.getPassword()))
        {
            return AjaxResult.error("请输入密码");
        }
        if (user.getUsername().length() < 3 || user.getUsername().length() > 30)
        {
            return AjaxResult.error("账号长度必须在 3-30 个字符之间");
        }
        if (user.getPassword().length() < 6 || user.getPassword().length() > 20)
        {
            return AjaxResult.error("密码长度必须在 6-20 个字符之间");
        }

        MySysUser existingUser = mySysUserService.selectMySysUserByUsername(user.getUsername());
        if (existingUser != null)
        {
            return AjaxResult.error("账号已存在");
        }

        user.setStatus(1);
        user.setIsDeleted(0);
        user.setCreateTime(new Date());

        int result = mySysUserService.insertMySysUser(user);
        if (result > 0)
        {
            return AjaxResult.success("注册成功");
        }
        return AjaxResult.error("注册失败");
    }

    @PostMapping("/changePassword")
    public AjaxResult changePassword(@RequestBody Map<String, String> body)
    {
        String username = body.get("username");
        String oldPassword = body.get("oldPassword");
        String newPassword = body.get("newPassword");

        if (StringUtils.isEmpty(username) || StringUtils.isEmpty(oldPassword) || StringUtils.isEmpty(newPassword))
        {
            return AjaxResult.error("参数不能为空");
        }
        if (newPassword.length() < 6 || newPassword.length() > 20)
        {
            return AjaxResult.error("新密码长度必须在 6-20 个字符之间");
        }

        MySysUser user = mySysUserService.selectMySysUserByUsername(username);
        if (user == null)
        {
            return AjaxResult.error("用户不存在");
        }

        boolean passwordMatch = SecurityUtils.matchesPassword(oldPassword, user.getPassword());
        if (!passwordMatch && !oldPassword.equals(user.getPassword()))
        {
            return AjaxResult.error("原密码错误");
        }

        user.setPassword(newPassword);
        user.setUpdateTime(new Date());
        int result = mySysUserService.updateMySysUser(user);
        if (result > 0)
        {
            return AjaxResult.success("密码修改成功");
        }
        return AjaxResult.error("密码修改失败");
    }

    /**
     * 学生头像上传:存文件并更新 my_sys_user.avatar
     */
    @PostMapping("/avatar")
    public AjaxResult avatar(@RequestParam("avatarfile") MultipartFile file) throws Exception
    {
        if (file.isEmpty())
        {
            return AjaxResult.error("上传图片异常，请联系管理员");
        }
        String avatar = FileUploadUtils.upload(RuoYiConfig.getAvatarPath(), file, MimeTypeUtils.IMAGE_EXTENSION, true);
        MySysUser user = new MySysUser();
        user.setUserId(SecurityUtils.getUserId());
        user.setAvatar(avatar);
        user.setUpdateTime(new Date());
        int rows = mySysUserService.updateMySysUser(user);
        if (rows > 0)
        {
            AjaxResult ajax = AjaxResult.success();
            ajax.put("imgUrl", avatar);
            return ajax;
        }
        return AjaxResult.error("头像更新失败");
    }
}
