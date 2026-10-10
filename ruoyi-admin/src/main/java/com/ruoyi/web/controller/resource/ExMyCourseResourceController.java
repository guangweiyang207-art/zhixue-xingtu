package com.ruoyi.web.controller.resource;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.mycourseresource.domain.MyCourseResource;
import com.ruoyi.mycourseresource.service.IExMyCourseResourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/resource/resource")
public class ExMyCourseResourceController extends BaseController
{
    @Autowired
    private IExMyCourseResourceService exMyCourseResourceService;

    @GetMapping("/list")
    public AjaxResult list(MyCourseResource myCourseResource)
    {
        List<MyCourseResource> list = exMyCourseResourceService.selectMyCourseResourceList(myCourseResource);
        return success(list);
    }

    @GetMapping(value = "/{reId}")
    public AjaxResult getInfo(@PathVariable("reId") Long reId)
    {
        return success(exMyCourseResourceService.selectMyCourseResourceById(reId));
    }

    @GetMapping("/top2")
    public AjaxResult top2()
    {
        List<MyCourseResource> list = exMyCourseResourceService.selectMyCourseResourceList(new MyCourseResource());
        if (list != null && list.size() > 2)
        {
            return success(list.subList(0, 2));
        }
        return success(list);
    }
}
