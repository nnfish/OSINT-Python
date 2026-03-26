# 认证模块 API

## 接口列表

| 方法 | 路径 | 说明 |
|------|------|------|
| POST | /auth/login | 用户登录 |
| POST | /auth/register | 用户注册 |
| POST | /auth/logout | 用户登出 |
| GET | /auth/me | 获取当前用户 |
| PUT | /auth/password | 修改密码 |

---

## 接口详情

### 1. 用户登录

```
POST /api/v1/auth/login
```

**请求体**
```json
{
  "username": "admin",
  "password": "password123"
}
```

**响应**
```json
{
  "code": 200,
  "message": "success",
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "expires_in": 86400,
    "user": {
      "id": 1,
      "username": "admin",
      "role": "admin",
      "email": "admin@openosint.com"
    }
  }
}
```

---

### 2. 用户注册

```
POST /api/v1/auth/register
```

**请求体**
```json
{
  "username": "newuser",
  "password": "password123",
  "email": "user@example.com"
}
```

**响应**
```json
{
  "code": 201,
  "message": "注册成功，请等待管理员审核",
  "data": {
    "user_id": 2
  }
}
```

---

### 3. 用户登出

```
POST /api/v1/auth/logout
```

**响应**
```json
{
  "code": 200,
  "message": "success",
  "data": null
}
```

---

### 4. 获取当前用户信息

```
GET /api/v1/auth/me
```

**响应**
```json
{
  "code": 200,
  "message": "success",
  "data": {
    "id": 1,
    "username": "admin",
    "email": "admin@openosint.com",
    "role": "admin",
    "status": "active",
    "created_at": "2024-01-01T00:00:00Z",
    "last_login_at": "2024-01-01T12:00:00Z"
  }
}
```

---

### 5. 修改密码

```
PUT /api/v1/auth/password
```

**请求体**
```json
{
  "old_password": "oldpass123",
  "new_password": "newpass456"
}
```

**响应**
```json
{
  "code": 200,
  "message": "密码修改成功",
  "data": null
}