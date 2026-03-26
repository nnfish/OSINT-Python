# 监控管理模块 API

## 接口列表

| 方法 | 路径 | 说明 |
|------|------|------|
| GET | /monitors | 获取监控列表 |
| POST | /monitors | 创建监控 |
| GET | /monitors/{id} | 获取监控详情 |
| PUT | /monitors/{id} | 更新监控 |
| DELETE | /monitors/{id} | 删除监控 |
| POST | /monitors/{id}/enable | 启用监控 |
| POST | /monitors/{id}/disable | 禁用监控 |
| GET | /monitors/{id}/logs | 获取监控日志 |

---

## 接口详情

### 1. 获取监控列表

```
GET /api/v1/monitors
```

**响应**
```json
{
  "code": 200,
  "message": "success",
  "data": {
    "items": [
      {
        "id": 1,
        "name": "关键词监控",
        "keywords": ["关键词 1"],
        "status": "active",
        "last_triggered_at": "2024-01-01T12:00:00Z",
        "trigger_count": 5
      }
    ],
    "total": 10
  }
}
```

---

### 2. 创建监控

```
POST /api/v1/monitors
```

**请求体**
```json
{
  "name": "新监控任务",
  "keywords": ["关键词 1", "关键词 2"],
  "conditions": {
    "min_count": 10,
    "time_range": 3600
  },
  "notification": {
    "enabled": true,
    "channels": ["email", "dingtalk"]
  },
  "check_interval": 300
}
```

**请求参数**
| 参数 | 类型 | 说明 |
|------|------|------|
| name | string | 监控名称 |
| keywords | array | 关键词列表 |
| conditions | object | 监控条件 |
| notification | object | 通知配置 |
| check_interval | int | 检查间隔（秒） |

**响应**
```json
{
  "code": 201,
  "message": "监控创建成功",
  "data": {
    "monitor_id": 1
  }
}
```

---

### 3. 获取监控详情

```
GET /api/v1/monitors/{id}
```

**响应**
```json
{
  "code": 200,
  "message": "success",
  "data": {
    "id": 1,
    "name": "关键词监控",
    "user_id": 1,
    "keywords": ["关键词 1", "关键词 2"],
    "conditions": {
      "min_count": 10,
      "time_range": 3600
    },
    "notification_config": {
      "enabled": true,
      "channels": ["email", "dingtalk"]
    },
    "status": "active",
    "last_triggered_at": "2024-01-01T12:00:00Z",
    "trigger_count": 5,
    "created_at": "2024-01-01T00:00:00Z"
  }
}
```

---

### 4. 更新监控

```
PUT /api/v1/monitors/{id}
```

**请求体**
```json
{
  "name": "更新后的监控名称",
  "keywords": ["新关键词"],
  "check_interval": 600
}
```

**响应**
```json
{
  "code": 200,
  "message": "监控更新成功",
  "data": null
}
```

---

### 5. 删除监控

```
DELETE /api/v1/monitors/{id}
```

**响应**
```json
{
  "code": 200,
  "message": "监控删除成功",
  "data": null
}
```

---

### 6. 启用监控

```
POST /api/v1/monitors/{id}/enable
```

**响应**
```json
{
  "code": 200,
  "message": "监控已启用",
  "data": null
}
```

---

### 7. 禁用监控

```
POST /api/v1/monitors/{id}/disable
```

**响应**
```json
{
  "code": 200,
  "message": "监控已禁用",
  "data": null
}
```

---

### 8. 获取监控日志

```
GET /api/v1/monitors/{id}/logs?page=1&page_size=20
```

**响应**
```json
{
  "code": 200,
  "message": "success",
  "data": {
    "items": [
      {
        "id": 1,
        "triggered_at": "2024-01-01T12:00:00Z",
        "matched_keywords": ["关键词 1"],
        "count": 15,
        "notified": true
      }
    ],
    "total": 50,
    "page": 1,
    "page_size": 20
  }
}