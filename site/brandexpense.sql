
set verify off;
set serveroutput on;


declare

bname brand.bname %type := '&brandname' ;
value expense.category %type;
a customer.cid %type := &id;
customername customer.cname %type;
cnt number :=0;
cost number :=0;
flag number :=0;
error_input exception;
	



	
	
begin
if (a = 0) then
	value := 'no';
	
end if;
	for r in (select bid,bname,income,cid from brand) loop
		if (r.bname=bname and value ='no') then
			cost := cost + r.income;
			flag := 1;
		elsif (r.bname=bname and r.cid=a) then
			cost := cost + r.income;
			flag :=2;
		
				
			end if;
		end loop;
	

for r in (select cname from customer where cid=a) loop
		customername := r.cname;
end loop;

if (flag =1 ) then
	DBMS_OUTPUT.PUT_LINE('total income '||bname||' is tk  '||cost);
elsif (flag =2) then
	DBMS_OUTPUT.PUT_LINE(customername||' bought products of tk  '||cost ||' from '||bname);
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





