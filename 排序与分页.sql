#排序

#如果不进行排序操作，那查询到的信息，是按照写入顺序呈现出来
SELECT * FROM employees;

#按照salary排序，呈现出员工信息
#ORDER BY用于排序操作
#DESC从高到底，降序
#ASC从低到高，升序

#降序
SELECT employee_id,last_name,salary
FROM employees
ORDER BY salary DESC;

#升序
SELECT employee_id,last_name,salary
FROM employees
ORDER BY salary ASC;#如果不带asc，依旧是升序，因为默认排序是从低到高

#使用列的别名进行排序
SELECT last_name,salary,salary * 12 annual_salary
FROM employees
ORDER BY annual_salary DESC;

#对列的别名进行操作时，只能用ORDER BY，但不能用WHERE，会报错
SELECT last_name,salary,salary * 12 annual_salary
FROM employees
WHERE annual_salary > 10000 ;#运行会报错，做个示范

#如果同时有WHERE和ORDER BY，WHERE一定紧跟FROM后面
SELECT last_name,salary,salary * 12 annual_salary
FROM employees
WHERE salary >5000
ORDER BY annual_salary DESC;

#二级排序（多级排序） 
#显示员工信息，按照deparment_id升序，按照salary降序
SELECT  employee_id,last_name,department_id,salary
FROM employees
ORDER BY department_id ASC,salary DESC;


#分页
#LIMIT 位置偏移量，条目数
#如果位置偏移量为0，那么可省略，只写条目数
#返回按工资排序的员工信息，每页二十人
SELECT last_name,salary
FROM employees
ORDER BY salary DESC
LIMIT 20,20;

#LIMIT 条目数 OFFSET 偏移量
SELECT last_name,salary
FROM employees
ORDER BY salary DESC
LIMIT 2 OFFSET 31;



#排序分页练习

#查询员工姓名和部门号和年薪，年薪降序，姓名升序
SELECT last_name,department_id,salary * 12 annual_salary
FROM employees
ORDER BY annual_salary DESC,last_name;

#选择工资不在8000到17000范围的员工姓名和工资，按工资降序，显示21到40位置的数据
SELECT last_name,salary
FROM employees
WHERE salary NOT BETWEEN 8000 AND 17000
ORDER BY salary DESC
LIMIT 20,20;

#查询邮箱中包含e的员工信息，先按邮箱字节数降序，再按部门号升序
SELECT last_name,department_id,email,employee_id
FROM employees
#WHERE email LIKE '%e%'
WHERE email REGEXP '[e]'#正则查询是否存在e
ORDER BY LENGTH(email) DESC,department_id;



