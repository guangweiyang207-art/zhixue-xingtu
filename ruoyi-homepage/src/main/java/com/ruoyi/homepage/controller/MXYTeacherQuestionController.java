package com.ruoyi.homepage.controller;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.homepage.domain.TodoQuestion;
import com.ruoyi.homepage.service.IMXYTeacherQuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 教师"待回答问题"Controller
 *
 * @author 马孝银
 */
@RestController
@RequestMapping("/teacher/answer")
public class MXYTeacherQuestionController extends BaseController {

    @Autowired
    private IMXYTeacherQuestionService service;

    /** 列表:待回答问题(优先 token teacherId) */
    @GetMapping("/list")
    public AjaxResult list(@RequestParam(value = "teacherId", required = false) Long teacherId) {
        if (teacherId == null) {
            teacherId = SecurityUtils.getTeacherId();
        }
        return AjaxResult.success(service.list(teacherId));
    }

    /** 列表:已回答问题(优先 token teacherId) */
    @GetMapping("/replied")
    public AjaxResult replied(@RequestParam(value = "teacherId", required = false) Long teacherId) {
        if (teacherId == null) {
            teacherId = SecurityUtils.getTeacherId();
        }
        return AjaxResult.success(service.listReplied(teacherId));
    }

    /** 详情 */
    @GetMapping("/detail/{chatId}")
    public AjaxResult detail(@PathVariable("chatId") Long chatId) {
        TodoQuestion q = service.detail(chatId);
        if (q == null) return AjaxResult.error("记录不存在");
        return AjaxResult.success(q);
    }

    /** 提交回答 */
    @PostMapping("/reply")
    public AjaxResult reply(@RequestBody ReplyRequest body) {
        if (body == null || body.getChatId() == null) {
            return AjaxResult.error("参数错误");
        }
        if (body.getAnswer() == null || body.getAnswer().trim().isEmpty()) {
            return AjaxResult.error("回答内容不能为空");
        }
        Long teacherId = SecurityUtils.getTeacherId();
        int rows = service.answer(body.getChatId(), body.getAnswer().trim(), teacherId);
        return rows > 0 ? AjaxResult.success("回答成功") : AjaxResult.error("回答失败");
    }

    public static class ReplyRequest {
        private Long   chatId;
        private String answer;
        public Long getChatId() { return chatId; }
        public void setChatId(Long chatId) { this.chatId = chatId; }
        public String getAnswer() { return answer; }
        public void setAnswer(String answer) { this.answer = answer; }
    }
}
