-- Tuần 6
use Northwind

--1. Hiển thị thông tin về hóa đơn có mã ‘10248’, bao gồm: OrderID, 
--OrderDate, CustomerID, EmployeeID, ProductID, Quantity, Unitprice, 
--Discount.
-- cách 1 
-- kết ở where
Select o.* 
from Orders o, [Order Details] d
where o.OrderID = d.OrderID and o.OrderID =10248

Select o.OrderID, o.OrderDate, o.CustomerID, o.EmployeeID, d.ProductID, d.Quantity, d.Unitprice,d.Discount
from Orders o, [Order Details] d
where o.OrderID = d.OrderID and o.OrderID =10248

-- kết ở from
Select o.OrderID, o.OrderDate, o.CustomerID, o.EmployeeID, d.ProductID, d.Quantity, d.Unitprice,d.Discount
from Orders o join [Order Details] d on  d.OrderID = o.OrderID
where o.OrderID  = 10248

Select o.OrderID, o.OrderDate, o.CustomerID, o.EmployeeID, d.ProductID, d.Quantity, d.Unitprice,d.Discount
from Orders o join [Order Details] d on  d.OrderID = o.OrderID
where o.OrderID  = 10248

-- lấy toàn bộ thuộc tính
Select *
from Orders o join [Order Details] d on  d.OrderID = o.OrderID
where o.OrderID  = 10248
-- lấy thuộc tính của riêng bảng order
Select o.*
from Orders o join [Order Details] d on  d.OrderID = o.OrderID
where o.OrderID  = 10248


--2. Liệt kê các khách hàng có lập hóa đơn trong tháng 7/1997 và 9/1997. 
--Thông tin gồm CustomerID, CompanyName, Address, OrderID, 
--Orderdate. Được sắp xếp theo CustomerID, cùng CustomerID thì sắp xếp 
--theo OrderDate giảm dần. 
--cách 1
select c.CustomerID, c.CompanyName, c.Address, o.OrderID, o.Orderdate
from Customers c join Orders o ON c.CustomerID = o.CustomerID
where (o.OrderDate >= '1997-07-01' and o.OrderDate <= '1997-07-31') or (o.OrderDate >= '1997-09-01' and o.OrderDate <= '1997-09-30')
order by c.CustomerID, o.OrderDate desc
-- cách 2
select c.CustomerID, c.CompanyName, c.Address, o.OrderID, o.Orderdate
from Customers c join Orders o ON c.CustomerID = o.CustomerID
where (month(o.OrderDate) = 7 or month(o.OrderDate) = 9) and year(o.OrderDate) = 1997
order by c.CustomerID, o.OrderDate desc

--cách 3
select c.CustomerID, c.CompanyName, c.Address, o.OrderID, o.Orderdate
from Customers c join Orders o ON c.CustomerID = o.CustomerID
where (month(o.OrderDate) = 7 and year(o.OrderDate) = 1997) or( month(o.OrderDate) = 9 and year(o.OrderDate) = 1997) 
order by c.CustomerID, o.OrderDate desc

-- cách 4: phep hôi, giao, trừ (ĐSQH) union,except, intersect => KHAR HOP 
select c.CustomerID, c.CompanyName, c.Address, o.OrderID, o.Orderdate
from Customers c join Orders o ON c.CustomerID = o.CustomerID
where (month(o.OrderDate) = 7 and year(o.OrderDate) = 1997) 
UNION
select c.CustomerID, c.CompanyName, c.Address, o.OrderID, o.Orderdate
from Customers c join Orders o ON c.CustomerID = o.CustomerID
where (month(o.OrderDate) = 9 and year(o.OrderDate) = 1997) 
order by c.CustomerID, o.OrderDate desc

--3. Liệt kê danh sách các mặt hàng xuất bán vào ngày 19/7/1996. Thông tin 
--gồm : ProductID, ProductName, OrderID, OrderDate, Quantity. 
select p.ProductID, p.ProductName, o.OrderID, oo.OrderDate, o.Quantity
from Products p 
	join [Order Details] o on p.ProductID = o.ProductID 
	join Orders oo on oo.OrderID = o.OrderID
where oo.OrderDate = '1996-07-19'

SET DATEFORMAT YMD 

select p.ProductID, p.ProductName, o.OrderID, oo.OrderDate, o.Quantity
from Products p, [Order Details] o, Orders oo
where p.ProductID = o.ProductID
	and o.OrderID = oo.OrderID 
	and oo.OrderDate = '1996-07-19'


