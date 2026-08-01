USE atguigudb;
SELECT 1 + 1,3 * 2
FROM DUAL;#dual是伪表，相当于临时创建一个

# * 代表表中所有字段,或者列
SELECT * FROM employees;

SELECT employee_id,last_name,salary 
FROM employees;

#列的别名
#as：alias（别名），可省略；""内部比如annual salary这种中间有空格的，不然就报错；中文可支持，因为这个是utf-8.
SELECT employee_id emp_id,last_name AS lname,department_id "部门id",salary * 12 "annual salary"
FROM employees

#查询员工部门（去重）
#未去重操作
SELECT department_id
FROM employees;

#去重操作distinct
SELECT DISTINCT department_id
FROM employees;

#空值参与运算
#空值null不等同于0，""
#如果null参与运算，结果都是空值
SELECT employee_id,salary 月工资,salary * (1 + commission_pct) * 12 年工资,commission_pct
FROM employees;#commission_pct为null的员工的年工资都成为空值null

#用ifnull，如果值存在，则使用原值进行运算，若不存在，就用0代替运算
SELECT employee_id,salary 月工资,salary * (1 + IFNULL(commission_pct,0) ) * 12 年工资,commission_pct
FROM employees;

#着重号`` 字段名或表名与保留字、关键字重名，需要用着重号引起来
#如果未重复字段名与表面用着重号``引用，不会报错
SELECT * FROM `order`;

#查询常数
#常数不单指数字，字符串也是常数，它会自动和每一行进行匹配
SELECT 'god',123,employee_id,salary
FROM employees;

#显示表结构
#显示表中字段的详细信息
DESCRIBE employees;
DESC employees;#简写

#过滤数据
#例，查询90号部门数据
SELECT *
FROM employees
WHERE department_id = 90;#过滤条件,要在from后面

#例，查询员工King的信息
SELECT *
FROM employees
WHERE last_name = 'King';






