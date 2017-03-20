-- 8
-- user database
use course;
-- view

create view student_course_view as
select s.student_no , s.name as s_name, c.course_no, c.course_name 
from student s, student_course sc, course c 
where s.id = sc.student_id and sc.course_id = c.id;

select * from student_course_view;
select * from student_course_view where student_no = 98031301;

insert into student_course values(13,2,2);

drop view student_course_view;