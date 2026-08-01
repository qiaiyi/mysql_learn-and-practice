#算术运算符：+ - * / div % mod
SELECT 100,100 + 10,100 - 20,10 * 10,100 + 50 * 3,100 - 30.5,100 - 30.5
FROM DUAL;

#sql中，+ 只进行算术运算，没有任何相连的作用，字符串会被转为数值（隐式转换）
SELECT 100 + '1'
FROM DUAL;

SELECT 100 + 'a'
FROM DUAL;#此时的'a'被当作0

SELECT 100 + NULL
FROM DUAL;#空值参与运算，结果为空

SELECT 100,100 * 1,100 * 1.0,100 / 1,100 / 1.0,100 / 2,100 / 3,100 DIV 0,100 + 2 * 5 / 2
FROM DUAL;#分母为0，结果为null

#取模运算（取余）% mod
SELECT 12 % 3,12 % 5,12 % -5,-12 % 5, -12 % -5
FROM DUAL; 

#例，查询id为偶数的员工信息
SELECT employee_id,last_name,salary
FROM employees
WHERE employee_id % 2 = 0;


#比较运算符：= <=> <> != < > <= >=
SELECT 1 = 2,1 != 2, 1 = '1',1 = 'a',0 = 'a'#字符串隐式转换。如果转换数值不成功，比如'a'就会转为0
FROM DUAL;

SELECT 'a' = 'a','a' = 'b'#两边都是字符串，不进行隐式转换，按照ASCII数值进行字符串比较
FROM DUAL;

SELECT 1 = NULL,NULL = NULL#有null参与，结果都是null
FROM DUAL;

#安全等于 <=> ;专门用于比较存在null值的字段
SELECT 1 <=> NULL,NULL <=> NULL
FROM DUAL;

#例，查询commission_pct为null的员工工资
SELECT last_name,salary,commission_pct
FROM employees
WHERE commission_pct <=> NULL;

#IS NULL \ IS NOT NULL \ ISNULL
#例，查询commission_pct为null的员工工资
SELECT last_name,salary,commission_pct
FROM employees
WHERE commission_pct IS NULL;
#或
SELECT last_name,salary,commission_pct
FROM employees
WHERE ISNULL(commission_pct);#函数ISNULL

#例，查询commission_pct不为null的员工工资
SELECT last_name,salary,commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;
#或
SELECT last_name,salary,commission_pct
FROM employees
WHERE NOT commission_pct <=> NULL;

#LEAST \ GREATEST 取最大最小
SELECT LEAST('b','m','t','x'),GREATEST('b','m','t','x')
FROM DUAL;

#BETWEEN  条件1（下界） AND 条件2（上界）包含两个边界
#查询工资在6000到8000之间的员工信息
SELECT last_name,salary,commission_pct
FROM employees
WHERE salary BETWEEN 6000 AND 8000;
#或
SELECT last_name,salary,commission_pct
FROM employees
WHERE salary >= 6000 AND salary <=8000;

#查询不在这个区间的
SELECT last_name,salary,commission_pct
FROM employees
WHERE salary NOT BETWEEN 6000 AND 8000;
#或
SELECT last_name,salary,commission_pct
FROM employees
WHERE salary <= 6000 OR salary >=8000;

#IN(set) \ NOT IN(set)   set:集合
#查询在部门号为10，20，30的员工信息
SELECT employee_id,last_name,salary
FROM employees
WHERE department_id IN (10,20,30);

#LIKE：模糊查询
#查找名字中存在a的员工,代表不确定个数的字符（0个，一个，或多个）
SELECT last_name
FROM employees
WHERE last_name LIKE '%a%';

#查询名字以a开头的员工
SELECT last_name
FROM employees
WHERE last_name LIKE 'a%';#去掉一个代表字符的%，这样a就在最前面

#查找名字中存在a和e的员工
SELECT last_name
FROM employees
WHERE last_name LIKE '%a%' AND last_name LIKE '%e%';
#或
SELECT last_name
FROM employees
WHERE last_name LIKE '%a%e%' OR last_name LIKE '%e%a%';

#查询名字第二个字母是a的员工
SELECT last_name
FROM employees
WHERE last_name LIKE '_a%';#一个下划线_占一个位置，代表一个不确定字符，如果查询第三个字母为a，就用两个下划线_

#要求第二个是_,且第三个是a
#用转义字符\
SELECT last_name
FROM employees
WHERE last_name LIKE '_\_a%';












