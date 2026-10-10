package com.ruoyi.web.controller.study;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.mystudent.domain.MyStudent;
import com.ruoyi.mystudent.service.IExMyStudentService;
import com.ruoyi.study.config.AiProperties;
import com.ruoyi.study.service.AiAgentService;
import com.ruoyi.userext.domain.MyTeacher;
import com.ruoyi.userext.service.IMyTeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * AI智能助手Controller
 */
@RestController
@RequestMapping("/ai/agent")
public class AiAgentController extends BaseController
{
    @Autowired
    private AiAgentService aiAgentService;

    @Autowired
    private AiProperties aiProperties;

    @Autowired
    private IExMyStudentService studentService;

    @Autowired
    private IMyTeacherService teacherService;

    /**
     * 发送消息给AI助手
     */
    @PreAuthorize("@ss.hasPermi('ai:agent:send')")
    @PostMapping("/chat")
    public AjaxResult chat(@RequestBody Map<String, Object> params)
    {
        String question = (String) params.get("question");
        Long stuId = params.get("stuId") != null ? Long.valueOf(params.get("stuId").toString()) : null;
        String sessionId = (String) params.get("sessionId");

        if (question == null || question.trim().isEmpty())
        {
            return error("问题内容不能为空");
        }

        String finalQuestion = buildAnalysisContextIfNeeded(question);
        String answer = aiAgentService.chat(finalQuestion, stuId, sessionId);
        return success(answer);
    }

    /**
     * 当问题涉及"分析/统计"学生或老师情况时，从数据库中抓取汇总信息并作为上下文附加到问题前。
     */
    private String buildAnalysisContextIfNeeded(String question)
    {
        if (question == null || !needsDbAnalysis(question))
        {
            return question;
        }
        String context = buildDbContext();
        if (context == null || context.isEmpty())
        {
            return question;
        }
        return "以下是系统数据库中关于学生和教师的最新统计信息，请基于这些数据回答用户问题：\n"
                + context + "\n\n"
                + "用户问题：" + question;
    }

    /**
     * 判断是否需要拉取数据库分析上下文
     */
    private boolean needsDbAnalysis(String question)
    {
        String q = question.toLowerCase();
        String[] keywords = {
                "分析", "统计", "情况", "概览", "概况", "总览", "数据",
                "学生", "老师", "教师", "学员", "学员情况", "教师情况",
                "学员概览", "教师概览", "学习情况", "教学情况", "分布"
        };
        for (String k : keywords)
        {
            if (q.contains(k.toLowerCase()))
            {
                return true;
            }
        }
        return false;
    }

