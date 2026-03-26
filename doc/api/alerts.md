# 预警管理模块 API

## 接口列表

| 方法 | 路径 | 说明 |
|------|------|------|
| GET | /alert-rules | 获取预警规则列表 |
| POST | /alert-rules | 创建预警规则 |
| GET | /alert-rules/{id} | 获取预警规则详情 |
| PUT | /alert-rules/{id} | 更新预警规则 |
| DELETE | /alert-rules/{id} | 删除预警规则 |
| POST | /alert-rules/{id}/enable | 启用预警规则 |
| POST | /alert-rules/{id}/disable | 禁用预警规则 |
| GET | /alerts | 获取预警记录列表 |
| PUT | /alerts/{id}/status | 更新预警状态 |

---

## 接口详情

### 1. 获取预警规则列表

```
GET /api/v1/alert-rules
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
        "name": "高频词预警",
        "keywords": ["关键词 1"],
        "priority": "high",
        "status": "active",
        "trigger_count": 3
      }
    ],
    "total": 5
  }
}
```

---

### 2. 创建预警规则

```
POST /api/v1/alert-rules
```

**请求体**
```json
{
  "name": "新预警规则",
  "keywords": ["关键词 1", "关键词 2"],
  "triggers": [
    {
      "type": "keyword_frequency",
      "threshold": 100,
      "time_window": 3600
    }
  ],
  "notification": {
    "enabled": true,
    "channels": ["email", "dingtalk"],
    "priority": "high"
  }
}
```

**请求参数**
| 参数 | 类型 | 说明 |
|------|------|------|
| name | string | 规则名称 |
| keywords | array | 关键词列表 |
| triggers | array | 触发条件列表 |
| notification | object | 通知配置 |
| priority | string | 优先级：low/medium/high |

**响应**
```json
{
  "code": 201,
  "message": "预警规则创建成功",
  "data": {
    "rule_id": 1
  }
}
```

---

### 3. 获取预警规则详情

```
GET /api/v1/alert-rules/{id}
```

**响应**
```json
{
  "code": 200,
  "message": "success",
  "data": {
    "id": 1,
    "name": "高频词预警",
    "user_id": 1,
    "keywords": ["关键词 1", "关键词 2"],
    "triggers": [
      {
        "type": "keyword_frequency",
        "threshold": 100,
        "time_window": 3600
      }
    ],
    "notification_config": {
      "enabled": true,
      "channels": ["email", "dingtalk"],
      "priority": "high"
    },
    "status": "active",
    "last_triggered_at": "2024-01-01T12:00:00Z",
    "trigger_count": 3,
    "created_at": "2024-01-01T00:00:00Z"
  }
}
```

---

### 4. 更新预警规则

```
PUT /api/v1/alert-rules/{id}
```

**请求体**
```json
{
  "name": "更新后的规则名称",
  "keywords": ["新关键词"],
  "priority": "medium"
}
```

**响应**
```json
{
  "code": 200,
  "message": "预警规则更新成功",
  "data": null
}
```

---

### 5. 删除预警规则

```
DELETE /api/v1/alert-rules/{id}
```

**响应**
```json
{
  "code": 200,
  "message": "预警规则删除成功",
  "data": null
}
```

---

### 6. 启用预警规则

```
POST /api/v1/alert-rules/{id}/enable
```

**响应**
```json
{
  "code": 200,
  "message": "预警规则已启用",
  "data": null
}
```

---

### 7. 禁用预警规则

```
POST /api/v1/alert-rules/{id}/disable
```

**响应**
```json
{
  "code": 200,
  "message": "预警规则已禁用",
  "data": null
}
```

---

### 8. 获取预警记录列表

```
GET /api/v1/alerts?page=1&page_size=20&status=new
```

**查询参数**
| 参数 | 类型 | 说明 |
|------|------|------|
| page | int | 页码，默认 1 |
| page_size | int | 每页数量，默认 20 |
| status | string | 状态筛选：new/processing/resolved/ignored |
| priority | string | 优先级筛选：low/medium/high |

**响应**
```json
{
  "code": 200,
  "message": "success",
  "data": {
    "items": [
      {
        "id": 1,
        "rule_id": 1,
        "title": "预警标题",
        "priority": "high",
        "status": "new",
        "created_at": "2024-01-01T12:00:00Z"
      }
    ],
    "total": 10,
    "page": 1,
    "page_size": 20
  }
}
```

---

### 9. 更新预警状态

```
PUT /api/v1/alerts/{id}/status
```

**请求体**
```json
{
  "status": "processing"
}
```

**响应**
```json
{
  "code": 200,
  "message": "预警状态已更新",
  "data": null
}