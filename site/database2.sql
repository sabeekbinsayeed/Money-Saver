
clear screen;

--delete existing table
drop table Customer cascade constraints;
drop table brand cascade constraints;
drop table expense cascade constraints;
drop table admin cascade constraints;


create table Customer(
cid     integer, 
cname   varchar2(30), 
cpass   varchar2(30),
cadd  varchar2(30),
balance integer, 
		PRIMARY KEY (cid)
);

--drop sequence cid;
--create sequence cid minvalue 20 start with 20;


create table brand(
bid   integer, 
bname varchar2(30), 
income integer,
cid   integer,
      PRIMARY KEY(bid),
      FOREIGN KEY(cid) REFERENCES customer(cid) ON DELETE CASCADE
);
drop sequence bid;
create sequence bid minvalue 1 start with 1;

create table expense(
eid   integer, 
month varchar2(30),
cost  number, 
category varchar2(30), 
cid   integer, 
      PRIMARY KEY(eid),
      FOREIGN KEY(cid) REFERENCES customer(cid) ON DELETE CASCADE
);
drop sequence eid;
create sequence eid minvalue 1 start with 1;

create table admin(
aid   integer, 
aname varchar2(30),
apassword varchar2(30),
      PRIMARY KEY(aid)  
);




--Insert data into expense database






insert into Customer values(1,'abdullah','hello','dhaka',30000);
insert into Customer values(2,'chowdhury','321','dhaka',40000);
insert into Customer values(3,'sayeed','123','dhaka',5000);
insert into Customer values(4,'pranto','red','rajshahi',2000);
insert into Customer values(5,'debnath','black','rajshahi',10000);
insert into Customer values(6,'rakib','111','rajshahi',3000);



insert into brand values(bid.nextval, 'foodpanda',200,1);
insert into brand values(bid.nextval, 'nesco',6000,2);
insert into brand values(bid.nextval, 'shohoz',4000,3);
insert into brand values(bid.nextval, 'rokomari',300,1);
insert into brand values(bid.nextval, 'foodpanda',280,1);
insert into brand values(bid.nextval, 'foodpanda',200,6);
insert into brand values(bid.nextval, 'nesco',6000,4);
insert into brand values(bid.nextval, 'shohoz',4000,5);
insert into brand values(bid.nextval, 'rokomari',300,6);
insert into brand values(bid.nextval, 'foodpanda',280,6);




insert into expense values(eid.nextval, 'september',4000,'electricity',1);
insert into expense values(eid.nextval, 'september',2000,'transportation',3);
insert into expense values(eid.nextval, 'september',4000,'food',1);
insert into expense values(eid.nextval, 'august',1000,'food',2);
insert into expense values(eid.nextval, 'august',2000,'food',2);
insert into expense values(eid.nextval, 'september',1000,'electricity',1);
insert into expense values(eid.nextval, 'september',1000,'food',6);
insert into expense values(eid.nextval, 'july',1000,'electricity',1);
insert into expense values(eid.nextval, 'september',1000,'electricity',6);





insert into admin values(1,'admin','password');



commit;

Select * from Customer;
select * from brand;
select * from expense;
select * from admin;





