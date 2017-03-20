-- transaction isolation levels

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

drop table `tx`;

CREATE TABLE `tx` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `num` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


SELECT @@GLOBAL.tx_isolation, @@tx_isolation; 
select @@autocommit;
set @@autocommit=0;

insert into tx(num) values(1);
insert into tx(num) values(2);
insert into tx(num) values(3);

select * from tx;

-- test repeatable read
SET SESSION tx_isolation='REPEATABLE-READ';
SET GLOBAL tx_isolation='REPEATABLE-READ';

SELECT @@GLOBAL.tx_isolation, @@tx_isolation; 
select @@autocommit;

-- client A
start transaction;
select * from tx;

commit;

-- B update
SET SESSION tx_isolation='REPEATABLE-READ';
SET GLOBAL tx_isolation='REPEATABLE-READ';
set @@autocommit=0;
start transaction;
update tx set num=12 where id=1;

select * from tx;

insert into tx(num) values(5);
commit;

select * from tx;

-- 由以上的实验可以得出结论，可重复读隔离级别只允许读取已提交记录，而且在一个事务两次读取一个记录期间，其他事务部的更新该记录。
-- 但该事务不要求与其他事务可串行化。
