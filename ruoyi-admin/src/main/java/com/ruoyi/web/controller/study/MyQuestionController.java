package com.ruoyi.web.controller.study;

import java.util.List;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.study.domain.MyQuestion;
import com.ruoyi.study.service.IMyQuestionService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 题目Controller
 * 
 * @author ruoyi
 * @date 2026-05-31
 */
@RestController
@RequestMapping("/study/myQuestion")
public class MyQuestionController extends BaseController
{
    @Autowired
    private IMyQuestionService myQuestionService;

    @PreAuthorize("@ss.hasPermi('study:myQuestion:list')")
    @GetMapping("/list")
    public TableDataInfo list(MyQuestion myQuestion)
    {
        startPage();
        List<MyQuestion> list = myQuestionService.selectMyQuestionList(myQuestion);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('study:myQuestion:export')")
    @Log(title = "题目", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, MyQuestion myQuestion)
    {
        List<MyQuestion> list = myQuestionService.selectMyQuestionList(myQuestion);
        ExcelUtil<MyQuestion> util = new ExcelUtil<MyQuestion>(MyQuestion.class);
        util.exportExcel(response, list, "题目数据");
    }

    @PreAuthorize("@ss.hasPermi('study:myQuestion:query')")
    @GetMapping(value = "/{qId}")
    public AjaxResult getInfo(@PathVariable("qId") Long qId)
    {
        return success(myQuestionService.selectMyQuestionByQId(qId));
    }

    @PreAuthorize("@ss.hasPermi('study:myQuestion:add')")
    @Log(title = "题目", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody MyQuestion myQuestion)
    {
        return toAjax(myQuestionService.insertMyQuestion(myQuestion));
    }

    @PreAuthorize("@ss.hasPermi('study:myQuestion:edit')")
    @Log(title = "题目", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody MyQuestion myQuestion)
    {
        return toAjax(myQuestionService.updateMyQuestion(myQuestion));
    }

    @PreAuthorize("@ss.hasPermi('study:myQuestion:remove')")
    @Log(title = "题目", businessType = BusinessType.DELETE)
    @DeleteMapping("/{qIds}")
    public AjaxResult remove(@PathVariable Long[] qIds)
    {
        return toAjax(myQuestionService.deleteMyQuestionByQIds(qIds));
    }
}
