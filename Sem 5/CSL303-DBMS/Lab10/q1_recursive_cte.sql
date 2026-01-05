WITH RECURSIVE org AS (
    SELECT 
        employee_id,
        employee_name,
        manager_id,
        0 AS level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT 
        e.employee_id,
        e.employee_name,
        e.manager_id,
        o.level + 1
    FROM employees e
    JOIN org o ON e.manager_id = o.employee_id
)
SELECT * FROM org
ORDER BY level, employee_id;

