package com.ruoyi.aiassistant.domain;

import java.util.List;
import java.util.Map;

public class AiChatRequest
{
    private String message;
    private List<Map<String, String>> history;
    private String type;
    private Long userId;

    public String getMessage()
    {
        return message;
    }

    public void setMessage(String message)
    {
        this.message = message;
    }

    public List<Map<String, String>> getHistory()
    {
        return history;
    }

    public void setHistory(List<Map<String, String>> history)
    {
        this.history = history;
    }

    public String getType()
    {
        return type;
    }

    public void setType(String type)
    {
        this.type = type;
    }

    public Long getUserId()
    {
        return userId;
    }

    public void setUserId(Long userId)
    {
        this.userId = userId;
    }
}