    /**
     * 从数据库中收集学生和教师的汇总信息
     */
    private String buildDbContext()
    {
        StringBuilder sb = new StringBuilder();
        try
        {
            List<MyStudent> students = studentService.selectMyStudentList(new MyStudent());
            if (students != null && !students.isEmpty())
            {
                sb.append("【学生总体情况】共 ").append(students.size()).append(" 名学生\n");
                // 按段位统计
                Map<String, Long> byRank = students.stream()
                        .collect(Collectors.groupingBy(s -> s.getRankLevel() == null ? "未知" : s.getRankLevel(), Collectors.counting()));
                sb.append("  段位分布：");
                byRank.forEach((k, v) -> sb.append(k).append(" ").append(v).append("人，"));
                sb.append("\n");
                // 按专业统计
                Map<String, Long> byMajor = students.stream()
                        .collect(Collectors.groupingBy(s -> s.getMajor() == null ? "未知" : s.getMajor(), Collectors.counting()));
                sb.append("  专业分布：");
                byMajor.forEach((k, v) -> sb.append(k).append(" ").append(v).append("人，"));
                sb.append("\n");
                // 按年级统计
                Map<String, Long> byGrade = students.stream()
                        .collect(Collectors.groupingBy(s -> s.getGrade() == null ? "未知" : s.getGrade(), Collectors.counting()));
                sb.append("  年级分布：");
                byGrade.forEach((k, v) -> sb.append(k).append(" ").append(v).append("人，"));
                sb.append("\n");
                // 学习数据
                long totalQuestions = students.stream()
                        .filter(s -> s.getTotalQuestions() != null)
                        .mapToLong(MyStudent::getTotalQuestions).sum();
                long correctQuestions = students.stream()
                        .filter(s -> s.getCorrectQuestions() != null)
                        .mapToLong(MyStudent::getCorrectQuestions).sum();
                double avgHours = students.stream()
                        .filter(s -> s.getStudyHours() != null)
                        .mapToDouble(s -> s.getStudyHours().doubleValue()).average().orElse(0.0);
                double accuracy = totalQuestions > 0 ? (correctQuestions * 100.0 / totalQuestions) : 0.0;
                sb.append("  累计做题：").append(totalQuestions).append(" 题，整体正确率 ")
                        .append(String.format("%.1f", accuracy)).append("%\n");
                sb.append("  平均学习时长：").append(String.format("%.1f", avgHours)).append(" 小时\n");
            }
        }
        catch (Exception e)
        {
            sb.append("【学生数据获取失败】").append(e.getMessage()).append("\n");
        }

        try
        {
            List<MyTeacher> teachers = teacherService.selectMyTeacherList(new MyTeacher());
            if (teachers != null && !teachers.isEmpty())
            {
                sb.append("【教师总体情况】共 ").append(teachers.size()).append(" 名教师\n");
                // 按院系统计
                Map<String, Long> byDept = teachers.stream()
                        .collect(Collectors.groupingBy(t -> t.getDepartment() == null ? "未知" : t.getDepartment(), Collectors.counting()));
                sb.append("  院系分布：");
                byDept.forEach((k, v) -> sb.append(k).append(" ").append(v).append("人，"));
                sb.append("\n");
                // 按职称统计
                Map<String, Long> byTitle = teachers.stream()
                        .collect(Collectors.groupingBy(t -> t.getTitle() == null ? "未知" : t.getTitle(), Collectors.counting()));
                sb.append("  职称分布：");
                byTitle.forEach((k, v) -> sb.append(k).append(" ").append(v).append("人，"));
                sb.append("\n");
                // 列出每位教师
                sb.append("  教师列表：");
                for (MyTeacher t : teachers)
                {
                    sb.append(t.getTeacherNo() == null ? "" : t.getTeacherNo())
                            .append("(").append(t.getDepartment() == null ? "未知院系" : t.getDepartment())
                            .append("/").append(t.getTitle() == null ? "未知" : t.getTitle())
                            .append(")，");
                }
                sb.append("\n");
            }
        }
        catch (Exception e)
        {
            sb.append("【教师数据获取失败】").append(e.getMessage()).append("\n");
        }
        return sb.toString();
    }

    /**
     * 获取AI配置信息（前端展示用，API Key做脱敏处理）
     */
    @PreAuthorize("@ss.hasPermi('ai:agent:query')")
    @GetMapping("/config")
    public AjaxResult getConfig()
    {
        Map<String, Object> config = new HashMap<>();
        config.put("provider", aiProperties.getProvider());
        config.put("model", aiProperties.getModel());
        config.put("baseUrl", aiProperties.getBaseUrl());
        config.put("systemPrompt", aiProperties.getSystemPrompt());

        // API Key做脱敏处理：只显示前4位和后4位，中间用星号代替
        String apiKey = aiProperties.getApiKey();
        if (apiKey != null && apiKey.length() > 8)
        {
            config.put("apiKey", apiKey);
            config.put("apiKeyMasked", apiKey.substring(0, 4) + "****" + apiKey.substring(apiKey.length() - 4));
        }
        else
        {
            config.put("apiKey", apiKey);
            config.put("apiKeyMasked", apiKey);
        }

        // 联网搜索配置
        config.put("webSearchEnabled", aiProperties.getWebSearchEnabled() != null ? aiProperties.getWebSearchEnabled() : false);
        config.put("searchEngine", aiProperties.getSearchEngine() != null ? aiProperties.getSearchEngine() : "bocha");
        String searchApiKey = aiProperties.getSearchApiKey();
        if (searchApiKey != null && searchApiKey.length() > 8)
        {
            config.put("searchApiKey", searchApiKey);
            config.put("searchApiKeyMasked", searchApiKey.substring(0, 4) + "****" + searchApiKey.substring(searchApiKey.length() - 4));
        }
        else
        {
            config.put("searchApiKey", searchApiKey);
            config.put("searchApiKeyMasked", searchApiKey);
        }
        config.put("searchResultCount", aiProperties.getSearchResultCount() != null ? aiProperties.getSearchResultCount() : 5);

        return success(config);
    }

