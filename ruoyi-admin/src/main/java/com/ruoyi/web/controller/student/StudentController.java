package com.ruoyi.web.controller.student;

import com.ruoyi.common.R;
import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.student.mapper.StudentMapper;
import com.ruoyi.student.pojo.StudentInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Anonymous
@RestController
@RequestMapping("/mine/user")
public class StudentController {

    @Autowired
    private StudentMapper studentMapper;

    @GetMapping("/profile")
    public R getProfile(@RequestParam("stu_id") Long stuId) {
        StudentInfo studentInfo = studentMapper.getStudentProfile(stuId);
        if (studentInfo == null) {
            return R.error("无此学生信息");
        }
        Map<String, Object> result = new HashMap<>();
        result.put("stuId", studentInfo.getStuId());
        result.put("major", studentInfo.getMajor());
        result.put("grade", studentInfo.getGrade());
        result.put("className", studentInfo.getClassName());
        if (studentInfo.getUser() != null) {
            result.put("name", studentInfo.getUser().getRealName());
        }
        return R.success(result);
    }

    /**
     * 获取个人设置信息（姓名、手机、邮箱、学校班级）
     */
    @GetMapping("/settings")
    public R getSettings(@RequestParam("stu_id") Long stuId) {
        Map<String, Object> settings = studentMapper.getSettings(stuId);
        if (settings == null || settings.isEmpty()) {
            return R.error("无此学生信息");
        }
        // 组装 school 字段
        String major = (String) settings.get("major");
        String grade = (String) settings.get("grade");
        String className = (String) settings.get("class_name");
        StringBuilder school = new StringBuilder();
        if (major != null) school.append(major);
        if (grade != null) {
            if (school.length() > 0) school.append(" · ");
            school.append(grade);
        }
        if (className != null) {
            school.append(" · ").append(className);
        }
        settings.put("school", school.toString());

        Map<String, Object> result = new HashMap<>();
        result.put("name", settings.get("name"));
        result.put("phone", settings.get("phone"));
        result.put("email", settings.get("email"));
        result.put("school", school.toString());
        result.put("major", major);
        result.put("grade", grade);
        result.put("className", className);
        return R.success(result);
    }

    /**
     * 保存个人设置
     */
    @PutMapping("/settings")
    public R updateSettings(@RequestParam("stu_id") Long stuId,
                            @RequestBody Map<String, Object> body) {
        String name = (String) body.getOrDefault("name", "");
        String phone = (String) body.getOrDefault("phone", "");
        String email = (String) body.getOrDefault("email", "");
        int rows = studentMapper.updateSettings(stuId, name, phone, email);
        if (rows > 0) {
            return R.success("保存成功");
        }
        return R.error("保存失败");
    }

    /**
     * 修改密码
     */
    @PutMapping("/updatePwd")
    public R updatePwd(@RequestParam("stu_id") Long stuId,
                       @RequestBody Map<String, String> body) {
        String oldPassword = body.get("oldPassword");
        String newPassword = body.get("newPassword");
        String confirmPassword = body.get("confirmPassword");

        // 校验旧密码
        String dbPassword = studentMapper.getPassword(stuId);
        if (dbPassword == null) {
            return R.error("无此学生信息");
        }
        if (!SecurityUtils.matchesPassword(oldPassword, dbPassword)) {
            return R.error("旧密码错误");
        }

        // 校验确认密码
        if (!newPassword.equals(confirmPassword)) {
            return R.error("确认密码与新密码不匹配");
        }

        // 加密新密码并更新
        String encrypted = SecurityUtils.encryptPassword(newPassword);
        int rows = studentMapper.updatePassword(stuId, encrypted);
        if (rows > 0) {
            return R.success("密码修改成功");
        }
        return R.error("密码修改失败");
    }
}