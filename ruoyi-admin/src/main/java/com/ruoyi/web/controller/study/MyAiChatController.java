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
import com.ruoyi.study.domain.MyAiChat;
import com.ruoyi.study.service.IMyAiChatService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * AI问答记录Controller
 * 
 * @author ruoyi
 * @date 2026-05-31
 */
@RestController
@RequestMapping("/study/myAiChat")
public class MyAiChatController extends BaseController
{
    @Autowired
    private IMyAiChatService myAiChatService;

    @PreAuthorize("@ss.hasPermi('study:myAiChat:list')")
    @GetMapping("/list")
    public TableDataInfo list(MyAiChat myAiChat)
    {
        startPage();
        List<MyAiChat> list = myAiChatService.selectMyAiChatList(myAiChat);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('study:myAiChat:export')")
    @Log(title = "AI问答记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, MyAiChat myAiChat)
    {
        List<MyAiChat> list = myAiChatService.selectMyAiChatList(myAiChat);
        ExcelUtil<MyAiChat> util = new ExcelUtil<MyAiChat>(MyAiChat.class);
        util.exportExcel(response, list, "AI问答记录数据");
    }

    @PreAuthorize("@ss.hasPermi('study:myAiChat:query')")
    @GetMapping(value = "/{chatId}")
    public AjaxResult getInfo(@PathVariable("chatId") Long chatId)
    {
        return success(myAiChatService.selectMyAiChatByChatId(chatId));
    }

    @PreAuthorize("@ss.hasPermi('study:myAiChat:add')")
    @Log(title = "AI问答记录", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody MyAiChat myAiChat)
    {
        return toAjax(myAiChatService.insertMyAiChat(myAiChat));
    }

    @PreAuthorize("@ss.hasPermi('study:myAiChat:edit')")
    @Log(title = "AI问答记录", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody MyAiChat myAiChat)
    {
        return toAjax(myAiChatService.updateMyAiChat(myAiChat));
    }

    @PreAuthorize("@ss.hasPermi('study:myAiChat:remove')")
    @Log(title = "AI问答记录", businessType = BusinessType.DELETE)
    @DeleteMapping("/{chatIds}")
    public AjaxResult remove(@PathVariable Long[] chatIds)
    {
        return toAjax(myAiChatService.deleteMyAiChatByChatIds(chatIds));
    }
}
