--
SELECT [ProductName] FROM [dbo].[Products]
--Lay ten san pham, gia ban tren moi don vi, so luong san pham tren moi don vi
SELECT ProductName, UnitPrice, UnitsOnOrder FROM Products
--Lay ra ten cong ty cua khach hang va quoc gia cua cac khach hang do
SELECT CompanyName, Country FROM Customers