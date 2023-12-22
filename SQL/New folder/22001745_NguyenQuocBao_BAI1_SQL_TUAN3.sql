--1. Tao CSDL QLBH
CREATE DATABASE QLBH
GO

USE QLBH

--2. CREATE TABLE

	CREATE TABLE NhomSanPham
	(MaNhom Int PRIMARY KEY,
	TenNhom Nvarchar(15) )

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

