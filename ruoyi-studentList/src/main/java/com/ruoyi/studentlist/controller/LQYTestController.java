package com.ruoyi.studentlist.controller;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

/**
 * 测试接口（兼容前端示例代码 pages/index.vue 里的 test() 调用）
 *
 * @author ruoyi
 */
@RestController
@RequestMapping("/test")
public class LQYTestController extends BaseController
{
    @GetMapping
    public AjaxResult test()
    {
        Map<String, Object> data = new HashMap<>();
        data.put("user", "ruoyi");
        data.put("msg", "Hello RuoYi - 智学星途后端已就绪");
        return AjaxResult.success(data);
    }
}
