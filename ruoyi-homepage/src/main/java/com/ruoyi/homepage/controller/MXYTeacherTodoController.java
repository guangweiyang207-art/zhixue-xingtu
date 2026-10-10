package com.ruoyi.homepage.controller;

import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.homepage.domain.TodoCount;
import com.ruoyi.homepage.service.IMXYTeacherTodoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * 教师主页待办统计
 *
 * @author 马孝银
 */
@Anonymous
@RestController
@RequestMapping("/teacher/todo")
public class MXYTeacherTodoController extends BaseController {

    @Autowired
    private IMXYTeacherTodoService todoService;

    /**
     * 一次性聚合
     * 优先从 token 中取 teacher_id;未取到时再按旧逻辑兜底
     */
    @GetMapping("/count")
    public AjaxResult count(@RequestParam(value = "teacherId", required = false) Long teacherId) {
        // 1) 入参优先
        if (teacherId != null) {
            return AjaxResult.success(todoService.selectTodoCount(teacherId));
        }
        // 2) token 中取(小程序教师登录后必带)
        Long tid = SecurityUtils.getTeacherId();
        if (tid != null) {
            return AjaxResult.success(todoService.selectTodoCount(tid));
        }
        // 3) 兜底
        try {
            Long userId = SecurityUtils.getUserId();
            return AjaxResult.success(todoService.selectTodoCountByUserId(userId));
        } catch (ServiceException e) {
            return AjaxResult.success(todoService.selectTodoCount(null));
        }
    }

    /** 仅待批改作业数 */
    @GetMapping("/homeworkCount")
    public AjaxResult homeworkCount(@RequestParam Long teacherId) {
        return AjaxResult.success(todoService.countHomeworkTodoByTeacherId(teacherId));
    }

    /** 仅待回答问题数 */
    @GetMapping("/questionCount")
    public AjaxResult questionCount(@RequestParam(value = "teacherId", required = false) Long teacherId) {
        if (teacherId == null) {
            teacherId = SecurityUtils.getTeacherId();
        }
        return AjaxResult.success(todoService.countUnansweredQuestion(teacherId));
    }
}
