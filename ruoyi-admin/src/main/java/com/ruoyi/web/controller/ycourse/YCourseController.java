package com.ruoyi.web.controller.ycourse;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.ycourse.domain.YCourse;
import com.ruoyi.ycourse.service.IYCourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/ycourse/course")
public class YCourseController extends BaseController
{
    @Autowired
    private IYCourseService yCourseService;

    @GetMapping("/list")
    public TableDataInfo list(YCourse yCourse)
    {
        startPage();
        List<YCourse> list = yCourseService.selectYCourseList(yCourse);
        return getDataTable(list);
    }

    @GetMapping(value = "/{cId}")
    public AjaxResult getInfo(@PathVariable("cId") Long cId)
    {
        return success(yCourseService.selectYCourseById(cId));
    }

    @GetMapping("/recommend")
    public AjaxResult recommend()
    {
        YCourse param = new YCourse();
        param.setStatus(0);
        List<YCourse> list = yCourseService.selectYCourseList(param);
        return success(list);
    }
}