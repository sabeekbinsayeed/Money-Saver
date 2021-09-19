
set verify off;
set serveroutput on;


declare

	
	signup brand.bname %type := '&press_y_for_signup' ;
	deletes brand.bname %type := '&press_y_for_delete' ;
	a customer.cid %type ;
	cname customer.cname %type := '&name';
	b customer.cpass %type := '&password';
	cbalance customer.balance %type:= &balance;
	location customer.cadd %type ;
	cnt number :=0;	
	
	
begin
	for r in (select cid,cname,cpass,cadd,balance from customer) loop
		if (r.cname = cname and r.cpass = b) then
			cnt:=1;
			a:= r.cid;
			cbalance := r.balance;
			location := r.cadd;
			if (location != 'rajshahi') then
				cnt :=5;
			end if;
			
		elsif( r.cname = cname) then
			cnt:=2;

		end if;




	end loop;

if (signup ='y') then
 	cnt :=6;
end if;

if (deletes ='y') then
	cnt :=7;
end if;


	

	if(cnt =0) then
		dbms_output.put_line('Account not Found. please Sign up.');
	elsif(cnt=6) then
		myPackage.signupp(cname,b,cbalance);
		dbms_output.put_line('signup successful');
	elsif(cnt=5) then
		dbms_output.put_line('outside rajshahi not allowed');
	elsif(cnt=7) then		
		 dbms_output.put_line('data delete');
		 delete from customer where cid=a;
		commit;
	elsif(cnt=2) then
		dbms_output.put_line('Password not valid');
	
	elsif(cnt=1) then
		dbms_output.put_line('Welcome back ' || cname || '!'||' your current balance is '||cbalance);
		
			
      end if;
end;
/
