
--Tuần 7 

--1. Liệt kê danh sách các orders ứng với tổng tiền của từng hóa đơn. Thông tin 
--bao gồm OrderID, OrderDate, Total. Trong đó Total là Sum của Quantity * 
--Unitprice, kết nhóm theo OrderID.

select o.OrderID,o.OrderDate, od.Quantity * od.UnitPrice as Total
from Orders o  join [Order Details] od on o.OrderID = od.OrderID

select o.OrderID,o.OrderDate, sum(od.Quantity * od.UnitPrice) as Total
from Orders o inner join [Order Details] od on o.OrderID = od.OrderID
group by o.OrderID, o.OrderDate


--2. Liệt kê danh sách các orders mà địa chỉ nhận hàng ở thành phố ‘Madrid’
--(Shipcity). Thông tin bao gồm OrderID, OrderDate, Total. Trong đó Total
--là tổng trị giá hóa đơn, kết nhóm theo OrderID.
select o.ShipCity, o.OrderID,o.OrderDate,sum(od.Quantity * od.UnitPrice) as Total
from Orders o inner join [Order Details] od on o.OrderID = od.OrderID
where o.ShipCity = 'Madrid'
group by o.OrderID, o.OrderDate, o.ShipCity

COUNT(*) DEM LUON NULL


--3. Viết các truy vấn để thống kê số lượng các hóa đơn : 
--- Trong mỗi năm. Thông tin hiển thị : Year , CoutOfOrders ?
select year(OrderDate) as year, count(OrderID) as CountOfOrders  
from Orders
group by year(OrderDate)
--- Trong mỗi tháng/năm . Thông tin hiển thị : Year , Month, 
--CoutOfOrders ?
select month(OrderDate) as Month, year(OrderDate) as year, count(OrderID) as CountOfOrders 
from Orders
group by year(OrderDate) , month(OrderDate)

--- Trong mỗi tháng/năm và ứng với mỗi nhân viên. Thông tin hiển 
--thị : Year, Month, EmployeeID, CoutOfOrders ?
select year(OrderDate) as year, month(OrderDate) as Month, EmployeeID, count(OrderID) as CountOfOrders 
from Orders
group by year(OrderDate) , month(OrderDate), EmployeeID


--4. Cho biết mỗi Employee đã lập bao nhiêu hóa đơn. Thông tin gồm 
--EmployeeID, EmployeeName, CountOfOrder. Trong đó CountOfOrder là tổng số hóa đơn của từng employee. EmployeeName được ghép từ 
--LastName và FirstName.
select e.EmployeeID, concat(e.LastName, ' ', e.FirstName) as EmployeeName, count(*) as CountOfOrders
from Employees e
  join Orders o on e.EmployeeID = o.EmployeeID
group by e.EmployeeID, e.LastName, e.FirstName 


--5. Cho biết mỗi Employee đã lập được bao nhiêu hóa đơn, ứng với tổng tiền
--các hóa đơn tương ứng. Thông tin gồm EmployeeID, EmployeeName, 
--CountOfOrder , Total.
select e.EmployeeID, concat(e.LastName, ' ', e.FirstName) as EmployeeName, 
	count(*) as CountOfOrders, sum(od.Quantity * od.UnitPrice) AS Total
from Employees e
  join Orders o on e.EmployeeID = o.EmployeeID
  join [Order Details] od on o.OrderID = od.OrderID
GROUP BY
  e.EmployeeID, e.LastName, e.FirstName


--6. Liệt kê bảng lương của mỗi Employee theo từng tháng trong năm 1996
--gồm EmployeeID, EmployName, Month_Salary, Salary =
--sum(quantity*unitprice)*10%. Được sắp xếp theo Month_Salary, cùmg
--Month_Salary thì sắp xếp theo Salary giảm dần.
select e.EmployeeID, EmployName = LastName +' '+ FirstName
, Month_Salary = month(o.OrderDate), salary = sum(quantity*unitprice)*0.1
from [Order Details] od, Orders o, Employees e
where od.OrderID = o.OrderID and e.EmployeeID = o.EmployeeID and year(o.OrderDate)=1996
group by e.EmployeeID, LastName , FirstName, month(o.OrderDate)

--7. Tính tổng số hóa đơn và tổng tiền các hóa đơn của mỗi nhân viên đã bán
--trong tháng 3/1997, có tổng tiền >4000. Thông tin gồm EmployeeID,
--LastName, FirstName, CountofOrder, Total.

select e.EmployeeID, e.LastName, e.FirstName, CountofOrder=count(o.OrderID), Total= sum(od.quantity*unitprice)
from Orders o, Employees e, [Order Details] od
where o.EmployeeID = e.EmployeeID and od.OrderID = o.OrderID
and month(o.OrderDate)=3 and year(o.orderDate)=1997
group by e.EmployeeID, e.LastName, e.FirstName
having sum(od.quantity*unitprice) > 4000


