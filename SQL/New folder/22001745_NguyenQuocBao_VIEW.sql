--Họ và tên: Nguyễn Quốc Bảo
--MSSV: 22001745

--1. Tạo view vw_Products_Info hiển thị danh sách các sản phẩm từ bảng
--Products và bảng Categories. Thông tin bao gồm CategoryName,
--Description, ProductName, QuantityPerUnit, UnitPrice, UnitsInStock ?
--Thực hiện truy vấn dữ liệu từ View ?
use Northwind
CREATE VIEW vw_Products_Info AS
SELECT 
    C.CategoryName,
    C.Description AS CategoryDescription,
    P.ProductName,
    P.QuantityPerUnit,
    P.UnitPrice,
    P.UnitsInStock
FROM
    Products P
JOIN
    Categories C ON P.CategoryID = C.CategoryID;

	--Truy vấn dữ liệu từ view
	SELECT * FROM vw_Products_Info;

--2. Tạo view vw_CustomerTotals hiển thị tổng tiền các hóa đơn của mỗi
--khách hàng theo tháng và theo năm. Thông tin gồm CustomerID,
--YEAR(OrderDate) AS Year, MONTH(OrderDate) AS Month,
--SUM(UnitPrice*Quantity) ?	CREATE VIEW vw_CustomerTotals AS
	SELECT
		CustomerID,
		YEAR(OrderDate) AS Year,
		MONTH(OrderDate) AS Month,
		SUM(UnitPrice * Quantity) AS TotalAmount
	FROM
		Orders O
	JOIN
		[dbo].[Order Details] OD ON O.OrderID = OD.OrderID
	GROUP BY
		CustomerID, YEAR(OrderDate), MONTH(OrderDate);

	--Truy vấn dữ liệu từ view
	SELECT * FROM vw_CustomerTotals;

--3. Tạo view hiển thị tổng số lượng sản phẩm bán được của mỗi nhân viên
--theo từng năm. Thông tin gồm EmployeeID, OrderYear,
--SumOfQuantity. Yêu cầu : người dùng không xem được cú pháp lệnh tạo
--view ?
--Xem lại cú pháp lệnh tạo view ? Thực hiện truy vấn dữ liệu từ View ?	CREATE VIEW EmployeeSales_view 
	AS
	SELECT
		EmployeeID,
		YEAR(OrderDate) AS OrderYear,
		SUM(Quantity) AS SumOfQuantity
	FROM
		Orders
	JOIN
		[Order Details] ON Orders.OrderID = [dbo].[Order Details].OrderID
	GROUP BY
		EmployeeID, YEAR(OrderDate);

	--Truy vấn dữ liệu từ view
	SELECT * FROM EmployeeSales_view

--4. Tạo view ListCustomer_view chứa danh sách các khách hàng có trên 5
--hóa đơn đặt hàng từ năm 1997 đến 1998, thông tin gồm mã khách hàng
--(CustomerID) , họ tên (CompanyName), Số hóa đơn (CountOfOrders) ?
--Thực hiện truy vấn dữ liệu từ View ?
	CREATE VIEW ListCustomer_view AS
	SELECT
		C.CustomerID,
		C.CompanyName,
		COUNT(O.OrderID) AS CountOfOrders
	FROM
		Customers C
	JOIN
		Orders O ON C.CustomerID = O.CustomerID
	WHERE
		YEAR(O.OrderDate) BETWEEN 1997 AND 1998
	GROUP BY
		C.CustomerID, C.CompanyName
	HAVING
		COUNT(O.OrderID) > 5;
	--Truy vấn dữ liệu từ view
	SELECT * FROM ListCustomer_view;

--5. Tạo view ListProduct_view chứa danh sách những sản phẩm thuộc
--nhóm hàng ‘Beverages’ và ‘Seafood’ có tổng số lượng bán trong mỗi
--năm trên 30 sản phẩm, thông tin gồm CategoryName, ProductName,
--Year, SumOfQuantity ?
--Thực hiện truy vấn dữ liệu từ View ?
	CREATE VIEW ListProduct_view 
	AS
	SELECT
		C.CategoryName,
		P.ProductName,
		YEAR(O.OrderDate) AS Year,
		SUM(OD.Quantity) AS SumOfQuantity
	FROM
		Categories C
	JOIN
		Products P ON C.CategoryID = P.CategoryID
	JOIN
		[dbo].[Order Details] OD ON P.ProductID = OD.ProductID
	JOIN
		Orders O ON OD.OrderID = O.OrderID
	WHERE
		C.CategoryName IN ('Beverages', 'Seafood')
	GROUP BY
		C.CategoryName, P.ProductName, YEAR(O.OrderDate)
	HAVING
		SUM(OD.Quantity) > 30;

		--Truy vấn dữ liệu
	SELECT * FROM ListProduct_view

