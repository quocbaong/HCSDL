--View
drop view vwProducts
CREATE VIEW vwProducts
	AS
	SELECT ProductName, UnitPrice, CompanyName
	FROM Suppliers 
	INNER JOIN Products
	ON Suppliers.SupplierID = Products.SupplierID
SELECT * FROM vwProducts
--XEM TRO GIUP VIEW
SP_HELPTEXT VWPRODUCTS

WITH ENCRYPTION
drop view vwProducts
CREATE VIEW vwProducts
WITH ENCRYPTION
	AS
	SELECT ProductName, UnitPrice, CompanyName
	FROM Suppliers 
	INNER JOIN Products
	ON Suppliers.SupplierID = Products.SupplierID
SELECT * FROM vwProducts
SP_HELPTEXT VWPRODUCTS
ALTER TABLE PRODUCTS
	ADD MOTA INT
DROP VIEW vwProducts
CREATE VIEW vwProducts
WITH SCHEMABINDING
AS
	SELECT CompanyName, ProductName, UnitPrice
	FROM dbo.Suppliers INNER JOIN dbo.Products
	ON Suppliers.SupplierID = Products.SupplierID
GO
	ALTER TABLE dbo.Products
	DROP COLUMN UNITPRICE
--
CREATE VIEW Customers1 AS
       SELECT * FROM Customers WHERE city='LonDon'
Select * from Customers1
GO
UPDATE Customers1 SET city='Anh Quoc' WHERE CustomerID='CONSH'
select * from Customers where CustomerID='CONSH'

CREATE VIEW Customers2 AS
       SELECT * FROM Customers WHERE city='LonDon'
WITH CHECK OPTION
Select * from Customers2
GO
UPDATE Customers2 SET city='Anh Quoc' WHERE CustomerID='EASTC'
select * from Customers where CustomerID='CONSH'
DROP TABLE donvi
DROP TABLE nhanvien
CREATE TABLE donvi 
( 	madv INT PRIMARY KEY, 
	tendv NVARCHAR(30) NOT NULL, 
	dienthoai NVARCHAR(10) NULL
) 
CREATE TABLE nhanvien 
( 	manv NVARCHAR(10) PRIMARY KEY, 
	hoten NVARCHAR(30) NOT NULL, 
	ngaysinh DATETIME NULL, 
	diachi NVARCHAR(50) NULL, 
	madv INT FOREIGN KEY 
	REFERENCES donvi(madv) 
	ON DELETE CASCADE 
	ON UPDATE CASCADE 
) 

Insert into DonVi (Madv, Tendv, DienThoai) values (1,'P.Kinh doanh','822321')
Insert into DonVi (Madv, Tendv, DienThoai) values (2,'Tiep thi','822012')
SET DATEFORMAT DMY
Insert into nhanvien(manv,hoten,ngaysinh,diachi,madv) Values('NV01','Tran Van A','3/2/1975','77 Tran Phu',1)
 Insert into nhanvien(manv,hoten,ngaysinh,diachi,madv) Values('NV02','Mai Thi Bich','13/2/1977','17 Nguyen Hue',2)
Insert into nhanvien(manv,hoten,ngaysinh,diachi,madv) Values('NV03','Le Van Ha','3/2/1973','12 Tran Phu',2)

SELECT * FROM donvi
SELECT * FROM nhanvien
DROP VIEW NV1
CREATE VIEW nv1 
AS 
	SELECT manv,hoten,madv FROM nhanvien 
GO
INSERT INTO nv1 VALUES('NV04','Le Thi DUYEN',1) 
SELECT * FROM NV1
DROP VIEW NV2
CREATE VIEW nv2 
AS 
	SELECT manv,hoten,YEAR(ngaysinh) AS namsinh,madv FROM nhanvien 
GO
INSERT INTO nv2(manv,hoten,madv) VALUES('NV05','Le Van HA',1) 
SELECT * FROM nv2
SELECT * FROM nhanvien
GO
UPDATE nv2 SET hoten='Le Thi XINH' WHERE manv='NV01' –Thực hiện được
GO 
DELETE FROM nv2 WHERE manv='NV05' –Thực hiện được
DROP VIEW NV3
CREATE VIEW nv3 
AS 
SELECT manv,hoten,ngaysinh, diachi,nhanvien.madv AS noilamviec, 
donvi.madv,tendv,dienthoai FROM nhanvien FULL OUTER JOIN donvi ON nhanvien.madv=donvi.madv 
GO
SELECT * FROM nv3 
SELECT * FROM donvi
SELECT * FROM nhanvien
--Thêm vào bảng NHANVIEN
INSERT INTO nv3(manv,hoten,noilamviec) VALUES('NV05','Le Van E',1) 
--Thêm vào bảng DONVI
INSERT INTO nv3(madv,tendv) VALUES(3,'P. Ke toan') 
INSERT INTO nv3(manv,hoten,noilamviec,tendv) VALUES('NV06','Le Van',2,'PHONG QUAN TRI') 

--
DROP TABLE KH_BAC
DROP TABLE KH_NAM
DROP TABLE KH_TRUNG
Create Table KH_BAC
   (Makh int, TenKh Nchar(30),
    Khuvuc Nvarchar(30) NOT NULL CHECK (Khuvuc='Bac bo'),
    PRIMARY KEY (Makh, Khuvuc)
    )
Create Table KH_TRUNG
   (Makh int, TenKh Nchar(30),
    Khuvuc Nvarchar(30) NOT NULL CHECK (Khuvuc='Trung bo'),
    PRIMARY KEY (Makh, Khuvuc))
 Create Table KH_NAM
        (Makh int, TenKh Nchar(30),
         Khuvuc Nvarchar(30) NOT NULL CHECK (Khuvuc='Nam bo'),
         PRIMARY KEY (Makh, Khuvuc)
	) 

Create View Kh
AS
		Select * From KH_BAC
	UNION ALL
		Select * From KH_TRUNG
	UNION ALL
		Select * From KH_NAM
SELECT * FROM KH
SELECT * FROM KH_BAC
SELECT * FROM KH_NAM
SELECT * FROM KH_TRUNG
INSERT Kh VALUES (1, 'LE MINH','Nam Bo')
INSERT Kh VALUES (1, 'LE MINH','TRUNG Bo')

SELECT * FROM  KH_Nam

