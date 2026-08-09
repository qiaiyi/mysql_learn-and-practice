#创建和管理数据库
#创建数据库

#方式一：
CREATE DATABASE mytest1;

SHOW CREATE DATABASE mytest1;

#方式二：显示指明创建数据库的字符集
CREATE DATABASE mytest2 CHARACTER SET 'gbk';

SHOW CREATE DATABASE mytest2;

#如果要创建的数据库已存在，则创建不成功，但不会报错
CREATE DATABASE IF NOT EXISTS mytest2 CHARACTER SET 'utf8';
#如果不存在，则创建成功
CREATE DATABASE IF NOT EXISTS mytest3 CHARACTER SET 'utf8';

#管理数据库
#查看当前连接中都有哪些数据库（目录）
SHOW DATABASES;

#切换数据库
USE atguigudb;

#查看当前数据库保存的表
SHOW TABLES;

#查看当前使用的数据库
SELECT DATABASE() FROM DUAL;

#查看指定数据库下保存的数据表
SHOW TABLES FROM mysql;


#修改数据库（数据库名没法修改）
#修改数据库字符集
ALTER DATABASE mytest2 CHARACTER SET 'utf8';

#删除数据库
#方式一，如果数据库本身不存在，会报错
DROP DATABASE mytest1;

#方式二，如果存在则执行，不存在不会报错
DROP DATABASE IF EXISTS mytest1; 

DROP DATABASE IF EXISTS mytest2; 


#创建数据表
#方式一
CREATE TABLE IF NOT EXISTS myempl(
id INT,
emp_name VARCHAR(15),
hire_date DATE
);
#查看表结构
DESC myempl;
DESCRIBE myempl;

SHOW CREATE TABLE myempl;

#查看表数据
SELECT * FROM myempl;

#方式二，基于现有的表
CREATE TABLE myempl1
AS
SELECT employee_id,last_name,salary
FROM employees;

DESC myempl1;

SELECT * FROM myempl1;#数据也同步过来

#查询语句中的别名，会作为新表的字段名称
CREATE TABLE myempl2
AS
SELECT e.employee_id emp_id,e.last_name emp_name,d.department_name
FROM employees e JOIN departments d
ON e.department_id = d.department_id;

SELECT * FROM myempl2;

#创建一个表 memployee_blanks，实现对employees的复制，不包含表数据
CREATE TABLE memployee_blanks
AS
SELECT *
FROM employees
WHERE 1 = 2;#设定一个不可能存在的条件，过滤掉表的所有数据，只保留字段名

SELECT * FROM memployee_blanks;

#修改表 ALTER TABLE
DESC myempl;

#添加一个字段
ALTER TABLE myempl
ADD salary DOUBLE(10,2);#默认会将字段添加至表尾

ALTER TABLE myempl
ADD phone_number VARCHAR (20) FIRST;#指定位置，添加至首位

ALTER TABLE myempl
ADD email VARCHAR(45) AFTER emp_name;#指定位置，在哪个字段后面

#修改一个字段
#通常不会修改数据类型
#修改长度
ALTER TABLE myempl
MODIFY phone_number VARCHAR (30);

#修改长度和默认值，默认值从原来的null变为设定的‘aaa’
ALTER TABLE myempl
MODIFY emp_name VARCHAR (20) DEFAULT 'aaa';

#重命名字段
ALTER TABLE myempl
CHANGE emp_name last_name VARCHAR (20);

#删除字段
ALTER TABLE myempl
DROP salary;


#重命名表
#方式一（推荐）RENAME
RENAME TABLE myempl
TO emp1;

#方式二
ALTER TABLE myempl1
RENAME TO emp2;

#删除表
DROP TABLE IF EXISTS myempl2;

#清空表
TRUNCATE TABLE emp1;