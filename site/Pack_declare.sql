create or replace package myPackage as
	
	function dotransaction(a in customer.cid %TYPE,cbalance in customer.balance %TYPE,bname in brand.bname %type,bincome in brand.income %type)
		return customer.cid %TYPE;

	procedure expensetrack(a in customer.cid%TYPE,bname in brand.bname %type,bincome in brand.income %type);

	procedure signupp(cname customer.cname %type,cpass customer.cpass %type,cbalance customer.balance %type);
	
end myPackage;
/