package com.ruoyi.web.controller.errorbook;

import com.ruoyi.common.R;
import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.errorbook.pojo.ErrorBookVO;
import com.ruoyi.errorbook.service.ErrorBookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Anonymous
@RestController
@RequestMapping("/errorbook")
public class ErrorBookController {

    @Autowired
    private ErrorBookService errorBookService;

    /**
     * 获取错题列表
     * @param stuId  学生ID
     * @param subject 科目标识（all/math/physics/english/chemistry），为空则查询全部
     */
    @GetMapping("/list")
    public R getErrorBookList(@RequestParam("stu_id") Long stuId,
                              @RequestParam(value = "subject", required = false, defaultValue = "all") String subject) {
        List<ErrorBookVO> list = errorBookService.getErrorBookList(stuId, subject);
        return R.success(list);
    }

    /**
     * 获取错题统计概览（总错题数、待复习数、已掌握数、掌握率）
     */
    @GetMapping("/stats")
    public R getErrorBookStats(@RequestParam("stu_id") Long stuId) {
        Map<String, Object> stats = errorBookService.getErrorBookStats(stuId);
        return R.success(stats);
    }
}