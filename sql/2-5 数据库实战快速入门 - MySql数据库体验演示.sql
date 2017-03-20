-- 1
-- create database
create database `course`;

-- user database
use course;

-- create table student
CREATE  TABLE `course`.`student` (
  `id` CHAR NOT NULL ,
  `student_no` INT NOT NULL ,
  `name` VARCHAR(255) NOT NULL ,
  `age` SMALLINT NOT NULL ,
  `gender` CHAR(1) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `student_no_UNIQUE` (`student_no` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'student information';

-- sql insert
insert into student(id,student_no,name,age,gender) values('1','98031301','李明',17,'1');
insert into student values('2','98031302','成龙',18,'1');
insert into student values('3','98031303','章子怡',18,'0');

-- sql query
select * from student;
select * from student limit 0, 2;

-- sql update
update student set age = age + 1 where id ='1';

-- sql delete
delete from student where id = '1';
insert into student(id,student_no,name,age,gender) values('1','98031301','李明',17,'1');

-- create table course
CREATE  TABLE `course`.`course` (
  `id` CHAR(32) NOT NULL ,
  `course_no` VARCHAR(45) NOT NULL ,
  `course_name` VARCHAR(45) NOT NULL COMMENT 'course information' ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `course_no_UNIQUE` (`course_no` ASC) ,
  UNIQUE INDEX `course_name_UNIQUE` (`course_name` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- insert into course
insert into course(id,course_no,course_name) values('1','M301','数学');
insert into course values('2','E201','英语');

delete from course;
delete from student;

-- create table student_course
CREATE  TABLE `course`.`student_course` (
  `id` CHAR(32) NOT NULL ,
  `student_id` CHAR(32) NOT NULL ,
  `course_id` CHAR(32) NOT NULL COMMENT 'course information' ,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- add constraint
CREATE TABLE `course`.`student_course` (
  `id` char(32) NOT NULL,
  `student_id` char(32) NOT NULL,
  `course_id` char(32) NOT NULL COMMENT 'course information',
  PRIMARY KEY (`id`),
  KEY `course_id_fk_idx` (`course_id`),
  KEY `student_id_fk_idx` (`student_id`),
  CONSTRAINT `course_id_fk` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `student_id_fk` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- insert into student
insert into student(id,student_no,name,age,gender) values('1','98031301','李明',17,'1');
insert into student values('2','98031302','成龙',18,'1');
insert into student values('3','98031303','章子怡',18,'0');

-- insert into course
insert into course(id,course_no,course_name) values('1','M301','数学');
insert into course values('2','E201','英语');

delete from student_course;
-- insert into student_course
insert into student_course(id,student_id,course_id) values('1','1','1');
insert into student_course values('2','2','2');
insert into student_course values('3','2','2');
commit;

delete from student where id='1';
delete from course where id='1';

delete from student_course where id='1';

select * from student;
select * from course;
select * from student_course;

