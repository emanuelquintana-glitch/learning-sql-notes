-- Migración V3: Procedimientos almacenados y funciones

DELIMITER $$

-- Procedimiento para obtener estadísticas de usuario
CREATE PROCEDURE GetUserStatistics(IN useid INT)
BEGIN
    SELECT 
        u.username,
        u.email,
        COUNT(DISTINCT e.id) as total_exercises,
        COUNT(DISTINCT c.id) as total_courses,
        MIN(e.created_at) as first_exercise_date,
        MAX(e.created_at) as last_exercise_date
    FROM users u
    LEFT JOIN exercises e ON e.id IN (SELECT id FROM exercises WHERE created_by = user_id)
    LEFT JOIN courses c ON c.id IN (SELECT course_id FROM exercises WHERE created_by = user_id)
    WHERE u.id = user_id
    GROUP BY u.id;
END$$

2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE avg_difficulty DECIMAL(3,2);
    
    SELECT AVG(
        CASE difficulty
            WHEN "easy" THEN 1
            WHEN "medium" THEN 2
            WHEN "hard" THEN 3
            ELSE 0
        END
    ) INTO avg_difficulty
    FROM exercises
    WHERE course_id = course_id_param;
    
    RETURN COALESCE(avg_difficulty, 0);
END$$

-- Trigger para actualizar timestamp
CREATE TRIGGER before_user_update
BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END$$

DELIMITER ;

