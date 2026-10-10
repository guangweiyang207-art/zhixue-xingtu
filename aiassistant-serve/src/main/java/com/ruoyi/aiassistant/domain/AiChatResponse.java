package com.ruoyi.aiassistant.domain;

public class AiChatResponse
{
    private String reply;
    private boolean success;
    private String errorMsg;

    public static AiChatResponse success(String reply)
    {
        AiChatResponse resp = new AiChatResponse();
        resp.setReply(reply);
        resp.setSuccess(true);
        return resp;
    }

    public static AiChatResponse fail(String errorMsg)
    {
        AiChatResponse resp = new AiChatResponse();
        resp.setErrorMsg(errorMsg);
        resp.setSuccess(false);
        return resp;
    }

    public String getReply()
    {
        return reply;
    }

    public void setReply(String reply)
    {
        this.reply = reply;
    }

    public boolean isSuccess()
    {
        return success;
    }

    public void setSuccess(boolean success)
    {
        this.success = success;
    }

    public String getErrorMsg()
    {
        return errorMsg;
    }

    public void setErrorMsg(String errorMsg)
    {
        this.errorMsg = errorMsg;
    }
}
