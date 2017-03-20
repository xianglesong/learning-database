-- transaction isolation levels
use course;

SELECT @@GLOBAL.tx_isolation, @@tx_isolation; 

SET SESSION tx_isolation='READ-UNCOMMITTED';
SET GLOBAL tx_isolation='READ-UNCOMMITTED';

SET SESSION tx_isolation='READ-COMMITTED';
SET GLOBAL tx_isolation='READ-COMMITTED';

SET SESSION tx_isolation='REPEATABLE-READ';
SET GLOBAL tx_isolation='REPEATABLE-READ';

SET SESSION tx_isolation='SERIALIZABLE';
SET GLOBAL tx_isolation='SERIALIZABLE';

-- test read-uncommitted
SET SESSION tx_isolation='READ-UNCOMMITTED';
SET GLOBAL tx_isolation='READ-UNCOMMITTED';

-- DROP TABLE `course`.`tx`;

CREATE TABLE `tx` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `num` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


SELECT @@GLOBAL.tx_isolation, @@tx_isolation; 
select @@autocommit;

insert into tx(num) values(1);
insert into tx(num) values(2);
insert into tx(num) values(3);

-- test read committed

SET SESSION tx_isolation='READ-COMMITTED';
SET GLOBAL tx_isolation='READ-COMMITTED';
SELECT @@GLOBAL.tx_isolation, @@tx_isolation; 

set @@autocommit=0;
select @@autocommit;

-- client A
start transaction;
set @@autocommit=0;
select @@autocommit;
select * from tx;
select * from tx;
commit;

-- client B
SET SESSION tx_isolation='READ-COMMITTED';
SET GLOBAL tx_isolation='READ-COMMITTED';
set @@autocommit=0;
SELECT @@GLOBAL.tx_isolation, @@tx_isolation; 
select @@autocommit;
start transaction;
update tx set num=11 where id=1;
select * from tx;

commit;

-- client A
select * from tx;

-- 经过上面的实验可以得出结论，已提交读隔离级别解决了脏读的问题，但是出现了不可重复读的问题，即事务A在两次查询的数据不一致，
-- 因为在两次查询之间事务B更新了一条数据。已提交读只允许读取已提交的记录，但不要求可重复读。
