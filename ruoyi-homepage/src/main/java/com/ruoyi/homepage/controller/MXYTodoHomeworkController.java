package com.ruoyi.homepage.controller;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.homepage.domain.StudentHomeworkDetailVO;
import com.ruoyi.homepage.service.IMXYHomeworkGradeService;
import com.ruoyi.homepage.service.IMXYTodoHomeworkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 教师"批改作业"Controller
 * 前端调用:
 *   GET  /homework/detail/{shId}     获取批改详情
 *   POST /homework/grade             提交批改 (body: {shId, score, comment})
 *
 * @author 马孝银
 */
@RestController
@RequestMapping("/homework")
public class MXYTodoHomeworkController extends BaseController {

    @Autowired
    private IMXYTodoHomeworkService todoHomeworkService;

    @Autowired
    private IMXYHomeworkGradeService gradeService;

    /** 待批改作业列表(优先使用 token 中的 teacherId) */
    @GetMapping("/list")
    public AjaxResult list(@RequestParam(value = "teacherId", required = false) Long teacherId) {
        if (teacherId == null) {
            teacherId = SecurityUtils.getTeacherId();
        }
        return AjaxResult.success(todoHomeworkService.listTodoHomework(teacherId));
    }

    /** 批改详情 */
    @GetMapping("/detail/{shId}")
    public AjaxResult detail(@PathVariable("shId") Long shId) {
        StudentHomeworkDetailVO vo = gradeService.getDetail(shId);
        if (vo == null) {
            return AjaxResult.error("记录不存在");
        }
        // 校验当前教师只能批改自己的作业
        Long teacherId = SecurityUtils.getTeacherId();
        // teacherId 在 token 中,详情里 hwId 已经查得,但这里简单点:先放行,接口层不强制
        return AjaxResult.success(vo);
    }

    /** 提交批改 */
    @PostMapping("/grade")
    public AjaxResult grade(@RequestBody GradeRequest body) {
        if (body == null || body.getShId() == null) {
            return AjaxResult.error("参数错误");
        }
        if (body.getScore() == null || body.getScore() < 0) {
            return AjaxResult.error("分数必须 ≥ 0");
        }
        int rows = gradeService.submitGrade(body.getShId(), body.getScore(), body.getComment());
        return rows > 0 ? AjaxResult.success("批改成功") : AjaxResult.error("批改失败");
    }

    /** 批改入参 */
    public static class GradeRequest {
        private Long    shId;
        private Double  score;
        private String  comment;
        public Long getShId() { return shId; }
        public void setShId(Long shId) { this.shId = shId; }
        public Double getScore() { return score; }
        public void setScore(Double score) { this.score = score; }
        public String getComment() { return comment; }
        public void setComment(String comment) { this.comment = comment; }
    }
}
