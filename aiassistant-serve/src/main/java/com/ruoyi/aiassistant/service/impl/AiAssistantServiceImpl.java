package com.ruoyi.aiassistant.service.impl;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.SynchronousQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.function.Consumer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.aiassistant.domain.AiChatRequest;
import com.ruoyi.aiassistant.domain.AiChatResponse;
import com.ruoyi.aiassistant.service.AgentToolService;
import com.ruoyi.aiassistant.service.IAiAssistantService;
import com.ruoyi.aiassistant.service.KnowledgeRagService;
import com.ruoyi.aiassistant.service.SemanticCacheService;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.myerrorbook.domain.MyErrorBook;
import com.ruoyi.myerrorbook.service.IExMyErrorBookService;
import com.ruoyi.mystudent.domain.MyStudent;
import com.ruoyi.mystudent.service.IExMyStudentService;

@Service
public class AiAssistantServiceImpl implements IAiAssistantService
{
    private static final Logger log = LoggerFactory.getLogger(AiAssistantServiceImpl.class);

    @Value("${ai.api-key:}")
    private String apiKey;

    @Value("${ai.api-url:https://api.deepseek.com/chat/completions}")
    private String apiUrl;

    @Value("${ai.model:deepseek-chat}")
    private String model;

    @Value("${ai.system-prompt:}")
    private String systemPrompt;

    @Autowired
    private IExMyStudentService studentService;

    @Autowired
    private IExMyErrorBookService errorBookService;

    @Autowired
    private KnowledgeRagService knowledgeRagService;

    @Autowired
    private SemanticCacheService semanticCacheService;

    @Autowired
    private AgentToolService agentToolService;

    private final RestTemplate restTemplate = new RestTemplate();

    /** 流式生成线程池:每个进行中对话占用一个线程(阻塞读 DeepSeek SSE 行),有界防线程扩散 */
    private static final ThreadPoolExecutor STREAM_POOL = new ThreadPoolExecutor(
        8, 64, 60L, TimeUnit.SECONDS, new SynchronousQueue<>(),
        r -> {
            Thread t = new Thread(r, "ai-stream");
            t.setDaemon(true);
            return t;
        });

    /** DeepSeek HTTP 客户端(Java 17 内置,流式用 ofLines 逐行读 SSE) */
    private static final HttpClient HTTP_CLIENT = HttpClient.newBuilder()
        .connectTimeout(Duration.ofSeconds(10))
        .build();

    private static final String DEFAULT_SYSTEM_PROMPT = "你是AI学习助手，专门帮助学生解答学习问题、制定复习计划和总结知识点。回答要简洁清晰，适合中学生理解。";

