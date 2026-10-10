# 主页接口文档

前端页面：`pages/index.vue`  
接口定义：`api/home/index.js`  
Mock 数据：`api/home/mock.js`（当前 `USE_MOCK = true`，不请求后端）

后端按以下约定实现接口，完成后将 `api/home/index.js` 中 `USE_MOCK` 改为 `false`。

---

## 通用响应格式（若依标准）

```json
{
  "code": 200,
  "msg": "操作成功",
  "data": {}
}
```

---

## 1. 主页聚合数据（推荐）

**GET** `/edu/home/index`

`data` 结构：

```json
{
  "banners": [],
  "quickLinks": [],
  "todos": [],
  "courses": [],
  "stats": {}
}
```

---

## 2. 轮播图

**GET** `/edu/home/banners`

| 字段 | 类型 | 说明 |
|------|------|------|
| id | number | 主键 |
| title | string | 标题 |
| subtitle | string | 副标题 |
| imageUrl | string | 图片地址 |
| linkUrl | string | 点击跳转链接，可为空 |

---

## 3. 快捷入口

**GET** `/edu/home/quick-links`

| 字段 | 类型 | 说明 |
|------|------|------|
| id | number | 主键 |
| name | string | 显示名称 |
| icon | string | uni-icons 图标名，如 `images-filled` |
| bgColor | string | 背景色，如 `#EEF4FF` |
| iconColor | string | 图标色，如 `#3B82F6` |
| path | string | 跳转路径，可为空 |

---

## 4. 今日待办

**GET** `/edu/home/todos`

| 字段 | 类型 | 说明 |
|------|------|------|
| id | number | 主键 |
| title | string | 任务标题 |
| subtitle | string | 副标题（截止时间/耗时等） |
| accentColor | string | 左侧色条颜色 |
| buttonText | string | 按钮文字 |
| buttonColor | string | 按钮背景色 |
| path | string | 跳转路径，可为空 |

---

## 5. 推荐课程

**GET** `/edu/home/courses`

| 字段 | 类型 | 说明 |
|------|------|------|
| id | number | 主键 |
| title | string | 课程名 |
| instructor | string | 讲师 |
| lessonCount | number | 课时数 |
| progress | number | 学习进度 0-100 |
| coverUrl | string | 封面图 |
| path | string | 跳转路径，可为空 |

---

## 6. 学情报表

**GET** `/edu/home/stats`

| 字段 | 类型 | 说明 |
|------|------|------|
| todayStudyHours | number | 今日学习时长（小时） |
| weeklyHomeworkCount | number | 本周完成作业数 |
| accuracyRate | number | 答题正确率（百分比） |
| totalQuestions | number | 累计做题数 |

---

## 接入步骤

1. 后端实现以上接口
2. `config.js` 中 `baseUrl` 改为你的后端地址
3. `api/home/index.js` 中 `USE_MOCK` 改为 `false`
4. 重新运行前端项目
