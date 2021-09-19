
set verify off;
set serveroutput on;


declare


	a customer.cid@site_link %type ;
	cname customer.cname@site_link %type := '&name';
	b customer.cpass@site_link %type := '&password';
	cbalance customer.balance %type:= &balance;
	location customer.cadd@site_link %type ;
	cnt number :=0;	
	deletes brand.bname@site_link %type := '&deletedata' ;
	signup brand.bname@site_link %type := '&dosignup' ;
	
begin
	for r in (select customer.cid,customer.cname,customer.cpass,customer.cadd,customer.balance from customer union select customer.cid@site_link,customer.cname@site_link,customer.cpass@site_link,customer.cadd@site_link,customer.balance@site_link from customer@site_link) loop
		if (r.cname = cname and r.cpass = b) then
			cnt:=1;
			a:= r.cid;
			cbalance := r.balance;
			
			
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
		
		myPackage2.signupp(cname,b,cbalance);
		dbms_output.put_line('signup successful');
	
	elsif(cnt=7) then
		
		 dbms_output.put_line('data delete');
		 delete from customer@site_link where cid=a;
	delete from customer where cid=a;
		commit;
			
		
		
	elsif(cnt=2) then
		dbms_output.put_line('Password not valid');
	
	elsif(cnt=1) then
		dbms_output.put_line('Welcome back ' || cname || '!'||' your current balance is '||cbalance);
				
		

      end if;
end;
/
