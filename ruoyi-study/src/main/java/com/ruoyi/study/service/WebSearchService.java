package com.ruoyi.study.service;

import com.ruoyi.study.config.AiProperties;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 联网搜索服务
 * 支持博查AI、SerpAPI等搜索引擎
 */
@Service
public class WebSearchService
{
    @Autowired
    private AiProperties aiProperties;

    private final RestTemplate restTemplate = new RestTemplate();

    /**
     * 联网搜索
     * @param query 查询关键词
     * @return 搜索结果摘要
     */
    public String search(String query)
    {
        System.out.println("[联网搜索] 搜索引擎=" + aiProperties.getSearchEngine()
                + ", query=" + query
                + ", apiKey=" + (aiProperties.getSearchApiKey() == null ? "null" :
                    (aiProperties.getSearchApiKey().isEmpty() ? "空" :
                     aiProperties.getSearchApiKey().substring(0, Math.min(4, aiProperties.getSearchApiKey().length())) + "****")));

        if (aiProperties.getSearchApiKey() == null || aiProperties.getSearchApiKey().isEmpty())
        {
            System.out.println("[联网搜索] 跳过：未配置搜索API Key");
            return "（未配置搜索引擎API Key，无法联网搜索）";
        }

        String engine = aiProperties.getSearchEngine();
        try
        {
            String result;
            if ("bocha".equalsIgnoreCase(engine))
            {
                result = searchByBocha(query);
            }
            else if ("serpapi".equalsIgnoreCase(engine))
            {
                result = searchBySerpApi(query);
            }
            else
            {
                result = searchByBocha(query);
            }
            System.out.println("[联网搜索] 返回结果长度: " + (result == null ? 0 : result.length()));
            if (result != null && result.length() > 200)
            {
                System.out.println("[联网搜索] 结果前200字: " + result.substring(0, 200));
            }
            return result;
        }
        catch (Exception e)
        {
            System.err.println("[联网搜索] 调用失败: " + e.getMessage());
            e.printStackTrace();
            return "（联网搜索出错：" + e.getMessage() + "）";
        }
    }

    /**
     * 博查AI搜索（推荐，免费额度大）
     * 文档：https://bochaai.com/
     */
    private String searchByBocha(String query)
    {
        String url = "https://api.bochaai.com/v1/web-search";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization", "Bearer " + aiProperties.getSearchApiKey());

        Map<String, Object> body = new HashMap<>();
        body.put("query", query);
        body.put("summary", true);
        body.put("count", aiProperties.getSearchResultCount() != null ? aiProperties.getSearchResultCount() : 5);
        body.put("freshness", "noLimit");

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(body, headers);

        // 使用带超时的RestTemplate
        org.springframework.http.client.SimpleClientHttpRequestFactory factory =
                new org.springframework.http.client.SimpleClientHttpRequestFactory();
        factory.setConnectTimeout(10000);
        factory.setReadTimeout(30000);
        RestTemplate rt = new RestTemplate(factory);

        try
        {
            ResponseEntity<Map> response = rt.postForEntity(url, entity, Map.class);
            int status = response.getStatusCode().value();
            Map<String, Object> responseBody = response.getBody();

            System.out.println("[博查搜索] HTTP状态: " + status);
            if (responseBody != null)
            {
                System.out.println("[博查搜索] 返回JSON前500字: " + responseBody.toString().substring(0, Math.min(500, responseBody.toString().length())));
            }

            if (status == 401 || status == 403)
            {
                return "（博查AI授权失败：API Key无效或已过期，请到 https://open.bochaai.com 重新获取）";
            }

            if (responseBody == null)
            {
                return "（搜索无结果：API返回空）";
            }

            // 检查code字段
            Object codeObj = responseBody.get("code");
            if (codeObj != null && !codeObj.toString().equals("200"))
            {
                String msg = (String) responseBody.get("msg");
                return "（搜索失败：" + (msg != null ? msg : codeObj) + "）";
            }

            // 解析结果 - 路径: data.webPages.value
            Map<String, Object> data = (Map<String, Object>) responseBody.get("data");
            if (data == null)
            {
                return "（搜索无结果：无data字段）";
            }

            Map<String, Object> webPages = (Map<String, Object>) data.get("webPages");
            if (webPages == null)
            {
                return "（搜索无结果：无webPages字段）";
            }

            List<Map<String, Object>> items = (List<Map<String, Object>>) webPages.get("value");
            if (items == null || items.isEmpty())
            {
                return "（搜索无结果：value数组为空）";
            }

            int maxCount = aiProperties.getSearchResultCount() != null ? aiProperties.getSearchResultCount() : 5;
            StringBuilder sb = new StringBuilder();
            sb.append("【联网搜索结果】\n");
            int idx = 1;
            for (Map<String, Object> page : items)
            {
                if (idx > maxCount) break;
                String title = (String) page.get("name");
                String url2 = (String) page.get("url");
                String snippet = (String) page.get("snippet");
                if (snippet == null || snippet.isEmpty())
                {
                    snippet = (String) page.get("summary");
                }
                if (title == null) title = "无标题";
                if (url2 == null) url2 = "";
                if (snippet == null) snippet = "";
                // 截断摘要，避免太长
                if (snippet.length() > 300)
                {
                    snippet = snippet.substring(0, 300) + "...";
                }
                sb.append(idx).append(". ").append(title).append("\n");
                sb.append("   ").append(snippet).append("\n");
                if (!url2.isEmpty())
                {
                    sb.append("   来源: ").append(url2).append("\n");
                }
                sb.append("\n");
                idx++;
            }
            return sb.toString();
        }
        catch (org.springframework.web.client.HttpClientErrorException e)
        {
            int status = e.getStatusCode().value();
            System.err.println("[博查搜索] HTTP错误 " + status + ": " + e.getResponseBodyAsString());
            if (status == 401 || status == 403)
            {
                return "（博查AI授权失败：API Key无效或已过期，请到 https://open.bochaai.com 重新获取）";
            }
            return "（搜索请求失败 HTTP " + status + "：请稍后重试）";
        }
    }

    /**
     * SerpAPI搜索（备选）
     */
    private String searchBySerpApi(String query)
    {
        String url = "https://serpapi.com/search.json?q=" + query
                + "&api_key=" + aiProperties.getSearchApiKey()
                + "&num=" + (aiProperties.getSearchResultCount() != null ? aiProperties.getSearchResultCount() : 5);

        ResponseEntity<Map> response = restTemplate.getForEntity(url, Map.class);
        Map<String, Object> responseBody = response.getBody();
        if (responseBody == null)
        {
            return "（搜索无结果）";
        }

        List<Map<String, Object>> results = (List<Map<String, Object>>) responseBody.get("organic_results");
        if (results == null || results.isEmpty())
        {
            return "（搜索无结果）";
        }

        StringBuilder sb = new StringBuilder();
        sb.append("【联网搜索结果】\n");
        int idx = 1;
        for (Map<String, Object> result : results)
        {
            String title = (String) result.get("title");
            String link = (String) result.get("link");
            String snippet = (String) result.get("snippet");
            sb.append(idx++).append(". ").append(title != null ? title : "").append("\n");
            sb.append("   ").append(snippet != null ? snippet : "").append("\n");
            if (link != null)
            {
                sb.append("   来源: ").append(link).append("\n");
            }
            sb.append("\n");
        }
        return sb.toString();
    }
}