--6. Tạo view vw_OrderSummary với từ khóa WITH ENCRYPTION gồm
--OrderYear (năm của ngày lập hóa đơn), OrderMonth (tháng của ngày lập
--hóa đơn), OrderTotal (tổng tiền sum(UnitPrice*Quantity)) ?
--Thực hiện truy vấn dữ liệu từ View ?
--Viết lệnh để thấy công dụng của từ khóa trên ?

	CREATE VIEW  OrderSummary_view
	WITH ENCRYPTION
	AS
	SELECT
		YEAR(OrderDate) AS OrderYear,
		MONTH(OrderDate) AS OrderMonth,
		SUM(UnitPrice * Quantity) AS OrderTotal
	FROM
		Orders
	JOIN
		[dbo].[Order Details] ON Orders.OrderID = [dbo].[Order Details].OrderID
	GROUP BY
		YEAR(OrderDate), MONTH(OrderDate);

	--Truy vấn dữ liệu
	SELECT * FROM OrderSummary_view

--7. Tạo view vwProducts với từ khóa WITH SCHEMABINDING gồm
--ProductID, ProductName, Discount ?
--Thực hiện truy vấn dữ liệu từ View ? Thực hiện xóa cột Discount trong bảng Products. Có xóa được không?
--Vì sao?
	CREATE VIEW dbo.vwProducts
	WITH SCHEMABINDING
	AS
	SELECT
		ProductID,
		ProductName,
		[Discontinued]
	FROM
		dbo.Products;
	--Truy vấn dữ liệu view
	SELECT * FROM dbo.vwProducts;
	--Thực hiện xóa cột Discount trong bảng Products. Có xóa được không?
	--Không thể xóa cột Discount trong bảng Products được. Bởi vì view vwProducts được tạo với WITH SCHEMABINDING, 
	--điều này có nghĩa là nó phụ thuộc vào cấu trúc của bảng Products và không cho phép bảng thay đổi cấu trúc (như xóa cột) mà nó phụ thuộc vào.

--	8. Tạo view vw_Customer với với từ khóa WITH CHECK OPTION chỉ
--chứa các khách hàng ở thành phố London và Madrid, thông tin gồm:
--CustomerID, CompanyName, City.
--a. Chèn thêm một khách hàng mới không ở thành phố London và
--Madrid thông qua view vừa tạo. Có chèn được không? Giải thích ?
--b. Chèn thêm một khách hàng mới ở thành phố London và một khách
--hàng mới ở thành phố Madrid. Dùng câu lệnh select trên bảng
--Customers để xem kết quả ?	CREATE VIEW vw_Customer 
	AS
	SELECT CustomerID, CompanyName, City
	FROM Customers
	WHERE City IN ('London', 'Madrid')
	WITH CHECK OPTION;
	--Truy vấn dữ liệu từ view	SELECT * FROM vw_Customer--a) Chèn thêm một khách hàng mới không ở thành phố London và
--Madrid thông qua view vừa tạo. Có chèn được không? Giải thích ?
 
 --Không thực hiện được. VÌ Điều này là do từ khóa WITH CHECK OPTION 
 --đảm bảo rằng chỉ các dòng thỏa mãn điều kiện của view mới có thể được chèn hoặc cập nhật thông qua view. 
 --Nếu dòng không thỏa mãn điều kiện của view, thì các thao tác chèn hoặc cập nhật sẽ bị từ chối.

 --b) Chèn thêm một khách hàng mới ở thành phố London và một khách
--hàng mới ở thành phố Madrid. Dùng câu lệnh select trên bảng
--Customers để xem kết quả ?

	-- Chèn một khách hàng mới ở thành phố London
	INSERT INTO Customers (CustomerID, CompanyName, City)
		VALUES ('NEWLD', 'New London Company', 'London');

	-- Chèn một khách hàng mới ở thành phố Madrid
	INSERT INTO Customers (CustomerID, CompanyName, City)
		VALUES ('NEWMA', 'New Madrid Company', 'Madrid');

