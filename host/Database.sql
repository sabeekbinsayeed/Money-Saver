
clear screen;

--delete existing table
drop table Customer cascade constraints;

drop table admin cascade constraints;


create table Customer(
cid     integer, 
cname   varchar2(30), 
cpass   varchar2(30),
cadd  varchar2(30),
balance integer, 
		PRIMARY KEY (cid)
);





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









insert into admin values(1,'admin','password');



commit;

Select * from Customer;

select * from admin;