    /**
     * 更新AI配置（管理员权限）
     */
    @PreAuthorize("@ss.hasPermi('ai:config:edit')")
    @PostMapping("/config")
    public AjaxResult updateConfig(@RequestBody Map<String, Object> config)
    {
        try
        {
            // 更新内存中的配置
            if (config.get("provider") != null) aiProperties.setProvider(config.get("provider").toString());
            if (config.get("model") != null) aiProperties.setModel(config.get("model").toString());
            if (config.get("baseUrl") != null) aiProperties.setBaseUrl(config.get("baseUrl").toString());
            if (config.get("systemPrompt") != null) aiProperties.setSystemPrompt(config.get("systemPrompt").toString());
            if (config.get("apiKey") != null && !config.get("apiKey").toString().isEmpty())
            {
                aiProperties.setApiKey(config.get("apiKey").toString());
            }

            // 联网搜索配置
            if (config.get("webSearchEnabled") != null)
            {
                aiProperties.setWebSearchEnabled(Boolean.valueOf(config.get("webSearchEnabled").toString()));
            }
            if (config.get("searchEngine") != null) aiProperties.setSearchEngine(config.get("searchEngine").toString());
            if (config.get("searchApiKey") != null && !config.get("searchApiKey").toString().isEmpty())
            {
                aiProperties.setSearchApiKey(config.get("searchApiKey").toString());
            }
            if (config.get("searchResultCount") != null)
            {
                try
                {
                    aiProperties.setSearchResultCount(Integer.valueOf(config.get("searchResultCount").toString()));
                }
                catch (Exception ignored) {}
            }

            // 持久化到application.yml
            saveConfigToYaml();

            return success("配置已保存到 application.yml");
        }
        catch (Exception e)
        {
            return error("保存配置失败：" + e.getMessage());
        }
    }

