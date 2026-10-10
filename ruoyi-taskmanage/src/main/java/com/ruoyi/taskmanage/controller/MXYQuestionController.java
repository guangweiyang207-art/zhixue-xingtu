package com.ruoyi.taskmanage.controller;

import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.taskmanage.domain.Question;
import com.ruoyi.taskmanage.service.IMXYQuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Anonymous
@RestController
@RequestMapping("/mxy/question")
public class MXYQuestionController extends BaseController {

    @Autowired private IMXYQuestionService service;

    @GetMapping("/list")
    public AjaxResult list(Question q) { return AjaxResult.success(service.selectQuestionList(q)); }

    @GetMapping("/{qId}")
    public AjaxResult getInfo(@PathVariable Long qId) { return AjaxResult.success(service.selectQuestionById(qId)); }

    @PostMapping
    public AjaxResult add(@RequestBody Question q) { return toAjax(service.insertQuestion(q)); }

    @PutMapping
    public AjaxResult edit(@RequestBody Question q) { return toAjax(service.updateQuestion(q)); }

    @DeleteMapping("/{qId}")
    public AjaxResult remove(@PathVariable Long qId) { return toAjax(service.deleteQuestionById(qId)); }
}


