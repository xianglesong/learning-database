-- 10
-- user database
use course;

-- create procedure
-- DELIMITER： sql语句是否结束标志，如下$$表示开始，则遇到$$才结束。最后继续使用默认的;进行sql语句结束标志。
-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `test_cursor`(out result varchar(90))
BEGIN

DECLARE done INT DEFAULT FALSE;
  DECLARE a CHAR(32);
  DECLARE b INT;
  DECLARE c varchar(1024);
  DECLARE cur1 CURSOR FOR SELECT id,student_no FROM course.student;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur1;
  read_loop: LOOP
    FETCH cur1 INTO a, b;
     IF done THEN
      LEAVE read_loop;
    END IF;
	select concat_ws(',',result,a,b) into result;
  END LOOP;

  CLOSE cur1;

END$$

DELIMITER ;
-- end procedure
-- ------------------------------------------------------------------------------------------------

-- call procedure
call test_cursor(@test);
select @test;

desc student;
select * from student;
drop procedure test_cursor;


