create or replace package myPackage2 as
	
	function dotransaction(a in customer.cid@site_link %TYPE,cbalance in customer.balance@site_link %TYPE,bname in brand.bname@site_link %type,bincome in brand.income@site_link %type)
  return customer.cid %TYPE;
  

	procedure expensetrack(a in customer.cid%TYPE,bname in brand.bname@site_link %type,bincome in brand.income@site_link %type);
		
	procedure signupp(cname customer.cname %type,cpass customer.cpass %type,cbalance customer.balance %type);
	procedure seereport(a in admin.aid%type);



	
end myPackage2;
/