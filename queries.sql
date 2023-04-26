-- Multi-Table Sorgu Pratiği

-- Tüm ürünler(product) için veritabanındaki ProductName ve CategoryName'i listeleyin. (77 kayıt göstermeli)
SELECT 
c.CategoryName, p.*
FROM Products as p 
JOIN Category as c
ON c.CategoryID = p.CategoryID

-- 9 Ağustos 2012 öncesi verilmiş tüm siparişleri(order) için sipariş id'si (Id) ve gönderici şirket adını(CompanyName)'i listeleyin. (429 kayıt göstermeli)
select 
c.CompanyName, o.Id
from Order as o
join Customer as c
on c.Id = o.CustomerID
where o.OrderDate < '2012-08-09'
-- Id'si 10251 olan siparişte verilen tüm ürünlerin(product) sayısını ve adını listeleyin. ProdcutName'e göre sıralayın. (3 kayıt göstermeli)
select 
p.QuantityPerUnit,  p.ProductName
from OrderDetail as o
join Product as p
on p.Id = o.ProductId
where o.OrderID = 10251
order by p.ProductName

-- Her sipariş için OrderId, Müşteri'nin adını(Company Name) ve çalışanın soyadını(employee's LastName). Her sütun başlığı doğru bir şekilde isimlendirilmeli. (16.789 kayıt göstermeli)
select o.Id as 'OrderId', c.CompanyName, e.LastName from [Order] as o 
join Employee e 
on o.EmployeeId = o.Id
join Customer c 
on c.Id = o.CustomerId

----------------------------------------
------Esnek------
--------------------------------------
select c.CustomerName, Count(*) from [Orders] o
join Custromer c on o.CustomerID = c.CustomerID
group by CustomerID
order by Count(*) desc
--------------------------------------
select e.FirstName, e.LastName, count(*) from [Orders] o
join Employees e on e.EmployeeId=o.EmployeeId
group by o.EmployeeId
order by Count(*) desc
limit 5
--------------------------------------
select  e.FirstName, e.LastName, (od.Quantity * p.Price) as 'SiparisTutari' from OrderDetails od 
join Orders o on od.OrderID= o.OrderID
join Products p on od.ProductID = p.ProductID
join Employees e on e.EmployeeID = o.EmployeeID
group by o.EmployeeID
order by Sum(od.Quantity * p.Price) desc
limit 5
-------------------------------------
select  c.CategoryName, (od.Quantity * p.Price) as 'SiparisTutari' from OrderDetails od 
join Orders o on od.OrderID= o.OrderID
join Products p on od.ProductID = p.ProductID
join Categories c on c.EmployeeID = p.CategoryID
group by o.EmployeeID
order by Sum(od.Quantity * p.Price) asc
limit 5
-------------------------------------
select c.CustomerName, c.Country count(*) as 'SiparisSayisi' from [Orders] o
join Customers c on c.CustomerID = o.CustomerID
group by CustomerID 
order by Count(*) desc