--9. Tạo 3 bảng lần lượt có tên là KhangHang_Bac, KhachHang_Trung,
--KhachHang_Nam, dùng để lưu danh sách các khách hàng ở ba miền, có
--cấu trúc như sau: MaKh, TenKH, DiaChi, KhuVuc. Trong đó,
--KhachHang_Bac có một Check Constraint là Khuvuc là ‘Bac Bo’
--KhachHang_Nam có một Check Constraint là Khuvuc là ‘Nam Bo’
--KhachHang_Trung có một Check Constraint là Khuvuc là ‘Trung Bo’
--Khoá chính là MaKH và KhuVuc.
--Tạo một partition view từ ba bảng trên, sau đó chèn mẫu tin tuỳ ý thông
--qua view. Kiểm tra xem mẫu tin được lưu vào bảng nào khi
--thêm/sửa/xóa dữ liệu vào view? 

	-- Bảng KhachHang_Bac
	CREATE TABLE KhachHang_Bac (
		MaKH INT PRIMARY KEY,
		TenKH NVARCHAR(255),
		DiaChi NVARCHAR(255),
		KhuVuc NVARCHAR(50) CHECK (KhuVuc = 'Bac Bo')
	);

	-- Bảng KhachHang_Trung
	CREATE TABLE KhachHang_Trung (
		MaKH INT PRIMARY KEY,
		TenKH NVARCHAR(255),
		DiaChi NVARCHAR(255),
		KhuVuc NVARCHAR(50) CHECK (KhuVuc = 'Trung Bo')
	);

	-- Bảng KhachHang_Nam
	CREATE TABLE KhachHang_Nam (
		MaKH INT PRIMARY KEY,
		TenKH NVARCHAR(255),
		DiaChi NVARCHAR(255),
		KhuVuc NVARCHAR(50) CHECK (KhuVuc = 'Nam Bo')
	);
	-- Tạo partition view với cột phân vùng MaKH
	CREATE VIEW vw_KhachHang AS
	SELECT MaKH, TenKH, DiaChi, KhuVuc
	FROM KhachHang_Bac
	UNION ALL
	SELECT MaKH, TenKH, DiaChi, KhuVuc
	FROM KhachHang_Trung
	UNION ALL
	SELECT MaKH, TenKH, DiaChi, KhuVuc
	FROM KhachHang_Nam;

	-- Chèn mẫu tin thông qua view
	INSERT INTO vw_KhachHang (MaKH, TenKH, DiaChi, KhuVuc)
		VALUES (1, 'KhachHang1', 'DiaChi1', 'Bac Bo', 'Bac Bo');

	-- Kiểm tra mẫu tin được lưu vào bảng nào
	SELECT * FROM KhachHang_Bac;
	SELECT * FROM KhachHang_Trung;
	SELECT * FROM KhachHang_Nam;

--10.Lần lượt tạo các view sau, đặt tên tùy ý, sau đó thực hiện truy vấn dữ liệu
--từ view.
-- Danh sách các sản phẩm có chữ ‘Boxes’ trong DonViTinh.
-- Danh sách các sản phẩm có đơn giá <10.
-- Các sản phẩm có đơn giá gốc lớn hơn hay bằng đơn giá gốc trung
--bình.
-- Danh sách các khách hàng ứng với các hóa đơn được lập. Thông
--tin gồm CustomerID, CompanyName, OrderID, Orderdate.
--Có thể INSERT, UPDATE, DELETE dữ liệu thông qua view nào trong
--các view trên ? Hãy Insert/Update/Delete thử dữ liệu tùy ý.--View danh sách sản phẩm có chữ ‘Boxes’ trong DonViTinh	CREATE VIEW vw_Products_Boxes
	AS
	SELECT *
	FROM Products
	WHERE [UnitPrice] LIKE '%Boxes';
--View danh sách sản phẩm có đơn giá <10:
	CREATE VIEW vw_Products_LowPrice
	AS
	SELECT *
	FROM Products
	WHERE [UnitPrice] < 10;
--View các sản phẩm có đơn giá gốc lớn hơn hay bằng đơn giá gốc trung bình:
	CREATE VIEW vw_Products_AboveAvgPrice
	AS
	SELECT *
	FROM Products
	WHERE [UnitPrice] >= (SELECT AVG([UnitPrice]) FROM Products);
--View danh sách các khách hàng ứng với các hóa đơn được lập:
	CREATE VIEW vw_CustomerOrders
	AS
	SELECT
		C.CustomerID,
		C.CompanyName,
		O.OrderID,
		O.OrderDate
	FROM
		Customers C
		JOIN Orders O ON C.CustomerID = O.CustomerID;

	-- Truy vấn từ view danh sách sản phẩm có chữ ‘Boxes’ trong DonViTinh
	SELECT * FROM vw_Products_Boxes;

	-- Truy vấn từ view danh sách sản phẩm có đơn giá <10
	SELECT * FROM vw_Products_LowPrice;

	-- Truy vấn từ view sản phẩm có đơn giá gốc lớn hơn hay bằng đơn giá gốc trung bình
	SELECT * FROM vw_Products_AboveAvgPrice;

	-- Truy vấn từ view danh sách các khách hàng ứng với các hóa đơn được lập
	SELECT * FROM vw_CustomerOrders;

		-- INSERT thông qua view (nếu view cho phép)
	INSERT INTO vw_Products_LowPrice (ProductName, [UnitPrice])
	VALUES ('New Product', 5);

	-- UPDATE thông qua view (nếu view cho phép)
	UPDATE vw_Products_AboveAvgPrice
	SET [UnitPrice] = [UnitPrice] * 1.1;

	-- DELETE thông qua view (nếu view cho phép)
	DELETE FROM vw_CustomerOrders
		WHERE CustomerID = 'TOMSP';
		--Không thực hiện được vì lỗi Msg 4405, Level 16, State 1, Line 314 
		--View or function 'vw_CustomerOrders' is not updatable because the modification affects multiple base tables.


