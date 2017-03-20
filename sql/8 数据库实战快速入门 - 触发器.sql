-- 7
-- user database
use course;
-- trigger

CREATE TABLE test_increament(id INT);
 
DELIMITER $$
 
CREATE TRIGGER test_ref BEFORE INSERT ON student
  FOR EACH ROW BEGIN
    UPDATE test_increament SET id = id + 1;
  END
$$
 
DELIMITER ;

insert test_increament(id) values(0);
select * from test_increament;
desc student;

insert into student(id,student_no,name,age,gender) values('t11',001,'t李明',17,'0');
insert into student(id,student_no,name,age,gender) values('t21',002,'t李明2',17,'0');
insert into student(id,student_no,name,age,gender) values('t31',003,'xxx',17,'0');
DROP TRIGGER test_ref;