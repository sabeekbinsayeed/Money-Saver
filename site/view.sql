create or replace view myview(customer) as
select customer.cname
from customer;

create or replace view myview2(Brand) as
select brand.bname
from brand;


select distinct* from myview;

select distinct * from myview2;

commit;
