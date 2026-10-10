package com.ruoyi.taskmanage.controller;

import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.taskmanage.domain.Notice;
import com.ruoyi.taskmanage.service.IMXYNoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@Anonymous
@RestController
@RequestMapping("/mxy/notice")
public class MXYNoticeController extends BaseController {

    @Autowired private IMXYNoticeService noticeService;

    @GetMapping("/list")
    public AjaxResult list(Notice notice) { return AjaxResult.success(noticeService.selectNoticeList(notice)); }

    @GetMapping("/{noticeId}")
    public AjaxResult getInfo(@PathVariable Long noticeId) { return AjaxResult.success(noticeService.selectNoticeById(noticeId)); }

    @PostMapping
    public AjaxResult add(@RequestBody Notice notice) {
        notice.setCreateTime(LocalDateTime.now());
        notice.setUpdateTime(LocalDateTime.now());
        if (notice.getStatus() == null) notice.setStatus(0);
        return toAjax(noticeService.insertNotice(notice));
    }

    @PutMapping
    public AjaxResult edit(@RequestBody Notice notice) {
        notice.setUpdateTime(LocalDateTime.now());
        return toAjax(noticeService.updateNotice(notice));
    }

    @DeleteMapping("/{noticeId}")
    public AjaxResult remove(@PathVariable Long noticeId) { return toAjax(noticeService.deleteNoticeById(noticeId)); }
}


