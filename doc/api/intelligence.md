# 情报数据模块 API

## 接口列表

| 方法 | 路径 | 说明 |
|------|------|------|
| GET | /intelligence | 获取情报列表 |
| GET | /intelligence/{id} | 获取情报详情 |
| GET | /intelligence/search | 搜索情报 |
| DELETE | /intelligence/{id} | 删除情报 |

---

## 接口详情

### 1. 获取情报列表

```
GET /api/v1/intelligence?page=1&page_size=20&sentiment=all
```

**查询参数**
| 参数 | 类型 | 说明 |
|------|------|------|
| page | int | 页码，默认 1 |
| page_size | int | 每页数量，默认 20 |
| sentiment | string | 情感筛选：all/positive/negative/neutral |
| task_id | int | 任务 ID 筛选 |

**响应**
```json
{
  "code": 200,
  "message": "success",
  "data": {
    "items": [
      {
        "id": 1,
        "title": "情报标题",
        "source_type": "search_engine",
        "publish_time": "2024-01-01T00:00:00Z",
        "sentiment": "positive",
        "sentiment_score": 0.85
      }
    ],
    "total": 100,
    "page": 1,
    "page_size": 20,
    "total_pages": 5
  }
}
```

---

### 2. 获取情报详情

```
GET /api/v1/intelligence/{id}
```

**响应**
```json
{
  "code": 200,
  "message": "success",
  "data": {
    "id": 1,
    "title": "情报标题",
    "content": "情报内容...",
    "source_url": "https://example.com/article/1",
    "source_type": "search_engine",
    "author": "作者名",
    "publish_time": "2024-01-01T00:00:00Z",
    "sentiment": "positive",
    "sentiment_score": 0.85,
    "keywords": ["关键词 1", "关键词 2"],
    "entities": {
      "persons": ["人物 1"],
      "organizations": ["组织 1"],
      "locations": ["地点 1"]
    }
  }
}
```

---

### 3. 搜索情报

```
GET /api/v1/intelligence/search?q=关键词&page=1&page_size=20
```

**查询参数**
| 参数 | 类型 | 说明 |
|------|------|------|
| q | string | 搜索关键词 |
| page | int | 页码，默认 1 |
| page_size | int | 每页数量，默认 20 |
| start_date | string | 开始日期 |
| end_date | string | 结束日期 |

**响应**
```json
{
  "code": 200,
  "message": "success",
  "data": {
    "items": [
      {
        "id": 1,
        "title": "相关情报标题",
        "snippet": "内容摘要...",
        "publish_time": "2024-01-01T00:00:00Z"
      }
    ],
    "total": 50,
    "page": 1,
    "page_size": 20,
    "total_pages": 3
  }
}
```

---

### 4. 删除情报

```
DELETE /api/v1/intelligence/{id}
```

**响应**
```json
{
  "code": 200,
  "message": "删除成功",
  "data": null
}