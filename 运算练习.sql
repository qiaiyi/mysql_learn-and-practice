#选择工资不再5000到12000范围内的员工姓名和工资
SELECT last_name,salary
FROM employees
WHERE salary NOT BETWEEN 5000 AND 12000;
#或
SELECT last_name,salary
FROM employees
WHERE salary <5000 OR salary > 12000;

#选择在部门20号或50号的员工姓名和部门号
SELECT department_id,last_name
FROM employees
WHERE department_id IN (20,50);

#选择没有管理者的员工姓名及job_id
SELECT last_name,job_id
FROM employees
WHERE manager_id IS NULL;

#选择有奖金的员工的姓名，工资，奖金级别
SELECT last_name,salary,commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;

#选择第三个字母是a的员工姓名
SELECT last_name
FROM employees
WHERE last_name LIKE '__a%';

#选择名字中有a和k的员工姓名
SELECT last_name
FROM employees
WHERE last_name LIKE '%a%k%' OR last_name LIKE '%k%a%';
#或
SELECT last_name
FROM employees
WHERE last_name LIKE '%a%' AND last_name LIKE '%k%';

#first_name以e结尾的员工信息
SELECT first_name,last_name,salary
FROM employees
WHERE first_name LIKE '%e';
#或正则写法
SELECT first_name,last_name,salary
FROM employees
WHERE first_name REGEXP 'e$';#以e开头用：'^e'













