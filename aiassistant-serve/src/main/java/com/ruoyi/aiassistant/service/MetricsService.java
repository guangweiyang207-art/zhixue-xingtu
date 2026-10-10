package com.ruoyi.aiassistant.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

/**
 * 量化统计服务:RAG效果 / 学习效果 / 接口监控 三个维度
 */
@Service
public class MetricsService
{
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private KnowledgeRagService ragService;

    @Autowired
    private SemanticCacheService semanticCacheService;

    /** 检索质量评测集:问题 + 期望命中的关键词(top3中任一片段包含即算命中) */
    private static final String[][] EVAL_SET = {
        {"直角三角形两条直角边怎么求斜边", "勾股定理"},
        {"一元二次方程根与系数有什么关系", "韦达定理"},
        {"定语从句什么时候只能用that", "定语从句"},
        {"虚拟语气与过去事实相反怎么表达", "虚拟语气"},
        {"滑动摩擦力的大小怎么计算", "摩擦力"},
        {"机械能守恒定律成立的条件是什么", "机械能守恒"},
        {"HashMap什么时候链表会转成红黑树", "HashMap"},
        {"Java多态的实现前提有哪些", "多态"},
        {"哪些排序算法是稳定的", "排序"},
        {"二次函数的顶点坐标怎么求", "二次函数"}
    };

    /** RAG 效果汇总:提问总数/命中率/平均耗时/平均相似度 */
    public Map<String, Object> ragSummary()
    {
        Map<String, Object> r = new HashMap<>();
        Long total = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM my_chat_log", Long.class);
        Long hits = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM my_chat_log WHERE rag_hit = 1", Long.class);
        Long today = jdbcTemplate.queryForObject(
            "SELECT COUNT(*) FROM my_chat_log WHERE create_time >= CURDATE()", Long.class);
        Double avgMs = jdbcTemplate.queryForObject("SELECT IFNULL(AVG(response_ms), 0) FROM my_chat_log", Double.class);
        Double avgScore = jdbcTemplate.queryForObject(
            "SELECT IFNULL(AVG(rag_top_score), 0) FROM my_chat_log WHERE rag_hit = 1", Double.class);
        r.put("totalQuestions", total == null ? 0 : total);
        r.put("ragHitCount", hits == null ? 0 : hits);
        r.put("ragHitRate", total == null || total == 0 ? 0.0 : Math.round(hits * 1000.0 / total) / 10.0);
        r.put("todayQuestions", today == null ? 0 : today);
        r.put("avgResponseMs", avgMs == null ? 0 : Math.round(avgMs));
        r.put("avgTopScore", avgScore == null ? 0 : Math.round(avgScore * 1000.0) / 1000.0);
        // 流式/缓存量化:首token平均耗时、语义缓存命中数
        Double avgFirstToken = jdbcTemplate.queryForObject(
            "SELECT IFNULL(AVG(first_token_ms), 0) FROM my_chat_log WHERE first_token_ms IS NOT NULL AND first_token_ms > 0", Double.class);
        Long cacheHits = jdbcTemplate.queryForObject(
            "SELECT COUNT(*) FROM my_chat_log WHERE cache_hit = 1", Long.class);
        r.put("avgFirstTokenMs", avgFirstToken == null ? 0 : Math.round(avgFirstToken));
        r.put("cacheHitCount", cacheHits == null ? 0 : cacheHits);
        // 知识贡献度TOP5:被命中最多的知识片段
        r.put("topKnowledge", jdbcTemplate.queryForList(
            "SELECT rag_titles FROM my_chat_log WHERE rag_hit = 1 ORDER BY id DESC LIMIT 200"));
        return r;
    }

    /** 语义缓存统计:内存状态 + 数据库命中记录 */
    public Map<String, Object> cacheStats()
    {
        Map<String, Object> r = new HashMap<>(semanticCacheService.stats());
        Long dbHits = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM my_chat_log WHERE cache_hit = 1", Long.class);
        Long total = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM my_chat_log", Long.class);
        r.put("dbCacheHitCount", dbHits == null ? 0 : dbHits);
        r.put("dbTotalChats", total == null ? 0 : total);
        return r;
    }

    /** 最近对话日志明细 */
    public List<Map<String, Object>> ragLogs(int limit)
    {
        int n = limit > 0 && limit <= 200 ? limit : 50;
        return jdbcTemplate.queryForList(
            "SELECT id, stu_id AS stuId, question, answer_len AS answerLen, response_ms AS responseMs, " +
            "rag_hit AS ragHit, rag_top_score AS ragTopScore, rag_titles AS ragTitles, create_time AS createTime " +
            "FROM my_chat_log ORDER BY id DESC LIMIT " + n);
    }

