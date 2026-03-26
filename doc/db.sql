-- ============================================================
-- OpenOSINT 互联网舆情采集分析系统 - 数据库初始化脚本
-- ============================================================

-- 创建数据库
CREATE DATABASE IF NOT EXISTS openosint DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE openosint;

-- ============================================================
-- 1. 用户表
-- ============================================================
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL COMMENT '用户名',
    password_hash VARCHAR(255) NOT NULL COMMENT '密码哈希',
    email VARCHAR(100) COMMENT '邮箱',
    role ENUM('admin', 'user') DEFAULT 'user' COMMENT '角色',
    status ENUM('active', 'pending', 'disabled') DEFAULT 'pending' COMMENT '状态',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    last_login_at TIMESTAMP NULL COMMENT '最后登录时间',
    INDEX idx_username (username),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- ============================================================
-- 2. 数据源表
-- ============================================================
CREATE TABLE data_sources (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL COMMENT '数据源名称',
    type ENUM('search_engine', 'social_media', 'website', 'rss') NOT NULL COMMENT '类型',
    url VARCHAR(500) COMMENT 'URL 地址',
    config JSON COMMENT '配置信息',
    status ENUM('active', 'inactive') DEFAULT 'active' COMMENT '状态',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_type (type),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='数据源表';

-- ============================================================
-- 3. 采集任务表
-- ============================================================
CREATE TABLE tasks (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL COMMENT '任务名称',
    user_id INT NOT NULL COMMENT '用户 ID',
    keywords JSON NOT NULL COMMENT '关键词列表',
    sources JSON NOT NULL COMMENT '数据源配置',
    schedule JSON COMMENT '调度配置',
    max_results INT DEFAULT 1000 COMMENT '最大结果数',
    status ENUM('pending', 'running', 'completed', 'failed', 'cancelled') DEFAULT 'pending' COMMENT '状态',
    progress INT DEFAULT 0 COMMENT '进度百分比',
    result_count INT DEFAULT 0 COMMENT '结果数量',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    started_at TIMESTAMP NULL COMMENT '开始时间',
    completed_at TIMESTAMP NULL COMMENT '完成时间',
    error_message TEXT COMMENT '错误信息',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='采集任务表';

-- ============================================================
-- 4. 情报数据表
-- ============================================================
CREATE TABLE intelligence (
    id INT PRIMARY KEY AUTO_INCREMENT,
    task_id INT COMMENT '任务 ID',
    title VARCHAR(500) NOT NULL COMMENT '标题',
    content TEXT COMMENT '内容',
    source_url VARCHAR(500) COMMENT '来源 URL',
    source_type VARCHAR(50) COMMENT '来源类型',
    author VARCHAR(100) COMMENT '作者',
    publish_time TIMESTAMP NULL COMMENT '发布时间',
    collected_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '采集时间',
    sentiment ENUM('positive', 'negative', 'neutral') DEFAULT 'neutral' COMMENT '情感倾向',
    sentiment_score DECIMAL(3,2) COMMENT '情感分数',
    keywords JSON COMMENT '关键词',
    entities JSON COMMENT '实体信息',
    raw_data JSON COMMENT '原始数据',
    INDEX idx_task_id (task_id),
    INDEX idx_publish_time (publish_time),
    INDEX idx_sentiment (sentiment),
    FULLTEXT INDEX idx_title_content (title, content)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='情报数据表';

-- ============================================================
-- 5. 关键词表
-- ============================================================
CREATE TABLE keywords (
    id INT PRIMARY KEY AUTO_INCREMENT,
    word VARCHAR(100) NOT NULL COMMENT '关键词',
    category VARCHAR(50) COMMENT '分类',
    weight DECIMAL(3,2) DEFAULT 1.0 COMMENT '权重',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    UNIQUE KEY uk_word (word),
    INDEX idx_category (category)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='关键词表';

-- ============================================================
-- 6. 分析报告表
-- ============================================================
CREATE TABLE reports (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(500) NOT NULL COMMENT '报告标题',
    user_id INT NOT NULL COMMENT '用户 ID',
    task_id INT COMMENT '任务 ID',
    keywords JSON COMMENT '关键词',
    summary TEXT COMMENT '摘要',
    content LONGTEXT COMMENT '报告内容',
    format ENUM('markdown', 'pdf') DEFAULT 'markdown' COMMENT '格式',
    value_rating ENUM('high', 'medium', 'low') DEFAULT 'medium' COMMENT '价值评级',
    status ENUM('draft', 'published', 'archived') DEFAULT 'draft' COMMENT '状态',
    is_favorite BOOLEAN DEFAULT FALSE COMMENT '是否收藏',
    view_count INT DEFAULT 0 COMMENT '查看次数',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_status (status),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='分析报告表';

-- ============================================================
-- 7. 监控配置表
-- ============================================================
CREATE TABLE monitors (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL COMMENT '监控名称',
    user_id INT NOT NULL COMMENT '用户 ID',
    keywords JSON NOT NULL COMMENT '关键词列表',
    conditions JSON COMMENT '监控条件',
    notification_config JSON COMMENT '通知配置',
    schedule JSON COMMENT '调度配置',
    status ENUM('active', 'inactive') DEFAULT 'active' COMMENT '状态',
    last_triggered_at TIMESTAMP NULL COMMENT '最后触发时间',
    trigger_count INT DEFAULT 0 COMMENT '触发次数',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='监控配置表';

-- ============================================================
-- 8. 预警规则表
-- ============================================================
CREATE TABLE alert_rules (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL COMMENT '规则名称',
    user_id INT NOT NULL COMMENT '用户 ID',
    keywords JSON NOT NULL COMMENT '关键词列表',
    triggers JSON NOT NULL COMMENT '触发条件',
    notification_config JSON COMMENT '通知配置',
    priority ENUM('low', 'medium', 'high') DEFAULT 'medium' COMMENT '优先级',
    status ENUM('active', 'inactive') DEFAULT 'active' COMMENT '状态',
    last_triggered_at TIMESTAMP NULL COMMENT '最后触发时间',
    trigger_count INT DEFAULT 0 COMMENT '触发次数',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_status (status),
    INDEX idx_priority (priority)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='预警规则表';

-- ============================================================
-- 9. 预警记录表
-- ============================================================
CREATE TABLE alerts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    rule_id INT NOT NULL COMMENT '规则 ID',
    title VARCHAR(500) NOT NULL COMMENT '预警标题',
    content TEXT COMMENT '预警内容',
    trigger_data JSON COMMENT '触发数据',
    priority ENUM('low', 'medium', 'high') DEFAULT 'medium' COMMENT '优先级',
    status ENUM('new', 'processing', 'resolved', 'ignored') DEFAULT 'new' COMMENT '状态',
    notified BOOLEAN DEFAULT FALSE COMMENT '是否已通知',
    notified_at TIMESTAMP NULL COMMENT '通知时间',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    resolved_at TIMESTAMP NULL COMMENT '解决时间',
    FOREIGN KEY (rule_id) REFERENCES alert_rules(id) ON DELETE CASCADE,
    INDEX idx_rule_id (rule_id),
    INDEX idx_status (status),
    INDEX idx_priority (priority)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='预警记录表';

-- ============================================================
-- 10. 通知记录表
-- ============================================================
CREATE TABLE notifications (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL COMMENT '用户 ID',
    type ENUM('email', 'dingtalk', 'sms') NOT NULL COMMENT '通知类型',
    channel VARCHAR(50) COMMENT '渠道',
    recipient VARCHAR(200) COMMENT '接收者',
    subject VARCHAR(200) COMMENT '主题',
    content TEXT COMMENT '内容',
    status ENUM('pending', 'sent', 'failed') DEFAULT 'pending' COMMENT '状态',
    error_message TEXT COMMENT '错误信息',
    sent_at TIMESTAMP NULL COMMENT '发送时间',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='通知记录表';

-- ============================================================
-- 11. 定时报告配置表
-- ============================================================
CREATE TABLE scheduled_reports (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL COMMENT '报告名称',
    user_id INT NOT NULL COMMENT '用户 ID',
    keywords JSON NOT NULL COMMENT '关键词列表',
    schedule JSON NOT NULL COMMENT '调度配置',
    output_config JSON COMMENT '输出配置',
    status ENUM('active', 'inactive') DEFAULT 'active' COMMENT '状态',
    last_run_at TIMESTAMP NULL COMMENT '最后运行时间',
    next_run_at TIMESTAMP NULL DEFAULT NULL COMMENT '下次运行时间',
    run_count INT DEFAULT 0 COMMENT '运行次数',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='定时报告配置表';

-- ============================================================
-- 12. 系统日志表
-- ============================================================
CREATE TABLE system_logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT COMMENT '用户 ID',
    action VARCHAR(100) NOT NULL COMMENT '操作',
    module VARCHAR(50) COMMENT '模块',
    description TEXT COMMENT '描述',
    ip_address VARCHAR(50) COMMENT 'IP 地址',
    user_agent VARCHAR(200) COMMENT '用户代理',
    status ENUM('success', 'failure') DEFAULT 'success' COMMENT '状态',
    error_message TEXT COMMENT '错误信息',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    INDEX idx_user_id (user_id),
    INDEX idx_action (action),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统日志表';

-- ============================================================
-- 13. 系统配置表
-- ============================================================
CREATE TABLE system_configs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    config_key VARCHAR(100) UNIQUE NOT NULL COMMENT '配置键',
    config_value TEXT COMMENT '配置值',
    config_type VARCHAR(50) COMMENT '配置类型',
    description VARCHAR(500) COMMENT '描述',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    updated_by INT COMMENT '更新人',
    INDEX idx_key (config_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统配置表';

-- ============================================================
-- 初始化数据
-- ============================================================

-- 插入默认管理员用户 (密码：123456)
-- 密码哈希使用 bcrypt 算法生成
INSERT INTO users (username, password_hash, email, role, status) 
VALUES ('admin', '$2b$12$KIXxYp7ryzWz8Vzq5JZtqOqGzq5JZtqOqGzq5JZtqOqGzq5JZtqO', 'admin@openosint.com', 'admin', 'active');

-- 插入默认数据源
INSERT INTO data_sources (name, type, url, status) VALUES
('百度搜索引擎', 'search_engine', 'https://www.baidu.com', 'active'),
('谷歌搜索引擎', 'search_engine', 'https://www.google.com', 'active'),
('微博', 'social_media', 'https://weibo.com', 'active'),
('Twitter', 'social_media', 'https://twitter.com', 'active'),
('默认 RSS', 'rss', '', 'inactive');

-- 插入默认系统配置
INSERT INTO system_configs (config_key, config_value, config_type, description) VALUES
('smtp_host', '', 'string', 'SMTP 服务器地址'),
('smtp_port', '587', 'integer', 'SMTP 端口'),
('smtp_user', '', 'string', 'SMTP 用户名'),
('smtp_password', '', 'string', 'SMTP 密码'),
('dingtalk_webhook', '', 'string', '钉钉机器人 Webhook'),
('llm_api_key', '', 'string', '大语言模型 API 密钥'),
('llm_api_url', 'https://dashscope.aliyuncs.com/compatible-mode/v1', 'string', '大语言模型 API 地址'),
('llm_model', 'qwen-plus', 'string', '大语言模型名称');

-- ============================================================
-- 视图定义
-- ============================================================

-- 任务统计视图
CREATE OR REPLACE VIEW v_task_stats AS
SELECT 
    status,
    COUNT(*) as count
FROM tasks
GROUP BY status;

-- 情报情感分布视图
CREATE OR REPLACE VIEW v_sentiment_stats AS
SELECT 
    sentiment,
    COUNT(*) as count
FROM intelligence
GROUP BY sentiment;

-- 预警统计视图
CREATE OR REPLACE VIEW v_alert_stats AS
SELECT 
    priority,
    status,
    COUNT(*) as count
FROM alerts
GROUP BY priority, status;

-- ============================================================
-- 结束
-- ============================================================