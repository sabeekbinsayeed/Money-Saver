
set verify off;
set serveroutput on;


declare


	
	adminid admin.aid %type ;
	aname admin.apassword %type := '&name';
	b admin.apassword %type := '&password';
	cnt number :=0;
	--check admin.aid %type ;
	
	
	
begin
	for r in (select aid,aname,apassword from admin) loop
		if (r.aname = aname and r.apassword = b) then
			
			cnt:=1;
			adminid := r.aid;
		elsif( r.aname = aname) then
			cnt:=2;




		end if;




	end loop;
	

	if(cnt =0) then
		dbms_output.put_line('Account not Found. please Sign up.');
	elsif(cnt=1) then
		dbms_output.put_line('Welcome back ' || aname || '!');
		myPackage2.seereport(1);
		
		
	elsif(cnt=2) then
		dbms_output.put_line('Password not valid');
	
	

      end if;

end;
/
