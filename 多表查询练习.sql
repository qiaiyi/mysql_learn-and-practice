#显示所有员工的姓名，部门号，部门名称
SELECT e.last_name,e.department_id,d.department_name
FROM employees e
LEFT OUTER JOIN departments d
ON e.department_id = d.department_id;

#查询90号部门的员工job_id和90号部门的location_id
SELECT e.job_id,d.location_id
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
WHERE d.department_id = 90;

#选择所有有奖金员工的last_name deparment_name location_id city
SELECT e.last_name,d.department_name,l.location_id,l.city
FROM employees e
LEFT JOIN departments d ON e.department_id =  d.department_id
LEFT JOIN locations l ON d.location_id = l.location_id
WHERE e.commission_pct IS NOT NULL;

#选择city在Toronto的员工的last_name job_id department_id department_name
SELECT e.last_name,e.job_id,d.department_id,d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
JOIN locations l
ON d.location_id = l.location_id
WHERE l.city = 'Toronto';


