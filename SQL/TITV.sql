--Viết lệnh SQL lấy ra tên và sdt của tất cả các nhà cung cấp hàng
SELECT CompanyName, Phone FROM Suppliers
--Viết leẹnh lấy ra tất cả dữ liệu của bảng Products
SELECT * FROM  dbo.Products
SELECT * FROM dbo.Customers
--SELECT DISTNICT
--Viết câu lệnh SQL lấy ra tên các quốc gia khác nhau từ bảng Customers
SELECT DISTINCT Country FROM Customers
--Lấy ra các mã số bưu điện khác nhau của Supplier
SELECT DISTINCT PostalCode FROM dbo.Suppliers
--Viết câu lệnh SQL lấy ra các dữ liệu khác nhau về họ của nhân viên (Last Name) và cách gọi danh hiệu lịch sự (TitleOfCourtesy) của nhân viên Employées
SELECT DISTINCT	LastName, TitleOfCourtesy FROM dbo.Employees
--Viết câu lệnh SQL lấy ra mã vận đơn vị vận chuyển (ShipVia) khác nhau của các đơn hàng - Orders
SELECT DISTINCT ShipVia FROM dbo.Orders

--SELECT...TOP...FROM
--SELECT TOP colum_name FROM table_name WHERE condition;
--Viết lệnh SQL lấy ra 5 dòng đầu tiên trong Customers
SELECT TOP 5 * FROM Customers;
--Viết lệnh lấy ra 30% nhân viên của công ty hiện tại
SELECT TOP 30 PERCENT * FROM Employees;
--Viết lệnh SQL lấy ra các mã khách hàng trong bảng đơn hàng  với quy định là mã khách hàng không dudowcj trùng lặp, chỉ lấy 5 dòng dữ liệu đầu
SELECT DISTINCT TOP 5 [CustomerID] FROM [dbo].[Orders]


--CÁCH ĐẶT TÊN THAY THẾ CHO CÁC CỘT VÀ BẢNG ALIAS
--SELECT colum_name AS alias_name FROM table_name (cot)
-- SELECT colum_name(s) FROM table_name AS alias_name (bảng)

--Viết câu lệnh SQL lấy "CompanyName" và đặt tên thay thế là "Công Ty"; "PostalCode" và đặt tên thay thế là "Mã bưu điện"
SELECT CompanyName AS "Công Ty", PostalCode AS "Mã bưu điện"
FROM Customers
--Viết câu lệnh lấy ra "LastName" và đặt tên thay thế là "Họ", "FirstName" đặt tên thay thế là "Tên"
SELECT LastName AS "Họ", FirstName AS "Tên"
FROM Employees
--Viết lệnh lấy ra 15 dòng đầu tiên tất cả các cột trong bảng Orders, đặt tên thay thế cho bằng là "o"
SELECT TOP 15 o.* FROM Orders AS "o";

SELECT TOP 5 p.ProductName AS [Tên Sản Phẩm], p.SupplierID AS [Mã nhà cung cấp], p.CategoryID AS [Mã thể loại]
FROM Products AS [p]
--Tìm giá trị nhỏ nhất
--SELECT MIN(COLUMNAME)
--FROM TABLE_NAME
--Viết câu lệnh tìm giá trị nhỏ nhất của các sản phẩm bảng Products
	SELECT MIN(UnitPrice) AS MinRice
	FROM Products
--Viet lenh lay ra ngay dat hang gan day nhat tu Orders
	SELECT MAX(OrderDate)
	FROM Orders
--VIET CAU LENH TIM RA SAN PHAMCO SO LUONG HANG TOT KHO(UNITSLNSTOCK) LOWNS NHAT
	SELECT MAX([UnitsInStock]) AS "TON KHO"
	FROM DBO.Products

--DEM SO LUONG - COUNT
--SELECT COUNT(COULUM_NAME) FROM TABLE_NAME
--tINH TONG -- SUM
--SELECT SUM(COULME_NAME) FROM TABLE_NAME
--TINH TRUNG BINH - AVG
--SELECT AVG(COLUM_NAME) FROM TABLE NAME
--DEM SO LUONG KHACH HANG CO TRONG BANG CUSTOME
	SELECT COUNT(*) AS [NUMBEROFCUSTOMER]
	FROM Customers
