-- 3
-- create database
create database `course`;

-- user database
use course;

-- create table student
CREATE  TABLE `course`.`student` (
  `id` CHAR(32) NOT NULL ,
  `student_no` INT NOT NULL ,
  `name` VARCHAR(255) NOT NULL ,
  `age` SMALLINT NOT NULL ,
  `gender` CHAR(1)  ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `student_no_UNIQUE` (`student_no` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'student information';

-- sql insert
insert into student(id,student_no,name,age,gender) values('1','98031301','李明',17,'1');
insert into student(id,student_no,name,age,gender) values('2','98031302','成龙',18,'1');
insert into student(id,student_no,name,age,gender) values('3','98031303','章子怡',18,'0');
insert into student(id,student_no,name,age,gender) values('4','98031304','张三',17,'1');
insert into student(id,student_no,name,age,gender) values('5','98031305','李四',18,'1');
insert into student(id,student_no,name,age,gender) values('j','98031306','赵六',18,'1');
insert into student(id,student_no,name,age,gender) values('n','98031307','空值',18,NULL);

-- create table course
CREATE  TABLE `course`.`course` (
  `id` CHAR(32) NOT NULL ,
  `course_no` VARCHAR(45) NOT NULL ,
  `course_name` VARCHAR(45) NOT NULL COMMENT 'course information' ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `course_no_UNIQUE` (`course_no` ASC) ,
  UNIQUE INDEX `course_name_UNIQUE` (`course_name` ASC) )
  DEFAULT CHARACTER SET = utf8
ENGINE = InnoDB;

-- insert into course
insert into course(id,course_no,course_name) values('1','M301','数学');
insert into course(id,course_no,course_name) values('2','E201','英语');
insert into course(id,course_no,course_name) values('3','C403','计算机');

-- create table student_course
CREATE  TABLE `course`.`student_course` (
  `id` CHAR(32) NOT NULL ,
  `student_id` CHAR(32) NOT NULL ,
  `course_id` CHAR(32) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `student_id_idx` (`student_id` ASC) ,
  INDEX `course_id_idx` (`course_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'student_course information';

-- insert into student_course
insert into student_course(id,student_id,course_id) values('1','1','1');
insert into student_course(id,student_id,course_id) values('2','2','2');
insert into student_course(id,student_id,course_id) values('3','2','2');
insert into student_course(id,student_id,course_id) values('4','1','2');

-- select
select * from student;
select * from course;
select * from student_course;

-- join
-- inner join
select * from student s, student_course sc where s.id = sc.student_id;
select * from student s inner join student_course sc on s.id = sc.student_id;

select * from student s, student_course sc where s.id = sc.student_id and s.age between 12 and 17;
select * from student s inner join student_course sc on s.id = sc.student_id and s.age between 12 and 18;

select * from student s, student_course sc, course c where s.id = sc.student_id and sc.course_id = c.id;

-- left, right outer join
select * from student s left outer join student_course sc on s.id = sc.student_id;
select * from student s left join student_course sc on s.id = sc.student_id;
select * from student s left outer join student_course sc on s.id = sc.student_id where s.age>17;
select * from student s left outer join student_course sc on s.id = sc.student_id where s.age>17 and s.name='成龙';

select * from student s right outer join student_course sc on s.id = sc.student_id;
select * from student_course sc right outer join student s on  sc.student_id = s.id ;

select * from student s;
select * from student_course sc;

-- full join
select * from student s left outer join student_course sc on s.id = sc.student_id
union 
select * from student s right outer join student_course sc on s.id = sc.student_id;

-- cross joins 
select * from student cross join course;
select * from student join course;
select * from student, course;

-- self join

-- id,parent_id,name
-- 0,1,系统功能
-- 1,0,用户管理
-- 2,1,添加用户
-- 3,1,删除用户
-- 10,0,文章管理
-- 11,10,添加文章
-- 12,10,删除文章

delete from `course`.`sys_func`;
drop table sys_func;

CREATE  TABLE `course`.`sys_func` (
  `id` INT NOT NULL ,
  `parent_id` INT   ,
  `func_name` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`id`)  )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

insert into sys_func(id,parent_id,func_name) values(0,Null,'系统功能');
insert into sys_func(id,parent_id,func_name) values(1,0,'用户管理');
insert into sys_func(id,parent_id,func_name) values(2,1,'添加用户');
insert into sys_func(id,parent_id,func_name) values(3,1,'删除用户');
insert into sys_func(id,parent_id,func_name) values(10,0,'文章管理');
insert into sys_func(id,parent_id,func_name) values(11,10,'添加文章');
insert into sys_func(id,parent_id,func_name) values(12,10,'删除文章');

select * from sys_func a, sys_func b where a.id = b.parent_id order by a.id;
