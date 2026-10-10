package com.ruoyi.taskmanage.controller;

import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.taskmanage.domain.QuestionAnswer;
import com.ruoyi.taskmanage.service.IMXYQuestionAnswerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

/**
 * 学生 ↔ 老师 问答接口
 *  - 学生:挑选老师 → 提交 question
 *  - 老师:看到 question 后回 answer → status 置 1
 *  - status: 0-待回复 1-已回复 2-已关闭
 *
 * 路由前缀:/mxy/qa
 */
@Anonymous
@RestController
@RequestMapping("/mxy/qa")
public class MXYQuestionAnswerController extends BaseController {

    @Autowired private IMXYQuestionAnswerService qaService;

    /** 列表(按 stuId/teacherId/status 过滤) */
    @GetMapping("/list")
    public AjaxResult list(QuestionAnswer qa) {
        return AjaxResult.success(qaService.selectQaList(qa));
    }

    /** 详情 */
    @GetMapping("/{id}")
    public AjaxResult getInfo(@PathVariable Long id) {
        return AjaxResult.success(qaService.selectQaById(id));
    }

    /**
     * 学生提交问题
     * 必传:stuId / teacherId / question
     * 可选:createBy(学生user_id)
     */
    @PostMapping("/ask")
    public AjaxResult ask(@RequestBody QuestionAnswer qa) {
        if (qa.getStuId() == null) throw new ServiceException("stuId 不能为空");
        if (qa.getTeacherId() == null) throw new ServiceException("teacherId 不能为空");
        if (qa.getQuestion() == null || qa.getQuestion().trim().isEmpty()) {
            throw new ServiceException("question 不能为空");
        }
        qa.setStatus(0); // 学生提交时状态=待回复
        if (qa.getAnswer() == null) qa.setAnswer("");
        LocalDateTime now = LocalDateTime.now();
        qa.setCreateTime(now);
        qa.setUpdateTime(now);
        return toAjax(qaService.insertQa(qa));
    }

    /**
     * 老师回答
     * 必传:id / answer
     * 可选:updateBy(老师user_id)
     * 自动把 status 置 1
     */
    @PutMapping("/answer")
    public AjaxResult answer(@RequestBody QuestionAnswer qa) {
        if (qa.getId() == null) throw new ServiceException("id 不能为空");
        if (qa.getAnswer() == null || qa.getAnswer().trim().isEmpty()) {
            throw new ServiceException("answer 不能为空");
        }
        qa.setStatus(1);
        qa.setUpdateTime(LocalDateTime.now());
        return toAjax(qaService.answerQa(qa));
    }

    /**
     * 修改(关闭/重开 等)
     */
    @PutMapping
    public AjaxResult edit(@RequestBody QuestionAnswer qa) {
        qa.setUpdateTime(LocalDateTime.now());
        return toAjax(qaService.updateQa(qa));
    }

    /** 删除 */
    @DeleteMapping("/{id}")
    public AjaxResult remove(@PathVariable Long id) {
        return toAjax(qaService.deleteQaById(id));
    }
}
