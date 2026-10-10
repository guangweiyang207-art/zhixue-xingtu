package com.ruoyi.aiassistant.service;

import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import jakarta.annotation.PostConstruct;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import dev.langchain4j.data.embedding.Embedding;
import dev.langchain4j.data.segment.TextSegment;
import dev.langchain4j.model.embedding.EmbeddingModel;
import dev.langchain4j.model.embedding.onnx.AbstractInProcessEmbeddingModel;
import dev.langchain4j.model.embedding.onnx.OnnxBertBiEncoder;
import dev.langchain4j.model.embedding.onnx.PoolingMode;
import dev.langchain4j.model.embedding.onnx.bgesmallzhv15.BgeSmallZhV15EmbeddingModel;
import dev.langchain4j.store.embedding.EmbeddingMatch;
import dev.langchain4j.store.embedding.inmemory.InMemoryEmbeddingStore;

/**
 * AI 知识库(RAG)服务:LangChain4j + 本地中文向量化模型(bge-small-zh-v15)
 *
 * - 知识片段持久化在 my_knowledge 表
 * - 向量索引启动时全量加载到内存(InMemoryEmbeddingStore),增删时增量重建(数据量小,成本低)
 * - 混合检索:向量语义召回 + BM25 关键词召回双路并集,融合排序后再按标题重合度轻量重排
 * - chat 回答前调用 retrieve() 检索相关知识片段注入系统提示词
 */
@Service
public class KnowledgeRagService
{
    private static final Logger log = LoggerFactory.getLogger(KnowledgeRagService.class);

    /** 检索相关片段数量 */
    private static final int TOP_K = 3;
    /** 向量相似度阈值(0~1,越高越严格):向量召回路把门用 */
    private static final double MIN_SCORE = 0.4;
    /** 双路召回候选池大小(融合排序前) */
    private static final int CANDIDATE_K = 15;
    /** BM25 关键词召回通过门槛(候选集内归一化 0~1):关键词召回路把门用 */
    private static final double BM25_GATE = 0.55;
    /** BM25 经典参数 */
    private static final double BM25_K1 = 1.5;
    private static final double BM25_B = 0.75;

    @Autowired
    private JdbcTemplate jdbcTemplate;

    /** 微调模型文件目录(项目根相对路径,由 PyTorch 微调管道产出;缺失则回退内置模型) */
    private static final Path FT_MODEL_PATH = Paths.get("ft-model", "model.onnx");
    private static final Path FT_TOKENIZER_PATH = Paths.get("ft-model", "tokenizer.json");

    private final EmbeddingModel embeddingModel = createEmbeddingModel();

    /** 优先加载教育领域微调模型(ft-model/),缺失时回退内置 bge-small-zh-v1.5 */
    private static EmbeddingModel createEmbeddingModel()
    {
        if (Files.isRegularFile(FT_MODEL_PATH) && Files.isRegularFile(FT_TOKENIZER_PATH))
        {
            try (InputStream model = Files.newInputStream(FT_MODEL_PATH);
                 InputStream tokenizer = Files.newInputStream(FT_TOKENIZER_PATH))
            {
                EmbeddingModel ft = new FtBgeEmbeddingModel(model, tokenizer);
                log.info("已加载微调 Embedding 模型: {} (教育领域对比学习)", FT_MODEL_PATH.toAbsolutePath());
                return ft;
            }
            catch (Exception e)
            {
                log.warn("微调模型加载失败,回退内置 bge-small-zh-v1.5: {}", e.getMessage());
            }
        }
        log.info("使用内置 Embedding 模型: bge-small-zh-v1.5");
        return new BgeSmallZhV15EmbeddingModel();
    }

    /** PyTorch 微调导出的 bge ONNX 模型(CLS pooling + L2 归一化,bge-small-zh-v1.5 输出 512 维) */
    private static class FtBgeEmbeddingModel extends AbstractInProcessEmbeddingModel
    {
        private final OnnxBertBiEncoder encoder;

        FtBgeEmbeddingModel(InputStream model, InputStream tokenizer)
        {
            super(Runnable::run);
            this.encoder = new OnnxBertBiEncoder(model, tokenizer, PoolingMode.CLS);
        }

        @Override
        protected OnnxBertBiEncoder model()
        {
            return encoder;
        }

        @Override
        protected Integer knownDimension()
        {
            return 512;
        }
    }

