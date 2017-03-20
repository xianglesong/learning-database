-- 2 
use course;

-- 创建测试表stduent2
CREATE  TABLE `course`.`student2` (
  `id` CHAR(32) NOT NULL ,
  `student_no` INT NOT NULL ,
  `name` VARCHAR(255) NOT NULL ,
  `age` SMALLINT NOT NULL ,
  `gender` CHAR(1) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `student_no_UNIQUE` (`student_no` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

describe student2;

insert into student2(id,student_no,name,age,gender) values('4','98031304','张三',17,'1');
insert into student2 values('5','98031305','李四',18,'1');

-- 复制表操作
insert into student (select * from student2);

select * from student;
select * from student2;

-- 选择
select id,student_no,name,age,gender from student where id ='2';
-- 投影
select name,age,gender from student where id ='2';
-- 并
select id,student_no,name,age,gender from student where age<18 or gender='1';
-- 差
select id,student_no,name,age,gender from student where age<18 and gender<>'1';

-- 高级查询
select 1+101;
select name as student_name from student;
select age,name,age+1 as 'new_age' from student;
select max(age) from student;
select count(*) from student; 

insert into student(id,student_no,name,age,gender) values('j','98031306','赵六',18,'1');
-- 函数
select id,upper(id) from student;

select * from student_course;
insert into student_course(id,student_id,course_id) values('4','2','2');
select student_id from student_course;
select distinct student_id from student_course;
select * from student limit 3;
select * from student order by age limit 3;
-- 分页查询
select * from student order by age limit 0, 2;
select * from student order by age limit 1, 2;

-- null
-- alter table
ALTER TABLE `course`.`student` CHANGE COLUMN `gender` `gender` CHAR(1) NULL  ;
insert into student(id,student_no,name,age,gender) values('n','98031307','空值',18,NULL);
select * from student where gender is null;
select * from student where gender = null;
select * from student where gender = '';

-- 子查询
select * from student where id  in (select student_id from student_course);
select * from student where id not  in (select student_id from student_course);

-- 统计
select count(*) from student group by gender;
select gender,count(*) from student group by gender;

select avg(age),gender from student group by gender;

-- update
update student set age = age + 1 where id = '3';

-- delete
select * from student2;
delete from student2 where id = '5' ;
delete from student2;

-- 删除表
truncate table student2;

drop table student2;
drop database course;
