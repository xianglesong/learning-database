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

select * from tx;

-- client A
start transaction;
set @@autocommit = 0;

select * from tx;

-- client B
update tx set num=10 where id=1;
select * from tx;
rollback;
select * from tx;

-- client A
select * from tx;
select * from tx;

-- 经过上面的实验可以得出结论，事务B更新了一条记录，但是没有提交，此时事务A可以查询出未提交记录。造成脏读现象。未提交读是最低的隔离级别。


-- test read committed

SET SESSION tx_isolation='READ-COMMITTED';
SET GLOBAL tx_isolation='READ-COMMITTED';
SELECT @@GLOBAL.tx_isolation, @@tx_isolation; 
select @@autocommit;

-- client A
start transaction;
select * from tx;

-- client B
start transaction;
update tx set num=11 where id=1;
select * from tx;
commit;

-- client A
select * from tx;

-- 经过上面的实验可以得出结论，已提交读隔离级别解决了脏读的问题，但是出现了不可重复读的问题，即事务A在两次查询的数据不一致，
-- 因为在两次查询之间事务B更新了一条数据。已提交读只允许读取已提交的记录，但不要求可重复读。


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
set @@autocommit=0;
start transaction;
update tx set num=12 where id=1;

select * from tx;

-- B insert
insert into tx(num) values(15);

select * from tx;

commit;
-- client B

start transaction;
update tx set num=12 where id=1;
select * from tx;
insert into tx(num) values(5);
commit;

-- 由以上的实验可以得出结论，可重复读隔离级别只允许读取已提交记录，而且在一个事务两次读取一个记录期间，其他事务部的更新该记录。
-- 但该事务不要求与其他事务可串行化。

-- test SERIALIZABLE
SET SESSION tx_isolation='SERIALIZABLE';
SET GLOBAL tx_isolation='SERIALIZABLE';

SELECT @@GLOBAL.tx_isolation, @@tx_isolation; 
select @@autocommit;

-- client A
start transaction;
select * from tx;
insert into tx(num) values(4);

commit;
-- client B
insert into tx(num) values(5);