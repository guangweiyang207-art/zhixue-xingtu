package com.ruoyi.taskmanage.controller;

import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.taskmanage.domain.Admin;
import com.ruoyi.taskmanage.service.IMXYAdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Anonymous
@RestController
@RequestMapping("/admin")
public class MXYAdminController extends BaseController {

    @Autowired private IMXYAdminService service;

    @GetMapping("/list")
    public AjaxResult list(Admin a) { return AjaxResult.success(service.selectAdminList(a)); }

    @GetMapping("/{adminId}")
    public AjaxResult getInfo(@PathVariable Long adminId) { return AjaxResult.success(service.selectAdminById(adminId)); }

    @PostMapping
    public AjaxResult add(@RequestBody Admin a) { return toAjax(service.insertAdmin(a)); }

    @PutMapping
    public AjaxResult edit(@RequestBody Admin a) { return toAjax(service.updateAdmin(a)); }

    @DeleteMapping("/{adminId}")
    public AjaxResult remove(@PathVariable Long adminId) { return toAjax(service.deleteAdminById(adminId)); }
}


