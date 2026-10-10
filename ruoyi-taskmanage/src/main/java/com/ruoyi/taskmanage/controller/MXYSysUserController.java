package com.ruoyi.taskmanage.controller;

import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.taskmanage.domain.SysUser;
import com.ruoyi.taskmanage.service.IMXYSysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Anonymous
@RestController
@RequestMapping("/mxy/user")
public class MXYSysUserController extends BaseController {

    @Autowired private IMXYSysUserService service;

    @GetMapping("/list")
    public AjaxResult list(SysUser u) { return AjaxResult.success(service.selectSysUserList(u)); }

    @GetMapping("/{userId}")
    public AjaxResult getInfo(@PathVariable Long userId) { return AjaxResult.success(service.selectSysUserById(userId)); }

    @PostMapping
    public AjaxResult add(@RequestBody SysUser u) { return toAjax(service.insertSysUser(u)); }

    @PutMapping
    public AjaxResult edit(@RequestBody SysUser u) { return toAjax(service.updateSysUser(u)); }

    @DeleteMapping("/{userId}")
    public AjaxResult remove(@PathVariable Long userId) { return toAjax(service.deleteSysUserById(userId)); }
}