    @Override
    public AiChatResponse chat(AiChatRequest request)
    {
        if (StringUtils.isEmpty(apiKey))
        {
            return AiChatResponse.fail("AI接口未配置，请在application.yml中设置ai.api-key");
        }
        long startMs = System.currentTimeMillis();

        try
        {
            String finalSystemPrompt = buildSystemPrompt(request);
            if (StringUtils.isEmpty(finalSystemPrompt))
            {
                finalSystemPrompt = DEFAULT_SYSTEM_PROMPT;
            }

            // RAG:检索知识库中与问题相关的片段,注入系统提示词(失败不影响主流程);量化:记录命中率/分数
            boolean ragHit = false;
            double ragTopScore = 0;
            String ragTitles = "";
            try
            {
                List<Map<String, Object>> refs = knowledgeRagService.retrieveWithScore(request.getMessage(), 3);
                if (!refs.isEmpty())
                {
                    ragHit = true;
                    ragTopScore = (double) refs.get(0).get("score");
                    StringBuilder rag = new StringBuilder("\n\n以下是知识库中与该问题相关的资料片段，回答时请优先参考这些内容：\n");
                    for (int i = 0; i < refs.size(); i++)
                    {
                        rag.append("资料").append(i + 1).append("：").append(refs.get(i).get("content")).append("\n");
                    }
                    finalSystemPrompt = finalSystemPrompt + rag;
                    StringBuilder titles = new StringBuilder();
                    for (Map<String, Object> ref : refs)
                    {
                        if (titles.length() > 0)
                        {
                            titles.append(",");
                        }
                        titles.append(ref.get("title"));
                    }
                    ragTitles = titles.toString();
                }
            }
            catch (Exception re)
            {
                log.warn("知识库检索失败,本次回答不使用RAG: {}", re.getMessage());
            }

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.set("Accept", MediaType.APPLICATION_JSON_VALUE);
            headers.set("Authorization", "Bearer " + apiKey.trim());

            List<Map<String, Object>> messages = new ArrayList<>();
            messages.add(createMessage("system", finalSystemPrompt));

            if (request.getHistory() != null)
            {
                for (Map<String, String> msg : request.getHistory())
                {
                    if (msg == null) continue;
                    String role = msg.get("role");
                    String content = msg.get("content");
                    if (StringUtils.isEmpty(role) || StringUtils.isEmpty(content))
                    {
                        continue;
                    }
                    messages.add(createMessage(role, content));
                }
            }

            String userMessage = request.getMessage();
            if (StringUtils.isEmpty(userMessage))
            {
                return AiChatResponse.fail("用户消息不能为空");
            }
            messages.add(createMessage("user", userMessage));

            Map<String, Object> body = new HashMap<>();
            body.put("model", model);
            body.put("messages", messages);

            log.info("AI请求体：{}", com.alibaba.fastjson2.JSON.toJSONString(body));

            HttpEntity<Map<String, Object>> entity = new HttpEntity<>(body, headers);
            ResponseEntity<Map> response = restTemplate.postForEntity(apiUrl, entity, Map.class);

            log.info("AI原始响应体：{}", com.alibaba.fastjson2.JSON.toJSONString(response.getBody()));

            List<Map<String, Object>> choices = (List<Map<String, Object>>) response.getBody().get("choices");
            if (choices == null || choices.isEmpty())
            {
                return AiChatResponse.fail("AI响应格式异常，未返回choices");
            }
            Map<String, Object> message = (Map<String, Object>) choices.get(0).get("message");
            if (message == null)
            {
                return AiChatResponse.fail("AI响应格式异常，未返回message");
            }
            log.info("AI message对象：{}", com.alibaba.fastjson2.JSON.toJSONString(message));
            String content = (String) message.get("content");
            if (StringUtils.isEmpty(content))
            {
                content = (String) message.get("reasoning_content");
            }
            if (StringUtils.isEmpty(content))
            {
                return AiChatResponse.fail("AI返回内容为空");
            }
            // 量化:记录本次对话(RAG命中/相似度/耗时)
            knowledgeRagService.logChat(request.getUserId(), userMessage, content.length(),
                (int) (System.currentTimeMillis() - startMs), ragHit, ragTopScore, ragTitles);
            return AiChatResponse.success(content);
        }
        catch (Exception e)
        {
            log.error("AI请求异常", e);
            return AiChatResponse.fail("AI请求失败：" + e.getMessage());
        }
    }

    private String buildSystemPrompt(AiChatRequest request)
    {
        StringBuilder sb = new StringBuilder();
        if (StringUtils.isNotEmpty(systemPrompt))
        {
            sb.append(systemPrompt);
        }
        else
        {
            sb.append(DEFAULT_SYSTEM_PROMPT);
        }

        Long userId = request.getUserId();
        if (userId != null)
        {
            MyStudent student = studentService.selectMyStudentByUserId(userId);
            if (student != null)
            {
                List<MyErrorBook> errors = errorBookService.selectMyErrorBookByStuId(student.getStuId());
                if (errors != null && !errors.isEmpty())
                {
                    sb.append("\n\n以下是你当前的错题记录，请在回答学习问题时参考，特别是当用户要求制定复习计划或总结知识点时，请优先基于这些错题给出针对性的建议：\n");
                    int idx = 1;
                    for (MyErrorBook e : errors)
                    {
                        sb.append("错题").append(idx).append("：");
                        if (StringUtils.isNotEmpty(e.getTag()))
                        {
                            sb.append("【标签：").append(e.getTag()).append("】");
                        }
                        sb.append(" 错误次数：").append(e.getErrorCount() != null ? e.getErrorCount() : 0).append("次");
                        if (StringUtils.isNotEmpty(e.getAnalysis()))
                        {
                            sb.append("，解析：").append(e.getAnalysis());
                        }
                        if (StringUtils.isNotEmpty(e.getCorrectAnswer()))
                        {
                            sb.append("，正确答案：").append(e.getCorrectAnswer());
                        }
                        sb.append("\n");
                        idx++;
                        if (idx > 20) break;
                    }
                }
            }
        }
        return sb.toString();
    }

    private Map<String, Object> createMessage(String role, String content)
    {
        Map<String, Object> map = new HashMap<>();
        map.put("role", role);
        map.put("content", content);
        return map;
    }

    // ==================== 真流式 + Agent(ReAct) + 语义缓存 ====================

