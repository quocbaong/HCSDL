
	CREATE DATABASE NGUYENQUOCBAO

	USE NGUYENQUOCBAO

--Thiết kế cấu trúc, xác định khoá chính, khóa ngoại và các ràng buộc toàn vẹn cho các Table sau:
	CREATE TABLE Phong (MaPHG CHAR(3) PRIMARY KEY,
						Tang INT,
						MoTa NVARCHAR(30),
						LoaiPHG INT);
	CREATE TABLE LoaiPhong (LoaiPHG INT PRIMARY KEY,
							DonGiaPhong MONEY);
	CREATE TABLE KhachHang (MaKH CHAR(5) PRIMARY KEY,
							TenKH NVARCHAR(30),
							QuocTich NVARCHAR(15),
							DienThoai NVARCHAR(15) );
	CREATE TABLE ThuePhong (MaKH CHAR(5),
							MaPHG CHAR(3),
							NgayThue DATETIME NOT NULL,
							NgayTra DATETIME,
							PRIMARY KEY(MaKH, MaPHG, NgayThue) );

--Thiet ke khoa ngoai
	ALTER TABLE Phong
		ADD CONSTRAINT LoaiPHG_FK FOREIGN KEY (LoaiPHG) REFERENCES LoaiPhong(LoaiPHG)
	ON DELETE Set NULL
	ON UPDATE Cascade

	ALTER TABLE ThuePhong
		ADD CONSTRAINT MaKH_FK FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH)
	ALTER TABLE ThuePhong
		ADD CONSTRAINT MaPHG_FK FOREIGN KEY (MaPHG) REFERENCES Phong(MaPHG)
	ON DELETE Set NULL
	ON UPDATE Cascade

-- Cac rang buoc
--Ngày trả phải sau hoặc là ngày thuê.
	ALTER TABLE ThuePhong
		ADD CONSTRAINT NgayTra_CHECK CHECK (NgayTra >= NgayThue)
	ALTER TABLE LoaiPhong
		ADD CONSTRAINT DonGia_CHECK CHECK (DonGiaPhong BETWEEN 35000 AND 70000)


--NHAP DU LIEU CHO CAC TABLE
	--TABLE LOAIPHONG
	INSERT INTO LoaiPhong VALUES (1, 50000),
								 (2, 40000),
								 (3, 35000)
	--TABLE KHACHHANG
	INSERT INTO KhachHang VALUES ('ALFKI','Alfreds Futterkiste','Germany','0-0074321'),
								 ('BLAUS','Blauer See Delikatessen','Germany','621-08460'),
								 ('BLONP','Blondesddsl père et fils','France','60.15.31'),
								 ('DRACD','Drachenblut Delikatessen','Germany','41-039123'),
								 ('GREAL','Great Lakes Food Market','USA', '555-7555'),
								 ('HUNGC','Hungry Coyote Import Store','USA', '555-6874'),
								 ('KOENE','Königlich Essen','Germany','555-09876'),
								 ('LAMAI','La maison dAsie','France','77.61.10'),
								 ('MORGK','Morgenstern Gesundkost','Germany','42-023176')
	--TABLE PHONG
	INSERT INTO Phong VALUES ('A11',1,N'Phòng số 1 tầng 1 dãy nhà A', 1),
							 ('A12',1,N'Phòng số 2 tầng 1 dãy nhà A', 1),
							 ('A13',1,N'Phòng số 3 tầng 1 dãy nhà A', 2),
							 ('A14',1,N'Phòng số 4 tầng 1 dãy nhà A', 3),
							 ('A21',2,N'Phòng số 1 tầng 2 dãy nhà A', 2),
							 ('A22',2,N'Phòng số 2 tầng 2 dãy nhà A', 2),
							 ('A23',2,N'Phòng số 3 tầng 2 dãy nhà A', 3),
							 ('A24',2,N'Phòng số 4 tầng 2 dãy nhà A', 3),
							 ('B01',0,N'Phòng số 1 tầng trệt dãy nhà B', 1),
							 ('C01',0,N'Phòng số 1 tầng trệt dãy nhà C', 2)
	--TABLE THUEPHONG
	INSERT INTO ThuePhong VALUES ('ALFKI','A11','02/04/2007','06/02/2007'),
								 ('ALFKI','A12','02/06/2007','02/06/2007'),
								 ('ALFKI','A13','02/08/2007','04/08/2007'),
								 ('ALFKI','A14','02/09/2007','02/09/2007'),
								 ('BLAUS','A11','09/10/2007','09/14/2007'),
								 ('BLAUS','A12','12/10/2007','12/12/2007'),
								 ('HUNGC','A24','10/10/2007','10/15/2007'),
								 ('BLAUS','B01','08/12/2007','08/14/2007'),
								 ('ALFKI','C01','08/01/2007',NULL)
	--xem lai dữ liệu cua tất cả các bảng
	select * from KhachHang
	select * from Phong
	select * from LoaiPhong
	select * from ThuePhong

