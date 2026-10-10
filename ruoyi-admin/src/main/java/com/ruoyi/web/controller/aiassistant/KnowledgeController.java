package com.ruoyi.web.controller.aiassistant;

import java.util.List;
import java.util.Map;

import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.aiassistant.service.KnowledgeRagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * AI 知识库(RAG)管理接口
 * 知识片段支持纯文本录入;后续有文档时可扩展文件上传→解析→分段→入库
 */
@Anonymous
@RestController
@RequestMapping("/ai/knowledge")
public class KnowledgeController extends BaseController
{
    @Autowired
    private KnowledgeRagService ragService;

    /** 知识列表 */
    @GetMapping("/list")
    public AjaxResult list()
    {
        return AjaxResult.success(ragService.list());
    }

    /** 检索测试:返回与问题最相关的知识片段 */
    @GetMapping("/retrieve")
    public AjaxResult retrieve(String query)
    {
        List<String> refs = ragService.retrieve(query, 3);
        return AjaxResult.success("检索成功", refs);
    }

    /** 新增知识片段(自动向量化) */
    @PostMapping
    public AjaxResult add(@RequestBody Map<String, String> body)
    {
        String title = body.get("title");
        String content = body.get("content");
        if (title == null || title.trim().isEmpty() || content == null || content.trim().isEmpty())
        {
            return AjaxResult.error("标题和内容不能为空");
        }
        Long id = ragService.add(title.trim(), content.trim(),
            body.getOrDefault("courseType", ""), body.getOrDefault("source", "手动录入"));
        return AjaxResult.success("新增成功", id);
    }

    /** 文档导入:整篇文档按段落自动切分,批量向量化入库 */
    @PostMapping("/importDoc")
    public AjaxResult importDoc(@RequestBody Map<String, String> body)
    {
        String title = body.get("title");
        String content = body.get("content");
        if (title == null || title.trim().isEmpty() || content == null || content.trim().isEmpty())
        {
            return AjaxResult.error("文档标题和内容不能为空");
        }
        int n = ragService.importDoc(title.trim(), body.getOrDefault("courseType", ""), content);
        return AjaxResult.success("文档导入成功,共入库 " + n + " 个知识片段", n);
    }

    /** 删除知识片段 */
    @DeleteMapping("/{id}")
    public AjaxResult remove(@PathVariable Long id)
    {
        return toAjax(ragService.deleteById(id));
    }
}
