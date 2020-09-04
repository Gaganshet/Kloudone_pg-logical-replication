 provider port:9990
===================

CREATE DATABASE employee;

CREATE EXTENSION pglogical;

CREATE TABLE students(id INT PRIMARY KEY,name TEXT,branch text,gender char(10));

SELECT pglogical.create_node(node_name := 'proviser',dsn := 'host=localhost port=9990 dbname=teacher');

SELECT pglogical.replication_set_add_table(set_name := 'default', relation :='students', synchronize_data := true, columns :='{id,name,branch}', row_filter := 'id>=2');

INSERT INTO students VALUES(1,'veer','cse','male');

INSERT INTO students VALUES(2,'vaman','mech','male');

INSERT INTO students VALUES(3,'manohar','ece','male');

INSERT INTO students VALUES(4,'jaya','eee','female');

INSERT INTO students VALUES(5,'kavya','ece','female');

 Subscriber  port:9991
=========================

CREATE DATABASE teacher; 

CREATE EXTENSION Pglogical;

CREATE TABLE students(id INT PRIMARY KEY,name TEXT,branch text,gender char(10));

SELECT pglogical.create_node(node_name := 'subscriber',dsn := 'host=localhost port=9991 dbname=teacher');

SELECT pglogical.create_subscription( subscription_name := 'subscription',provider_dsn := 'host=localhost port=9990 dbname=teacher');


SELECT * FROM students;