--TINH TONG SO TIEN VAN CHUYEN (FERIGHT) CUAR TAT CA CAC DON DAT HANG
	SELECT SUM(Freight) AS [SO TIEN VAN CHUYEN]
	FROM Orders
--tINH TRUNG BINH SO LUONG DAT HANG (QUANLITY) CUA TAT CA CAC SP TRONG ORDER DETAILS
	SELECT AVG([Quantity]) AS [AVGQuantity]
	FROM [dbo].[Order Details]
--DEM SO LUONG, TINH TONG SO LUONG HANG TON KHO, VA TRUNG BINH GIA CUA CAC SAN PHAM CO TRONG BANG PRODUCT
	SELECT COUNT(*) AS [COUNT PRODUCTS], 
		   SUM([UnitsInStock]) AS [SUM UnitsInStock], 
		   AVG([UnitPrice]) AS [AVG UnitPrice]
	FROM Products

--ORDER BY
--SELECT COULUMN1, COLUMN2
--FROM TABLE_NAME
--ORDER BY COLUMN1, COLUMN2,... ASC(SAP XEP TANG DAN)| DESC(SAP XEP GIAM DAN)
--LIET KE TAT CA CAC NHA CUNG CAP THEO THU TU TEN DON VI COMPANYNAME YU A-Z
	SELECT *
	FROM [dbo].[Suppliers]
	ORDER BY [CompanyName] ASC
--LIET KE TAT CA CAC SAN PHAM THEO THU TU GIA GIAM DAN
	SELECT *
	FROM Products
	ORDER BY [UnitPrice] DESC
--LAY RA 1 SAN PHAM CO SO LUONG BAN CAO NHAT TU ORDERS DETAIL 
	SELECT TOP 1 *
	FROM [dbo].[Order Details]
	ORDER BY [Quantity] DESC
--LIET KE DANH SACH CAC DON DAT HANG  ORDERID TRONG ORDER THEO THU TU GIAM DAN CUA NGAY DAT HANG
	SELECT [OrderID]
	FROM [dbo].[Orders]
	ORDER BY [OrderDate] DESC

--CAC PHEP TOAN
--TINH SO LUONG SAN PHAM CON LAI TRONG KHO (UNITSTOCK) SAU KHI BAN HET CAC SAN PHAM DA DUOC DAT HANG
	SELECT [ProductID],[ProductName], [UnitsInStock]-[UnitsOnOrder] AS STOCKREMAINING
	FROM [dbo].[Products]
--TINH GIA TRI DON HANG CHI TIET CHO TAT CA CAC SAN PHAM TRONG BANG ORDERDETAIL
	SELECT *, [UnitPrice]*[Quantity] AS ORDERDETAILVALUE
	FROM [dbo].[Order Details]
--TINH TY LE
	SELECT AVG([Freight])/MAX([Freight]) AS FREIGHTRATIO
	FROM [dbo].[Orders]


	--WHERE
	--SELECT COULMN1, COLUMN2
	--FROM TABLE_NAME
	--WHERE CONDITION
--LIET KE TAT CA CAC NHAN VIEN DEN TU TP LONDON
	SELECT *
	FROM [dbo].[Employees] WHERE City = 'LonDon'
	ORDER BY [LastName] ASC

	SELECT  COUNT (*) AS [SO LUONG]
	FROM [dbo].[Orders] 
	WHERE [ShippedDate]>[RequiredDate]

	SELECT *
	FROM [dbo].[Order Details]
	WHERE [Discount] > 0.1
--AND, OR, NOT
	SELECT *
	FROM [dbo].[Products]
	WHERE [UnitsInStock] < 50 OR [UnitsInStock] > 100

	SELECT *
	FROM [dbo].[Orders]
	WHERE [ShipCountry] = 'Brazil' AND [RequiredDate] < [ShippedDate]

	SELECT *
	FROM [dbo].[Products]
	WHERE NOT ([UnitPrice] >= 100 OR [ProductID] =1 )
	ORDER BY [UnitPrice] ASC

