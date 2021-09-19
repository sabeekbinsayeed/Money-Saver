create or replace package body myPackage as



	 function dotransaction(a in customer.cid %TYPE,cbalance in customer.balance %TYPE,bname in brand.bname %type,bincome in brand.income %type)
  		return customer.cid %TYPE
  		is



	newbalance customer.balance %type ;
	flag integer :=1;
	key integer ;
	b brand.bid%type;
--select max(bid)+1 into b from brand;

begin
 select max(bid)+1 into b from brand;
	
	--dbms_output.put_line('function is called');

		if (bincome > cbalance ) then
		 flag := 0;
		
		elsif (bname = 'ubereats'or bname='foodpanda') then
			insert into brand (bid,bname,income,cid) values(b,bname,bincome,a);
			commit;
					

		elsif (bname = 'nesco') then
			--dbms_output.put_line('in nesco');	
			insert into brand (bid,bname,income,cid) values(b,bname,bincome,a);
			commit;
			

		elsif (bname = 'shohoz') then
			--dbms_output.put_line('in shohoz');	
			insert into brand (bid,bname,income,cid) values(b,bname,bincome,a);
			commit;
			

	       end if;

newbalance := cbalance - bincome ;

	if (flag =0) then
		dbms_output.put_line('not enough balance for buying the product');
	elsif (flag =1) then 
		dbms_output.put_line('your money left '||newbalance);
        	UPDATE customer set balance=newbalance WHERE cid=a; 
	commit;


	end if;

return flag;
end dotransaction;

		
	



	procedure expensetrack(a in customer.cid%TYPE,bname in brand.bname %type,bincome in brand.income %type)
		IS

	emonth expense.month%type :='september' ;
	category expense.category %type ;
	b brand.bid%type;
	error_brand exception;
	--SELECT MONTH(CURRENT_TIMESTAMP);
	--e expense.eid%type;


begin

select max(eid)+1 into b from expense;
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

	insert into expense (eid,month,cost,category,cid) values(b,emonth,bincome,category,a);
commit;
        -- dbms_output.put_line('data inserted in expense table');

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
	cadd customer.cadd %type :='rajshahi' ;





begin
	select max(cid)+1 into b from customer;
	insert into Customer values(b,cname,cpass,cadd,cbalance);
	commit;
		
	end signupp;




end myPackage;
/