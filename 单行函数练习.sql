#显示系统日期＋时间
SELECT NOW(),SYSDATE(),CURRENT_TIMESTAMP(),LOCALTIMESTAMP(),LOCALTIME()
FROM DUAL;

#查询员工工号，姓名，工资，以及工资提高百分之二十之后的结果
SELECT employee_id,last_name,salary,salary * 1.2 "new salary"
FROM employees;

#将员工姓名按首字母排序，并显示姓名的长度
SELECT last_name,LENGTH(last_name)
FROM employees
ORDER BY last_name;

#查询员工id，姓名，工资，并作为一个列输出
SELECT CONCAT(employee_id,last_name,salary) out_put
FROM employees;

#查询各员工工作的年数，工作的天数，并按工作年数降序排序
SELECT employee_id,DATEDIFF(CURDATE(),hire_date)/365 "work_years",DATEDIFF(CURRENT_DATE(),hire_date) "work_days",
TO_DAYS(CURRENT_DATE()) - TO_DAYS(hire_date) "work_days1"
FROM employees
ORDER BY work_years DESC;

#查询员工姓名，hire_date,department_name。雇佣时间是1997年之后，部门号为80，90，110，且奖金率不为空
SELECT last_name,hire_date,department_id
FROM employees
WHERE department_id IN (80,90,110)
AND commission_pct IS NOT NULL
#AND hire_date >= '1997-01-01';#存在隐式转换
#AND DATE_FORMAT(hire_date,'%Y-%m-%d') >= '1997-01-01';#显示转化，将招募日期转为字符串（格式化）
#AND DATE_FORMAT(hire_date,'%Y') >= '1997';#也可以只转换年份，此题可以
AND hire_date >= STR_TO_DATE('1997-01-01','%Y-%m-%d');#字符串转换为日期（解析）

#查询入职10000天的员工，姓名和入职时间
SELECT last_name,hire_date
FROM employees
WHERE DATEDIFF(CURDATE(),hire_date) >= 10000;



