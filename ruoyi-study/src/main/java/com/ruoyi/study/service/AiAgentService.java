package com.ruoyi.study.service;

import com.ruoyi.study.config.AiProperties;
import com.ruoyi.study.domain.MyAiChat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

/**
 * AI智能助手服务（支持Function Calling联网搜索 + 多轮记忆）
 */
@Service
public class AiAgentService
{
    /** 上下文保留的最大历史轮数（一问一答算1轮） */
    private static final int MAX_HISTORY_ROUNDS = 6;

    @Autowired
    private AiProperties aiProperties;

    @Autowired
    private IMyAiChatService myAiChatService;

    @Autowired
    private WebSearchService webSearchService;

    /**
     * 发送消息给AI并获取回复（支持联网搜索 + 多轮记忆）
     */
    public String chat(String question, Long stuId, String sessionId)
    {
        try
        {
            String finalSessionId = (sessionId != null && !sessionId.isEmpty()) ? sessionId : generateSessionId();
            String answer;
            // 如果开启了联网搜索，先搜索再让AI总结
            if (Boolean.TRUE.equals(aiProperties.getWebSearchEnabled()))
            {
                answer = chatWithWebSearch(question, stuId, finalSessionId);
            }
            else
            {
                answer = chatDirectly(question, stuId, finalSessionId);
            }

            // 保存对话记录到数据库
            saveChatRecord(stuId, finalSessionId, question, answer);
            return answer;
        }
        catch (Exception e)
        {
            System.err.println("AI调用失败: " + e.getMessage());
            e.printStackTrace();
            return "AI服务暂时不可用，请稍后重试。错误：" + e.getMessage();
        }
    }

    /**
     * 直接对话（无联网，带历史）
     */
    private String chatDirectly(String question, Long stuId, String sessionId) throws Exception
    {
        List<Map<String, String>> historyMessages = loadHistory(stuId, sessionId);
        List<Map<String, String>> messages = buildMessagesWithHistory(historyMessages, question, false, null);
        Map<String, Object> requestBody = new HashMap<>();
        requestBody.put("model", aiProperties.getModel());
        requestBody.put("messages", messages);
        requestBody.put("temperature", 0.7);
        requestBody.put("max_tokens", 2048);
        Map<String, Object> response = callDeepSeekApi(requestBody);
        return extractAnswer(response);
    }

    /**
     * 带联网搜索的对话
     * 流程：先搜索 -> 把搜索结果作为补充信息 + 加载历史 -> 调用AI总结回答
     */
    private String chatWithWebSearch(String question, Long stuId, String sessionId) throws Exception
    {
        // 第一步：执行联网搜索
        String searchResult = webSearchService.search(question);

        // 第二步：判断搜索是否成功
        boolean searchSuccess = searchResult != null
                && !searchResult.isEmpty()
                && !searchResult.startsWith("（")
                && searchResult.contains("【联网搜索结果】");

        // 第三步：构造最终问题
        String finalQuestion;
        if (searchSuccess)
        {
            finalQuestion = "以下是用户当前问题的联网搜索结果，请基于这些最新信息回答用户当前问题。"
                    + "注意：这是为用户当前问题补充的最新信息，不要被这些搜索结果误导而忽略之前的对话内容。\n\n"
                    + "用户当前问题：" + question + "\n\n"
                    + searchResult + "\n\n"
                    + "请结合以上搜索结果和之前的对话历史，给出准确、详细、有条理的回答。";
        }
        else
        {
            finalQuestion = question;
        }

        // 第四步：加载历史 + 联网增强问题
        List<Map<String, String>> historyMessages = loadHistory(stuId, sessionId);
        List<Map<String, String>> messages = buildMessagesWithHistory(historyMessages, finalQuestion, true, null);
        Map<String, Object> requestBody = new HashMap<>();
        requestBody.put("model", aiProperties.getModel());
        requestBody.put("messages", messages);
        requestBody.put("temperature", 0.7);
        requestBody.put("max_tokens", 2048);
        Map<String, Object> response = callDeepSeekApi(requestBody);
        String answer = extractAnswer(response);

        // 搜索成功时追加来源标识
        if (searchSuccess)
        {
            answer = answer + "\n\n---\n*本回答参考了联网搜索的最新信息*";
        }
        return answer;
    }