    /**
     * RAG 检索质量评测:对固定测试集跑检索,输出命中率与相似度
     * 命中判定:top3 结果的标题或内容包含期望关键词
     */
    public Map<String, Object> ragEval()
    {
        List<Map<String, Object>> details = new ArrayList<>();
        int hitCount = 0;
        double scoreSum = 0;
        long costSum = 0;
        for (String[] eval : EVAL_SET)
        {
            String question = eval[0];
            String keyword = eval[1];
            long start = System.currentTimeMillis();
            List<Map<String, Object>> refs = ragService.retrieveWithScore(question, 3);
            costSum += System.currentTimeMillis() - start;

            boolean hit = false;
            String hitTitle = "";
            double topScore = refs.isEmpty() ? 0.0 : (double) refs.get(0).get("score");
            for (Map<String, Object> ref : refs)
            {
                String content = String.valueOf(ref.get("content"));
                String title = String.valueOf(ref.get("title"));
                if (content.contains(keyword) || title.contains(keyword))
                {
                    hit = true;
                    hitTitle = title;
                    break;
                }
            }
            if (hit)
            {
                hitCount++;
            }
            scoreSum += topScore;
            Map<String, Object> row = new HashMap<>();
            row.put("question", question);
            row.put("expectKeyword", keyword);
            row.put("hit", hit);
            row.put("hitTitle", hitTitle);
            row.put("topScore", Math.round(topScore * 1000.0) / 1000.0);
            details.add(row);
        }
        Map<String, Object> result = new HashMap<>();
        result.put("evalSize", EVAL_SET.length);
        result.put("hitCount", hitCount);
        result.put("hitRate", Math.round(hitCount * 1000.0 / EVAL_SET.length) / 10.0);
        result.put("avgTopScore", Math.round(scoreSum * 100.0 / EVAL_SET.length) / 100.0);
        result.put("avgRetrieveMs", costSum / EVAL_SET.length);
        result.put("details", details);
        return result;
    }

    /** 学习效果量化:错题消灭率/近7天作业趋势/正确率 */
    public Map<String, Object> learning(Long stuId)
    {
        long sid = stuId == null || stuId <= 0 ? 1 : stuId;
        Map<String, Object> r = new HashMap<>();
        // 错题本:总数/已掌握/待复习 + 消灭率
        Long errTotal = jdbcTemplate.queryForObject(
            "SELECT COUNT(*) FROM my_error_book WHERE stu_id = ?", Long.class, sid);
        Long mastered = jdbcTemplate.queryForObject(
            "SELECT COUNT(*) FROM my_error_book WHERE stu_id = ? AND is_mastered = 1", Long.class, sid);
        Long new7d = jdbcTemplate.queryForObject(
            "SELECT COUNT(*) FROM my_error_book WHERE stu_id = ? AND last_wrong_time >= DATE_SUB(NOW(), INTERVAL 7 DAY)",
            Long.class, sid);
        long total = errTotal == null ? 0 : errTotal;
        r.put("errorTotal", total);
        r.put("errorMastered", mastered == null ? 0 : mastered);
        r.put("errorPending", total - (mastered == null ? 0 : mastered));
        r.put("newError7d", new7d == null ? 0 : new7d);
        r.put("masteredRate", total == 0 ? 0.0 : Math.round((mastered == null ? 0 : mastered) * 1000.0 / total) / 10.0);
        // 近7天完成作业趋势(按批改时间)
        r.put("weekHomework", jdbcTemplate.queryForList(
            "SELECT DATE_FORMAT(correct_time, '%m-%d') AS day, COUNT(*) AS cnt " +
            "FROM my_student_homework WHERE stu_id = ? AND status = 2 " +
            "AND correct_time >= DATE_SUB(NOW(), INTERVAL 7 DAY) " +
            "GROUP BY day ORDER BY day", sid));
        // 总体正确率与完成数
        Long done = jdbcTemplate.queryForObject(
            "SELECT COUNT(*) FROM my_student_homework WHERE stu_id = ? AND status = 2", Long.class, sid);
        r.put("completedHomework", done == null ? 0 : done);
        Double avgRate = jdbcTemplate.queryForObject(
            "SELECT IFNULL(AVG(score), 0) FROM my_student_homework WHERE stu_id = ? AND status = 2", Double.class, sid);
        r.put("avgScore", avgRate == null ? 0 : Math.round(avgRate * 10.0) / 10.0);
        return r;
    }

    /** 接口监控:总请求数/错误数/平均耗时/最慢接口TOP */
    public Map<String, Object> apiSummary()
    {
        Map<String, Object> r = new HashMap<>();
        Long total = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM my_api_metric", Long.class);
        Long errors = jdbcTemplate.queryForObject(
            "SELECT COUNT(*) FROM my_api_metric WHERE status >= 400", Long.class);
        Double avgMs = jdbcTemplate.queryForObject(
            "SELECT IFNULL(AVG(cost_ms), 0) FROM my_api_metric", Double.class);
        r.put("totalRequests", total == null ? 0 : total);
        r.put("errorCount", errors == null ? 0 : errors);
        r.put("avgCostMs", avgMs == null ? 0 : Math.round(avgMs));
        // 最慢接口TOP5
        r.put("slowestApis", jdbcTemplate.queryForList(
            "SELECT uri, COUNT(*) AS cnt, ROUND(AVG(cost_ms)) AS avgCost, MAX(cost_ms) AS maxCost " +
            "FROM my_api_metric GROUP BY uri ORDER BY avgCost DESC LIMIT 5"));
        // 调用量TOP5
        r.put("hottestApis", jdbcTemplate.queryForList(
            "SELECT uri, COUNT(*) AS cnt, ROUND(AVG(cost_ms)) AS avgCost " +
            "FROM my_api_metric GROUP BY uri ORDER BY cnt DESC LIMIT 5"));
        return r;
    }
}