--1.Thêm vào các bảng mỗi bảng một dòng dữ liệu. 
	INSERT INTO LoaiPhong VALUES (4, 60000)
	INSERT INTO KhachHang VALUES ('ALFKY','Lionel Futterkiste','USA','0-0074061')
	INSERT INTO Phong VALUES ('B02',1,N'Phòng số 1 tầng 1 dãy nhà A', 1)
	INSERT INTO ThuePhong VALUES ('ALFKY','B02','02/03/2007','06/02/2007')

--2.Liệt kê các các phòng mà khách hàng thuê chưa trả. Thông tin bao gồm: Mã phòng, mô tả, loại phòng.
	SELECT P.MaPHG, P.MoTa, P.LoaiPHG
	FROM Phong AS P
	JOIN ThuePhong ON P.MaPHG = ThuePhong.MaPHG
	WHERE ThuePhong.NgayTra IS NULL
--3.	Nhập thêm vào bảng phòng một dòng mới với thông tin sau:
 --Mã phòng: B02
--Tầng: 0
--Mô tả: Phòng số 2 tầng trệt dãy nhà B
--Lọai phòng: 4
	INSERT INTO Phong VALUES ('B03', 0, N'Phòng số 2 tầng trệt dãy nhà B', 4)
--4. Liệt kê các phòng có đơn giá phòng rẻ nhất. Thông tin bao gồm: Mã phòng, mô tả và đơn giá phòng.
	SELECT Phong.MaPHG, Phong.MoTa, LoaiPhong.DonGiaPhong
	FROM Phong
	JOIN LoaiPhong ON Phong.LoaiPHG = LoaiPhong.LoaiPHG
	WHERE LoaiPhong.DonGiaPhong = (SELECT MIN(DonGiaPhong) FROM LoaiPhong)
--5. Liệt kê danh sách các phòng có giá lớn hơn 40000.
	SELECT * FROM Phong
	JOIN LoaiPhong ON Phong.LoaiPHG = LoaiPhong.LoaiPHG
	WHERE LoaiPhong.DonGiaPhong > 40000
--6.Liệt kê danh sách các khách hàng có ký tự đầu của mã khách hàng là A đến H.
	SELECT * FROM KhachHang
	WHERE MaKH BETWEEN 'A%' AND 'H%'
--7. Liệt kê các phòng chưa có khách hàng thuê viết bằng 3 cách Left Join, Not In , Not Exists
	--SỬ DỤNG LEFT JOIN
	SELECT Phong.MaPHG, Phong.MoTa, Phong.LoaiPHG
	FROM Phong
	LEFT JOIN ThuePhong ON Phong.MaPHG = ThuePhong.MaPHG
	WHERE ThuePhong.MaKH IS NULL;
	--SỬ DỤNG NOT IN
	SELECT MaPHG, MoTa, LoaiPHG
	FROM Phong
	WHERE MaPHG NOT IN (SELECT DISTINCT MaPHG FROM ThuePhong);
	--SỬ DỤNG NOT EXISTS
	SELECT MaPHG, MoTa, LoaiPHG
	FROM Phong
	WHERE NOT EXISTS (SELECT 1 FROM ThuePhong WHERE Phong.MaPHG = ThuePhong.MaPHG);