    private static final class ToolCall
    {
        String id;
        String name;
        String arguments;
        final StringBuilder argsBuf = new StringBuilder();
    }

    private static final class StreamRound
    {
        String content;
        final List<ToolCall> toolCalls = new ArrayList<>();
        long firstTokenMs;
    }

    @Override
    public void streamChat(AiChatRequest request, AiStreamListener listener)
    {
        STREAM_POOL.execute(() -> {
            String dedupKey = null;
            try
            {
                doStreamChat(request, listener);
            }
            catch (Exception e)
            {
                log.error("流式对话异常", e);
                try
                {
                    listener.onError("AI请求失败：" + e.getMessage());
                }
                catch (Exception ignored)
                {
                }
            }
        });
    }

    private void doStreamChat(AiChatRequest request, AiStreamListener listener)
    {
        long startMs = System.currentTimeMillis();
        if (StringUtils.isEmpty(apiKey))
        {
            notifyError(listener, "AI接口未配置，请在application.yml中设置ai.api-key");
            return;
        }
        String question = request.getMessage();
        if (StringUtils.isEmpty(question))
        {
            notifyError(listener, "用户消息不能为空");
            return;
        }
        Long userId = request.getUserId();
        String dedupKey = (userId == null ? 0L : userId) + "|" + question.trim();

        // 1) 语义缓存:相似问题直接返回,不打 LLM(亚毫秒级命中)
        SemanticCacheService.CachedAnswer cached = semanticCacheService.get(userId, question);
        if (cached.hit)
        {
            long costMs = System.currentTimeMillis() - startMs;
            listener.onDelta(cached.answer);
            knowledgeRagService.logChat(userId, question, cached.answer.length(), (int) costMs,
                false, 0, "", 0, 1);
            AiStreamMeta meta = new AiStreamMeta();
            meta.firstTokenMs = costMs;
            meta.totalMs = costMs;
            meta.cacheHit = true;
            listener.onDone(cached.answer, meta);
            return;
        }

        // 2) 相同问题并发去重(防缓存击穿):leader 执行,follower 等待复用
        CompletableFuture<String> leaderFuture = semanticCacheService.beginInFlight(dedupKey);
        if (leaderFuture != null)
        {
            try
            {
                String answer = leaderFuture.get(120, TimeUnit.SECONDS);
                listener.onDelta(answer);
                long costMs = System.currentTimeMillis() - startMs;
                knowledgeRagService.logChat(userId, question, answer.length(), (int) costMs, false, 0, "", 0, 1);
                AiStreamMeta meta = new AiStreamMeta();
                meta.firstTokenMs = costMs;
                meta.totalMs = costMs;
                meta.cacheHit = true;
                listener.onDone(answer, meta);
            }
            catch (Exception e)
            {
                notifyError(listener, "AI请求失败：" + e.getMessage());
            }
            return;
        }

        Exception execError = null;
        String reply = null;
        try
        {
            reply = doAgentChat(request, listener, startMs);
        }
        catch (Exception e)
        {
            execError = e;
        }
        finally
        {
            semanticCacheService.finishInFlight(dedupKey, execError == null ? reply : null, execError);
        }
        if (execError != null)
        {
            log.error("流式对话异常", execError);
            notifyError(listener, "AI请求失败：" + execError.getMessage());
        }
    }

