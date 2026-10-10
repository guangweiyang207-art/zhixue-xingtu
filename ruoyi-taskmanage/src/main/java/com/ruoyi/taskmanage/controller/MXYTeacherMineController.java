package com.ruoyi.taskmanage.controller;

import com.ruoyi.common.config.RuoYiConfig;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.file.FileUploadUtils;
import com.ruoyi.taskmanage.domain.Course;
import com.ruoyi.taskmanage.domain.MXYTeacherAccountVO;
import com.ruoyi.taskmanage.domain.MXYTeacherMineVO;
import com.ruoyi.taskmanage.domain.MXYTeacherStatsVO;
import com.ruoyi.taskmanage.service.IMXYTeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * 教师小程序"我的"页面 + 子页面接口
 *  - 需要登录(无 @Anonymous),teacherId 从 token 取
 *
 * @author 马孝银
 */
@RestController
@RequestMapping("/mxy/teacher")
public class MXYTeacherMineController extends BaseController {

    @Autowired private IMXYTeacherService teacherService;

    /** GET /mxy/teacher/info */
    @GetMapping("/info")
    public AjaxResult info() {
        Long teacherId = SecurityUtils.getTeacherId();
        MXYTeacherMineVO vo = teacherService.selectTeacherMineInfo(teacherId);
        return AjaxResult.success(vo);
    }

    /** GET /mxy/teacher/courses 我发布的课程 */
    @GetMapping("/courses")
    public AjaxResult myCourses() {
        Long teacherId = SecurityUtils.getTeacherId();
        List<Course> list = teacherService.selectMyCourses(teacherId);
        return AjaxResult.success(list);
    }

    /** GET /mxy/teacher/stats 教学统计 */
    @GetMapping("/stats")
    public AjaxResult stats() {
        Long teacherId = SecurityUtils.getTeacherId();
        MXYTeacherStatsVO vo = teacherService.selectTeacherStats(teacherId);
        return AjaxResult.success(vo);
    }

    /** GET /mxy/teacher/account 完整账号信息 */
    @GetMapping("/account")
    public AjaxResult account() {
        Long teacherId = SecurityUtils.getTeacherId();
        MXYTeacherAccountVO vo = teacherService.selectTeacherAccount(teacherId);
        return AjaxResult.success(vo);
    }

    /** PUT /mxy/teacher/account 修改账号信息 */
    @PutMapping("/account")
    public AjaxResult updateAccount(@RequestBody MXYTeacherAccountVO vo) {
        // 强制把路径上的 teacherId 写回,避免前端漏传
        Long teacherId = SecurityUtils.getTeacherId();
        if (vo == null) vo = new MXYTeacherAccountVO();
        vo.setTeacherId(teacherId);
        if (vo.getUserId() == null) {
            LoginUser lu = SecurityUtils.getLoginUser();
            if (lu != null && lu.getUser() != null) {
                vo.setUserId(lu.getUser().getUserId());
            }
        }
        return toAjax(teacherService.updateTeacherAccount(vo));
    }

    /** POST /mxy/teacher/avatar 头像上传,返回头像访问 URL */
    @PostMapping("/avatar")
    public AjaxResult uploadAvatar(@RequestParam("file") MultipartFile file) throws Exception {
        if (file == null || file.isEmpty()) {
            return AjaxResult.error("上传文件不能为空");
        }
        LoginUser lu = SecurityUtils.getLoginUser();
        if (lu == null || lu.getUser() == null) {
            return AjaxResult.error("请先登录");
        }
        String fileName = FileUploadUtils.upload(RuoYiConfig.getAvatarPath(), file);
        String url = fileName;
        teacherService.updateTeacherAvatar(lu.getUser().getUserId(), url);
        return AjaxResult.success("上传成功").put("imgUrl", url);
    }

    /** PUT /mxy/teacher/password 修改密码 */
    @PutMapping("/password")
    public AjaxResult updatePassword(@RequestBody java.util.Map<String, String> body) {
        LoginUser lu = SecurityUtils.getLoginUser();
        if (lu == null || lu.getUser() == null) {
            return AjaxResult.error("请先登录");
        }
        String oldPwd = body == null ? null : body.get("oldPassword");
        String newPwd = body == null ? null : body.get("newPassword");
        if (oldPwd == null || oldPwd.isEmpty()) {
            return AjaxResult.error("请输入原密码");
        }
        if (newPwd == null || newPwd.isEmpty()) {
            return AjaxResult.error("请输入新密码");
        }
        if (newPwd.length() < 6) {
            return AjaxResult.error("新密码长度不能少于 6 位");
        }
        boolean ok = teacherService.updateTeacherPassword(lu.getUser().getUserId(), oldPwd, newPwd);
        return ok ? AjaxResult.success("密码修改成功") : AjaxResult.error("原密码不正确");
    }
}
