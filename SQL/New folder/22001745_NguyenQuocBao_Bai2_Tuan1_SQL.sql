--Bai 2. Tạo cơ sở dữ liệu bằng lệnh T-SQL tại cửa sổ Query Analyzer
--1.Tao Database QLBH
	CREATE DATABASE QLBH
	ON PRIMARY
		(NAME = QLBH_data1,
		FILENAME = 'D:\DuLieu\QLBH_data1.mdf',
		SIZE = 10, 
		MAXSIZE = 40,
		FILEGROWTH = 1)
	LOG ON
		(NAME = QLBH_log,
		FILENAME = 'D:\DuLieu\QLBH.ldf',
		SIZE = 6,
		MAXSIZE = 8,
		FILEGROWTH = 1)

--b) Xem lại thuộc tính của CSDL QLBH bằng cách Click phải vào tên
CSDL chọn Properties và bằng thủ tục hệ thống sp_helpdb,
sp_spaceused, sp_helpfile
--2. Xem thong tin CSDL hien hanh
	sp_helpdb
--3. Xem thong tin 1 CSDL cu the
	sp_helpdb QLBH
--4. Xem khong gian cua CSDL
	USE QLBH
	sp_spaceused

--c) Thêm một filegroup có tên là DuLieuQLBH
	ALTER DATABASE QLBH
		ADD FILEGROUP DuLieuQLBH

--d) Thêm một secondary data file có tên logic là QLBH_data2 trong
filegroup vừa tạo : tên và đường dẫn file vật lý T:\QLBH_data2.ndf , các
thông số khác tuỳ chọn
	
	ALTER DATABASE QLBH
	ADD FILE(NAME = QLBH_data2,
			 FILENAME = 'D:\DuLieu\QLBH_data2.ndf',
			 SIZE = 5,
			 MAXSIZE = 10,
			 FILEGROWTH = 1)
	TO FILEGROUP DuLieuQLBH

--e) Xem thong tin cac file trong filegroup
	sp_helpfilegroup

--f) Dùng lệnh Alter Database … Set … để cấu hình cho CSDL QLBH có
thuộc tính là Read_Only. Dùng sp_helpDB để xem lại thuộc tính của
CSDL. Hủy bỏ thuộc tính Read_Only

	--Thuoc tinh Read_only
		ALTER DATABASE QLBH
			SET READ_ONLY
		sp_helpdb

	--Huy bo Read_only
		ALTER DATABASE QLBH
			SET READ_WRITE

--g) Dùng lệnh Alter DataBase … MODIFY FILE … để tăng SIZE của
QLBH_data1 thành 50 MB. Tương tự tăng SIZE của tập tin QLBH_log
thành 10 MB. 
	--tăng SIZE của QLBH_data1 thành 50 MB
	ALTER DATABASE QLBH
		MODIFY FILE(NAME = QLBH_data1, SIZE = 50)
	sp_helpdb QLBH
	-- tăng SIZE của tập tin QLBH_log thành 10 MB
	ALTER DATABASE QLBH
		MODIFY FILE(NAME = QLBH_log, SIZE = 10) 
