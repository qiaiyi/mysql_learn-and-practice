#查询公司员工工资的最大，最小，平均，总和
SELECT MAX(salary),MIN(salary),AVG(salary),SUM(salary)
FROM employees;

#查询各job_id员工工资的最大，最小，平均，总和
SELECT job_id,MAX(salary),MIN(salary),AVG(salary),SUM(salary)
FROM employees
GROUP BY job_id;

#选择具有各个job_id的员工人数
SELECT job_id,COUNT(*)
FROM employees
GROUP BY job_id;

#查询员工最高工资与最低工资的差距
SELECT MAX(salary) - MIN(salary) "DIFFERENE"
FROM employees;

#查询各个管理者手下员工的最低工资，其中最低工资不能低于6000，没有管理者的员工不计算在内
SELECT manager_id,MIN(salary)
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id
HAVING MIN(salary) >=6000;

#查询所有部门名字 location_id 员工数量和平均工资，并按平均工资降序
SELECT department_name,location_id,COUNT(employee_id),AVG(salary)
FROM employees e RIGHT JOIN departments d
ON e.department_id = d.department_id
GROUP BY department_name,location_id;


#查询每个工种，每个部门的工种名，部门名，最低工资
SELECT department_name,job_id,MIN(salary)
FROM employees e RIGHT JOIN departments d
ON e.department_id = d.department_id
GROUP BY e.job_id,d.department_name;
















