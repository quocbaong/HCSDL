﻿--1. Tao CSDL QLBH
CREATE DATABASE QLBH
GO

USE QLBH

--2. CREATE TABLE

	CREATE TABLE NhomSanPham
	(MaNhom Int PRIMARY KEY,
	TenNhom Nvarchar(20) )

	GO 
	CREATE TABLE NhaCungCap
	(MaNCC Int PRIMARY KEY,
	TenNCC Nvarchar(40) NOT NULL,
	Diachi Nvarchar(60),
	Phone Nvarchar(24),
	SoFax Nvarchar(24),
	DCMail Nvarchar(50))

	GO
	CREATE TABLE SanPham
	(MaSP Int PRIMARY KEY,
	TenSP nvarchar(40) NOT NULL,
	MaNhaCungCap Int REFERENCES NhaCungCap(MaNCC),
	MoTa Nvarchar(50),
	MaNH Int REFERENCES NhomSanPham(MaNhom),
	Donvitinh Nvarchar(20),
	GiaGoc Money Check (GiaGoc > 0),
	SLTon Int Check (SLTon >=0))

	GO 
	CREATE TABLE KhachHang
	(MaKH Char(5) PRIMARY KEY,
	TenKH Nvarchar(40) NOT NULL,
	LoaiKH Nvarchar(3) CHECK (LoaiKH IN ('VIP', 'TV', 'VL')),
	DiaChi Nvarchar(60),
	Phone Nvarchar(24),
	DCMail Nvarchar(50),
	DiemTL Int CHECK (DiemTL >=0))

	GO
	CREATE TABLE HoaDon
	(MaHD Int PRIMARY KEY,
	NgayLapHD DateTime DEFAULT GetDate(), 
	CONSTRAINT Check_NgayLapHD CHECK (NgayLapHD >= GETDATE()),
	NgayGiao DateTime,
	Noichuyen Nvarchar(60) NOT NULL,
	MaKhachHang Char(5) REFERENCES KhachHang(MaKH))

	GO
	CREATE TABLE CT_HoaDon
	(MaHoaDon Int REFERENCES HoaDon(MaHD) NOT NULL,
	MaSanPham Int REFERENCES SanPham(MaSP) NOT NULL,
	PRIMARY KEY(MaHoaDon, MaSanPham),
	SoLuong SmallInt CHECK (SoLuong > 0),
	Dongia Money,
	ChietKhau Money CHECK (ChietKhau >=0))

--4. Viết lệnh thực hiện :
	--Thêm cột LoaiHD vào bảng HoaDon
	GO
	ALTER TABLE HoaDon
		ADD LoaiHD Char(1) DEFAULT 'N' CHECK (LoaiHD IN ('N', 'X', 'C', 'T'))
	--Tạo thêm ràng buộc trên bảng HoaDon : NgayGiao>=NgayLapHD 
	ALTER TABLE HoaDon
		ADD CONSTRAINT HD_NgayGiao CHECK (NgayGiao >= NgayLapHD)

--Bai Tap Thuc Hanh Tuan 4
--1. Sử dụng Insert để nhập dữ liệu vào các bảng trong CSDL QLBH
	INSERT INTO NhomSanPham VALUES (1, N'Điện Tư'),
								   (2, N'Gia Dụng'),
								   (3, N'Dụng Cụ Gia Đình'),
								   (4, N'Các Mặt Hàng Khác')
	SELECT * FROM NhomSanPham

	INSERT NhaCungCap VALUES (1, N'Công Ty TNHH Nam Phương', N'1 Lê Lợi Phường 4 Quận Gò Vấp', N'083843456', N'32343434', N'NamPhuong@yahoo.com'),
							 (2, N'Công Ty Lan Ngọc', N'12 Cao Bá Quát Quận 1 Tp. Hồ Chí Minh', N'086234567', N'83434355', N'LanNgoc@gmail.com')
	SELECT * FROM NhaCungCap

	INSERT SanPham VALUES (1, N'Máy Tính', 1, N'Máy Sony RAM 2GB', 1, N'Cái', '7000', 100),
						  (2, N'Bàn Phím', 1, N'Bàn phím 101 phím', 1, N'Cái', '1000', 50),
						  (3, N'Chuột', 1, N'Chuột không dây', 1, N'Cái', '800', 150),
						  (4, N'CPU', 1, N'CPU', 1, N'Cái', '3000', 200),
						  (5, N'USB', 1, N'8GB', 1, N'Cái', '500', 100),
						  (6, N'Lò Vi Sóng', 2, NULL, 3, N'Cái', '1000000', 20)
	SELECT * FROM SanPham

	INSERT KhachHang VALUES ('KH1', N'Nguyễn Thu Hằng', N'VL', N'12 Nguyễn Du',' ', NULL, NULL),
							('KH2', N'Lê Minh', N'TV', N'34 Điện Biên Phủ', N'0123943455', N'LeMInh@yahoo.com', 100),
							('KH3', N'Nguyễn Minh Trung', N'VIP', N'3 Lê Lợi Quận Gò Vấp', N'098343434', N'Trung@gmail.com', 800)
	SELECT * FROM KhachHang

	SET DATEFORMAT DMY
	INSERT HoaDon VALUES (1, '2/10/2023', '5/10/2023', N'Cửa Hàng ABC 3 Lý Chính Thắng Quận 3', 'KH1', 'C'),
						 (2, '2/10/2023', '10/10/2023', N'23 Lê Lợi Quận Gò Vấp', 'KH2', 'T'),
						 (3, '2/10/2023', '6/10/2023', N'2 Nguyễn Du Quận Gò Vấp', 'KH3', 'T')
	SELECT * FROM HoaDon

	INSERT CT_HoaDon VALUES (1, 1, 5, '8000', '0.05'),
							(1, 2, 4, '1200', '0.05'),
							(1, 3, 15, '1000', '0.05'),
							(2, 2, 9, '1200', '0.05'),
							(2, 4, 5, '800', '0.1'),
							(3, 2, 20, '3500', '0.1'),
							(3, 3, 15, '1000', '0.2')
	SELECT * FROM CT_HoaDon

--2. Dùng lệnh Update chỉnh sửa dữ liệu theo yêu cầu :
			ADD CONSTRAINT FK_HoaDon_KhachHang FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKH)
		ON DELETE CASCADE
		ON UPDATE CASCADE
--3. Dùng lệnh Delete thực hiện các yêu cầu sau:
		Delete from NhomSanPham where MaNhom = 4
	--b) Xóa dòng trong CT_Hoadon có MaHD là 1 và MaSP là 3
		SELECT * FROM CT_HoaDon
	--c) Xóa dòng trong bảng HoaDon có mã là 1
		DELETE FROM CT_HoaDon WHERE MaHoaDon = 1
		DELETE FROM HoaDon WHERE MaHD = 1
	--d) Tương tự , xóa dòng trong bảng HoaDon có mã là 2
			ADD CONSTRAINT FK_CT_HoaDon_HoaDon FOREIGN KEY (MaHoaDon) REFERENCES HoaDon(MaHD) 
		ON DELETE CASCADE 
		ON UPDATE CASCADE
		DELETE FROM HoaDon WHERE MaHD = 2
		SELECT * FROM HoaDon
		SELECT * FROM CT_HoaDon

		