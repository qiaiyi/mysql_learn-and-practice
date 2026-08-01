#多表查询
#必须实现两个或多个表之间的连接条件
#否则会出现交叉连接（笛卡尔积），每个员工与每个岗位都匹配一边，能正常运行，但结果是错误的，且数据庞大。
SELECT employee_id,department_name
FROM employees,departments
WHERE employees.department_id = departments.department_id;
#两个表的连接条件，让相同字段名指定为同一个量

#查询中出现多个表都存在的字段，必须指明字段所在的表名，如employees.department_id
SELECT employee_id,department_name,employees.department_id
FROM employees,departments
WHERE employees.department_id = departments.department_id;
#多表查询时，尽量每个字段都在前面加上表名，方便sql优化


#可以给表起别名。在select和where中使用表的别名
#起了表的别名之后，只能用别名，不能再用原名
SELECT e.employee_id,d.department_name,e.department_id,l.city,l.location_id
FROM employees e,departments d,locations l
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id;
#如果有n个表相连，那么至少要有n-1个相连条件


/*多表查询分类

角度1：等值连接 非等值连接

角度2：自连接 非自连接

角度3：内连接 外连接

*/

#等值连接例子如上，通过相同字段名进行连接
#非等值连接例子：选取员工姓名及工资等级
SELECT e.last_name,e.salary,j.grade_level
FROM employees e,job_grades j
WHERE e.salary BETWEEN j.lowest_sal AND j.highest_sal;

#自连接
#自己跟自己连接，相当于两个相同的表，找到关键字段名，进行相连
#如，查询员工id，员工姓名，以及管理者id，管理者姓名
#关联点可理解为，第一个表是所有员工表，第二个表单独把管理抽出来，又列了一个相同结构的表
SELECT emp.employee_id,emp.last_name,mag.employee_id,mag.last_name
FROM employees emp,employees mag
WHERE emp.manager_id = mag.employee_id;


#内连接，类似于交集
#SQL92，92版本的外连接在MySQL中不支持，只能使用内连接
#如，查询员工姓名和部门名称
SELECT e.last_name,d.department_id
FROM employees e,departments d#在92版本中，用，间隔开就行
WHERE e.department_id = d.department_id;
#运行结果显示106条，这是两者取了交集，107名员工中有一个人没有部门。如果想要查询所有员工部门信息，那就得用外连接

#99版本语法实现内连接，用JOIN 新加入连接的表 ON 与连接内已有表的关系，建立新连接
SELECT last_name,department_name,city
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN locations l ON d.location_id = l.location_id;
#内连接使用INNER JOIN，innner可以省略，默认为内连接
#如果再加入一个新表，再补充一个join on即可
#以location为例

#外连接，SQL99语法实现，92的（+）在MySQL中无法实现
#查询所有员工的姓名与部门名称

#左外连接：
#例，查询所有员工的姓名与工作部门。（这里提到所有，内连接取交集肯定用不了，返回的结果会少一个无部门之人
SELECT last_name,department_name
FROM employees e
LEFT OUTER JOIN departments d #outer可省略
ON e.department_id = d.department_id;

#右外连接：（不符合这个题目要求）
#因为有些部门并没有员工，就像是有一个员工没有部门一样，只不过这里要补全多个null
SELECT last_name,department_name
FROM employees e
RIGHT OUTER JOIN departments d 
ON e.department_id = d.department_id;

#满外连接：
#理论上的语法是FULL OUTER JOIN,但MySQL不支持改语法，就像不支持92语法中的外连接左右用+一个道理，在Oracle中所有语法都能用


#UNION和UNION ALL
#UNION：会执行去重操作，两个存在交集的集合取并集，会去掉重复的交集部分
#UNION ALL：不会执行去重，也就是多了一个交集部分，即两部分交集
#如果结果数据不存在重复，或者非必要去重，优先选择UNION ALL，提高查询效率

#全连接的实现，依靠集合A和B的视图。
#如：左外连接为集合A，右外连接为集合B
#实现全外连接，即A和B的并集
#可通过A U (B - (A交B））实现
#集合A
SELECT last_name,department_name
FROM employees e
LEFT OUTER JOIN departments d 
ON e.department_id = d.department_id
UNION ALL#将两个集合并在一起，实现满外连接
#集合B-(A交B）
SELECT last_name,department_name
FROM employees e
RIGHT OUTER JOIN departments d 
ON e.department_id = d.department_id
WHERE e.department_id IS NULL;

#99新语法，自然连接:
#自然连接，自动匹配表之间的相同字段名，等值连接
#缺点是不够灵活，因为有的时候只匹配两个表中的一个字段，但自然查询会默认全部匹配，使用情况受限
SELECT employee_id,last_name,department_name
FROM employees e
NATURAL JOIN departments d;
#等效于：
SELECT employee_id,last_name,department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
AND e.manager_id = d.manager_id;

#99新语法，USING：
SELECT employee_id,last_name,department_name
FROM employees e
JOIN departments d
USING(department_id);
#能够简化等值连接的条件，使代码更简洁




















