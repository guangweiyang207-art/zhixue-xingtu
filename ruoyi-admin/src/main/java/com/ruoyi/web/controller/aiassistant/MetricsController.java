package com.ruoyi.web.controller.aiassistant;

import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.aiassistant.service.MetricsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * 量化统计接口:RAG效果 / 学习效果 / 接口监控
 */
@Anonymous
@RestController
@RequestMapping("/ai/metrics")
public class MetricsController extends BaseController
{
    @Autowired
    private MetricsService metricsService;

    /** RAG 效果汇总:提问数/命中率/平均耗时/平均相似度 */
    @GetMapping("/ragSummary")
    public AjaxResult ragSummary()
    {
        return AjaxResult.success(metricsService.ragSummary());
    }

    /** 语义缓存统计:条目数/命中率/并发去重次数 */
    @GetMapping("/cache")
    public AjaxResult cacheStats()
    {
        return AjaxResult.success(metricsService.cacheStats());
    }

    /** 最近 AI 对话日志明细 */
    @GetMapping("/ragLogs")
    public AjaxResult ragLogs(@RequestParam(defaultValue = "50") int limit)
    {
        return AjaxResult.success(metricsService.ragLogs(limit));
    }

    /** RAG 检索质量评测:固定测试集跑检索,输出命中率与相似度 */
    @GetMapping("/ragEval")
    public AjaxResult ragEval()
    {
        return AjaxResult.success(metricsService.ragEval());
    }

    /** 学习效果量化:错题消灭率/近7天作业趋势/平均分 */
    @GetMapping("/learning")
    public AjaxResult learning(Long stu_id)
    {
        return AjaxResult.success(metricsService.learning(stu_id));
    }

    /** 接口监控:请求数/错误数/平均耗时/最慢与最热接口TOP5 */
    @GetMapping("/api")
    public AjaxResult apiSummary()
    {
        return AjaxResult.success(metricsService.apiSummary());
    }
}
