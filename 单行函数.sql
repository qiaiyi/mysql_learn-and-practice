#单行函数


SELECT
ABS(123),ABS(-23),#ABS取绝对值
SIGN(12),SIGN(-23),SIGN(0),#SIGN，正数是1，负数是-1，0是0
PI(),#圆周率
CEIL(32.32),CEILING(-43.32),#天花板函数，向上取整
FLOOR(32.32),FLOOR(-43.23),#地板函数，向下取整
MOD(12,5)#取模，也就是取余，相当于 12%5
FROM DUAL;

SELECT RAND(),RAND(),RAND(10),RAND(10)#不带参数返回0~1随机数，带参数，参数相同时，返回的随机数一样
FROM DUAL;

#四舍五入
SELECT ROUND(123.456),ROUND(123.456,0),ROUND(123.456,1),ROUND(123.456,2),ROUND(123.456,-1)
FROM DUAL;

#截断操作，不考虑四舍五入，直接将后面数值去掉
SELECT TRUNCATE(123.678,0),TRUNCATE(123.678,1),TRUNCATE(123.678,2),TRUNCATE(123.678,-1)
FROM DUAL;

#开平方,,正数开平方，负数返回null
SELECT SQRT(3),SQRT(-2)
FROM DUAL;

#角度与弧度互换
SELECT RADIANS(30),RADIANS(45),RADIANS(60),RADIANS(90),#角度换弧度
DEGREES(2*PI()),DEGREES(PI()),DEGREES(RADIANS(60))
FROM DUAL;

#指数函数
SELECT POW(2,4),POWER(2,4),#这两个一个意思
EXP(2)#以e为底的指数
FROM DUAL;

#对数函数
SELECT LN(EXP(2)),LOG(2,8),LOG10(100),LOG2(16)
FROM DUAL;

#进制转换
SELECT BIN(10),HEX(10),OCT(10),#依次是2，16，8进制
CONV(10,10,2)#第一个参数是第二个参数进制下的值，转换为第三个参数进制，也就是将十进制下的10转换为二进制
FROM DUAL;

#字符串函数
#ASCII函数只返回开头字符的ASCII值
SELECT ASCII('a'),ASCII('asdf')
FROM DUAL;

#length和char-length
SELECT LENGTH('asdf'),LENGTH('我们'),#返回的是字符串所占的字节
CHAR_LENGTH('asdf'),CHAR_LENGTH('我们')#返回字符串的长度
FROM DUAL;

#连接字符串
SELECT CONCAT('hello ','god',' pig'),
CONCAT_WS(' ','hello','god','pig')#用第一个参数值连接后面的字符串，可以是空字符，也可以是横杠
FROM DUAL;

#替换字符串
SELECT INSERT('helloworld',2,3,'我们'),#2代表替换部分的开头位置，3代表替换掉多少个字符
REPLACE('hello','ll','我们')#ll是指替换掉的部分，我们是新部分，注意第二个参数不能写错，必须是原字符串存在的字符段
FROM DUAL;

#大小写转换
SELECT UPPER('hello'),LOWER('WHSIL')
FROM DUAL;

#左右取字符串
SELECT LEFT('asdfgh',2),RIGHT('asdfgh',2)#分别从最左边和最右边开始数
FROM DUAL;

#左右对齐
SELECT last_name,LPAD(salary,10,'*')#让所有工资的字符串位数补充至十位，在左边用*补（通常用空字符），最终右边都对齐；左对齐情况反之
FROM employees;

#去字符串空格
SELECT TRIM('  s d f g   ')
FROM DUAL;
#trim是首尾都去，ltrim是去左边，rtrim是去右边

#
SELECT REPEAT('asd',3),SPACE(6),#重复字符串和返回多少个空格
STRCMP('asd','asd')#比较两个字符串的ASCII大小，前减后，分别返回1，0，-1三个值对应三种情况
FROM DUAL;

#
SELECT SUBSTR('hello',2,2),#从字符串的第二个位置开始，返回两个长度的字符串
LOCATE('ll','hello')#返回substr'lll'在字符串中首次出现的位置，如果不匹配，返回0
FROM DUAL;


#
SELECT ELT(2,'a','b','n','v'),#返回第二个位置的字符串
FIELD('mm','nn','mm','rr','mm'),#返回第一个参数字符串，在后面字符串中首次出现的位置，后续不管
FIND_IN_SET('mm','aa,mm,d,f,mm,er')#返回mm在后面字符串首次出现的位置，其中后面的字符串是在一个‘’内，使用，隔开的
FROM DUAL;

#反转字符串
REVERSE(str)

