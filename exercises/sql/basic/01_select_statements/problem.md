# Ejercicio 1: Consultas SELECT Básicas

## Objetivo
Practicar el uso de la cláusula SELECT para recuperar datos.

## Base de Datos
Utilizarás la base de datos `employees`:

```sql
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    hire_date DATE,
    salary DECIMAL(10,2),
    department_id INT
);
```

## Ejercicios

1. Selecciona todos los empleados
2. Muestra nombre, apellido y email
3. Ordena por apellido ascendente
4. Filtra por fecha de contratación > 2020-01-01
5. Encuentra empleados con salario > 50000
6. Limita a 10 resultados
7. Muestra department_id únicos
8. Calcula salario anual (salario * 12)
9. Concatena nombre completo
10. Agrupa por departamento con conteo
