-- 6
-- user database
use course;

-- create procedure
-- DELIMITER： sql语句是否结束标志，如下$$表示开始，则遇到$$才结束。最后继续使用默认的;进行sql语句结束标志。
-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `test_procedure1`(p1 INT)
BEGIN
	CREATE  TABLE `course`.`student3` (
	  `id` CHAR(32) NOT NULL ,
	  `student_no` INT NOT NULL ,
	  `name` VARCHAR(255) NOT NULL ,
	  `age` SMALLINT NOT NULL ,
	  `gender` CHAR(1) NOT NULL ,
	  PRIMARY KEY (`id`) ,
	  UNIQUE INDEX `student_no_UNIQUE` (`student_no` ASC) )
	ENGINE = InnoDB
	DEFAULT CHARACTER SET = utf8
	COMMENT = 'student information';

    label1: LOOP
    SET p1 = p1 + 1;
	insert into student3(id,student_no,name,age,gender) values(concat(p1,'1'),concat('20',p1),concat('a',p1), 20,'1');
    IF p1 < 100 THEN ITERATE label1; END IF;
    LEAVE label1;
  END LOOP label1;
  
END$$

DELIMITER ;
-- end procedure
-- ------------------------------------------------------------------------------------------------

-- call procedure
call test_procedure1(0);

select * from student3;
select count(*) from student3;
-- drop procedure
drop procedure `course`.`test_procedure1`;
drop table student3;
