-- 9
-- user database
use course;
-- transaction

select @@autocommit;
SELECT @@global.tx_isolation, @@tx_isolation;

select * from course;
desc course;
insert into course(id,course_no,course_name) value('4','P101','物理');
delete from course where id = '4';

START TRANSACTION;
SET autocommit = 0;
insert into course(id,course_no,course_name) value('5','P102','生物');
COMMIT;

delete from course where id = '5';
commit;

START TRANSACTION;
insert into course(id,course_no,course_name) value('5','P102','生物');
rollback;

select * from course where id ='1';
-- savepoint
START TRANSACTION;
update course set course_name = 's1' where id ='1';
SAVEPOINT save1;
update course set course_name = 's2' where id ='1';
ROLLBACK TO SAVEPOINT save1;
commit;

update course set course_name = '数学' where id ='1';

SELECT @@global.tx_isolation;
SELECT @@tx_isolation;

start transaction;
SET autocommit = off;
select * from course where id ='1' for update;
update course set course_name = 's1' where id ='1';
commit;

-- ISOLATION LEVEL
set session transaction isolation level REPEATABLE READ;
set global transaction isolation level REPEATABLE READ;
create table t1(a int) engine=innodb;
start transaction;
insert into t1 values (3);

select * from t1;
-- wait
commit;