#比较两个字符串
SELECT NULLIF('asd','azx'),NULLIF('asd','asd')#相同返回null，否则返回第一个字符串
FROM DUAL;

#时间与日期函数

#获取日期、时间
SELECT CURDATE(),CURRENT_DATE(),#返回当前日期，年月日，前者是简写
CURTIME(),CURRENT_TIME(),#返回当前时间，
NOW(),SYSDATE(),#系统当前日期与时间，两者相同，只是写法不一
UTC_DATE(),UTC_TIME()#国际标准日期和时间，格林尼治时间
FROM DUAL;

#日期与时间戳的转换
SELECT UNIX_TIMESTAMP(),UNIX_TIMESTAMP('2026-08-02 16:00:00'),#显示unix时间戳,也可自己设定时间
FROM_UNIXTIME(UNIX_TIMESTAMP())#将unix时间戳转为系统时间
FROM DUAL;

#日期操作函数
SELECT EXTRACT(SECOND FROM NOW())#秒，毫秒，小时，天，季度等等，将second替换掉即可
FROM DUAL;

#时间和秒钟转换
SELECT TIME_TO_SEC(CURTIME()),
SEC_TO_TIME(61608)
FROM DUAL;

#计算时间和日期的函数
SELECT NOW(),DATE_ADD(NOW(),INTERVAL 1 YEAR),#add是进行加运算，如果后面的数值是负数，可以当作减运算，相当于sub
#now（）可以更换为其他日期，只要格式对就行，year可以换成月日，时分秒等
DATE_ADD(NOW(),INTERVAL -1 YEAR),
DATE_SUB(NOW(),INTERVAL 1 YEAR)
FROM DUAL;

#格式化：
#日期
SELECT DATE_FORMAT(CURRENT_DATE(),'%Y-%M-%D'),#%ymd表示两位数字年份、月份，日期
DATE_FORMAT(NOW(),'%Y-%m-%d')
FROM DUAL;

#时间
SELECT TIME_FORMAT(CURTIME(),'%H:%i:%S'),
TIME_FORMAT(CURTIME(),'%h:%i:%S')#h是十二小时制写法
FROM DUAL;


#流程控制函数：
#IF(value,value1,value2),条件value成立，返回value1，否则返回value2
SELECT last_name,salary,IF(salary >= 7000,'高收入','低收入') "details"
FROM employees;

#IFNULL(value1,value2)是IF(value,value1,value2)的特殊情况，如果value1存在，返回value1，否则返回0
SELECT last_name,commission_pct,IFNULL(commission_pct,0)
FROM employees;

#CASE WHEN ... THEN ... WHEN ... THEN ... ELSE ... END
SELECT last_name,salary,CASE WHEN salary >= 15000 THEN 'god'
                             WHEN salary >= 10000 THEN 'niupi'
                             WHEN salary >= 7000 THEN 'yiban'
                             ELSE 'lawanle' END "details"
FROM employees;


#CASE ... WHEN ... THEN ... WHEN ... THEN ... ELSE ... END
#打印10，20，30号部门员工工资，10号1.1倍，20号1.2倍，30号1.3倍
SELECT last_name,department_id,salary,CASE department_id WHEN 10 THEN salary * 1.1
                                                         WHEN 20 THEN salary * 1.2
                                                         WHEN 30 THEN salary * 1.3
                                                         ELSE salary * 1.4 END "details"
FROM employees
WHERE department_id IN (10,20,30);


#加密与解密函数：
#password在MySQL8.0中弃用
SELECT MD5('mysql'),SHA('mysql')#加密后的结果都是不可逆的，且是唯一的
FROM DUAL;
#encode和decode在8.0中也不能用

#MySQL信息函数
SELECT VERSION(),CONNECTION_ID(),DATABASE(),SCHEMA(),
USER(),CURRENT_USER(),CHARSET('字符集'),COLLATION('起点')
FROM DUAL;


#其他函数
SELECT FORMAT(123.563,1),FORMAT(123.563,-1)#四舍五入，保留一位小数,如果n<=0，返回整数部分
FROM DUAL;

SELECT CONV(16,10,2)#进制转化，将十进制的16转为二进制
FROM DUAL;

SELECT INET_ATON('192.168.100.0'),#ip转数字
INET_NTOA('3232261120')#数字转ip
FROM DUAL;

SELECT BENCHMARK(10000,MD5('mysql'))#测试md5加密mysql一万次所花费的时间
FROM DUAL;

SELECT CHARSET('asdf'),CHARSET(CONVERT('asdf' USING 'utf8mb3'))#更改字符串的字符编码
FROM DUAL;
