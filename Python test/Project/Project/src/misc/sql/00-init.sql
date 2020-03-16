CREATE DATABASE zen default character set utf8mb4;

GRANT ALL ON zen.* TO 'zen'@'%' IDENTIFIED BY 'zen';

FLUSH PRIVILEGES;
