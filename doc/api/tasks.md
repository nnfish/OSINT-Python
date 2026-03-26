# 采集任务模块 API

## 接口列表

| 方法 | 路径 | 说明 |
|------|------|------|
| GET | /tasks | 获取任务列表 |
| POST | /tasks | 创建采集任务 |
| GET | /tasks/{id} | 获取任务详情 |
| PUT | /tasks/{id} | 更新任务 |
| DELETE | /tasks/{id} | 删除任务 |
| POST | /tasks/{id}/start | 启动任务 |
| POST | /tasks/{id}/stop | 停止任务 |
| GET | /tasks/{id}/progress | 获取任务进度 |

---

## 接口详情

### 1. 获取任务列表

```
GET /api/v1/tasks?page=1&page_size=20&status=all
```

**查询参数**
| 参数 | 类型 | 说明 |
|------|------|------|
| page | int | 页码，默认 1 |
| page_size | int | 每页数量，默认 20 |
| status | string | 状态筛选：all/pending/running/completed/failed/cancelled |

**响应**
```json
{
  "code": 200,
  "message": "success",
  "data": {
    "items": [
      {
        "id": 1,
        "name": "舆情监控任务",
        "keywords": ["关键词 1", "关键词 2"],
        "status": "running",
        "progress": 50,
        "result_count": 100,
        "created_at": "2024-01-01T00:00:00Z"
      }
    ],
    "total": 10,
    "page": 1,
    "page_size": 20,
    "total_pages": 1
  }
}
```

---

### 2. 创建采集任务

```
POST /api/v1/tasks
```

**请求体**
```json
{
  "name": "新采集任务",
  "keywords": ["关键词 1", "关键词 2"],
  "sources": [
    {"type": "search_engine", "name": "baidu"},
    {"type": "rss", "url": "https://example.com/rss"}
  ],
  "schedule": {
    "type": "once",
    "start_time": "2024-01-01T00:00:00Z"
  },
  "max_results": 1000
}
```

**请求参数**
| 参数 | 类型 | 说明 |
|------|------|------|
| name | string | 任务名称 |
| keywords | array | 关键词列表 |
| sources | array | 数据源配置 |
| schedule | object | 调度配置 |
| max_results | int | 最大结果数 |

**响应**
```json
{
  "code": 201,
  "message": "任务创建成功",
  "data": {
    "task_id": 1
  }
}
```

---

### 3. 获取任务详情

```
GET /api/v1/tasks/{id}
```

**响应**
```json
{
  "code": 200,
  "message": "success",
  "data": {
    "id": 1,
    "name": "舆情监控任务",
    "user_id": 1,
    "keywords": ["关键词 1", "关键词 2"],
    "sources": [...],
    "schedule": {...},
    "status": "running",
    "progress": 50,
    "result_count": 100,
    "created_at": "2024-01-01T00:00:00Z",
    "started_at": "2024-01-01T01:00:00Z"
  }
}
```

---

### 4. 更新任务

```
PUT /api/v1/tasks/{id}
```

**请求体**
```json
{
  "name": "更新后的任务名",
  "keywords": ["新关键词"],
  "max_results": 2000
}
```

**响应**
```json
{
  "code": 200,
  "message": "任务更新成功",
  "data": null
}
```

---

### 5. 删除任务

```
DELETE /api/v1/tasks/{id}
```

**响应**
```json
{
  "code": 200,
  "message": "任务删除成功",
  "data": null
}
```

---

### 6. 启动任务

```
POST /api/v1/tasks/{id}/start
```

**响应**
```json
{
  "code": 200,
  "message": "任务已启动",
  "data": null
}
```

---

### 7. 停止任务

```
POST /api/v1/tasks/{id}/stop
```

**响应**
```json
{
  "code": 200,
  "message": "任务已停止",
  "data": null
}
```

---

### 8. 获取任务进度

```
GET /api/v1/tasks/{id}/progress
```

**响应**
```json
{
  "code": 200,
  "message": "success",
  "data": {
    "progress": 75,
    "current_step": "正在采集社交媒体数据",
    "estimated_remaining": 300
  }
}