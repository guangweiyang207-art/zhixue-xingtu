package com.ruoyi.taskmanage.controller;

import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.taskmanage.domain.QuestionBank;
import com.ruoyi.taskmanage.service.IMXYQuestionBankService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Anonymous
@RestController
@RequestMapping("/mxy/questionBank")
public class MXYQuestionBankController extends BaseController {

    @Autowired private IMXYQuestionBankService service;

    @GetMapping("/list")
    public AjaxResult list(QuestionBank q) { return AjaxResult.success(service.selectQuestionBankList(q)); }

    @GetMapping("/{id}")
    public AjaxResult getInfo(@PathVariable Long id) { return AjaxResult.success(service.selectQuestionBankById(id)); }

    @PostMapping
    public AjaxResult add(@RequestBody QuestionBank q) { return toAjax(service.insertQuestionBank(q)); }

    @PutMapping
    public AjaxResult edit(@RequestBody QuestionBank q) { return toAjax(service.updateQuestionBank(q)); }

    @DeleteMapping("/{id}")
    public AjaxResult remove(@PathVariable Long id) { return toAjax(service.deleteQuestionBankById(id)); }
}


