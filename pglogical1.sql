Provider  port:9990
=====================

CREATE DATABASE replica;

CREATE EXTENSION pglogical;

CREATE TABLE log(id int primary key,name text,location char(30));

SELECT pglogical.create_node(
    node_name := 'provider',
    dsn := 'host=localhost port=9990 dbname=replica'
);

select pglogical.replication_set_add_table(set_name := 'default', relation := 'log' , synchronize_data := 'true');

INSERT INTO log  VALUES (1,'ram','mangalore');

INSERT INTO log VALUES (2,'ramu','bangalore');
 
INSERT INTO log VALUES (3,'suresh','tirupathi');
 
INSERT INTO log VALUES (4,'timma','kundapur');
 
INSERT INTO log VALUES (5,'shiva','hyderabad');


 Subscriber port:9991
======================

CREATE DATABASE replica;

CREATE EXTENSION pglogical;

CREATE TABLE log(id int primary key,name text,location char(30));

SELECT pglogical.create_node(node_name := 'subscriber', dsn := 'host=localhost port=9991 dbname=replica');

SELECT pglogical.create_subscription(subscription_name := 'subscription',provider_dsn := 'host=locahost port=9990 dbname=replica');

SELECT * FROM log;
