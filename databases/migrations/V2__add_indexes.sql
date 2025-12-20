-- Migración V2: Agregar índices para optimización

-- Índices para la tabla users
CREATE INDEX idx_users_created_at ON users(created_at);
CREATE INDEX idx_users_updated_at ON users(updated_at);

-- Índices para la tabla courses
CREATE INDEX idx_courses_created_at ON courses(created_at);
CREATE INDEX idx_courses_duration ON courses(duration_hours);

-- Índices para la tabla exercises
CREATE INDEX idx_exercises_created_at ON exercises(created_at);
CREATE FULLTEXT INDEX idx_exercises_search ON exercises(title, description);

-- Tabla de logs para auditoría
CREATE TABLE IF NOT EXISTS audit_logs (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    action VARCHAR(50) NOT NULL,
    table_name VARCHAR(50),
    record_id INT,
    changes JSON,
    ip_address VARCHAR(45),
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_audit_user (user_id),
    INDEX idx_audit_action (action),
    INDEX idx_audit_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

