package com.ruoyi.aiassistant.service;

import com.ruoyi.aiassistant.domain.AiChatRequest;
import com.ruoyi.aiassistant.domain.AiChatResponse;

public interface IAiAssistantService
{
    public AiChatResponse chat(AiChatRequest request);

    /**
     * 流式对话(真流式):DeepSeek stream=true 增量回调 + Agent Function Calling(ReAct循环)
     * 实现在独立线程池执行,方法立即返回;客户端断开通过 listener 抛异常传导终止生成
     */
    void streamChat(AiChatRequest request, AiStreamListener listener);

    /** 流式对话回调:实现方需保证线程安全;send 失败直接抛异常即可终止上游生成 */
    interface AiStreamListener
    {
        /** Agent 即将调用业务工具(前端可渲染"正在查询错题本..."步骤气泡) */
        void onTool(String toolName, String toolArgs);

        /** 增量文本(每次几个 token) */
        void onDelta(String text);

        /** 正常结束 */
        void onDone(String reply, AiStreamMeta meta);

        /** 失败 */
        void onError(String message);
    }

    /** 流式对话指标(量化用) */
    class AiStreamMeta
    {
        /** 首个 token 耗时(ms) */
        public long firstTokenMs;
        /** 总耗时(ms) */
        public long totalMs;
        /** 是否命中语义缓存 */
        public boolean cacheHit;
        /** RAG 命中的知识片段标题 */
        public String ragTitles;
        /** Agent 工具调用次数 */
        public int toolCalls;
    }
}
