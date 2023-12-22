--4. Kiểu dữ liệu (datatype)
--a. Tìm hiểu và trả lời các câu hỏi sau:
 Có mấy loại datatype trong SQL Server, hãy liệt kê ?
 --> Có các loại datatype là: Numeric Datatypes (Dữ liệu số học), Character Strings (Chuỗi ký tự), Date and Time Datatypes (Dữ liệu ngày giờ), Binary Datatypes (Dữ liệu nhị phân),
	Other Datatypes (Các loại dữ liệu khác)

 Các system datatype được SQL Server lưu trữ trong Table nào và ở trong CSDL nào ?
 --> Khong duoc luu tru trong Table nao, chung duoc quan ly va duy tri boi he thong SQL Server
 Các User-defined datatype được SQL Server lưu trữ trong Table nào, ở trong CSDL nào?
 --> Duoc luu tru trong co so du lieu nguoi dung cua ban dang su dung
 
 --b) Vào Query Analyzer, chọn QLBH là CSDL hiện hành, định nghĩa các datatype:
	--Su dung CSDL QLBH
	USE QLBH
	--Dinh nghia cac datatype
	sp_addtype Mavung, 'char(10)'
	sp_addtype STT, 'int'
	sp_addtype SoDienThoai, 'char(13)', NULL
	sp_addtype Shortstring, 'nvarchar(15)'

--c) Các User-defined datatype vừa định nghĩa được lưu trữ ở đâu và phạm vi
sử dụng của nó ở đâu (trong toàn bộ một instance hay chỉ ở trong CSDL
hiện hành)
--> Các User-defined datatype được lưu trữ ở CSDL QLBH, trong Programmability\Types\User-Defined Data Types
--> Phạm vi sử dụng trong CSDL hiện hành

--d) Thực hiện liệt kê danh sách các User-Defined datatype vừa định nghĩa 
--Cach 1:
	SELECT domain_name, data_type, character_maximum_length
	FROM information_schema.domains
	ORDER BY domain_name
--Cach 2:
	SELECT * From Systype
--e) Tạo 1 bảng có tên là ThongTinKH trong CSDL QLBH và sử dụng User-defined data type vừa định nghĩa ở trên. Bảng gồm các cột :
MaKH (khóa chính) có kiểu dữ liệu STT , Vung có kiểu dữ liệu Mavung , Diachi có kiểu dữ liệu Shortstring, DienThoai có kiểu dữ liệu SoDienThoai.
Bạn có tạo được không? Nếu được bạn nhập thử 2 record bằng giao diện design
	
	CREATE TABLE ThongTinKH (
		MaKH STT PRIMARY KEY,
		Vung MaVung,
		Diachi Shortstring,
		DienThoai SoDienThoai)

--f) Muốn User-Defined datatype được dùng trong tất cả các CSDL thì bạn định nghĩa nó ở đâu? 
--> Định nghĩa nó ở CSDL master

--g) Xóa kiểu dữ liệu SoDienThoai.

	sp_droptype SoDienThoai
	--Cannot drop type 'dbo.SoDienThoai' because it is being referenced by object 'ThongTinKH'. There may be other objects that reference this type.

	--Để xóa được đầu tiên ta xóa Table ThongTinKH, sau đó ta mới xóa kiểu dữ liệu SoDienThoai
	DROP TABLE ThongTinKH

	sp_droptype SoDienThoai