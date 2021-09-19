
set verify off;
set serveroutput on;


declare


	a customer.cid@site_link %type ;
	cname customer.cname@site_link %type := '&name';
	b customer.cpass@site_link %type := '&password';
	emonth expense.month@site_link %type := '&month' ;
	ecategory expense.category@site_link %type := '&category' ;
	cnt number :=0;
	cost number :=0;
	flag number :=0;
	error_input exception;
	
	


	
	
begin
	for r in (select customer.cid,customer.cname,customer.cpass,customer.cadd,customer.balance from customer union select customer.cid@site_link,customer.cname@site_link,customer.cpass@site_link,customer.cadd@site_link,customer.balance@site_link from customer@site_link) loop
		if (r.cname = cname and r.cpass = b) then
			cnt:=1;
			a := r.cid;
			
		elsif( r.cname = cname) then
			cnt:=2;


		end if;


	end loop;
	

	if(cnt =0) then
		dbms_output.put_line('Account not Found. please Sign up.');
	elsif(cnt=2) then
		dbms_output.put_line('password not valid');
	
	elsif(cnt=1) then
		for r in (select eid,month,cost,category,cid from expense@site_link) loop
			if (r.month = emonth and r.category=ecategory and r.cid=a) then
			  cost := cost + r.cost ;	
			  flag := 1;		
			elsif (r.month= emonth and r.cid=a and ecategory='no' ) then
			   cost := cost + r.cost;
			   flag := 2;
			elsif (r.category= ecategory and r.cid=a and emonth ='no') then
			   cost := cost + r.cost;
			   flag := 3;
			elsif (ecategory= 'no' and r.cid=a and emonth ='no') then
			   cost := cost + r.cost;
			   flag := 4;
			
			end if;
		end loop;

end if;
	--dbms_output.put_line(cost);




--dbms_output.put_line(flag);
if (flag =1 ) then
	
	DBMS_OUTPUT.PUT_LINE('yours total cost is tk '||cost||' under category  '||ecategory||' in month '||emonth);
elsif (flag =2) then
	DBMS_OUTPUT.PUT_LINE('yours total cost is tk '||cost|| ' in month '||emonth);

elsif (flag=3) then
DBMS_OUTPUT.PUT_LINE('yours total cost is tk '||cost||' under category  '||ecategory);


elsif (flag=4) then
DBMS_OUTPUT.PUT_LINE('yours total cost is tk '||cost);
else 
	raise error_input;


end if;


exception

	when error_input then
		dbms_output.put_line('wrong input');
	
	when zero_divide then
		dbms_output.put_line('Cannot be divided by zero');
		
	when no_data_found then
		dbms_output.put_line('not found');


end;
/