    /** 内存向量索引(重建时整体替换实例) */
    private volatile InMemoryEmbeddingStore<TextSegment> store = new InMemoryEmbeddingStore<>();

    /** BM25 关键词索引(重建时整体替换实例) */
    private volatile Bm25Index bm25Index = new Bm25Index();

    /** 启动时:表为空则写入示例知识点,然后全量构建内存向量索引 */
    @PostConstruct
    public void init()
    {
        try
        {
            seedIfEmpty();
            rebuildIndex();
            log.info("AI知识库(RAG)向量索引构建完成");
        }
        catch (Exception e)
        {
            log.error("AI知识库初始化失败,RAG 能力降级为不可用: {}", e.getMessage());
        }
    }

    /** 检索与问题相关的知识片段(供 chat 注入提示词) */
    public List<String> retrieve(String query, int topK)
    {
        List<String> result = new ArrayList<>();
        for (Map<String, Object> m : retrieveWithScore(query, topK))
        {
            result.add(String.valueOf(m.get("content")));
        }
        return result;
    }

    /**
     * 带分数检索(混合检索 + 轻量重排):
     * ① 双路召回:向量(bge 语义相似) + BM25(关键词字面),各自把门后取并集
     * ② 融合排序:0.7*向量分 + 0.3*关键词分 + 0.1*标题重合加成
     * ③ 按融合分取 topK,返回 title/content/score(0~1 融合分),供 chat 注入与量化统计
     */
    public List<Map<String, Object>> retrieveWithScore(String query, int topK)
    {
        List<Map<String, Object>> result = new ArrayList<>();
        if (query == null || query.trim().isEmpty())
        {
            return result;
        }
        int k = topK > 0 ? topK : TOP_K;
        Set<String> queryTokens = new HashSet<>(tokenize(query));

        // ① 向量召回(语义路)
        Embedding queryEmbedding = embeddingModel.embed(query).content();
        Map<String, Double> vecScores = new HashMap<>();
        for (EmbeddingMatch<TextSegment> m : store.findRelevant(queryEmbedding, CANDIDATE_K, 0.0))
        {
            if (m != null && m.embedded() != null && m.embedded().text() != null)
            {
                vecScores.put(m.embedded().text(), m.score());
            }
        }

        // ① BM25 召回(关键词路)
        Map<String, Double> bm25Scores = bm25Scores(queryTokens);

        // ②③ 融合 + 重排:双路并集,各自把门(向量达阈值或关键词强命中),按融合分排序取 topK
        Set<String> candidates = new LinkedHashSet<>(vecScores.keySet());
        candidates.addAll(bm25Scores.keySet());
        Map<String, Double> fused = new HashMap<>();
        for (String text : candidates)
        {
            double v = vecScores.getOrDefault(text, 0.0);
            double b = bm25Scores.getOrDefault(text, 0.0);
            if (v < MIN_SCORE && b < BM25_GATE)
            {
                continue;
            }
            fused.put(text, fusedScore(text, v, b, queryTokens));
        }
        List<String> texts = new ArrayList<>(fused.keySet());
        texts.sort((a, b2) -> Double.compare(fused.get(b2), fused.get(a)));
        for (String text : texts)
        {
            if (result.size() >= k)
            {
                break;
            }
            Map<String, Object> item = new HashMap<>();
            item.put("content", text);
            item.put("score", Math.round(fused.get(text) * 1000.0) / 1000.0);
            item.put("title", titleOf(text));
            result.add(item);
        }
        return result;
    }

    /** 融合分 = 0.7*向量 + 0.3*关键词 + 0.1*标题重合加成(封顶 0.99) */
    private double fusedScore(String text, double vecScore, double bm25Score, Set<String> queryTokens)
    {
        double overlap = 0.0;
        for (String t : tokenize(titleOf(text)))
        {
            if (queryTokens.contains(t))
            {
                overlap += 1.0;
            }
        }
        double bonus = queryTokens.isEmpty() ? 0.0
            : 0.1 * Math.min(1.0, overlap / Math.min(6.0, queryTokens.size()));
        return Math.min(0.7 * vecScore + 0.3 * bm25Score + bonus, 0.99);
    }

