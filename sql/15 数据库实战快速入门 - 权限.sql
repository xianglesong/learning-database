-- 14
-- user database
use course;

select * from course.student;

-- 1
create user newuser identified by 'pwd123';

--
GRANT ALL PRIVILEGES ON *.* TO 'newuser'@'%'  IDENTIFIED BY 'pwd123' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON *.* TO 'newuser'@'localhost'  IDENTIFIED BY 'pwd123' WITH GRANT OPTION;
flush privileges;

-- 2 revoke all privileges;

-- 3 grant and revoke
grant select on course.student to newuser;
grant select on course.course to newuser;
revoke select on course.student from newuser;

select * from course.course;