# 分析报告模块 API

## 接口列表

| 方法 | 路径 | 说明 |
|------|------|------|
| GET | /reports | 获取报告列表 |
| POST | /reports/analyze | 生成分析报告 |
| GET | /reports/{id} | 获取报告详情 |
| POST | /reports/{id}/export | 导出报告 |
| PUT | /reports/{id}/favorite | 收藏报告 |
| DELETE | /reports/{id} | 删除报告 |

---

## 接口详情

### 1. 获取报告列表

```
GET /api/v1/reports?page=1&page_size=20&status=all
```

**查询参数**
| 参数 | 类型 | 说明 |
|------|------|------|
| page | int | 页码，默认 1 |
| page_size | int | 每页数量，默认 20 |
| status | string | 状态筛选：all/draft/published/archived |
| favorite | boolean | 仅看收藏 |

**响应**
```json
{
  "code": 200,
  "message": "success",
  "data": {
    "items": [
      {
        "id": 1,
        "title": "分析报告标题",
        "summary": "报告摘要...",
        "value_rating": "high",
        "status": "published",
        "is_favorite": false,
        "view_count": 10,
        "created_at": "2024-01-01T00:00:00Z"
      }
    ],
    "total": 20,
    "page": 1,
    "page_size": 20
  }
}
```

---

### 2. 生成分析报告

```
POST /api/v1/reports/analyze
```

**请求体**
```json
{
  "keywords": ["关键词 1", "关键词 2"],
  "time_range": {
    "start": "2024-01-01T00:00:00Z",
    "end": "2024-01-31T23:59:59Z"
  },
  "format": "markdown"
}
```

**请求参数**
| 参数 | 类型 | 说明 |
|------|------|------|
| keywords | array | 分析关键词 |
| time_range | object | 时间范围 |
| format | string | 输出格式：markdown/pdf |

**响应**
```json
{
  "code": 201,
  "message": "报告生成中",
  "data": {
    "report_id": 1
  }
}
```

---

### 3. 获取报告详情

```
GET /api/v1/reports/{id}
```

**响应**
```json
{
  "code": 200,
  "message": "success",
  "data": {
    "id": 1,
    "title": "分析报告标题",
    "summary": "报告摘要...",
    "content": "# 分析报告\n\n## 一、报告摘要\n...",
    "format": "markdown",
    "value_rating": "high",
    "status": "published",
    "keywords": ["关键词 1", "关键词 2"],
    "created_at": "2024-01-01T00:00:00Z"
  }
}
```

---

### 4. 导出报告

```
POST /api/v1/reports/{id}/export
```

**请求体**
```json
{
  "format": "pdf"
}
```

**响应**
```json
{
  "code": 200,
  "message": "导出成功",
  "data": {
    "download_url": "/api/v1/reports/1/download"
  }
}
```

---

### 5. 收藏/取消收藏报告

```
PUT /api/v1/reports/{id}/favorite
```

**请求体**
```json
{
  "is_favorite": true
}
```

**响应**
```json
{
  "code": 200,
  "message": "操作成功",
  "data": null
}
```

---

### 6. 删除报告

```
DELETE /api/v1/reports/{id}
```

**响应**
```json
{
  "code": 200,
  "message": "删除成功",
  "data": null
}