
set verify off;
set serveroutput on;


declare


	a customer.cid %type ;
	cname customer.cname %type := '&name';
	b customer.cpass %type := '&password';
	location customer.cadd %type ;
	cbalance customer.balance %type ;
	cnt number :=0;
	bname brand.bname %type := '&brandname' ;
	bincome brand.income %type := '&sendmoney' ;
	error_negative exception;
	
	
begin
	for r in (select cid,cname, cpass,cadd,balance from customer@site_link) loop
		if (r.cname = cname and r.cpass = b) then
			--dbms_output.put_line('Welcome back ' || bname || '!');
			cnt:=2;
			cbalance :=r.balance;
			a:= r.cid;
			location := r.cadd;
			if (location != 'dhaka') then
				cnt :=5;
			end if;
		elsif( r.cid = a) then
			cnt:=1;

		end if;




	end loop;
	

	if(cnt =0) then
		dbms_output.put_line('Account not Found. please Sign up.');
	elsif(cnt=1) then
		dbms_output.put_line('Password not valid');
	elsif(cnt=5) then
		dbms_output.put_line('outside dhaka not allowed');
	
	elsif(cnt=2) then
		dbms_output.put_line('Welcome back ' || cname || '!'||'your current balance is'||cbalance);
		if (bincome <0) then
			raise error_negative;
		end if;
		B := myPackage2.dotransaction(a,cbalance,bname,bincome);
		if (B = 1) then 
			dbms_output.put_line('transaction successful!');
			myPackage2.expensetrack(a,bname,bincome);
			
		elsif (B=0) then
			dbms_output.put_line('not successful');
		end if;
	--procEven(A);
	--DBMS_OUTPUT.PUT_LINE(B);

      end if;
exception

	when error_negative then
		dbms_output.put_line('scale factor cannot be -ve');
	
	when zero_divide then
		dbms_output.put_line('Cannot be divided by zero');
		
	when no_data_found then
		dbms_output.put_line('not found');
end;
/
