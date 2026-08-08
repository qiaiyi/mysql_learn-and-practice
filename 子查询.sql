#谁的工资比abel高？
#方式一：
SELECT last_name,salary
FROM employees
WHERE last_name = 'Abel';

SELECT last_name ,salary
FROM employees
WHERE salary > 11000;

#方式二：自连接
SELECT e2.last_name,e2.salary
FROM employees e1,employees e2
WHERE e2.salary > e1.salary
AND e1.last_name = 'Abel';

#方式三：子查询
SELECT last_name,salary
FROM employees
WHERE salary > (

                SELECT salary
                FROM employees
                WHERE last_name = 'Abel'

                );



#单行子查询
#查询工资大于149号员工的工人信息
SELECT last_name,employee_id,salary
FROM employees
WHERE salary > (
                SELECT salary
                FROM employees
                WHERE employee_id = 149
                );

#查询job_id与员工141号相同，工资比143号多的员工姓名，job_id,工资
SELECT last_name,job_id,salary
FROM employees
WHERE job_id = (
                SELECT job_id
                FROM employees
                WHERE employee_id = 141
                )
AND salary > (
                SELECT salary
                FROM employees
                WHERE employee_id = 143
                );

#返回公司工资最少的员工的姓名，jobid，工资
SELECT last_name,job_id,salary
FROM employees
WHERE salary = (
                SELECT MIN(salary)
                FROM employees
                );

#HAVING子查询
#查询最低工资大于50号部门最低工资的部门id和其最低工资
SELECT department_id,MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) > (
                      SELECT MIN(salary)
                      FROM employees
                      WHERE department_id = 50
                      );

















