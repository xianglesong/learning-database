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

CREATE TABLE `tx` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `num` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


SELECT @@GLOBAL.tx_isolation, @@tx_isolation; 
select @@autocommit;
set @@autocommit = 0;

insert into tx(num) values(1);
insert into tx(num) values(2);
insert into tx(num) values(3);

select * from tx;

-- client A
start transaction;
set @@autocommit = 0;

select * from tx;

-- client B
SET SESSION tx_isolation='READ-UNCOMMITTED';
SET GLOBAL tx_isolation='READ-UNCOMMITTED';
start transaction;
set @@autocommit = 0;
update tx set num=10 where id=1;
select * from tx;
rollback;
select * from tx;

-- client A
select * from tx;
select * from tx;

-- 经过上面的实验可以得出结论，事务B更新了一条记录，但是没有提交，此时事务A可以查询出未提交记录。造成脏读现象。未提交读是最低的隔离级别。

