#常见聚合函数
#AVG平均数/SUM求和
#注意，这两个函数只能对数值变量有效，对字符串操作返回0
SELECT AVG(salary),SUM(salary)
FROM employees;

#MAX/MIN:适用于数值，字符串，日期时间等常用字段的求取
#对数值
SELECT MAX(salary),MIN(salary)
FROM employees;

#对字符串和日期
SELECT MAX(last_name),MIN(last_name),MAX(hire_date)
FROM employees;

#COUNT
#查询指定字段在结构中出现的个数（一行算一个）
SELECT COUNT(salary),COUNT(last_name),COUNT(1),COUNT(*)
FROM employees;

#计算表中有多少条记录
#COUNT(*)
#COUNT(1)
#COUNT(具体字段)，不可取，因为有的字段值为null，count对值为null的字段不计数，比如：
SELECT COUNT(commission_pct)
FROM employees;
#107条记录，运行只显示三十五条，因为其余人的奖金率都是null

#AVG = SUM / COUNT
#avg和sum都会将null过滤，所以公式成立
SELECT AVG(salary),SUM(salary) / COUNT(salary),
AVG(commission_pct),SUM(commission_pct) / COUNT(commission_pct),
SUM(commission_pct) / 107
FROM employees;

#查询工资平均奖金率（要把没有奖金的加进去做分母）
#直接avg奖金率不行，那只平均了三十五个人
SELECT SUM(commission_pct) / COUNT(IFNULL(commission_pct,0)),
AVG(IFNULL(commission_pct,0))
FROM employees;

#count统计表中记录数效率
#使用myisam引擎，三者效率一样
#使用inuodb引擎（8.0版本），count（*）=count（1）>count（具体字段）


#分组查询
#查询各个部门的平均工资
SELECT department_id,AVG(salary)
FROM employees
GROUP BY department_id;

SELECT department_id,job_id,AVG(salary)
FROM employees
GROUP BY department_id,job_id;

#select后面的字段，必须在group by后面声明，反之，group by后面的字段，可以不出现在select后面

#with rollup在原本按组排序的基础上，加一个所有字段的平均值
#rolluo和order by相互冲突，不能同时使用
SELECT department_id,AVG(salary)
FROM employees
GROUP BY department_id WITH ROLLUP;


#查询部门最高工资高于10000的部门信息
SELECT department_id,MAX(salary)
FROM employees
GROUP BY department_id
HAVING MAX(salary) >= 10000;
#要求1：过滤条件中出现聚合函数，对要用HAVING而不能用WHERE
#要求2：HAVING必须跟在group by后面
#要求3：使用HAVING的前提是出现GROUP BY

#查询部门号为10，20，30，40，四个部门最高工资高于一万的部门信息
#方式一：效率更高
SELECT department_id,MAX(salary)
FROM employees
WHERE department_id IN (10,20,30,40)
GROUP BY department_id
HAVING MAX(salary) >= 10000;

#方式二
SELECT department_id,MAX(salary)
FROM employees
GROUP BY department_id
HAVING MAX(salary) >= 10000 AND department_id IN (10,20,30,40);









