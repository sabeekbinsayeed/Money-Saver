create or replace view myview(Brand) as
select  brand.bname
from brand;



create or replace view myview(customername,customerbalance) as
select customer.cname,customer.balance from customer union select customer.cname@site_link,customer.balance@site_link from customer@site_link;



select distinct * from myview;



select distinct * from myview2;

commit;