SET DATEFORMAT DMY 

select p.ProductID, p.ProductName, o.OrderID, oo.OrderDate, o.Quantity
from Products p, [Order Details] o, Orders oo
where p.ProductID = o.ProductID
	and o.OrderID = oo.OrderID 
	and oo.OrderDate = '19-07-1996'

select p.ProductID, p.ProductName, o.OrderID, oo.OrderDate, o.Quantity
from Products p, [Order Details] o, Orders oo
where p.ProductID = o.ProductID
	and o.OrderID = oo.OrderID 
	and month(oo.OrderDate)= 7 and day(oo.OrderDate)= 19 and year(oo.OrderDate)= 1996

--4. Liệt kê danh sách các mặt hàng từ nhà cung cấp (supplier) có mã 1,3,6 và 
--đã xuất bán trong quý 2 năm 1997. Thông tin gồm : ProductID, 
--ProductName, SupplierID, OrderID, Quantity. Được sắp xếp theo mã nhà cung cấp (SupplierID), cùng mã nhà cung cấp thì sắp xếp theo 
--ProductID. 

---?????
select p.ProductID, p.ProductName, p.SupplierID, o.OrderID, o.Quantity, oo.OrderDate
from Products p
join [Order Details] o on p.ProductID =o.ProductID
join Orders oo ON o.OrderID = oo.OrderID
where p.SupplierID IN (1, 3, 6)
  and YEAR(oo.OrderDate) = 1997 and MONTH(oo.OrderDate) between 4 and 6
order by p.SupplierID, p.ProductID
----

select p.ProductID, p.ProductName, p.SupplierID, o.OrderID, od.Quantity, o.OrderDate
from Products p
join [Order Details] od on p.ProductID =od.ProductID
join Orders o ON o.OrderID = od.OrderID
where p.SupplierID IN (1, 3, 6)
  and YEAR(o.OrderDate) = 1997 and DATEPART(qq,o.OrderDate) = 2 -- quarter 
order by p.SupplierID, p.ProductID

select p.ProductID, p.ProductName, p.SupplierID, o.OrderID, od.Quantity, o.OrderDate
from Products p
join [Order Details] od on p.ProductID =od.ProductID
join Orders o ON o.OrderID = od.OrderID
where (p.SupplierID = 1 OR p.SupplierID = 3 OR p.SupplierID = 6)
  and YEAR(o.OrderDate) = 1997 and DATEPART(qq,o.OrderDate) = 2 -- quarter 
order by p.SupplierID, p.ProductID


--5. Liệt kê danh sách các mặt hàng có đơn giá bán bằng đơn giá mua
select *
from Products p
join [Order Details] o on p.ProductID = o.ProductID
where p.UnitPrice = o.UnitPrice


--6. Danh sách các mặt hàng bán trong ngày thứ 7 và chủ nhật của tháng 12
--năm 1996, thông tin gồm ProductID, ProductName, OrderID, OrderDate,
--CustomerID, Unitprice, Quantity, ToTal= Quantity*UnitPrice. Được sắp
--xếp theo ProductID, cùng ProductID thì sắp xếp theo Quantity giảm dần.

select DATEPART(dw,o.OrderDate), p.ProductID, p.ProductName, o.OrderID, od.Quantity, o.OrderDate,o.CustomerID, od.UnitPrice, od.Quantity, 
Total = od.UnitPrice * od.Quantity
from Products p
join [Order Details] od on p.ProductID =od.ProductID
join Orders o ON o.OrderID = od.OrderID
where DATEPART(dw,o.OrderDate) not in (7,8) --??1 --?9 
  and YEAR(o.OrderDate) = 1997 and month(o.OrderDate) = 12
order by p.ProductID, od.Quantity desc

select cs = DATENAME(WEEKDAY,o.OrderDate), p.ProductID, p.ProductName, o.OrderID, od.Quantity, o.OrderDate,o.CustomerID, od.UnitPrice, od.Quantity, 
Total = od.UnitPrice * od.Quantity
from Products p
join [Order Details] od on p.ProductID =od.ProductID
join Orders o ON o.OrderID = od.OrderID
where DATENAME(WEEKDAY,o.OrderDate) not in ('saturday','sunday')
  and YEAR(o.OrderDate) = 1997 and month(o.OrderDate) = 12
