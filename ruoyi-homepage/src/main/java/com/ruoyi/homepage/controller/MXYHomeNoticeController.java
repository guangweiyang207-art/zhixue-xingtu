package com.ruoyi.homepage.controller;

import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.homepage.service.IMXYHomeNoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * 主页通知 Controller(只读,发布/编辑请走 taskmanage 的 /system/notice)
 *
 * @author 马孝银
 */
@Anonymous
@RestController
@RequestMapping("/teacher/notice")
public class MXYHomeNoticeController extends BaseController {

    @Autowired
    private IMXYHomeNoticeService noticeService;

    @GetMapping("/list")
    public AjaxResult list(@RequestParam(value = "limit", defaultValue = "10") int limit) {
        return AjaxResult.success(noticeService.selectLatestNotices(limit));
    }

    @GetMapping("/listByType")
    public AjaxResult listByType(@RequestParam Integer noticeType,
                                 @RequestParam(value = "limit", defaultValue = "10") int limit) {
        return AjaxResult.success(noticeService.selectNoticesByType(noticeType, limit));
    }
}
