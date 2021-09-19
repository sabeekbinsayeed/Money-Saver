
set verify off;
set serveroutput on;


declare


	a customer.cid %type ;
	cname customer.cname %type := '&name';
	b customer.cpass %type := '&password';
	emonth expense.month %type := '&month' ;
	ecategory expense.category %type := '&category' ;
	cnt number :=0;
	cost number :=0;
	totalcost number :=0;
	flag number :=0;
	percent number :=0;
	location customer.cadd %type ;
	error_input exception;
	
	
	



	
	
begin
	for r in (select cid,cname, cpass,cadd from customer) loop
		if (r.cname = cname and r.cpass = b) then
			--dbms_output.put_line('Welcome back ' || bname || '!');
			cnt:=1;
			a := r.cid;
		location := r.cadd;
			if (location != 'rajshahi') then
				cnt :=5;
			end if;
			
		elsif( r.cname = cname) then
			cnt:=2;




		end if;




	end loop;
	

	if(cnt =0) then
		dbms_output.put_line('Account not Found. please Sign up.');
	elsif(cnt=2) then
		dbms_output.put_line('password not valid');
	elsif(cnt=5) then
		dbms_output.put_line('outside dhaka not allowed');
	
	
	elsif(cnt=1) then
		for r in (select eid,month,cost,category,cid from expense) loop
			if (r.cid=a) then
			  totalcost := totalcost + r.cost ;	
			  	
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
			end if;
		end loop;

end if;
	--dbms_output.put_line(cost);




--dbms_output.put_line(flag);
if (flag =1 ) then
	percent := (cost/totalcost )*100;
	DBMS_OUTPUT.PUT_LINE('yours total cost is tk '||cost||' under category  '||ecategory||' in month '||emonth||' which is '||percent ||' percent of your total expense');
elsif (flag =2) then
	percent := (cost/totalcost )*100;	
	DBMS_OUTPUT.PUT_LINE('yours  cost is tk '||cost|| ' in month '||emonth||' which is '||percent ||' percent of your total expense');

elsif (flag=3) then
	percent := (cost/totalcost )*100;
	DBMS_OUTPUT.PUT_LINE('yours  cost is tk '||cost||' under category  '||ecategory||' which is '||percent ||' percent of your total expense');


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
