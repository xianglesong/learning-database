-- 11
-- user database
use course;

CREATE TABLE `course`.`test1` (
  `id` CHAR(32) NOT NULL,
  `username` VARCHAR(45) NULL,
  `userpwd` VARCHAR(45) NULL,
  PRIMARY KEY (`id`));

insert into `course`.`test1` values('1','2','3');
insert into `course`.`test1` values('11','22','33');
insert into `course`.`test1` values('111','222','333');
commit;

-- export
select * from `course`.`test1`;

-- import
delete from `course`.`test1`;