--8. Thống kê tổng số phòng theo từng loại phòng. Gồm loại phòng, số lượng phòng.
	SELECT Phong.LoaiPHG AS LoaiPhong, COUNT(Phong.MaPHG) AS "SoLuongPhong"
	FROM Phong
	GROUP BY Phong.LoaiPHG;
--9. Thống kê lượng khách hàng thuê phòng trong từng tháng. Gồm tháng, tổng số lượng khách.
	SELECT MONTH(NgayThue) AS Thang, COUNT(MaKH) AS "TongSoLuongKhach" 
	FROM ThuePhong 
	GROUP BY MONTH(NgayThue)
--10. Sao chép bảng Loại Phòng thành bảng LoaiPhong_SaoLuu. Sau đó cập nhật lại đơn giá phòng tăng lên 5% cho những phòng ở tầng 1.
	--SAO CHÉP BẢNG
	SELECT * INTO LoaiPhong_SaoLuu
	FROM LoaiPhong;
	-- CẬP NHẬT LẠI ĐƠN GIÁ TĂNG LÊN 5% CHO PHÒNG TẦNG 1
	UPDATE LoaiPhong_SaoLuu
	SET DonGiaPhong = DonGiaPhong * 1.05
	WHERE LoaiPHG IN (
    SELECT LoaiPHG FROM Phong WHERE Tang = 1)

	SELECT * FROM LoaiPhong_SaoLuu
--11.Liệt kê các quốc tịch có nhiều khách hàng nhất. Gồm Quốc tịch, số lượng khách.
	SELECT QuocTich, COUNT(MaKH) AS SoLuongKhach
	FROM KhachHang
	GROUP BY QuocTich
	ORDER BY SoLuongKhach DESC;
--12. Liệt kê danh sách các khách hàng đã thuê tất cả các phòng ở tầng 1 dãy nhà A. 
	SELECT * FROM KHACHHANG 
	WHERE MAKH IN  (SELECT MAKH FROM THUEPHONG TP JOIN PHONG P ON TP.MAPHG=P.MAPHG WHERE TANG = 1 AND P.MAPHG LIKE 'A%')
--13. Viết câu truy vấn để xóa các khách hàng chưa từng thuê phòng.
	DELETE FROM KHACHHANG WHERE MAKH NOT IN (SELECT MAKH FROM THUEPHONG)
	SELECT * FROM KHACHHANG 
--14. Tính tổng tiền thuê phòng cho các khách hàng đã trả phòng. 
--Trong đó: 
--Nếu ngày thuê và ngày trả trong cùng ngày thì được tính một ngày, còn lại số ngày thuê phòng bằng NgayTra – NgayThue. 
--Tiền thuê phòng là số ngày thuê nhân đơn giá phòng.
	
--15.	Tạo bảng KHThang9 chứa danh sách các khách hàng thuê phòng tháng 9
	CREATE TABLE KHThang9
	(MAKH NVARCHAR(60) NOT NULL,
	 MAPHG NVARCHAR(20),
	 NGAYTHUE DATE NOT NULL,
	 NGAYTRA DATE)
	INSERT KHThang9
	SELECT *
	FROM THUEPHONG WHERE MONTH(NGAYTHUE)=9
--16. Dùng lệnh INSERT..INTO thêm vào bảng KHThang9 những khách hàng thuê vào tháng 10
	INSERT INTO KHThang9 
	SELECT * FROM THUEPHONG WHERE MONTH(NGAYTHUE)=10
--17. Xoá trong bảng thuê phòng những khách hàng có tên bắt đầu bằng chữ A
	DELETE FROM THUEPHONG WHERE MAKH IN (SELECT MAKH FROM KHACHHANG WHERE TENKH LIKE 'A%')
--18. Tạo View chứa danh sách các khách hàng thuê phòng ở tầng 1 dãy nhà A
	CREATE VIEW View_KhachHangThueTang1DayA AS
	SELECT
		KhachHang.*,
		ThuePhong.NgayThue,
		ThuePhong.NgayTra,
		Phong.LoaiPHG
	FROM KhachHang
	JOIN ThuePhong ON KhachHang.MaKH = ThuePhong.MaKH
	JOIN Phong ON ThuePhong.MaPHG = Phong.MaPHG
	WHERE Phong.Tang = 1 AND Phong.MoTa LIKE 'A%';