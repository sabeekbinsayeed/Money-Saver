create or replace package body myPackage2 as

	function dotransaction(a in customer.cid@site_link %TYPE,cbalance in customer.balance@site_link %TYPE,bname in brand.bname@site_link %type,bincome in brand.income@site_link %type)
  return customer.cid %TYPE
  is


newbalance customer.balance@site_link %type ;
flag integer :=1;
key integer ;
b brand.bid@site_link %type;

begin
select max(bid)+1 into b from brand@site_link;	
	--dbms_output.put_line('function is caleed');
		--key := select max(bid) from brand@site_link;
		if (bincome > cbalance ) then
		 flag := 0;
		
		elsif (bname = 'ubereats'or bname='foodpanda') then
			insert into brand@site_link (bid,bname,income,cid) values(b,bname,bincome,a);
			commit;
					

		elsif (bname = 'nesco') then
			--dbms_output.put_line('in nesco');	
			insert into brand@site_link (bid,bname,income,cid) values(b,bname,bincome,a);
			commit;
			

		elsif (bname = 'shohoz') then
			--dbms_output.put_line('in shohoz');	
			insert into brand@site_link (bid,bname,income,cid) values(b,bname,bincome,a);
			commit;
			


	       end if;
		newbalance := cbalance - bincome ;

if (flag =0) then
	dbms_output.put_line('not enough balance');
elsif (flag =1) then 
	dbms_output.put_line('money left tk '||newbalance);
        UPDATE customer@site_link set balance=newbalance WHERE cid=a; 
	 UPDATE customer set balance=newbalance WHERE cid=a; 
	commit;

end if;

return flag;
end dotransaction;

		
	



procedure expensetrack(a in customer.cid%TYPE,bname in brand.bname@site_link %type,bincome in brand.income@site_link %type)
		IS

emonth expense.month@site_link%type :='september' ;
category expense.category@site_link %type ;
error_brand exception;
e expense.eid@site_link%type;
--SELECT MONTH(CURRENT_TIMESTAMP);
begin

 select max(eid)+1 into e from expense@site_link;
	if (bname ='ubereats' or bname='foodpanda' ) then
		category := 'food';
	elsif (bname = 'rokomari') then
		category := 'entertainment';
	elsif (bname = 'shohoz') then
		category := 'transportation';
	elsif (bname = 'nesco') then
		category := 'electricity';
	else 
			raise error_brand;

end if;
	--dbms_output.put_line(category);
	insert into expense@site_link (eid,month,cost,category,cid) values(e,emonth,bincome,category,a);
	commit;
dbms_output.put_line('data inserted in expense');

exception

	when error_brand then
		dbms_output.put_line('brandname not recognized');
	
	when zero_divide then
		dbms_output.put_line('Cannot be divided by zero');
		
	when no_data_found then
		dbms_output.put_line('not found');		
end expensetrack;




procedure signupp(cname customer.cname %type,cpass customer.cpass %type,cbalance customer.balance %type)
		IS

b customer.cid % type;

cadd customer.cadd %type :='dhaka' ;





begin


select max(cid)+1 into b from customer@site_link;	

if(cadd ='dhaka') then
insert into Customer@site_link values(b,cname,cpass,cadd,cbalance);
insert into Customer values(b,cname,cpass,cadd,cbalance);
commit;
commit;
elsif (cadd ='rajshahi') then
insert into Customer@site_link values(b,cname,cpass,cadd,cbalance);
commit;
end if;
		
end signupp;



 procedure seereport(a in admin.aid%type)
  is


cnt number :=0;
	cost number :=0;
	flag number :=0;
	
	
begin

for r in (select customer.cname,customer.balance from customer union select customer.cname@site_link,customer.balance@site_link from customer@site_link) loop
	dbms_output.put_line(r.cname || '   '|| r.balance);
	cnt :=cnt +1;
	end loop;

dbms_output.put_line('total customers available in the system '||cnt);
 DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
dbms_output.put_line( ' customer  '|| ' brandname ' ||' income ');
for r in (select c.cname, B.bname,B.income from customer@site_link C join brand B on c.cid = B.cid) loop

 cost := cost + r.income ;

dbms_output.put_line(r.cname || '   '|| r.bname ||'    '||r.income);
		


	end loop;
	

	dbms_output.put_line('total sales tk '||cost);
	flag := cost * 15;
	flag :=flag/100;
	dbms_output.put_line('total profit tk '||flag);
dbms_output.put_line(' ');


	



	
	

end seereport;

end myPackage2;
/