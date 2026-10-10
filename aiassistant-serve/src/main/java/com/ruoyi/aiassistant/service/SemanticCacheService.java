package com.ruoyi.aiassistant.service;

import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicLong;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 语义缓存:把已回答的问题向量存内存,新问题向量与缓存余弦相似度超阈值直接返回缓存答案,免去 LLM 调用
 *
 * 高并发设计(面试点):
 * 1. 缓存命中判定 O(N) 余弦扫描(N<=MAX_ENTRIES,384维向量,亚毫秒级),读路径无锁
 * 2. 相同问题并发去重(in-flight merge):同一问题并发 N 个请求只有一个真正打 LLM,其余等待复用,防缓存击穿
 * 3. 按用户隔离:命中要求 userId 相同,防止把 A 的个性化答案(注入了 A 的错题本)返回给 B
 * 4. LRU + TTL:超容量淘汰最旧条目,24小时过期
 */
@Service
public class SemanticCacheService
{
    private static final Logger log = LoggerFactory.getLogger(SemanticCacheService.class);

    /** 相似度命中阈值 */
    private static final double HIT_THRESHOLD = 0.92;
    /** 最大缓存条目数 */
    private static final int MAX_ENTRIES = 500;
    /** 缓存有效期 24h */
    private static final long TTL_MS = 24L * 3600 * 1000;

    @Autowired
    private KnowledgeRagService knowledgeRagService;

    public static class CachedAnswer
    {
        public final boolean hit;
        public final String answer;
        public final double similarity;

        public CachedAnswer(boolean hit, String answer, double similarity)
        {
            this.hit = hit;
            this.answer = answer;
            this.similarity = similarity;
        }
    }

    private static class CacheEntry
    {
        final Long userId;
        final String question;
        final float[] vector;
        final String answer;
        final long createdAt;

        CacheEntry(Long userId, String question, float[] vector, String answer)
        {
            this.userId = userId;
            this.question = question;
            this.vector = vector;
            this.answer = answer;
            this.createdAt = System.currentTimeMillis();
        }
    }

    /** LRU:每次命中移动到尾部,容量超限淘汰头部 */
    private final LinkedHashMap<String, CacheEntry> cache = new LinkedHashMap<>(128, 0.75f, true);

    /** 相同问题并发去重:leader 执行中,follower 等待复用结果 */
    private final ConcurrentHashMap<String, CompletableFuture<String>> inFlight = new ConcurrentHashMap<>();

    private final AtomicLong lookups = new AtomicLong();
    private final AtomicLong hits = new AtomicLong();
    private final AtomicLong inFlightMerges = new AtomicLong();

    /** 查缓存(同步,亚毫秒级):先过期清理再余弦扫描 */
    public synchronized CachedAnswer get(Long userId, String question)
    {
        lookups.incrementAndGet();
        long uid = userId == null ? 0L : userId;
        long now = System.currentTimeMillis();
        float[] qv = knowledgeRagService.embedVector(question);
        if (qv == null)
        {
            return new CachedAnswer(false, null, 0);
        }
        // 过期清理
        cache.values().removeIf(e -> now - e.createdAt > TTL_MS);
        String bestKey = null;
        double bestSim = 0;
        for (Map.Entry<String, CacheEntry> e : cache.entrySet())
        {
            CacheEntry ce = e.getValue();
            if (ce.userId != uid)
            {
                continue;
            }
            double sim = cosine(qv, ce.vector);
            if (sim > bestSim)
            {
                bestSim = sim;
                bestKey = e.getKey();
            }
        }
        if (bestKey != null && bestSim >= HIT_THRESHOLD)
        {
            hits.incrementAndGet();
            return new CachedAnswer(true, cache.get(bestKey).answer, bestSim);
        }
        return new CachedAnswer(false, null, bestSim);
    }

    /** 写缓存 */
    public synchronized void put(Long userId, String question, String answer)
    {
        try
        {
            if (answer == null || answer.isEmpty())
            {
                return;
            }
            float[] qv = knowledgeRagService.embedVector(question);
            if (qv == null)
            {
                return;
            }
            long uid = userId == null ? 0L : userId;
            cache.put(uid + "|" + question, new CacheEntry(uid, question, qv, answer));
            while (cache.size() > MAX_ENTRIES)
            {
                Iterator<String> it = cache.keySet().iterator();
                if (!it.hasNext())
                {
                    break;
                }
                it.next();
                it.remove();
            }
        }
        catch (Exception e)
        {
            log.warn("语义缓存写入失败: {}", e.getMessage());
        }
    }

    /**
     * 并发去重注册:返回 null 表示本请求是 leader(需要真正调用 LLM 并在结束时调 finishInFlight);
     * 返回 future 表示已有相同问题在执行,follower 等待该 future 复用结果
     */
    public CompletableFuture<String> beginInFlight(String dedupKey)
    {
        CompletableFuture<String> created = new CompletableFuture<>();
        CompletableFuture<String> existing = inFlight.putIfAbsent(dedupKey, created);
        if (existing != null)
        {
            inFlightMerges.incrementAndGet();
            return existing;
        }
        return null;
    }

    /** leader 结束时调用:发布结果给等待中的 follower 并移除在途标记 */
    public void finishInFlight(String dedupKey, String answer, Exception error)
    {
        CompletableFuture<String> future = inFlight.remove(dedupKey);
        if (future != null)
        {
            if (error != null)
            {
                future.completeExceptionally(error);
            }
            else
            {
                future.complete(answer);
            }
        }
    }

    /** 缓存统计(量化接口用) */
    public synchronized Map<String, Object> stats()
    {
        Map<String, Object> r = new LinkedHashMap<>();
        long look = lookups.get();
        long hit = hits.get();
        r.put("entries", cache.size());
        r.put("maxEntries", MAX_ENTRIES);
        r.put("lookups", look);
        r.put("hits", hit);
        r.put("hitRate", look == 0 ? 0.0 : Math.round(hit * 1000.0 / look) / 10.0);
        r.put("inFlightMerges", inFlightMerges.get());
        r.put("threshold", HIT_THRESHOLD);
        return r;
    }

    private static double cosine(float[] a, float[] b)
    {
        if (a == null || b == null || a.length != b.length)
        {
            return 0;
        }
        double dot = 0, na = 0, nb = 0;
        for (int i = 0; i < a.length; i++)
        {
            dot += a[i] * b[i];
            na += a[i] * a[i];
            nb += b[i] * b[i];
        }
        if (na == 0 || nb == 0)
        {
            return 0;
        }
        return dot / (Math.sqrt(na) * Math.sqrt(nb));
    }
}