    /** BM25 检索,分数按候选集最大值归一化到 0~1 */
    private Map<String, Double> bm25Scores(Set<String> queryTokens)
    {
        Map<String, Double> raw = new HashMap<>();
        Bm25Index idx = bm25Index;
        if (queryTokens.isEmpty() || idx.docs.isEmpty())
        {
            return raw;
        }
        int n = idx.docs.size();
        for (Bm25Doc d : idx.docs)
        {
            double s = 0.0;
            for (String t : queryTokens)
            {
                Integer f = d.tf.get(t);
                if (f == null)
                {
                    continue;
                }
                int dfc = idx.df.getOrDefault(t, 0);
                double idf = Math.log(1.0 + (n - dfc + 0.5) / (dfc + 0.5));
                s += idf * f * (BM25_K1 + 1.0) / (f + BM25_K1 * (1.0 - BM25_B + BM25_B * d.len / idx.avgLen));
            }
            if (s > 0)
            {
                raw.put(d.text, s);
            }
        }
        double max = 0.0;
        for (Double v : raw.values())
        {
            max = Math.max(max, v);
        }
        Map<String, Double> norm = new HashMap<>();
        if (max > 0)
        {
            for (Map.Entry<String, Double> e : raw.entrySet())
            {
                norm.put(e.getKey(), e.getValue() / max);
            }
        }
        return norm;
    }

    /** 极简切词:中文按相邻双字(bigram),英文/数字按连续词;孤立汉字退化为单字 */
    private static List<String> tokenize(String s)
    {
        List<String> tokens = new ArrayList<>();
        if (s == null || s.isEmpty())
        {
            return tokens;
        }
        String lower = s.toLowerCase();
        StringBuilder word = new StringBuilder();
        for (int i = 0; i < lower.length(); i++)
        {
            char c = lower.charAt(i);
            if (c >= 0x4E00 && c <= 0x9FFF)
            {
                if (word.length() > 0)
                {
                    tokens.add(word.toString());
                    word.setLength(0);
                }
                if (i + 1 < lower.length() && lower.charAt(i + 1) >= 0x4E00 && lower.charAt(i + 1) <= 0x9FFF)
                {
                    tokens.add(lower.substring(i, i + 2));
                }
                else
                {
                    tokens.add(String.valueOf(c));
                }
            }
            else if (Character.isLetterOrDigit(c))
            {
                word.append(c);
            }
            else if (word.length() > 0)
            {
                tokens.add(word.toString());
                word.setLength(0);
            }
        }
        if (word.length() > 0)
        {
            tokens.add(word.toString());
        }
        return tokens;
    }

    /** 从片段文本提取标题(格式:【标题】(类型)\n正文) */
    private static String titleOf(String text)
    {
        if (text != null && text.startsWith("【") && text.indexOf('】') > 0)
        {
            return text.substring(1, text.indexOf('】'));
        }
        return text == null ? "" : text;
    }

    /** BM25 单个文档(标题词已按×3计入词频) */
    private static final class Bm25Doc
    {
        final String title;
        final String text;
        final Map<String, Integer> tf;
        final int len;

        Bm25Doc(String title, String text, Map<String, Integer> tf, int len)
        {
            this.title = title;
            this.text = text;
            this.tf = tf;
            this.len = len;
        }
    }

    /** BM25 全量索引(不可变,重建时整体替换) */
    private static final class Bm25Index
    {
        final List<Bm25Doc> docs = new ArrayList<>();
        final Map<String, Integer> df = new HashMap<>();
        int totalLen;
        double avgLen = 1.0;
    }

    /** 记录一次 AI 对话日志(量化统计用,失败不影响主流程) */
    public void logChat(Long stuId, String question, int answerLen, int responseMs,
                        boolean ragHit, double ragTopScore, String ragTitles)
    {
        logChat(stuId, question, answerLen, responseMs, ragHit, ragTopScore, ragTitles, null, null);
    }

    /** 对话日志(含流式指标:首token耗时/是否语义缓存) */
    public void logChat(Long stuId, String question, int answerLen, int responseMs,
                        boolean ragHit, double ragTopScore, String ragTitles,
                        Integer firstTokenMs, Integer cacheHit)
    {
        try
        {
            jdbcTemplate.update(
                "INSERT INTO my_chat_log(stu_id, question, answer_len, response_ms, rag_hit, rag_top_score, rag_titles, first_token_ms, cache_hit) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)",
                stuId == null ? 0L : stuId,
                question == null ? "" : question.substring(0, Math.min(990, question.length())),
                answerLen, responseMs, ragHit ? 1 : 0, ragTopScore,
                ragTitles == null ? "" : ragTitles.substring(0, Math.min(490, ragTitles.length())),
                firstTokenMs, cacheHit == null ? 0 : cacheHit);
        }
        catch (Exception e)
        {
            log.warn("AI对话日志写入失败: {}", e.getMessage());
        }
    }

