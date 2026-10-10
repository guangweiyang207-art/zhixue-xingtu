package com.ruoyi.web.controller.notification;

import com.ruoyi.common.R;
import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.notification.pojo.ReminderAddVO;
import com.ruoyi.notification.pojo.ReminderVO;
import com.ruoyi.notification.service.ReminderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Anonymous
@RestController
@RequestMapping("/reminder")
public class ReminderController {

    @Autowired
    private ReminderService reminderService;

    @GetMapping("/list")
    public R getReminders(@RequestParam("stu_id") Long stuId) {
        List<ReminderVO> list = reminderService.getReminders(stuId);
        return R.success(list);
    }

    @GetMapping("/count")
    public R countReminders(@RequestParam("stu_id") Long stuId) {
        int count = reminderService.countReminders(stuId);
        return R.success(count);
    }

    @GetMapping("/{trId}")
    public R getReminderById(@PathVariable Long trId) {
        ReminderAddVO vo = reminderService.getReminderForUpdate(trId);
        if (vo == null) {
            return R.error("提醒不存在");
        }
        return R.success(vo);
    }

    @PostMapping("/add")
    public R addReminder(@RequestParam("stu_id") Long stuId, @RequestBody ReminderAddVO vo) {
        reminderService.addReminder(stuId, vo);
        return R.success("提醒已添加");
    }

    @PutMapping("/{trId}")
    public R updateReminder(@PathVariable Long trId, @RequestBody ReminderAddVO vo) {
        reminderService.updateReminder(trId, vo);
        return R.success("提醒已更新");
    }

    @DeleteMapping("/{trId}")
    public R deleteReminder(@PathVariable Long trId) {
        reminderService.deleteReminder(trId);
        return R.success("提醒已删除");
    }
}