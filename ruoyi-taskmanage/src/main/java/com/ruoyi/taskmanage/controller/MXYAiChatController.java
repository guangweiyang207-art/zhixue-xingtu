package com.ruoyi.taskmanage.controller;

import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.taskmanage.domain.AiChat;
import com.ruoyi.taskmanage.service.IMXYAiChatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@Anonymous
@RestController
@RequestMapping("/mxy/aiChat")
public class MXYAiChatController extends BaseController {

    @Autowired private IMXYAiChatService service;

    @GetMapping("/list")
    public AjaxResult list(AiChat a) { return AjaxResult.success(service.selectAiChatList(a)); }

    @GetMapping("/{id}")
    public AjaxResult getInfo(@PathVariable Long id) { return AjaxResult.success(service.selectAiChatById(id)); }

    @PostMapping
    public AjaxResult add(@RequestBody AiChat a) {
        if (a.getCreateTime() == null) a.setCreateTime(LocalDateTime.now());
        return toAjax(service.insertAiChat(a));
    }

    @PutMapping
    public AjaxResult edit(@RequestBody AiChat a) { return toAjax(service.updateAiChat(a)); }

    @DeleteMapping("/{id}")
    public AjaxResult remove(@PathVariable Long id) { return toAjax(service.deleteAiChatById(id)); }
}


