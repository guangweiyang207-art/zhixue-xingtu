package com.ruoyi.web.controller.homework;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.myhomework.domain.MyHomework;
import com.ruoyi.myhomework.service.IExMyHomeworkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/homework/homework")
public class ExMyHomeworkController extends BaseController
{
    @Autowired
    private IExMyHomeworkService exMyHomeworkService;

    @GetMapping("/list")
    public TableDataInfo list(MyHomework myHomework)
    {
        startPage();
        List<MyHomework> list = exMyHomeworkService.selectMyHomeworkList(myHomework);
        return getDataTable(list);
    }

    @GetMapping(value = "/{hwId}")
    public AjaxResult getInfo(@PathVariable("hwId") Long hwId)
    {
        return success(exMyHomeworkService.selectMyHomeworkById(hwId));
    }

    @GetMapping("/todayTodos")
    public AjaxResult todayTodos()
    {
        Long userId = SecurityUtils.getUserId();
        List<MyHomework> list = exMyHomeworkService.selectMyHomeworkByUserId(userId);
        return success(list);
    }
}