--BETWEEN
	--SELECT COLUMN_NAME
	--FROM TABLE_NAME
	--WHERE COLUMN_NAME BETWEEN VALUE1 AND VALUE2;
	SELECT *
	FROM [dbo].[Products]
	WHERE [UnitPrice] BETWEEN 10 AND 20

	SELECT SUM([Freight])
	FROM [dbo].[Orders]
	WHERE [OrderDate] BETWEEN '1996-07-01' AND '1996-07-31'

	--LIKE
	--SELECT COLUMN_NAME
	--FROM TABLE_NAME
	--WHERE COLUMN_NAME LIKE PATTERN;
	SELECT *
	FROM [dbo].[Customers]
	WHERE [Country] LIKE 'A%'

	SELECT *
	FROM [dbo].[Orders]
	WHERE ShipCity LIKE '%a%'

-- CAC THANH PHO BAT DAU BANG L, Ky TU THU HAI LA a HOAC o

	SELECT [OrderID]
	FROM [dbo]. [Orders]
	WHERE [ShipCity] LIKE 'L[u,O]%';
-- CAC THANH PHO BAT DAU BANG L, Ky TU THU HAI KHONG LA a HOAC o
	SELECT [OrderID]
	FROM [dbo]. [Orders]
	WHERE [ShipCity] LIKE  'L[^u,O]%';
	-- CAC THANH PHO BAT DAU BANG L, Ky TU THU HAI  LA a DEN e
	SELECT [OrderID],[ShipCity]
	FROM [dbo]. [Orders]
	WHERE [ShipCity] LIKE  'L[a-u]%';
	--LOC DU LIEU BANG IN
	--SELECT COLUMN_NAME(S)
	--FROM TABLE_NAME
	--WHERE COLUMN_NAME IN (VALUES1, VALUE2,..)
	SELECT *
	FROM [dbo].[Orders]
	WHERE ShipCountry IN ('Germany', 'UK', 'Brazil')

	SELECT *
	FROM [dbo].[Orders]
	WHERE ShipCountry NOT IN ('Germany', 'UK', 'Brazil')

	--SELECT column_name(s)
	--FROM table_name
	--WHERE condition
	--GROUP BY coLumn_name(s)
	--ORDER BY column_name(s);
	--HAY CHO BIET MOI KHACH HANG DAT BAO NHIEU DON HANG
	SELECT [CustomerID], COUNT([OrderID])
	FROM [dbo].[Orders]
	GROUP BY [CustomerID]
	-- HAY TINH GIA TRI DON GIA TRUNG BINH THEO MOI NHA CUNG CAP SAN PHAM
	SELECT [SupplierID], AVG([UnitPrice]) AS [DON GIA TRUNG BINH]
	FROM [dbo].[Products]
	GROUP BY [SupplierID]

	SELECT [CategoryID], SUM([UnitsInStock]) AS [TONG SO]
	FROM [dbo].[Products]
	GROUP BY [CategoryID]

	SELECT [ShipCity],[ShipCountry], MIN([Freight]) AS [MIN FREIGHT], MAX([Freight]) AS [MAX FREIGHT]
	FROM [dbo].[Orders]
	GROUP BY [ShipCity],[ShipCountry]

	--NGAY, THANG,NAM
	--TINH SO LUONG DON DAT HANG TRONG NAM 1997 CUA TUNG KHACH HANG
	SELECT [CustomerID], COUNT([OrderID]), YEAR([OrderDate]) AS [YEAR]
	FROM [dbo].[Orders]
	WHERE YEAR([OrderDate]) = 1997
	GROUP BY [CustomerID],YEAR([OrderDate])
	--HAVING
	--SELECT column_name(s)
	--FROM table_name
	--WHERE condition
	--GROUP BY coLumn_njyme(s)
	--HAVING condition
	--ORDER BY column_name(s);
	
	SELECT [CustomerID], COUNT([OrderID]) AS [TOTAL ORDER]
	FROM [dbo].[Orders]
	GROUP BY [CustomerID]
	HAVING COUNT([OrderID]) > 20
	ORDER BY [TOTAL ORDER] ASC