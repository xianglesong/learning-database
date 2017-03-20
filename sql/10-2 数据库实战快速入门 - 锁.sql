-- lock

use course;

insert into course(id,course_no,course_name) values('1','M301','数学');
insert into course values('2','E201','英语');

SET SESSION tx_isolation='REPEATABLE-READ';
SET GLOBAL tx_isolation='REPEATABLE-READ';
SELECT @@GLOBAL.tx_isolation, @@tx_isolation; 

-- client a
start transaction;
set @@autocommit=0;

SELECT * FROM course WHERE id= '1' LOCK IN SHARE MODE;
COMMIT; 

-- client B
SELECT * FROM course WHERE id= '1' ;

-- client A
start transaction;
SET autocommit = off;
select * from course where id ='1' for update;

update course set course_name = 's1' where id ='1';
commit;

-- client B
SELECT * FROM course WHERE id= '1' for update;