    /** 对外暴露向量化(语义缓存用) */
    public float[] embedVector(String text)
    {
        if (text == null || text.trim().isEmpty())
        {
            return null;
        }
        return embeddingModel.embed(text).content().vector();
    }

    /** 新增知识片段(入库 + 向量化) */
    public Long add(String title, String content, String courseType, String source)
    {
        jdbcTemplate.update(
            "INSERT INTO my_knowledge(title, content, course_type, source) VALUES(?, ?, ?, ?)",
            title, content, courseType == null ? "" : courseType, source == null ? "" : source);
        Long id = jdbcTemplate.queryForObject("SELECT LAST_INSERT_ID()", Long.class);
        rebuildIndex();
        return id;
    }

    /** 删除知识片段 */
    public int deleteById(Long id)
    {
        int rows = jdbcTemplate.update("DELETE FROM my_knowledge WHERE id = ?", id);
        if (rows > 0)
        {
            rebuildIndex();
        }
        return rows;
    }

    /** 文档导入:按段落自动切分批量入库(每段独立向量化,检索更精准) */
    public int importDoc(String docTitle, String courseType, String content)
    {
        List<Object[]> batch = new ArrayList<>();
        String[] paras = content.split("\\n\\s*\\n");
        int seq = 0;
        for (String p : paras)
        {
            String para = p.replace("\r", "").replace("\n", "").trim();
            if (para.length() < 20)
            {
                continue;
            }
            for (String piece : splitLong(para, 400))
            {
                seq++;
                batch.add(new Object[] { docTitle + "·第" + seq + "段", piece,
                    courseType == null ? "" : courseType, "文档导入:" + docTitle });
            }
        }
        for (Object[] row : batch)
        {
            jdbcTemplate.update(
                "INSERT INTO my_knowledge(title, content, course_type, source) VALUES(?, ?, ?, ?)",
                row);
        }
        if (!batch.isEmpty())
        {
            rebuildIndex();
        }
        return batch.size();
    }

    /** 长段落按句读二次切分,每段不超过 maxLen 字 */
    private List<String> splitLong(String para, int maxLen)
    {
        List<String> pieces = new ArrayList<>();
        if (para.length() <= maxLen)
        {
            pieces.add(para);
            return pieces;
        }
        StringBuilder sb = new StringBuilder();
        for (String s : para.split("(?<=。|！|？|；|\\.)"))
        {
            if (sb.length() + s.length() > maxLen && sb.length() > 0)
            {
                pieces.add(sb.toString().trim());
                sb.setLength(0);
            }
            sb.append(s);
        }
        if (sb.length() > 0)
        {
            pieces.add(sb.toString().trim());
        }
        return pieces;
    }

    /** 知识列表 */
    public List<Map<String, Object>> list()
    {
        return jdbcTemplate.queryForList(
            "SELECT id, title, content, course_type AS courseType, source, create_time AS createTime FROM my_knowledge ORDER BY id DESC");
    }

    /** 全量重建内存双索引(向量 + BM25,知识条目少,代价可忽略) */
    private synchronized void rebuildIndex()
    {
        List<Map<String, Object>> rows = jdbcTemplate.queryForList(
            "SELECT id, title, content, course_type FROM my_knowledge");
        InMemoryEmbeddingStore<TextSegment> fresh = new InMemoryEmbeddingStore<>();
        Bm25Index freshBm25 = new Bm25Index();
        for (Map<String, Object> row : rows)
        {
            String title = String.valueOf(row.get("title"));
            String content = String.valueOf(row.get("content"));
            Object courseType = row.get("course_type");
            String text = "【" + title + "】(" + (courseType == null ? "通用" : courseType) + ")\n" + content;
            TextSegment segment = TextSegment.from(text);
            fresh.add(embeddingModel.embed(segment).content(), segment);
            // BM25 文档:标题词权重×3 + 正文词
            Map<String, Integer> tf = new HashMap<>();
            for (String t : tokenize(title))
            {
                tf.merge(t, 3, Integer::sum);
            }
            for (String t : tokenize(content))
            {
                tf.merge(t, 1, Integer::sum);
            }
            int len = 0;
            for (Integer f : tf.values())
            {
                len += f;
            }
            freshBm25.docs.add(new Bm25Doc(title, text, tf, len));
            freshBm25.totalLen += len;
            for (String t : tf.keySet())
            {
                freshBm25.df.merge(t, 1, Integer::sum);
            }
        }
        freshBm25.avgLen = freshBm25.docs.isEmpty() ? 1.0 : (double) freshBm25.totalLen / freshBm25.docs.size();
        this.store = fresh;
        this.bm25Index = freshBm25;
    }

