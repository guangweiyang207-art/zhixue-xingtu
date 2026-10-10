# 主页后端服务

为 RuoYi-App 主页提供真实数据的 Spring Boot 接口。

## 启动

```bash
cd ruoyi-home-server
mvn spring-boot:run
```

服务地址：`http://localhost:8088`

## 接口列表

| 方法 | 路径 | 说明 |
|------|------|------|
| GET | `/edu/home/index` | 主页聚合数据（推荐） |
| GET | `/edu/home/banners` | 轮播图 |
| GET | `/edu/home/quick-links` | 快捷入口 |
| GET | `/edu/home/todos` | 今日待办 |
| GET | `/edu/home/courses` | 推荐课程 |
| GET | `/edu/home/stats` | 学情报表 |

响应格式（若依标准）：

```json
{
  "code": 200,
  "msg": "操作成功",
  "data": { }
}
```

## 数据存储

使用 H2 文件数据库，首次启动自动写入示例数据，数据文件在 `data/homedb.mv.db`。

H2 控制台：`http://localhost:8088/h2-console`

## 前端配置

`config.js` 中 `homeBaseUrl` 指向本服务：

```js
homeBaseUrl: 'http://localhost:8088'
```

小程序调试时需改为本机局域网 IP，并在微信开发者工具中关闭「校验合法域名」。
