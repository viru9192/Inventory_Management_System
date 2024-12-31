-- Project Tasks:

-- 1. List the top 5 items with the highest stock.

-- Query:

select itemid, name, stockquantity 
from (
     select itemid, name, stockquantity 
     from items 
     order by stockquantity desc
     )
where rownum < 6;

-- _________________________________________________________

-- 2. Find suppliers who haven't supplied any purchase orders.

-- Query:

select supplierid, name
from suppliers
where 
supplierid not in (
                select distinct supplierid from purchaseorders
                );
				
-- _________________________________________________________

-- 3. Identify the item with the highest total quantity ordered.

-- Query:

SELECT Name, ItemID, total_quantity
from (
select i.name, i.itemid, o.orderid, sum(o.quantity) as total_quantity
from items i
join orderdetails o
on 
i.itemid = o.itemid
group by i.name, i.itemid, o.orderid
order by total_quantity desc
)
where rownum < 2;

-- Alternate Solution:

select i.name, i.itemid, o.orderid, sum(o.quantity) as total_quantity
from items i
join orderdetails o
on 
i.itemid = o.itemid
group by i.name, i.itemid, o.orderid
order by total_quantity desc
fetch first 1 row only;

-- _________________________________________________________

-- 4. List all purchase orders made in the last 30 days.

-- Query:

select * from purchaseorders
where 
orderdate >= sysdate - 30;

-- _________________________________________________________

-- 5. Calculate the total revenue generated (stock price * quantity sold).

-- Query:

select sum(i.price * o.quantity) as Total_Revenue
from items i
join orderdetails o
on 
i.itemid = o.itemid;

-- _________________________________________________________

-- 6. List items that are out of stock.

-- Query:

select itemid, name
from items 
where 
stockquantity = 0;

-- _________________________________________________________

-- 7. Get the total value of items in stock (stock quantity * price per item).

-- Query:

select sum(stockquantity * price) as Total_Value
from items;


-- _________________________________________________________

-- 8. Find the supplier with the most purchased items.

-- Query:

select s.supplierid, s.name, sum(o.quantity) as totalcost
from suppliers s
join purchaseorders p
on 
s.supplierid = p.supplierid
join orderdetails o
on
p.orderid = o.orderid
group by s.supplierid, s.name, totalcost
order by totalcost desc
fetch first 1 row only;

-- _________________________________________________________

-- 9. Find items with stock quantity below the stock quantity < 20.

-- Query:

select * from items 
where 
stockquantity < 20
order by stockquantity desc;


-- _________________________________________________________

-- 10. List all suppliers and the total amount they’ve invoiced (i.e., total cost of all their purchase orders).

-- Query:

select s.supplierid, s.name, sum(p.totalcost) as Total_Invoice
from suppliers s
join purchaseorders p
on
s.supplierid = p.supplierid
group by s.supplierid, s.name
order by Total_Invoice desc;
