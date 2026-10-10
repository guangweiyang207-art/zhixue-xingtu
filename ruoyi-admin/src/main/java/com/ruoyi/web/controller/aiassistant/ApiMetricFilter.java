package com.ruoyi.web.controller.aiassistant;

import java.io.IOException;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.Order;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * 接口耗时监控:记录核心业务接口的耗时与状态码到 my_api_metric(量化统计用)
 * 只记录写操作之外的白名单前缀,排除监控接口自身与知识库检索测试,避免数据自污染
 */
@Component
@Order(1)
public class ApiMetricFilter extends OncePerRequestFilter
{
    private static final Logger log = LoggerFactory.getLogger(ApiMetricFilter.class);

    private static final String[] INCLUDE_PREFIXES = {
        "/ai/assistant", "/homework/", "/studenthomework/", "/mine/", "/myauth/",
        "/teacher/", "/students/", "/mxy/", "/errorbook/"
    };

    private static final String[] EXCLUDE_PREFIXES = {
        "/ai/metrics", "/ai/knowledge"
    };

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    protected boolean shouldNotFilter(HttpServletRequest request)
    {
        String uri = request.getRequestURI();
        String path = uri.substring(request.getContextPath().length());
        if (!"GET".equals(request.getMethod()) && !"POST".equals(request.getMethod()))
        {
            return true;
        }
        for (String ex : EXCLUDE_PREFIXES)
        {
            if (path.startsWith(ex))
            {
                return true;
            }
        }
        for (String in : INCLUDE_PREFIXES)
        {
            if (path.startsWith(in))
            {
                return false;
            }
        }
        return true;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
        throws ServletException, IOException
    {
        long start = System.currentTimeMillis();
        try
        {
            filterChain.doFilter(request, response);
        }
        finally
        {
            try
            {
                String path = request.getRequestURI().substring(request.getContextPath().length());
                int cost = (int) (System.currentTimeMillis() - start);
                int status = response.getStatus();
                jdbcTemplate.update(
                    "INSERT INTO my_api_metric(method, uri, cost_ms, status) VALUES(?, ?, ?, ?)",
                    request.getMethod(), path, cost, status);
            }
            catch (Exception e)
            {
                log.warn("接口监控记录失败: {}", e.getMessage());
            }
        }
    }
}
