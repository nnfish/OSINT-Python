# 系统管理模块 API

## 接口列表

| 方法 | 路径 | 说明 |
|------|------|------|
| GET | /admin/users | 获取用户列表 |
| PUT | /admin/users/{id}/status | 更新用户状态 |
| PUT | /admin/users/{id}/role | 更新用户角色 |
| DELETE | /admin/users/{id} | 删除用户 |
| GET | /admin/data-sources | 获取数据源列表 |
| POST | /admin/data-sources | 创建数据源 |
| PUT | /admin/data-sources/{id} | 更新数据源 |
| DELETE | /admin/data-sources/{id} | 删除数据源 |
| GET | /admin/configs | 获取系统配置 |
| PUT | /admin/configs/{key} | 更新系统配置 |
| GET | /admin/logs | 获取系统日志 |

---

## 接口详情

### 1. 获取用户列表

```
GET /api/v1/admin/users?page=1&page_size=20&status=all
```

**查询参数**
| 参数 | 类型 | 说明 |
|------|------|------|
| page | int | 页码，默认 1 |
| page_size | int | 每页数量，默认 20 |
| status | string | 状态筛选：all/active/pending/disabled |
| role | string | 角色筛选：all/admin/user |

**响应**
```json
{
  "code": 200,
  "message": "success",
  "data": {
    "items": [
      {
        "id": 1,
        "username": "admin",
        "email": "admin@openosint.com",
        "role": "admin",
        "status": "active",
        "created_at": "2024-01-01T00:00:00Z",
        "last_login_at": "2024-01-01T12:00:00Z"
      }
    ],
    "total": 10,
    "page": 1,
    "page_size": 20
  }
}
```

---

### 2. 更新用户状态

```
PUT /api/v1/admin/users/{id}/status
```

**请求体**
```json
{
  "status": "active"
}
```

**响应**
```json
{
  "code": 200,
  "message": "用户状态已更新",
  "data": null
}
```

---

### 3. 更新用户角色

```
PUT /api/v1/admin/users/{id}/role
```

**请求体**
```json
{
  "role": "admin"
}
```

**响应**
```json
{
  "code": 200,
  "message": "用户角色已更新",
  "data": null
}
```

---

### 4. 删除用户

```
DELETE /api/v1/admin/users/{id}
```

**响应**
```json
{
  "code": 200,
  "message": "用户删除成功",
  "data": null
}
```

---

### 5. 获取数据源列表

```
GET /api/v1/admin/data-sources
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
        "name": "百度搜索引擎",
        "type": "search_engine",
        "url": "https://www.baidu.com",
        "status": "active",
        "created_at": "2024-01-01T00:00:00Z"
      }
    ],
    "total": 5
  }
}
```

---

### 6. 创建数据源

```
POST /api/v1/admin/data-sources
```

**请求体**
```json
{
  "name": "新数据源",
  "type": "rss",
  "url": "https://example.com/rss",
  "config": {}
}
```

**响应**
```json
{
  "code": 201,
  "message": "数据源创建成功",
  "data": {
    "source_id": 1
  }
}
```

---

### 7. 更新数据源

```
PUT /api/v1/admin/data-sources/{id}
```

**请求体**
```json
{
  "name": "更新后的数据源名称",
  "status": "inactive"
}
```

**响应**
```json
{
  "code": 200,
  "message": "数据源更新成功",
  "data": null
}
```

---

### 8. 删除数据源

```
DELETE /api/v1/admin/data-sources/{id}
```

**响应**
```json
{
  "code": 200,
  "message": "数据源删除成功",
  "data": null
}
```

---

### 9. 获取系统配置

```
GET /api/v1/admin/configs
```

**响应**
```json
{
  "code": 200,
  "message": "success",
  "data": {
    "smtp_host": "",
    "smtp_port": "587",
    "smtp_user": "",
    "dingtalk_webhook": "",
    "llm_api_key": "",
    "llm_api_url": "https://dashscope.aliyuncs.com/compatible-mode/v1",
    "llm_model": "qwen-plus"
  }
}
```

---

### 10. 更新系统配置

```
PUT /api/v1/admin/configs/{key}
```

**请求体**
```json
{
  "value": "smtp.example.com"
}
```

**响应**
```json
{
  "code": 200,
  "message": "配置更新成功",
  "data": null
}
```

---

### 11. 获取系统日志

```
GET /api/v1/admin/logs?page=1&page_size=20&module=all
```

**查询参数**
| 参数 | 类型 | 说明 |
|------|------|------|
| page | int | 页码，默认 1 |
| page_size | int | 每页数量，默认 20 |
| module | string | 模块筛选 |
| status | string | 状态筛选：all/success/failure |

**响应**
```json
{
  "code": 200,
  "message": "success",
  "data": {
    "items": [
      {
        "id": 1,
        "user_id": 1,
        "action": "login",
        "module": "auth",
        "description": "用户登录",
        "ip_address": "192.168.1.1",
        "status": "success",
        "created_at": "2024-01-01T12:00:00Z"
      }
    ],
    "total": 100,
    "page": 1,
    "page_size": 20
  }
}