    /**
     * 将配置持久化到 application.yml
     */
    private void saveConfigToYaml() throws Exception
    {
        // yml文件路径
        String ymlPath = System.getProperty("user.dir") + "/src/main/resources/application.yml";
        java.io.File ymlFile = new java.io.File(ymlPath);
        if (!ymlFile.exists())
        {
            ymlPath = System.getProperty("user.dir") + "/ruoyi-admin/src/main/resources/application.yml";
            ymlFile = new java.io.File(ymlPath);
        }
        if (!ymlFile.exists())
        {
            throw new RuntimeException("找不到application.yml文件，路径: " + ymlPath);
        }

        java.util.List<String> lines = java.nio.file.Files.readAllLines(ymlFile.toPath(), java.nio.charset.StandardCharsets.UTF_8);
        java.util.List<String> newLines = new java.util.ArrayList<>();
        boolean inAiSection = false;
        boolean aiSectionExists = false;
        java.util.Set<String> handledKeys = new java.util.HashSet<>();

        for (int i = 0; i < lines.size(); i++)
        {
            String line = lines.get(i);
            String trimmed = line.trim();

            // 检测ai配置节
            if (trimmed.equals("ai:"))
            {
                inAiSection = true;
                aiSectionExists = true;
                newLines.add(line);
                continue;
            }
            // 离开ai节（遇到新的顶级key）
            if (inAiSection && !trimmed.isEmpty() && !trimmed.startsWith("#")
                    && !line.startsWith(" ") && !line.startsWith("\t") && trimmed.matches("^[a-zA-Z].*:"))
            {
                inAiSection = false;
            }

            if (inAiSection)
            {
                if (trimmed.startsWith("provider:"))
                {
                    newLines.add("  provider: " + aiProperties.getProvider());
                    handledKeys.add("provider");
                }
                else if (trimmed.startsWith("api-key:"))
                {
                    newLines.add("  api-key: " + aiProperties.getApiKey());
                    handledKeys.add("api-key");
                }
                else if (trimmed.startsWith("model:"))
                {
                    newLines.add("  model: " + aiProperties.getModel());
                    handledKeys.add("model");
                }
                else if (trimmed.startsWith("base-url:"))
                {
                    newLines.add("  base-url: " + aiProperties.getBaseUrl());
                    handledKeys.add("base-url");
                }
                else if (trimmed.startsWith("system-prompt:"))
                {
                    newLines.add(line);
                    i++;
                    while (i < lines.size() && (lines.get(i).startsWith("    ") || lines.get(i).trim().isEmpty()))
                    {
                        i++;
                    }
                    i--;
                    String[] promptLines = (aiProperties.getSystemPrompt() != null ? aiProperties.getSystemPrompt() : "").split("\n");
                    for (String pl : promptLines)
                    {
                        newLines.add("    " + pl);
                    }
                    handledKeys.add("system-prompt");
                }
                else if (trimmed.startsWith("web-search-enabled:"))
                {
                    newLines.add("  web-search-enabled: " + aiProperties.getWebSearchEnabled());
                    handledKeys.add("web-search-enabled");
                }
                else if (trimmed.startsWith("search-engine:"))
                {
                    newLines.add("  search-engine: " + aiProperties.getSearchEngine());
                    handledKeys.add("search-engine");
                }
                else if (trimmed.startsWith("search-api-key:"))
                {
                    newLines.add("  search-api-key: " + (aiProperties.getSearchApiKey() != null ? aiProperties.getSearchApiKey() : ""));
                    handledKeys.add("search-api-key");
                }
                else if (trimmed.startsWith("search-result-count:"))
                {
                    newLines.add("  search-result-count: " + aiProperties.getSearchResultCount());
                    handledKeys.add("search-result-count");
                }
                else
                {
                    newLines.add(line);
                }
            }
            else
            {
                newLines.add(line);
            }
        }

        // 添加未处理的新字段到ai节末尾
        if (aiSectionExists)
        {
            int insertPos = newLines.size();
            for (int i = newLines.size() - 1; i >= 0; i--)
            {
                if (newLines.get(i).trim().equals("ai:") || (i > 0 && newLines.get(i-1).trim().equals("ai:")))
                {
                    insertPos = i + 1;
                    break;
                }
                if (newLines.get(i).startsWith("  ") && !newLines.get(i).startsWith("    "))
                {
                    insertPos = i + 1;
                }
            }
            java.util.List<String> newKeys = new java.util.ArrayList<>();
            if (!handledKeys.contains("web-search-enabled")) newKeys.add("  web-search-enabled: " + aiProperties.getWebSearchEnabled());
            if (!handledKeys.contains("search-engine")) newKeys.add("  search-engine: " + aiProperties.getSearchEngine());
            if (!handledKeys.contains("search-api-key")) newKeys.add("  search-api-key: " + (aiProperties.getSearchApiKey() != null ? aiProperties.getSearchApiKey() : ""));
            if (!handledKeys.contains("search-result-count")) newKeys.add("  search-result-count: " + aiProperties.getSearchResultCount());
            newLines.addAll(insertPos, newKeys);
        }
        else
        {
            int insertIndex = -1;
            for (int i = 0; i < newLines.size(); i++)
            {
                if (newLines.get(i).contains("# Spring配置"))
                {
                    insertIndex = i;
                    break;
                }
            }
            if (insertIndex == -1) insertIndex = newLines.size();
            java.util.List<String> aiConfig = new java.util.ArrayList<>();
            aiConfig.add("");
            aiConfig.add("# AI大模型配置");
            aiConfig.add("ai:");
            aiConfig.add("  provider: " + aiProperties.getProvider());
            aiConfig.add("  api-key: " + aiProperties.getApiKey());
            aiConfig.add("  model: " + aiProperties.getModel());
            aiConfig.add("  base-url: " + aiProperties.getBaseUrl());
            aiConfig.add("  system-prompt: |");
            String[] promptLines = (aiProperties.getSystemPrompt() != null ? aiProperties.getSystemPrompt() : "").split("\n");
            for (String pl : promptLines) aiConfig.add("    " + pl);
            aiConfig.add("  web-search-enabled: " + aiProperties.getWebSearchEnabled());
            aiConfig.add("  search-engine: " + aiProperties.getSearchEngine());
            aiConfig.add("  search-api-key: " + (aiProperties.getSearchApiKey() != null ? aiProperties.getSearchApiKey() : ""));
            aiConfig.add("  search-result-count: " + aiProperties.getSearchResultCount());
            newLines.addAll(insertIndex, aiConfig);
        }

        java.nio.file.Files.write(ymlFile.toPath(), newLines, java.nio.charset.StandardCharsets.UTF_8);
        System.out.println("AI配置已保存到: " + ymlFile.getAbsolutePath());
    }
}
