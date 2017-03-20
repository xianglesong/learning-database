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

DROP TABLE `course`.`tx`;

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

set @@autocommit = 0;
-- test SERIALIZABLE
SET SESSION tx_isolation='SERIALIZABLE';
SET GLOBAL tx_isolation='SERIALIZABLE';

SELECT @@GLOBAL.tx_isolation, @@tx_isolation; 
select @@autocommit;

-- client A transaction;
select * from tx;

start transaction;
set @@autocommit = 0;
select * from tx;
insert into tx(num) values(4);

commit;

-- client B
set @@autocommit = 0;
SET SESSION tx_isolation='SERIALIZABLE';
SET GLOBAL tx_isolation='SERIALIZABLE';

insert into tx(num) values(5);