package com.ruoyi.taskmanage.controller;

import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.taskmanage.domain.Homework;
import com.ruoyi.taskmanage.domain.HomeworkPublishRequest;
import com.ruoyi.taskmanage.service.IMXYHomeworkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

/**
 * 作业管理(对应 my_homework)
 *
 * @author 马孝银
 */
@Anonymous
@RestController
@RequestMapping("/homework")
public class MXYHomeworkController extends BaseController {

    @Autowired
    private IMXYHomeworkService homeworkService;

    @GetMapping("/{homeworkId}")
    public AjaxResult getInfo(@PathVariable Long homeworkId) {
        return AjaxResult.success(homeworkService.selectHomeworkById(homeworkId));
    }

    /**
     * 教师"发布作业"专用接口(推荐小程序使用)
     * 入参:title / content / courseId / className / type / totalScore / deadline
     * 后端自动注入 teacher_id + status(1) + create_time/update_time,
     * 并按 class_name 派发到所在班级的所有学生(my_student_homework)
     */
    @PostMapping("/publish")
    public AjaxResult publish(@RequestBody HomeworkPublishRequest req) {
        Long hwId = homeworkService.publish(req);
        return hwId != null
                ? AjaxResult.success("发布成功").put("hwId", hwId)
                : AjaxResult.error("发布失败");
    }

    @PostMapping
    public AjaxResult add(@RequestBody Homework homework) {
        homework.setCreateTime(LocalDateTime.now());
        homework.setUpdateTime(LocalDateTime.now());
        if (homework.getStatus() == null) homework.setStatus(0);
        if (homework.getTeacherId() == null) {
            homework.setTeacherId(SecurityUtils.getTeacherId());
        }
        return toAjax(homeworkService.insertHomework(homework));
    }

    @PutMapping
    public AjaxResult edit(@RequestBody Homework homework) {
        homework.setUpdateTime(LocalDateTime.now());
        if (homework.getTeacherId() == null) {
            homework.setTeacherId(SecurityUtils.getTeacherId());
        }
        return toAjax(homeworkService.updateHomework(homework));
    }

    @DeleteMapping("/{homeworkId}")
    public AjaxResult remove(@PathVariable Long homeworkId) {
        return toAjax(homeworkService.deleteHomeworkById(homeworkId));
    }
}


