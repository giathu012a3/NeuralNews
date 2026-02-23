-- NeuralNews Database Schema

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS homepage_config;
DROP TABLE IF EXISTS search_history;
DROP TABLE IF EXISTS interactions;
DROP TABLE IF EXISTS reports;
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS articles;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS roles;
SET FOREIGN_KEY_CHECKS = 1;

-- Bảng Roles (Quyền hạn)
CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255)
);

-- 1. Bảng Users (Người dùng) - Gắn trực tiếp role_id
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    role_id INT NOT NULL DEFAULT 1,
    status ENUM('ACTIVE', 'PENDING', 'BANNED', 'SUSPENDED') DEFAULT 'ACTIVE',
    avatar_url VARCHAR(500),
    bio TEXT,
    experience_years INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE RESTRICT
);

-- 2. Bảng Categories (Danh mục)
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- 3. Bảng Articles (Bài viết)
CREATE TABLE articles (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    summary TEXT,
    image_url VARCHAR(500),
    author_id BIGINT,
    category_id INT,
    status ENUM('DRAFT', 'PUBLISHED', 'ARCHIVED', 'REJECTED') DEFAULT 'DRAFT',
    views INT DEFAULT 0,
    likes_count INT DEFAULT 0,
    sentiment_label VARCHAR(50),
    source_score INT,
    popularity_score FLOAT DEFAULT 0,
    published_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL
);

-- 4. Bảng Comments (Bình luận)
CREATE TABLE comments (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    content TEXT NOT NULL,
    article_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (article_id) REFERENCES articles(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 5. Bảng Reports (Báo cáo vi phạm)
CREATE TABLE reports (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    article_id BIGINT NOT NULL,
    reporter_id BIGINT,
    reason VARCHAR(100) NOT NULL,
    status ENUM('PENDING', 'Reviewed', 'DISMISSED', 'ACTION_TAKEN') DEFAULT 'PENDING',
    ai_analysis TEXT,
    ai_trust_score INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (article_id) REFERENCES articles(id) ON DELETE CASCADE,
    FOREIGN KEY (reporter_id) REFERENCES users(id) ON DELETE SET NULL
);

-- 6. Bảng Interactions (Tương tác)
CREATE TABLE interactions (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    article_id BIGINT NOT NULL,
    type ENUM('LIKE', 'BOOKMARK', 'VIEW') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (article_id) REFERENCES articles(id) ON DELETE CASCADE
);

-- 7. Bảng Lịch sử tìm kiếm (Search History)
CREATE TABLE search_history (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT,
    keyword VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 8. Bảng Cấu hình Trang chủ  (Homepage Config)
CREATE TABLE homepage_config (
    id INT AUTO_INCREMENT PRIMARY KEY,
    section_name VARCHAR(100),
    display_order INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    layout_type ENUM('GRID', 'LIST', 'CAROUSEL', 'HERO') DEFAULT 'GRID',
    display_columns INT DEFAULT 3,
    item_limit INT DEFAULT 6,
    data_source ENUM('LATEST', 'CATEGORY', 'TRENDING', 'FEATURED', 'CUSTOM_HTML') DEFAULT 'LATEST',
    category_id INT,
    html_content TEXT,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL
);

-- DATA MẪU (SAMPLE DATA)
INSERT INTO categories (name, description) VALUES 
('Technology', 'Latest tech news'), 
('Politics', 'Global politics'), 
('Health', 'Health and wellness');

-- Thêm dữ liệu mẫu cho Roles
INSERT INTO roles (name, description) VALUES
('USER', 'Người dùng bình thường, có thể đọc và bình luận'),
('JOURNALIST', 'Nhà báo, có quyền đăng tải và chỉnh sửa bài viết'),
('ADMIN', 'Quản trị viên hệ thống, toàn quyền kiểm soát');

-- Thêm dữ liệu mẫu Users kèm luôn role_id
INSERT INTO users (email, password_hash, full_name, role_id, status, bio, experience_years) VALUES
('admin@neuralnews.com', 'password123', 'Admin Stark', 3, 'ACTIVE', 'System administrator of NexusAI', 10),
('journalist@neuralnews.com', 'password123', 'Alex Rivera', 2, 'ACTIVE', 'Senior tech journalist with focus on AI.', 5),
('user@neuralnews.com', 'password123', 'John Doe', 1, 'ACTIVE', 'Regular user learning about AI', 0);

INSERT INTO homepage_config (section_name, display_order, layout_type, data_source, is_active, category_id, display_columns, item_limit, html_content) VALUES
('Hero Banner', 1, 'HERO', 'FEATURED', TRUE, NULL, 3, 6, NULL),
('Tech News Grid', 2, 'GRID', 'CATEGORY', TRUE, 1, 4, 8, NULL),
('Ad Banner', 3, 'GRID', 'CUSTOM_HTML', TRUE, NULL, 3, 6, '<div style="background:#f0f0f0; padding:20px; text-align:center;">Quảng Cáo Tại Đây</div>');
