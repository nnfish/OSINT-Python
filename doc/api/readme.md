# OpenOSINT API 接口文档

## API 概览

| 模块 | 文件 | 说明 |
|------|------|------|
| 认证 | [auth.md](auth.md) | 用户登录、注册、密码管理 |
| 采集任务 | [tasks.md](tasks.md) | 采集任务管理 |
| 情报数据 | [intelligence.md](intelligence.md) | 情报查询、搜索 |
| 分析报告 | [reports.md](reports.md) | 报告生成、管理 |
| 监控管理 | [monitors.md](monitors.md) | 监控配置、日志 |
| 预警管理 | [alerts.md](alerts.md) | 预警规则、记录 |
| 系统管理 | [admin.md](admin.md) | 用户、配置、日志管理 |

---

## 通用规范

### 基础路径

```
/api/v1
```

### 认证方式

在请求头中添加：
```
Authorization: Bearer <token>
```

### 响应格式

#### 成功响应
```json
{
  "code": 200,
  "message": "success",
  "data": {}
}
```

#### 错误响应
```json
{
  "code": 400,
  "message": "error message",
  "data": null
}
```

### 状态码

| 状态码 | 说明 |
|--------|------|
| 200 | 成功 |
| 201 | 创建成功 |
| 400 | 请求参数错误 |
| 401 | 未授权 |
| 403 | 禁止访问 |
| 404 | 资源不存在 |
| 500 | 服务器内部错误 |
