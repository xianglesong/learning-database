-- 5
-- user database
use course;

SELECT MOD(29,9);
SELECT ASCII('2');
SELECT CONCAT('My', 'S', 'QL');
SELECT LEFT('foobarbar', 5);
SELECT LENGTH('text');
SELECT REPLACE('www.mysql.com', 'w', 'Ww');
SELECT SUBSTRING('Sakila', 5, 3);
SELECT ADDDATE('1998-01-02', 31);
SELECT CURTIME();
SELECT CURDATE();
SELECT CURDATE() + 0;
SELECT DATEDIFF('1997-12-31 23:59:59','1997-12-30');
SELECT DATE_FORMAT('1997-10-04 22:23:00', '%W %M %Y');
SELECT DAYOFWEEK('1998-02-03');

-- 
SELECT USER();
SELECT DATABASE();

-- create function
USE `course`;

DROP function IF EXISTS `test_function`;

-- create function
-- DELIMITER： sql语句是否结束标志，如下$$表示开始，则遇到$$才结束。最后继续使用默认的;进行sql语句结束标志。
DELIMITER $$
USE `course`$$
CREATE FUNCTION test_function (s CHAR(20)) 
RETURNS CHAR(50)
BEGIN
  RETURN CONCAT('Hello, ',s,'!');
END$$
DELIMITER ;

-- call function
SELECT test_function('world');

-- drop function
DROP FUNCTION test_function;
