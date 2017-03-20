CREATE TABLE `test_partitions` (
  `id` char(32) NOT NULL,
  `pid` bigint(64) NOT NULL,
  `insert_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`pid`),
  UNIQUE KEY `pid` (`pid`),
  KEY `update_time` (`update_time`),
  KEY `insert_time` (`insert_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
/*!50100 PARTITION BY HASH (pid)
PARTITIONS 50 */;

show variables;
-- datadir
-- /usr/local/mysql/data/
