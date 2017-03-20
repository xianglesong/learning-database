-- 12
-- user database
use course;

-- c:\Program Files\MySQL\MySQL Server 5.5\bin>mysqldump -u root -p  --databases course > course_backup.dat
--  /Applications/MySQLWorkbench.app/Contents/MacOS/mysqldump  -u root -p  --databases course > course_backup.bak

select * from student;

select * from student_course;
delete from student_course;
commit;

-- c:\Program Files\MySQL\MySQL Server 5.5\bin>mysql -p -u root course < course_backup.dat
-- mysql -p -u root course < course_backup.bak