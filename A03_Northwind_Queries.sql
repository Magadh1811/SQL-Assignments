use northwind;
show tables;
select * from customers ;
select * from orders ;

# Q1

select c.*,OrderID from customers as c join orders as o on c.CustomerID= o.CustomerId;

# Q2

select o.CustomerID,count(o.OrderID) as Total from Orders as o join customers as c on c.CustomerID = o.CustomerID where c.Country='UK' group by o.CustomerID order by Total DESC;

# Q3
select c.CustomerID,count(OrderID) from customers as c right join orders as o on c.CustomerID= o.CustomerId where c.Country = 'UK' group by c.CustomerID ;

# Q4
select * from customers as c right join orders as o on c.CustomerID= o.CustomerId;

# Q5
select ProductName, (UnitPrice-UnitPrice*0.1) as DiscountedPrice from products;

# Q6
select * from products order by UnitPrice DESC Limit 10;