    /** 表为空时写入示例知识点,让"还没有文档"也能演示 RAG 效果 */
    private void seedIfEmpty()
    {
        Integer count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM my_knowledge", Integer.class);
        if (count != null && count > 0)
        {
            return;
        }
        String[][] seeds = {
            {"一元二次方程求根公式", "对于一元二次方程 ax²+bx+c=0（a≠0），求根公式为 x=(-b±√(b²-4ac))/2a。其中判别式 Δ=b²-4ac：Δ>0 时有两个不相等的实数根；Δ=0 时有两个相等的实数根；Δ<0 时无实数根。解题时可先化简为一般式再代入公式，配方法与因式分解法是常用替代方案。", "数学"},
            {"勾股定理", "在直角三角形中，两条直角边 a、b 与斜边 c 满足 a²+b²=c²。常见勾股数有 (3,4,5)、(5,12,13)、(6,8,10)、(7,24,25)。已知两边求第三边时，注意先判断所求边是直角边还是斜边：斜边=√(a²+b²)，直角边=√(c²-a²)。", "数学"},
            {"等差数列求和", "等差数列前 n 项和公式：Sn=n(a₁+aₙ)/2=n·a₁+n(n-1)d/2，其中 a₁ 是首项，d 是公差。通项公式 aₙ=a₁+(n-1)d。解题时先确定首项与公差，再选择合适公式，注意 n 的取值范围和正负性讨论。", "数学"},
            {"英语动词时态", "英语常用时态：一般现在时（主语三单动词+s）、现在进行时（am/is/are+doing）、一般过去时（动词过去式，常见不规则变化如 go-went）、现在完成时（have/has+done，强调对现在的影响，常搭配 already/just/yet）。判断时态关键看时间状语和上下文。", "英语"},
            {"定语从句", "定语从句由关系代词（who/whom/whose/which/that）或关系副词（when/where/why）引导，修饰名词或代词（先行词）。指人用 who/that，指物用 which/that；先行词在从句中作状语时用关系副词。注意：先行词前有序数词、最高级或 the only/all 等修饰时，关系代词只能用 that。", "英语"},
            {"牛顿运动定律", "牛顿第二定律 F=ma：物体的加速度与所受合外力成正比，与质量成反比，方向与合外力相同。解题步骤：确定研究对象→受力分析（画受力图）→建立坐标系分解力→列方程求解。注意单位统一为国际单位制。", "物理"},
            {"能量守恒定律", "能量既不会凭空产生也不会凭空消灭，只能从一种形式转化为另一种形式，或从一个物体转移到另一个物体，总量保持不变。机械能守恒的条件是只有重力或弹力做功。解题时明确初末状态的动能（EK=½mv²）和势能（EP=mgh）。", "物理"},
            {"Java 面向对象三大特性", "封装：隐藏内部细节，通过 getter/setter 访问，提高安全性；继承：子类 extends 父类，复用代码，Java 单继承；多态：父类引用指向子类对象，运行时决定调用的方法实现，前提是方法重写。三大特性是面向对象设计的基石。", "编程"},
            {"编程循环结构", "for 循环适合已知次数的场景（如遍历数组）；while 循环适合先判断后执行、次数不确定的场景；do-while 至少执行一次。注意避免死循环：循环体内必须有使条件趋于结束的变化。二重循环常用于打印图形和穷举问题。", "编程"},
            {"错题复盘方法", "高效错题复盘三步法：①归类错因（概念不清/计算失误/审题偏差/方法没掌握）；②针对性重做：遮住答案独立重做一遍，写清每一步依据；③定期回看：按艾宾浩斯遗忘曲线，在第1、3、7、15天回看错题，能独立讲出解题思路才算真正掌握。", "学习方法"}
        };
        for (String[] s : seeds)
        {
            jdbcTemplate.update("INSERT INTO my_knowledge(title, content, course_type, source) VALUES(?, ?, ?, ?)",
                s[0], s[1], s[2], "内置示例知识点");
        }
        log.info("AI知识库为空,已写入 {} 条示例知识点", seeds.length);
    }
}
