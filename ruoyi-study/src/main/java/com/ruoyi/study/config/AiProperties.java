package com.ruoyi.study.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * AI大模型配置属性
 */
@Component
@ConfigurationProperties(prefix = "ai")
public class AiProperties
{
    /** 模型提供商 */
    private String provider;

    /** API Key */
    private String apiKey;

    /** 模型名称 */
    private String model;

    /** API基础地址 */
    private String baseUrl;

    /** 系统角色设定 */
    private String systemPrompt;

    /** 是否启用联网搜索 */
    private Boolean webSearchEnabled = false;

    /** 搜索引擎类型: bocha(博查)/serpapi/baidu */
    private String searchEngine = "bocha";

    /** 搜索引擎API Key（博查AI） */
    private String searchApiKey;

    /** 搜索结果数量 */
    private Integer searchResultCount = 5;

    public String getProvider()
    {
        return provider;
    }

    public void setProvider(String provider)
    {
        this.provider = provider;
    }

    public String getApiKey()
    {
        return apiKey;
    }

    public void setApiKey(String apiKey)
    {
        this.apiKey = apiKey;
    }

    public String getModel()
    {
        return model;
    }

    public void setModel(String model)
    {
        this.model = model;
    }

    public String getBaseUrl()
    {
        return baseUrl;
    }

    public void setBaseUrl(String baseUrl)
    {
        this.baseUrl = baseUrl;
    }

    public String getSystemPrompt()
    {
        return systemPrompt;
    }

    public void setSystemPrompt(String systemPrompt)
    {
        this.systemPrompt = systemPrompt;
    }

    public Boolean getWebSearchEnabled()
    {
        return webSearchEnabled;
    }

    public void setWebSearchEnabled(Boolean webSearchEnabled)
    {
        this.webSearchEnabled = webSearchEnabled;
    }

    public String getSearchEngine()
    {
        return searchEngine;
    }

    public void setSearchEngine(String searchEngine)
    {
        this.searchEngine = searchEngine;
    }

    public String getSearchApiKey()
    {
        return searchApiKey;
    }

    public void setSearchApiKey(String searchApiKey)
    {
        this.searchApiKey = searchApiKey;
    }

    public Integer getSearchResultCount()
    {
        return searchResultCount;
    }

    public void setSearchResultCount(Integer searchResultCount)
    {
        this.searchResultCount = searchResultCount;
    }
}
