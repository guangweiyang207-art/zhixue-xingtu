# 约课接口文档

前端页面：`pages/book/index.vue` 和 `pages/yueke/index.vue`  
接口定义：`api/yueke/yueke.js`  
Mock 数据：`api/yueke/mock.js`（当前 `USE_MOCK = true`，不请求后端）

后端按以下约定实现接口，完成后将 `api/yueke/yueke.js` 中 `USE_MOCK` 改为 `false`。

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

## 1. 课程预约

**POST** `/course/appointment/add`

请求参数：

| 字段 | 类型 | 必填 | 说明 |
|------|------|------|------|
| stu_id | number | 是 | 学生ID |
| c_id | number | 是 | 课程ID |
| remark | string | 否 | 预约备注 |

响应数据：

```json
{
  "ca_id": 1,
  "stu_id": 1,
  "c_id": 1,
  "remark": "希望安排在上午",
  "status": 0,
  "create_time": "2026-05-30 10:00:00"
}
```

---

## 2. 获取我的预约列表

**GET** `/course/appointment/myList`

请求参数：

| 字段 | 类型 | 必填 | 说明 |
|------|------|------|------|
| stu_id | number | 是 | 学生ID |

响应数据：

```json
[
  {
    "ca_id": 1,
    "stu_id": 1,
    "c_id": 999,
    "course_name": "高二数学：立体几何深度解析",
    "course_time": "19:00-20:30",
    "remark": "",
    "status": 0,
    "create_time": "2026-05-30 10:00:00"
  }
]
```

---

## 3. 取消预约

**POST** `/course/appointment/cancel`

请求参数：

| 字段 | 类型 | 必填 | 说明 |
|------|------|------|------|
| ca_id | number | 是 | 预约ID |

响应数据：

```json
{
  "ca_id": 1,
  "status": 1
}
```

---

## 4. 获取课程列表

**GET** `/course/list`

响应数据：

```json
[
  {
    "c_id": 1,
    "name": "初中物理：力学基础突破",
    "time": "周六 14:00",
    "count": "24/30人",
    "type": "physics",
    "icon": "⚛"
  },
  {
    "c_id": 2,
    "name": "英语口语：模拟面试实战",
    "time": "周日 10:00",
    "count": "12/20人",
    "type": "english",
    "icon": "文A"
  }
]
```

---

## 接入步骤

1. 后端实现以上4个接口
2. `config.js` 中 `baseUrl` 改为你的后端地址（确保后端已配置CORS跨域）
3. `api/yueke/yueke.js` 中 `USE_MOCK` 改为 `false`
4. 重新运行前端项目

---

## 注意事项

1. **status 字段说明**：
   - `0`: 待确认/已预约
   - `1`: 已取消
   - `2`: 已完成
   - `3`: 已拒绝

2. **后端需要处理的业务逻辑**：
   - 检查课程是否还有剩余名额
   - 检查学生是否已经预约过该课程
   - 发送预约通知（可选）

3. **错误码处理**：
   - `400`: 参数错误
   - `404`: 课程不存在
   - `409`: 已经预约过该课程
   - `500`: 服务器内部错误
