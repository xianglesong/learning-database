-- 4
-- user database
use course;

-- select
select * from student where student_no = '98031303';
select * from student;
describe student;

-- create index 
create index student_no_idx on student(student_no);
-- explain
explain select * from student where student_no = '98031303'; 
-- drop index
drop index student_no_idx on student;
drop index student_no_UNIQUE on student;

-- multi column index
explain select * from student where age = 18 and gender = '1';
create index student_age_gender_indx on student(age,gender);
drop index student_age_gender_indx on student;

-- performance
select count(*) from student;

-- DELIMITER： sql语句是否结束标志，如下$$表示开始，则遇到$$才结束。最后继续使用默认的;进行sql语句结束标志。
-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `test_procedure`(p1 INT)
BEGIN
    label1: LOOP
    SET p1 = p1 + 1;
	insert into student(id,student_no,name,age,gender) values(concat(p1,'1'),concat('20',p1),concat('a',p1), 20,'1');
    IF p1 < 5000 THEN ITERATE label1; END IF;
    LEAVE label1;
  END LOOP label1;
END$$
DELIMITER ;
-- end procedure
-- ------------------------------------------------------------------------------------------------
-- insert 4000 rows to student with procedure test_procedure, please execute last routine ddl first.
call test_procedure(1000);
drop procedure `course`.`test_procedure`;

delete from student where age = 20;

CREATE TABLE `student` (
  `id` char(32) NOT NULL,
  `student_no` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `age` smallint(6) NOT NULL,
  `gender` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `student_no_UNIQUE` (`student_no`),
  KEY `student_no_idx` (`student_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='student information';
