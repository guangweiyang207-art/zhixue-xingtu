# 智学星途 zhixue-xingtu

> 三端 AI 智能学习平台 · Java 17 + Spring Boot 3 + LangChain4j + DeepSeek · **已部署上线**

一个连接**学生端**、**教师端**与**管理端**的教学平台：作业发布 → 逐题作答 → 教师批改 → 错题沉淀 → 学情报告全链路闭环，AI 深度介入错题讲解、个性化问答与学情分析。

## 在线演示

| 端 | 地址 |
|---|---|
| 管理端 Web | http://47.116.16.86:81 （admin / admin123） |
| 后端 API | http://47.116.16.86:8081 |
| 学生端小程序 / 教师端小程序 | HBuilderX 导入对应工程，微信开发者工具运行 |

## 核心亮点

### 1. 混合检索 + 微调模型（RAG）
- 双路召回：**BM25**（中文 bigram + 标题加权）+ **BGE 向量**，加权融合重排
- 使用 PyTorch 对 `bge-small-zh-v1.5` 做教育领域对比学习微调（MNRL，544 样本对），导出 ONNX 由 Java 侧加载，评测集 **recall@3 95% → 98.75%**
- 模型文件超过 GitHub 单文件限制未入库：训练产物放项目根 `ft-model/`（`model.onnx` + `tokenizer.json`）即自动加载，缺失时回退内置模型

### 2. 真·流式输出
- SSE（`SseEmitter`）+ DeepSeek stream，首 token 延迟实测 **890ms**
- 小程序端 `enableChunked` 分块接收 + H5 `ReadableStream`，增量 UTF-8 解码处理中文跨 chunk

### 3. Agent Function Calling
- ReAct 循环（≤3 轮自主决策 + 第 4 轮强制收敛），工具真实查询业务库：**查错题本 / 查作业 / 推荐练习**
- 前端渲染工具调用步骤气泡，回答自动结合学生个人错题数据

### 4. 语义缓存
- 相似问题余弦 >0.92 直接命中缓存（LRU 500 / TTL 24h / 按用户隔离 / 并发去重合并）
- 重复问题响应 **3.6s → 64ms**（约 56 倍），零 LLM 调用

### 5. 全链路量化埋点
- `my_chat_log`（首字耗时 / RAG 命中 / 融合分）+ `my_api_metric`（接口耗时/状态），`/ai/metrics/**` 输出 RAG 评测、缓存命中、慢接口 TOP5 等指标

## 技术栈

**后端** Java 17 · Spring Boot 3 · MyBatis · LangChain4j 0.36 · DeepSeek API · Redis
**管理端** Vue 2 · Element UI（基于 RuoYi 脚手架深度改造）
**小程序端** uni-app（教师端 / 学生端微信小程序）
**AI 工程** PyTorch · sentence-transformers · ONNX Runtime · InMemoryEmbeddingStore
**部署** 阿里云 ECS · Nginx 反向代理 · systemd 进程守护 · MySQL/Redis 数据迁移 · JVM 限堆 + swap

## 快速开始

```bash
# 1. 环境要求：JDK 17、MySQL 8、Redis、Maven 3.8+
mysql -uroot -e "CREATE DATABASE ai_study_helper DEFAULT CHARSET utf8mb4"
mysql -uroot ai_study_helper < sql/ai_study_helper.sql

# 2. 配置 AI Key（不提交到仓库）
#    方式一：环境变量  DEEPSEEK_API_KEY=sk-xxx
#    方式二：本地私有配置 ruoyi-admin/src/main/resources/application-local.yml（已被 .gitignore 忽略）

# 3. 启动后端（8081）
mvn -pl ruoyi-admin -am package -DskipTests
java -jar ruoyi-admin/target/ruoyi-admin.jar

# 4. 管理端（可选，需 Node 14+）
cd ruoyi-ui && npm install && npm run dev
```

小程序端用 HBuilderX 打开 `zhixue-student-ui` / `zhixue-teacher-ui`，运行到微信开发者工具即可（默认连接 `http://localhost:8081`）。

演示账号：学生端 `student001/123456`，教师端 `teacher001/123456`，管理端 `admin/admin123`。

## 项目结构

```
├── ruoyi-admin            # 启动模块 + AI Agent/RAG 相关 Controller（含 SSE 流式）
├── ruoyi-framework        # 框架核心（安全/认证/拦截器）
├── ruoyi-system           # 系统模块（用户/角色/菜单）
├── ruoyi-common           # 通用模块
├── aiassistant-serve      # AI 助手领域服务（对话/流式/语义缓存）
├── my*-serve              # 业务领域服务（错题本/作业/学情报告/通知等）
├── ruoyi-ui               # 管理端前端
├── zhixue-student-ui      # 学生端小程序（uni-app）
├── zhixue-teacher-ui      # 教师端小程序（uni-app）
├── sql                    # 数据库初始化脚本
└── docs/knowledge         # RAG 知识库示例文档
```

> 项目基于 RuoYi-Vue 开源脚手架二次开发，在此基础上完成了双登录体系（学生/教师独立登录）、AI 模块（RAG/Agent/流式/缓存/量化埋点）、通知体系与三端业务闭环的自研改造。

## License

[MIT](LICENSE)
