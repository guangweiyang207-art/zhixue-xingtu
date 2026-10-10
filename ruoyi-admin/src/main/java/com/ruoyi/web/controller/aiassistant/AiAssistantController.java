package com.ruoyi.web.controller.aiassistant;

import com.alibaba.fastjson2.JSON;
import com.ruoyi.aiassistant.domain.AiChatRequest;
import com.ruoyi.aiassistant.domain.AiChatResponse;
import com.ruoyi.aiassistant.service.IAiAssistantService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.utils.SecurityUtils;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.concurrent.atomic.AtomicBoolean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

@RestController
@RequestMapping("/ai/assistant")
public class AiAssistantController extends BaseController
{
    @Autowired
    private IAiAssistantService aiAssistantService;

    @PostMapping("/chat")
    public AjaxResult chat(@RequestBody AiChatRequest request)
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser != null && loginUser.getUser() != null)
        {
            request.setUserId(loginUser.getUser().getUserId());
        }
        AiChatResponse response = aiAssistantService.chat(request);
        if (response.isSuccess())
        {
            return AjaxResult.success("操作成功", response.getReply());
        }
        return error(response.getErrorMsg());
    }

    /**
     * 真·流式对话(POST SSE):
     * 事件流格式: event: tool/delta/done/error + data: JSON
     * 客户端断开时 send 抛异常传导回服务层,终止 DeepSeek 生成,不浪费 token
     */
    @PostMapping("/chat/stream")
    public SseEmitter chatStream(@RequestBody AiChatRequest request)
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser != null && loginUser.getUser() != null)
        {
            request.setUserId(loginUser.getUser().getUserId());
        }
        SseEmitter emitter = new SseEmitter(120_000L);
        AtomicBoolean completed = new AtomicBoolean(false);
        Runnable completeOnce = () -> {
            if (completed.compareAndSet(false, true))
            {
                try
                {
                    emitter.complete();
                }
                catch (Exception ignored)
                {
                }
            }
        };

        try
        {
            aiAssistantService.streamChat(request, new IAiAssistantService.AiStreamListener()
            {
                @Override
                public void onTool(String toolName, String toolArgs)
                {
                    Map<String, Object> data = new LinkedHashMap<>();
                    data.put("tool", toolName);
                    data.put("args", toolArgs);
                    send(emitter, "tool", data);
                }

                @Override
                public void onDelta(String text)
                {
                    Map<String, Object> data = new HashMap<>();
                    data.put("text", text);
                    send(emitter, "delta", data);
                }

                @Override
                public void onDone(String reply, IAiAssistantService.AiStreamMeta meta)
                {
                    Map<String, Object> data = new LinkedHashMap<>();
                    data.put("reply", reply);
                    data.put("firstTokenMs", meta.firstTokenMs);
                    data.put("totalMs", meta.totalMs);
                    data.put("cacheHit", meta.cacheHit);
                    data.put("ragTitles", meta.ragTitles);
                    data.put("toolCalls", meta.toolCalls);
                    send(emitter, "done", data);
                    completeOnce.run();
                }

                @Override
                public void onError(String message)
                {
                    Map<String, Object> data = new HashMap<>();
                    data.put("msg", message);
                    send(emitter, "error", data);
                    completeOnce.run();
                }
            });
        }
        catch (Exception e)
        {
            completeOnce.run();
        }
        emitter.onTimeout(completeOnce);
        emitter.onError(t -> completeOnce.run());
        return emitter;
    }

    /** SSE 发送:客户端断开时抛异常,沿调用链传导终止上游生成 */
    private void send(SseEmitter emitter, String event, Object data)
    {
        try
        {
            emitter.send(SseEmitter.event().name(event).data(data, MediaType.APPLICATION_JSON));
        }
        catch (Exception e)
        {
            throw new RuntimeException("客户端断开,终止流式生成", e);
        }
    }
}
