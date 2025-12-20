-- Ejemplos básicos de SELECT
-- Aprendiendo SQL - Capítulo 3

-- 1. SELECT simple
SELECT * FROM employees;

-- 2. Seleccionar columnas específicas
SELECT first_name, last_name, email 
FROM employees;

-- 3. Alias de columnas
SELECT 
    first_name AS nombre,
 last_name AS apellido,
    salary AS salario
FROM employees;

-- 4. Expresiones en SELECT
SELECT 
    first_name,
    last_name,
    salary,
    salary * 1.10 AS nuevo_salario
FROM employees;

-- 5. Funciones en SELECT
SELECT 
    UPPER(first_name) AS nombre_mayusculas,
    LOWER(last_name) AS apellido_minusculas,
    CONCAT(first_name, " ", last_name) AS nombre_completo,
    LENGTH(email) AS longitud_email
FROM employees;

-- 6. SELECT DISTINCT (valores únicos)
SELECT DISTINCT department_id FROM employees;

-- 7. SELECT con ORDER BY
SELECT first_name, last_name, salary
FROM employees
ORDER BY salary DESC;

-- 8. SELECT con LIMIT
SELECT first_name, last_name, salary
FROM employees
ORDER BY salary DESC
LIMIT 10;

-- 9. SELECT con OFFSET (paginación)
SELECT first_name, last_name, salary
FROM employees
ORDER BY salary DESC
LIMIT 10 OFFSET 10;  -- Página 2

-- 10. SELECT con todas las cláusulas
SELECT 
    department_id,
    COUNT(*) AS total_empleados,
    AVG(salary) AS salario_promedio,
    MAX(salary) AS salario_maximo,
    MIN(salary) AS salario_minimo
FROM employees
WHERE salary > 30000
GROUP BY department_id
HAVING COUNT(*) > 5
ORDER BY salario_promedio DESC
LIMIT 5;

