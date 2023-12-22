--1. Taoj CSDL QLDuAn
	CREATE DATABASE QLDuAn

	GO
	USE QLDuAn
--2. Tao Table
	GO
	CREATE TABLE PhongBan
	(MaPB char(5) PRIMARY KEY,
	TenPB Nvarchar(30) NOT NULL,
	MaTruongPhong char(5) NOT NULL
	)

	CREATE TABLE NhanVien
	(MaNV char(5) PRIMARY KEY,
	HoTen Nvarchar(30) NOT NULL,
	Phai Nvarchar(5) CHECK (Phai IN ('Nam', 'Nu')),
	NgaySinh DateTime,
	MaPhongBan char(5) REFERENCES PhongBan(MaPB),
	NhomTruong char(5),
	)

	CREATE TABLE CongViec
	(MaCV Int PRIMARY KEY,
	TenCV Nvarchar(30) NOT NULL
	)

	CREATE TABLE DuAn
	(MaDA Int PRIMARY KEY,
	TenDA Nvarchar(30) NOT NULL
	)

	CREATE TABLE Nhanvien_duan
	(MaDuAn Int REFERENCES DuAn(MaDA),
	MaNhanVien char(5) REFERENCES NhanVien(MaNV),
	MaCongViec Int REFERENCES CongViec(MaCV),
	PRIMARY KEY(MaDuAN, MaNhanVien, MaCongViec),
	Thoigian DateTime NOT NULL
	)

	ALTER TABLE PhongBan
		ADD CONSTRAINT MaTruongPhong_FK FOREIGN KEY (MaTruongPhong) REFERENCES NhanVien(MaNV)
	ALTER TABLE NhanVien
		ADD CONSTRAINT MaNhomTruong_FK FOREIGN KEY (NhomTruong) REFERENCES NhanVien(MaNV)

