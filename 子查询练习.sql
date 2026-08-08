#查询和zlotkey相同部门的员工姓名和工资
SELECT last_name,salary
FROM employees
WHERE department_id = (
                      SELECT department_id
                      FROM employees
                      WHERE last_name = 'Zlotkey'
                      );
                      
#查询工资比公司平均工资高的员工工号，姓名，工资
SELECT employee_id,last_name,salary
FROM employees
WHERE salary > (
                SELECT AVG(salary)
                FROM employees
                );
                
#选择工资大于所有job_id = 'sa_man'的员工工资的员工的姓名，jobid，工资
SELECT last_name,job_id,salary
FROM employees
WHERE salary > ALL (
                  SELECT salary
                  FROM employees
                  WHERE job_id = 'SA_MAN'
                  );
                  
#查询和姓名中包含字母u的员工在相同部门的员工工号和姓名
SELECT employee_id,last_name
FROM employees
WHERE department_id IN (
                      SELECT DISTINCT department_id
                      FROM employees
                      WHERE last_name LIKE '%u%'
                      );
                      
#查询部门在location_id为1700的部门的员工的员工号
SELECT employee_id
FROM employees
WHERE department_id IN (
                        SELECT department_id
                        FROM departments
                        WHERE location_id = 1700
                        );

#查询管理者是king的员工姓名和工资
SELECT last_name,salary
FROM employees
WHERE manager_id IN (
                    SELECT employee_id
                    FROM employees
                    WHERE last_name = 'King'
                    );

#查询工资最低的员工姓名和工资
SELECT last_name,salary
FROM employees
WHERE salary = (
                SELECT MIN(salary)
                FROM employees
                );

#查询平均工资最低的部门信息
#方式一：
SELECT *
FROM departments
WHERE department_id = (
                        SELECT department_id
                        FROM employees
                        GROUP BY department_id
                        HAVING AVG(salary) = (
                                              SELECT MIN(t_salary)
                                              FROM (SELECT AVG(salary) t_salary
                                                    FROM employees
                                                    GROUP BY department_id) t_dept_salary
                                              )
                                                  
                        );
  
#方式二：
SELECT *
FROM departments
WHERE department_id = (
                        SELECT department_id
                        FROM employees
                        GROUP BY department_id
                        HAVING AVG(salary) <= ALL (
                                                    SELECT AVG(salary) 
                                                    FROM employees
                                                    GROUP BY department_id
                                              )
                                                  
                        );

#方式三：LIMIT

SELECT *
FROM departments
WHERE department_id = (
                        SELECT department_id
                        FROM employees
                        GROUP BY department_id
                        HAVING AVG(salary) = (
                                              SELECT AVG(salary) avg_sal
                                              FROM employees
                                              GROUP BY department_id
                                              ORDER BY avg_sal
                                              LIMIT 1
                                              )
                       );


#方式四
SELECT d.*
FROM departments d,(
                    SELECT department_id,AVG(salary) avg_sal
                    FROM employees
                    GROUP BY department_id
                    ORDER BY avg_sal
                    LIMIT 1
                    ) min_avg_sal
WHERE d.department_id = min_avg_sal.department_id;

#查询平均工资最低的部门信息和该部门的平均工资（相关子查询）

SELECT d.*,(SELECT AVG(salary) FROM employees WHERE department_id = d.department_id) avg_sal
FROM departments d
WHERE department_id = (
                        SELECT department_id
                        FROM employees
                        GROUP BY department_id
                        HAVING AVG(salary) = (
                                              SELECT MIN(t_salary)
                                              FROM (SELECT AVG(salary) t_salary
                                                    FROM employees
                                                    GROUP BY department_id) t_dept_salary
                                              )
                                                  
                        );

#查询平均工资最高的job信息
#方式一：

SELECT *
FROM jobs
WHERE job_id = (
                  SELECT job_id
                  FROM employees
                  GROUP BY job_id
                  HAVING AVG(salary) = (
                                        SELECT MAX(avg_sal)
                                        FROM (SELECT AVG(salary) avg_sal
                                              FROM employees
                                              GROUP BY job_id) t_job_avg
                                        )
                  );

#查询平均工资高于公司平均工资的部门有哪些

SELECT department_id,AVG(salary)
FROM employees
GROUP BY department_id
HAVING AVG(salary) >= (
                       SELECT AVG(salary) avg_sal
                       FROM employees
                       );

#查出公司中所有manager的详细信息
#子查询
SELECT * 
FROM employees
WHERE employee_id IN (
                    SELECT manager_id
                    FROM employees
                    );

#EXISTS
SELECT *
FROM employees e1 
WHERE EXISTS (
              SELECT * 
              FROM employees e2
              WHERE e1.employee_id = e2.manager_id
              );



#查询各个部门中，最高工资最的的部门，的最低工资

#方式一：

SELECT MIN(salary)
FROM employees
WHERE department_id = (
                      SELECT department_id
                      FROM employees
                      GROUP BY department_id
                      HAVING MAX(salary) = (
                                            SELECT MIN(max_sal)
                                            FROM (
                                                  SELECT department_id,MAX(salary) max_sal
                                                  FROM employees
                                                  GROUP BY department_id
                                                  ) t_max_sal
                                            )

                      );

#方式二：
SELECT MIN(salary)
FROM employees
WHERE department_id = (
                      SELECT department_id
                      FROM employees
                      GROUP BY department_id
                      HAVING MAX(salary) <= ALL  (
                                                  SELECT MAX(salary)
                                                  FROM employees
                                                  GROUP BY department_id
                                                  )

                      );

#方式三：
SELECT MIN(salary)
FROM employees
WHERE department_id = (
                      SELECT department_id
                      FROM employees
                      GROUP BY department_id
                      HAVING MAX(salary) = (
                                             SELECT MAX(salary) max_sal
                                             FROM employees
                                             GROUP BY department_id
                                             ORDER BY max_sal
                                             LIMIT 1
                                            )

                      );

#方案四
SELECT MIN(salary)
FROM employees e,(
                 SELECT department_id,MAX(salary) max_sal
                 FROM employees
                 GROUP BY department_id
                 ORDER BY max_sal
                 LIMIT 1
                ) t_dept
WHERE e.department_id = t_dept.department_id;




































