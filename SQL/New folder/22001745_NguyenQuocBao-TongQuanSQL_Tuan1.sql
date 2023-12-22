--1. Tao CSDL bang lenh
CREATE DATABASE QLBH
ON PRIMARY
	(NAME=QLBH_data1,
	FILENAME='T:\QLBH_data1.mdf',
	SIZE=10,
	MAXSIZE=40,
	FILEGROWTH=1) 
LOG ON
	( NAME=QLBH_Log,
	FILENAME= 'T:\QLBH.ldf',
	SIZE=6,
	MAXSIZE=8,
	FILEGROWTH=1)
--2. Mo CSDL 
	USE QLBH
--3. Kiem tra khong gian cua CSDL
	sp_spaceused
--4. Xem thong tin cua tat ca cac CSDL
	sp_helpdb
--5. Xem thong tin cua CSDL QLBH
	sp_helpdb QLBH
--6. Thêm  một  filegroup  có  tên  là  DuLieuQLBH
	sp_helpdb QLBH

	ALTER DATABASE QLBH
		ADD FILEGROUP DULIEUQLBH

	--xEM THONG TIN FILEGROUP
	sp_helpfilegroup

--7. Thêm  một  secondary  data  file  có  tên  logic  là  QLBH_data2  trong 
filegroup vừa tạo :  tên và đường dẫn file vật lý T:\QLBH_data2.ndf , các 
thông số khác tuỳ  chọn
	ALTER DATABASE QLBH
		ADD FILE( NAME = QLBH_data2,
		FILENAME = 'T:\QLBH_data2.ndf',
		SIZE = 3,
		MAXSIZE = 10,
		FILEGROWTH = 1)
		TO FILEGROUP DULIEUQLBH

	sp_helpdb	QLBH

	--XEM THONG TIN FILEGROUP
		sp_helpfilegroup
--9. Dùng lệnh Alter Database … Set … để cấu hình cho CSDL  QLBH  có 
thuộc  tính  là  Read_Only.  Dùng  sp_helpDB  để  xem  lại  thuộc  tính  của 
CSDL. Hủy bỏ thuộc tính Read_Only.
	--Set read_only
	ALTER DATABASE QLBH
		SET READ_ONLY

	--XEM THONG TIN THUOC TINH
	sp_helpdb

	--Set read-write
	ALTER DATABASE QLBH
		SET READ_WRITE

--10. Dùng  lệnh  Alter  DataBase  …  MODIFY  FILE  …  để  tăng  SIZE  của 
QLBH_data1 thành 50 MB. Tương tự tăng SIZE của tập tin  QLBH_log 
thành 10 MB
	--Tang size cua QLBH_data1 thanh 50MB
	ALTER DATABASE QLBH
		MODIFY FILE (NAME = 'QLBH_data1', SIZE = 50)

	ALTER DATABASE QLBH
		MODIFY FILE (NAME = 'QLBH_data1', SIZE = 20) --MODIFY FILE failed. Specified size is less than or equal to current size. Vi o tren
													-- da dua size ve 50MB nen khong the dua ve lai 20MB
	--SUA MAX
	ALTER DATABASE QLBH
		MODIFY FILE(NAME = 'QLBH_data1', MAXSIZE = 5MB)		--MODIFY FILE failed. Size is greater than MAXSIZE. Vi file dang co kich thuoc
															-- 50MB thi maxsize = 5MB se khong luu duoc file nen bao loi
	ALTER DATABASE QLBH
		MODIFY FILE(NAME = 'QLBH_data1', MAXSIZE = 60MB)
	--Tang SIZE cua tap tin QLBH_log thanh 10MB
	ALTER DATABASE QLBH
		MODIFY FILE (NAME = 'QLBH_log', SIZE = 10)
