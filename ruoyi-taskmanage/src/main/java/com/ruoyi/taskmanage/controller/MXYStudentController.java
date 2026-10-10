package com.ruoyi.taskmanage.controller;

import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.taskmanage.mapper.MXYStudentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 学生辅助接口(班级下拉 / 派发预览)
 *
 * @author 马孝银
 */
@Anonymous
@RestController
@RequestMapping("/student")
public class MXYStudentController extends BaseController {

    @Autowired private MXYStudentMapper studentMapper;

    /** 获取所有不重复的班级名称,给发布作业表单用 */
    @GetMapping("/class-names")
    public AjaxResult classNames() {
        List<String> list = studentMapper.selectDistinctClassNames();
        return AjaxResult.success(list);
    }
}
