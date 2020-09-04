Coordinator  Port:9990
==========================

CREATE EXTENSION Citus; 

SELECT * from master_add_node('localhost', 9991); // To connect coordinator node with worker1 node

SELECT * from master_add_node('localhost', 9992); // To connect coordinator node with worker2 node

select * from master_get_active_worker_nodes(); // To verify that both worker nodes are connected to coordinator node

creating tables on coordinator node
====================================

CREATE TABLE student (id int primary key,name text,location char(30));

------insert data -----------

CREATE TABLE teacher(id int primary key,name text,subject text,location char(30));

------insert data-------------

SET citus.replication_model = 'streaming';


 To distribute the tables in the worker nodes
================================================

SELECT create_distributed_table('student', 'id');

SELECT create_distributed_table('teacher', 'id');


run some queries
=================

1.SELECT name,location from student;

2.SELECT name,subject from teacher;

3.insert into student values(4,'aditya','kerala');

4.insert into teacher values(5,'raman','social','chennai');

5.update teacher set subject='hindi' where subject='science';

6.delete from student where location='bangalore';

Worker1 node port:9991
=======================

 CREATE EXTENSION citus;

\d //run this command to view the list of distributed tables

Worker2 node port:9992
=======================

CREATE EXTENSION citus;

\d //run this command to view the list of distributed tables
