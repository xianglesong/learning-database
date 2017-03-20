-- er
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