order by p.ProductID, od.Quantity desc

select DATENAME(WEEKDAY,o.OrderDate), p.ProductID, p.ProductName, o.OrderID, od.Quantity, o.OrderDate,o.CustomerID, od.UnitPrice, od.Quantity, 
Total = od.UnitPrice * od.Quantity
from Products p
join [Order Details] od on p.ProductID =od.ProductID
join Orders o ON o.OrderID = od.OrderID
where (DATENAME(WEEKDAY,o.OrderDate) != 'saturday' or  DATENAME(WEEKDAY,o.OrderDate) <> 'sunday') 
  and YEAR(o.OrderDate) = 1997 and month(o.OrderDate) = 12
order by p.ProductID, od.Quantity desc


--7. Liệt kê danh sách các nhân viên đã lập hóa đơn trong tháng 7 của năm
--1996. Thông tin gồm : EmployeeID, EmployeeName, OrderID,
--Orderdate.
SELECT e.EmployeeID, EmployeeName= e.FirstName +' ' +e.LastName, o.OrderID, o.Orderdate
FROM Employees e, Orders o
Where e.EmployeeID = o.EmployeeID and month(o.OrderDate) = 7 and year(o.OrderDate)=1996

--8. Liệt kê danh sách các hóa đơn do nhân viên có Lastname là ‘Fuller’ lập.
--Thông tin gồm : OrderID, Orderdate, ProductID, Quantity, Unitprice.
select  o.OrderID, o.Orderdate, od.ProductID, od.Quantity, od.Unitprice
from Employees e, [Order Details] od, Orders o
where  o.OrderID = od.OrderID and e.EmployeeID = o.EmployeeID
and e.LastName = 'Fuller' 


--9. Liệt kê chi tiết bán hàng của mỗi nhân viên theo từng hóa đơn trong năm
--1996. Thông tin gồm: EmployeeID, EmployName, OrderID, Orderdate,
--ProductID, quantity, unitprice, ToTalLine=quantity*unitprice.


--10.Danh sách các đơn hàng sẽ được giao trong các thứ 7 của tháng 12 năm
--1996.
SELECT *
FROM Orders
where datename(weekday,OrderDate) = 'saturday' and month(OrderDate) = 7 and year(OrderDate) =1996

SELECT *
FROM Orders
where datename(weekday,OrderDate) != 'saturday' and month(OrderDate) = 7 and year(OrderDate) =1996
--11.Liệt kê danh sách các nhân viên chưa lập hóa đơn (dùng LEFT
--JOIN/RIGHT JOIN).
select *
from orders o, Employees e
where o.EmployeeID = e.EmployeeID

select e.EmployeeID, o.EmployeeID
from orders o join Employees e on  o.EmployeeID = e.EmployeeID

-- kết nội
--INNER JOIN

-- kết ngoại
--LEFT
--RIGHT
--FULL OUTER JOIN 


select e.EmployeeID, o.EmployeeID
from Employees e LEFT join orders o   on  o.EmployeeID = e.EmployeeID
where o.EmployeeID is null 

select e.EmployeeID, o.EmployeeID
from orders o right join Employees e on  o.EmployeeID = e.EmployeeID
where o.EmployeeID is null 

---- cách 2 -- dùng phép trừ Except
Select EmployeeID
from Employees 
except
Select EmployeeID
from orders 



--12 Liệt kê danh sách các sản phẩm chưa bán được (dùng LEFT 
--JOIN/RIGHT JOIN)
select p.*
--SELECT p.ProductID ,od.ProductID
from Products p left join [Order Details] od ON p.ProductID = od.ProductID
where od.ProductID is null


select p.*
--SELECT p.ProductID ,od.ProductID
from [Order Details] od  RIGHT join Products p  ON p.ProductID = od.ProductID
where od.ProductID is null

--13 Liệt kê danh sách các khách hàng chưa mua hàng lần nào (dùng LEFT 
--JOIN/RIGHT JOIN).

SELECT c.CustomerID, o.CustomerID
FROM Customers  c  LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL

SELECT c.CustomerID, o.CustomerID
FROM Orders o RIGHT JOIN Customers  c  ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL

-- CÁCH 3 DÙNG PHÉP TRỪ (PHẢI KHẢ HỢP)
SELECT CustomerID
FROM Customers  
EXCEPT
SELECT CustomerID
FROM Orders  