    /** Agent 主流程:RAG 注入 -> 循环调用 DeepSeek(模型自主决定调用业务工具) -> 流式输出 */
    private String doAgentChat(AiChatRequest request, AiStreamListener listener, long startMs) throws Exception
    {
        String question = request.getMessage();
        Long userId = request.getUserId();

        // 系统提示词:个性化(错题本) + RAG 知识片段
        String finalSystemPrompt = buildSystemPrompt(request);
        if (StringUtils.isEmpty(finalSystemPrompt))
        {
            finalSystemPrompt = DEFAULT_SYSTEM_PROMPT;
        }
        boolean ragHit = false;
        double ragTopScore = 0;
        String ragTitles = "";
        try
        {
            List<Map<String, Object>> refs = knowledgeRagService.retrieveWithScore(question, 3);
            if (!refs.isEmpty())
            {
                ragHit = true;
                ragTopScore = (double) refs.get(0).get("score");
                StringBuilder rag = new StringBuilder("\n\n以下是知识库中与该问题相关的资料片段，回答时请优先参考这些内容：\n");
                StringBuilder titles = new StringBuilder();
                for (int i = 0; i < refs.size(); i++)
                {
                    rag.append("资料").append(i + 1).append("：").append(refs.get(i).get("content")).append("\n");
                    if (titles.length() > 0)
                    {
                        titles.append(",");
                    }
                    titles.append(refs.get(i).get("title"));
                }
                finalSystemPrompt = finalSystemPrompt + rag;
                ragTitles = titles.toString();
            }
        }
        catch (Exception re)
        {
            log.warn("知识库检索失败,本次回答不使用RAG: {}", re.getMessage());
        }

        List<Map<String, Object>> messages = new ArrayList<>();
        messages.add(createMessage("system", finalSystemPrompt));
        if (request.getHistory() != null)
        {
            for (Map<String, String> msg : request.getHistory())
            {
                if (msg == null) continue;
                String role = msg.get("role");
                String content = msg.get("content");
                if (StringUtils.isEmpty(role) || StringUtils.isEmpty(content)) continue;
                messages.add(createMessage(role, content));
            }
        }
        messages.add(createMessage("user", question));

        // Agent ReAct 循环:最多3轮工具调用,第4轮不带工具强制收敛
        long firstTokenMs = 0;
        int toolCallCount = 0;
        String reply = "";
        for (int round = 0; round < 4; round++)
        {
            boolean withTools = round < 3;
            long[] first = { 0 };
            StreamRound r = callDeepSeekStream(messages, withTools, delta -> {
                listener.onDelta(delta);
            }, first, startMs);
            if (firstTokenMs == 0)
            {
                firstTokenMs = first[0];
            }
            if (!r.toolCalls.isEmpty())
            {
                toolCallCount += r.toolCalls.size();
                // 前端渲染工具步骤气泡
                for (ToolCall tc : r.toolCalls)
                {
                    listener.onTool(tc.name, tc.arguments);
                }
                // assistant(带tool_calls) + tool 结果消息回填
                Map<String, Object> assistantMsg = new HashMap<>();
                assistantMsg.put("role", "assistant");
                assistantMsg.put("content", r.content == null ? "" : r.content);
                List<Object> rawTcs = new ArrayList<>();
                for (ToolCall tc : r.toolCalls)
                {
                    Map<String, Object> raw = new HashMap<>();
                    raw.put("id", tc.id);
                    raw.put("type", "function");
                    Map<String, Object> fn = new HashMap<>();
                    fn.put("name", tc.name);
                    fn.put("arguments", tc.arguments);
                    raw.put("function", fn);
                    rawTcs.add(raw);
                }
                assistantMsg.put("tool_calls", rawTcs);
                messages.add(assistantMsg);
                for (ToolCall tc : r.toolCalls)
                {
                    String result;
                    try
                    {
                        result = agentToolService.execute(tc.name, tc.arguments, userId);
                    }
                    catch (Exception te)
                    {
                        result = "工具执行失败: " + te.getMessage();
                    }
                    Map<String, Object> toolMsg = new HashMap<>();
                    toolMsg.put("role", "tool");
                    toolMsg.put("tool_call_id", tc.id);
                    toolMsg.put("content", result);
                    messages.add(toolMsg);
                }
                continue;
            }
            reply = r.content == null ? "" : r.content;
            break;
        }
        if (StringUtils.isEmpty(reply))
        {
            reply = "(AI未返回有效内容,请重试)";
        }

        // 语义缓存写入 + 量化日志 + 完成
        semanticCacheService.put(userId, question, reply);
        long totalMs = System.currentTimeMillis() - startMs;
        knowledgeRagService.logChat(userId, question, reply.length(), (int) totalMs,
            ragHit, ragTopScore, ragTitles, (int) firstTokenMs, 0);
        AiStreamMeta meta = new AiStreamMeta();
        meta.firstTokenMs = firstTokenMs;
        meta.totalMs = totalMs;
        meta.ragTitles = ragTitles;
        meta.toolCalls = toolCallCount;
        listener.onDone(reply, meta);
        return reply;
    }