    /**
     * 加载会话历史消息
     * @return 按时间正序的 [{role, content}, ...] 列表
     */
    private List<Map<String, String>> loadHistory(Long stuId, String sessionId)
    {
        if (sessionId == null || sessionId.isEmpty())
        {
            return new ArrayList<>();
        }
        try
        {
            MyAiChat query = new MyAiChat();
            // 优先用 stuId + sessionId 精确定位
            // 如果 stuId 为 null，则只用 sessionId 查询（兼容前端没传stuId的情况）
            if (stuId != null)
            {
                query.setStuId(stuId);
            }
            query.setSessionId(sessionId);
            List<MyAiChat> records = myAiChatService.selectMyAiChatList(query);
            if (records == null || records.isEmpty())
            {
                System.out.println("[AI记忆] sessionId=" + sessionId + ", stuId=" + stuId + " 无历史记录");
                return new ArrayList<>();
            }

            // 按创建时间升序
            Collections.sort(records, (a, b) -> {
                if (a.getCreateTime() == null) return -1;
                if (b.getCreateTime() == null) return 1;
                return a.getCreateTime().compareTo(b.getCreateTime());
            });

            // 截取最近N条
            int fromIndex = Math.max(0, records.size() - MAX_HISTORY_ROUNDS * 2);
            List<MyAiChat> recent = records.subList(fromIndex, records.size());

            // 转换为 messages 格式
            List<Map<String, String>> result = new ArrayList<>();
            for (MyAiChat r : recent)
            {
                if (r.getQuestion() != null && !r.getQuestion().isEmpty())
                {
                    Map<String, String> userMsg = new HashMap<>();
                    userMsg.put("role", "user");
                    userMsg.put("content", r.getQuestion());
                    result.add(userMsg);
                }
                if (r.getAnswer() != null && !r.getAnswer().isEmpty())
                {
                    Map<String, String> aiMsg = new HashMap<>();
                    aiMsg.put("role", "assistant");
                    aiMsg.put("content", r.getAnswer());
                    result.add(aiMsg);
                }
            }
            System.out.println("[AI记忆] 加载历史: sessionId=" + sessionId + ", 共" + result.size() + "条消息");
            return result;
        }
        catch (Exception e)
        {
            System.err.println("加载历史记录失败: " + e.getMessage());
            return new ArrayList<>();
        }
    }

    /**
     * 构建带历史的 messages 数组
     * @param history 历史消息
     * @param currentQuestion 当前用户问题（可能已被联网增强）
     * @param isEnhanced 当前问题是否被联网增强
     * @param summary 自定义前缀（可选）
     */
    private List<Map<String, String>> buildMessagesWithHistory(List<Map<String, String>> history,
                                                               String currentQuestion,
                                                               boolean isEnhanced,
                                                               String summary)
    {
        List<Map<String, String>> messages = new ArrayList<>();

        // 1. 系统提示
        if (aiProperties.getSystemPrompt() != null && !aiProperties.getSystemPrompt().isEmpty())
        {
            Map<String, String> systemMsg = new HashMap<>();
            systemMsg.put("role", "system");
            systemMsg.put("content", aiProperties.getSystemPrompt());
            messages.add(systemMsg);
        }

        // 2. 历史对话（联网/普通模式都传，让AI记住之前的对话）
        if (history != null && !history.isEmpty())
        {
            messages.addAll(history);
        }

        // 3. 当前问题
        Map<String, String> userMsg = new HashMap<>();
        userMsg.put("role", "user");
        if (isEnhanced)
        {
            // 联网模式直接用增强问题（已包含搜索结果）
            userMsg.put("content", currentQuestion);
        }
        else
        {
            // 普通模式：组合自定义前缀 + 原问题
            userMsg.put("content", (summary != null ? summary : "") + currentQuestion);
        }
        messages.add(userMsg);

        return messages;
    }

    /**
     * 调用 DeepSeek API
     */
    private Map<String, Object> callDeepSeekApi(Map<String, Object> requestBody) throws Exception
    {
        RestTemplate restTemplate = createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization", "Bearer " + aiProperties.getApiKey());

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);
        ResponseEntity<Map> response = restTemplate.postForEntity(
                aiProperties.getBaseUrl() + "/chat/completions",
                entity,
                Map.class
        );
        Map<String, Object> responseBody = response.getBody();
        if (responseBody == null)
        {
            throw new RuntimeException("API返回为空");
        }
        return responseBody;
    }

    /**
     * 创建带超时的 RestTemplate
     */
    private RestTemplate createRestTemplate()
    {
        SimpleClientHttpRequestFactory factory = new SimpleClientHttpRequestFactory();
        factory.setConnectTimeout((int) TimeUnit.SECONDS.toMillis(10));
        factory.setReadTimeout((int) TimeUnit.SECONDS.toMillis(60));
        return new RestTemplate(factory);
    }

    /**
     * 从API响应中提取回答
     */
    private String extractAnswer(Map<String, Object> responseBody)
    {
        Object choicesObj = responseBody.get("choices");
        if (!(choicesObj instanceof List))
        {
            throw new RuntimeException("API返回格式异常，无choices列表");
        }
        List<Map<String, Object>> choices = (List<Map<String, Object>>) choicesObj;
        if (choices.isEmpty())
        {
            throw new RuntimeException("API返回choices为空");
        }
        Map<String, Object> firstChoice = choices.get(0);
        if (firstChoice == null)
        {
            throw new RuntimeException("API返回第一个choice为null");
        }
        Map<String, Object> message = (Map<String, Object>) firstChoice.get("message");
        if (message == null)
        {
            throw new RuntimeException("API返回message为null");
        }
        Object content = message.get("content");
        if (content == null)
        {
            return "";
        }
        return content.toString();
    }

    /**
     * 保存对话记录
     */
    private void saveChatRecord(Long stuId, String sessionId, String question, String answer)
    {
        MyAiChat chatRecord = new MyAiChat();
        chatRecord.setStuId(stuId);
        chatRecord.setSessionId(sessionId != null ? sessionId : generateSessionId());
        chatRecord.setQuestion(question);
        chatRecord.setAnswer(answer);
        chatRecord.setQuestionType(1L);
        myAiChatService.insertMyAiChat(chatRecord);
    }

    /**
     * 生成会话ID
     */
    private String generateSessionId()
    {
        return "SESSION_" + UUID.randomUUID().toString().replace("-", "").substring(0, 16);
    }
}