--8. Liệt kê danh sách các customer ứng với tổng số hoá đơn, tổng tiền các hoá
--đơn, mà các hóa đơn được lập từ 31/12/1996 đến 1/1/1998 và tổng tiền các
--hóa đơn >20000. Thông tin được sắp xếp theo CustomerID, cùng mã thì
--sắp xếp theo tổng tiền giảm dần.
set dateformat dmy 
select CustomerID, Total= sum(od.quantity*unitprice)
from Orders o, [Order Details] od
where o.OrderID = od.OrderID and
o.orderDate between '31/12/1996' and '1/1/1998'
group by CustomerID
order by CustomerID, Total desc

set dateformat dmy 
select CustomerID, Total= sum(od.quantity*unitprice)
from Orders o, [Order Details] od
where o.OrderID = od.OrderID and
o.orderDate >= '31/12/1996' and  o.orderDate <= '1/1/1998'
group by CustomerID
order by CustomerID, Total desc
--9. Liệt kê danh sách các customer ứng với tổng tiền của các hóa đơn ở từng
--tháng. Thông tin bao gồm CustomerID, CompanyName, Month_Year,
--Total. Trong đó Month_year là tháng và năm lập hóa đơn, Total là tổng của
--Unitprice* Quantity.
select c.CustomerID, c.CompanyName,concat(month(OrderDate),'-', year(OrderDate)) as Month_Year,Total=SUM(od.Unitprice* od.Quantity)
from Customers c, Orders o, [Order Details] od
where c.CustomerID = o.CustomerID and od.OrderID = o.OrderID
group by c.CustomerID, c.CompanyName,month(OrderDate), year(OrderDate)

--10.Liệt kê danh sách các nhóm hàng (category) có tổng số lượng tồn
--(UnitsInStock) lớn hơn 300, đơn giá trung bình nhỏ hơn 25. Thông tin bao
--gồm CategoryID, CategoryName, Total_UnitsInStock, Average_Unitprice.
select ct.CategoryID, ct.CategoryName, Total_UnitsInStock= SUM(p.UnitsInStock), Average_Unitprice = AVG(p.UnitPrice)
from Categories ct
join Products p ON p.CategoryID = ct.CategoryID
group by ct.CategoryID, ct.CategoryName
having SUM(p.UnitsInStock)>300 and AVG(p.UnitPrice)<25

TRUE AND TRUE -> HIEN THI 

--11.Liệt kê danh sách các nhóm hàng (category) có tổng số mặt hàng (product)
--nhỏ hớn 10. Thông tin kết quả bao gồm CategoryID, CategoryName,
--CountOfProducts. Được sắp xếp theo CategoryName, cùng CategoryName
--thì sắp theo CountOfProducts giảm dần.

select ct.CategoryID, ct.CategoryName, CountOfProducts = COUNT(p.ProductID)
from Categories ct
join Products p ON p.CategoryID = ct.CategoryID
group by ct.CategoryID, ct.CategoryName
having COUNT(p.ProductID)<10
order by CategoryName, CountOfProducts desc

--12.Liệt kê danh sách các Product bán trong quý 1 năm 1998 có tổng số lượng
--bán ra >200, thông tin gồm [ProductID], [ProductName], SumofQuatity
select p.ProductID, p.ProductName, SumofQuatity = Sum(od.Quantity)
from Products p, [Order Details] od, Orders o  
where YEAR(o.OrderDate) = 1998 and datepart(qq, o.OrderDate) =1 and p.ProductID = od.ProductID and o.OrderID = od.ProductID
group by p.ProductID, p.ProductName 
having SUM(od.Quantity) > 200

--13.Cho biết Employee nào bán được nhiều tiền nhất trong tháng 7 năm 1997
select top 1 with ties  e.EmployeeID, e.EmployeeID, EmployeeName = e.FirstName + e.LastName, SUM(od.Quantity * od.UnitPrice ) as Total
from Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN [Order Details] od ON o.OrderID = od.OrderID
where month(o.OrderDate )= 7 and year(o.OrderDate) = 1997
group by e.EmployeeID, e.FirstName, e.LastName
order by Total desc


--14.Liệt kê danh sách 3 Customer có nhiều đơn hàng nhất của năm 1996.
-- cách 1
select top 3 with ties c.CustomerID,  c.CustomerID, c.ContactName, NumberofOrder = count(*)
from Customers c
join Orders o on o.CustomerID = c.CustomerID
where year(o.OrderDate) = 1996
group by c.CustomerID, c.ContactName
order by NumberofOrder desc


-- 60
-- 60
-- 60
-- 60 
-- cách 2
select top 3 with ties c.CustomerID,  c.CustomerID, c.ContactName, NumberofOrder = count(*)
from Customers c, Orders o  
where year(o.OrderDate) = 1996 and o.CustomerID = c.CustomerID
group by c.CustomerID, c.ContactName
order by NumberofOrder desc


--15.Liệt kê danh sách các Products có tổng số lượng lập hóa đơn lớn nhất.
--Thông tin gồm ProductID, ProductName, CountOfOrders.

select top 1 with ties p.ProductID, p.ProductName, CountOfOrders = count(o.OrderDate)
from Products p, [Order Details] od ,  Orders o  
where p.ProductID = od.ProductID and od.OrderID = o.OrderID
group by p.ProductID, p.ProductName
order by CountOfOrders desc