    /** 调 DeepSeek stream=true,逐行解析 SSE;content 增量实时回调;tool_calls 跨 chunk 聚合 */
    private StreamRound callDeepSeekStream(List<Map<String, Object>> messages, boolean withTools,
                                           Consumer<String> onDelta, long[] firstTokenHolder, long startMs) throws Exception
    {
        Map<String, Object> body = new HashMap<>();
        body.put("model", model);
        body.put("messages", messages);
        body.put("stream", true);
        if (withTools)
        {
            body.put("tools", buildTools());
        }

        HttpRequest httpRequest = HttpRequest.newBuilder(URI.create(apiUrl))
            .timeout(Duration.ofSeconds(120))
            .header("Content-Type", "application/json")
            .header("Authorization", "Bearer " + apiKey.trim())
            .header("Accept", "text/event-stream")
            .POST(HttpRequest.BodyPublishers.ofString(JSON.toJSONString(body)))
            .build();

        HttpResponse<java.util.stream.Stream<String>> resp =
            HTTP_CLIENT.send(httpRequest, HttpResponse.BodyHandlers.ofLines());
        if (resp.statusCode() != 200)
        {
            String err = resp.body().limit(5).reduce("", (a, b) -> a + b);
            throw new IllegalStateException("DeepSeek HTTP " + resp.statusCode() + ": " + err);
        }

        StreamRound round = new StreamRound();
        Map<Integer, ToolCall> tcMap = new HashMap<>();
        final boolean[] finished = { false };
        resp.body().forEach(line ->
        {
            if (finished[0] || line == null || !line.startsWith("data:"))
            {
                return;
            }
            String payload = line.substring(5).trim();
            if (payload.isEmpty())
            {
                return;
            }
            if ("[DONE]".equals(payload))
            {
                finished[0] = true;
                return;
            }
            try
            {
                JSONObject obj = JSON.parseObject(payload);
                JSONArray choices = obj.getJSONArray("choices");
                if (choices == null || choices.isEmpty())
                {
                    return;
                }
                JSONObject delta = choices.getJSONObject(0).getJSONObject("delta");
                if (delta == null)
                {
                    return;
                }
                String content = delta.getString("content");
                if (content != null && !content.isEmpty())
                {
                    if (firstTokenHolder[0] == 0)
                    {
                        firstTokenHolder[0] = System.currentTimeMillis() - startMs;
                    }
                    round.content = (round.content == null ? "" : round.content) + content;
                    onDelta.accept(content);
                }
                JSONArray tcs = delta.getJSONArray("tool_calls");
                if (tcs != null)
                {
                    for (int i = 0; i < tcs.size(); i++)
                    {
                        JSONObject tc = tcs.getJSONObject(i);
                        Integer idx = tc.getInteger("index");
                        if (idx == null)
                        {
                            idx = tcMap.size();
                        }
                        ToolCall call = tcMap.computeIfAbsent(idx, k -> new ToolCall());
                        if (tc.getString("id") != null)
                        {
                            call.id = tc.getString("id");
                        }
                        JSONObject fn = tc.getJSONObject("function");
                        if (fn != null)
                        {
                            if (fn.getString("name") != null)
                            {
                                call.name = fn.getString("name");
                            }
                            if (fn.getString("arguments") != null)
                            {
                                call.argsBuf.append(fn.getString("arguments"));
                            }
                        }
                    }
                }
            }
            catch (Exception pe)
            {
                log.warn("SSE行解析失败: {}", pe.getMessage());
            }
        });
        for (ToolCall c : tcMap.values())
        {
            c.arguments = c.argsBuf.length() == 0 ? "{}" : c.argsBuf.toString();
            round.toolCalls.add(c);
        }
        return round;
    }

    /** OpenAI Function Calling 工具定义(deepseek 兼容) */
    private List<Map<String, Object>> buildTools()
    {
        List<Map<String, Object>> tools = new ArrayList<>();
        tools.add(tool("query_error_book", "查询当前学生的错题本统计:各知识点(标签)的错题数量与累计错误次数,用于分析薄弱知识点"));
        tools.add(tool("query_homework", "查询当前学生最近5次作业的完成状态与得分"));
        Map<String, Object> recParams = new HashMap<>();
        recParams.put("type", "object");
        recParams.put("properties", new HashMap<>());
        tools.add(tool("recommend_practice", "查询待完成的作业清单,并结合错题薄弱点给出练习建议"));
        return tools;
    }

    private Map<String, Object> tool(String name, String description)
    {
        Map<String, Object> fn = new HashMap<>();
        fn.put("name", name);
        fn.put("description", description);
        Map<String, Object> params = new HashMap<>();
        params.put("type", "object");
        params.put("properties", new HashMap<>());
        fn.put("parameters", params);
        Map<String, Object> t = new HashMap<>();
        t.put("type", "function");
        t.put("function", fn);
        return t;
    }

    private void notifyError(AiStreamListener listener, String msg)
    {
        try
        {
            listener.onError(msg);
        }
        catch (Exception ignored)
        {
        }
    }
}
