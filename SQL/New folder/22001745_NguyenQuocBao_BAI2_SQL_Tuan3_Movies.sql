USE [master]
GO

/****** Object:  Database [Movies]    Script Date: 9/23/2023 1:53:55 PM ******/
CREATE DATABASE [Movies]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Movies_data', FILENAME = N'D:\Movies\Movies_data.mdf' , SIZE = 25600KB , MAXSIZE = 40960KB , FILEGROWTH = 1024KB ),
( NAME = N'Movies_data2', FILENAME = N'D:\Movies\Movies_data2.ndf' , SIZE = 9240KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Movies_log', FILENAME = N'D:\Movies\Movies_log.ldf' , SIZE = 6144KB , MAXSIZE = 8192KB , FILEGROWTH = 1024KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Movies].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [Movies] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [Movies] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [Movies] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [Movies] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [Movies] SET ARITHABORT OFF 
GO

ALTER DATABASE [Movies] SET AUTO_CLOSE ON 
GO

ALTER DATABASE [Movies] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [Movies] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [Movies] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [Movies] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [Movies] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [Movies] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [Movies] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [Movies] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [Movies] SET  ENABLE_BROKER 
GO

ALTER DATABASE [Movies] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [Movies] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [Movies] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [Movies] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [Movies] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [Movies] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [Movies] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [Movies] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [Movies] SET  MULTI_USER 
GO

ALTER DATABASE [Movies] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [Movies] SET DB_CHAINING OFF 
GO

ALTER DATABASE [Movies] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [Movies] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [Movies] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [Movies] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO

ALTER DATABASE [Movies] SET QUERY_STORE = ON
GO

ALTER DATABASE [Movies] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO

ALTER DATABASE [Movies] SET  READ_WRITE 
GO

USE Movies
--3. Mở tập tin Movies.sql, thực hiện: 
--Tao 1 FileGroup
	ALTER DATABASE Movies
		ADD FILEGROUP DataGroup
	
	GO
--Hiệu chỉnh maxsize của tập tin transaction log thành 10 MB
	ALTER DATABASE Movies
		MODIFY FILE(NAME = Movies_log, MAXSIZE = 10)
	GO
--Size của tập tin data file thứ 2 thành 10 MB.
	ALTER DATABASE Movies
		MODIFY FILE(NAME = Movies_data2, SIZE = 10) --MODIFY FILE failed. Specified size is less than or equal to current size.
	GO
--Thêm data file thứ 3 thuộc filegroup DataGroup (thông số tùy ý)
	ALTER DATABASE Movies
		ADD FILE(NAME = Movies_data3,
				FILENAME = 'D:\Movies\Movies_data3.ndf',
				SIZE = 10,
				MAXSIZE = 15,
				FILEGROWTH = 1)
		TO FILEGROUP DataGroup

		GO
--Dùng sp_helpDB để kiểm tra sự tồn tại của Movies và các thông số của nó.
	SP_HELPDB Movies

--4. Bạn hãy suy nghĩ xem mỗi bảng trên cần lưu những thông tin cụ thể nào (tức là các cột nào), kiểu dữ liệu ra sao? Khóa chính của từng bảng, --mối quan hệ giữa các bảng, có những ràng buộc toàn vẹn nào?
1. Bảng "Movie":

	Tên bảng: Movie
	Mô tả: Danh sách các phim có trong cửa hàng
	Các cột:
	MovieID (Khóa chính, kiểu dữ liệu: INT): Mã số duy nhất cho mỗi bộ phim.
	Title (kiểu dữ liệu: VARCHAR hoặc NVARCHAR): Tiêu đề của bộ phim.
	ReleaseDate (kiểu dữ liệu: DATE hoặc DATETIME): Ngày phát hành của bộ phim.
	Genre (kiểu dữ liệu: VARCHAR hoặc NVARCHAR): Thể loại của bộ phim.
	Director (kiểu dữ liệu: VARCHAR hoặc NVARCHAR): Đạo diễn của bộ phim.
	Description (kiểu dữ liệu: TEXT hoặc NVARCHAR(MAX)): Mô tả về bộ phim.
	Stock (kiểu dữ liệu: INT): Số lượng tồn kho của bộ phim.
2. Bảng "Customer":

	Tên bảng: Customer
	Mô tả: Thông tin khách hàng
	Các cột:
	CustomerID (Khóa chính, kiểu dữ liệu: INT): Mã số duy nhất cho mỗi khách hàng.
	FirstName (kiểu dữ liệu: VARCHAR hoặc NVARCHAR): Tên của khách hàng.
	LastName (kiểu dữ liệu: VARCHAR hoặc NVARCHAR): Họ của khách hàng.
	Email (kiểu dữ liệu: VARCHAR hoặc NVARCHAR): Địa chỉ email của khách hàng.
	Phone (kiểu dữ liệu: VARCHAR hoặc NVARCHAR): Số điện thoại của khách hàng.
	Address (kiểu dữ liệu: NVARCHAR hoặc VARCHAR): Địa chỉ của khách hàng.
3. Bảng "Category":

	Tên bảng: Category
	Mô tả: Danh sách các loại phim
	Các cột:
	CategoryID (Khóa chính, kiểu dữ liệu: INT): Mã số duy nhất cho mỗi loại phim.
	Name (kiểu dữ liệu: VARCHAR hoặc NVARCHAR): Tên của loại phim.
4. Bảng "Rental":

	Tên bảng: Rental
	Mô tả: Thông tin thuê phim
	Các cột:
	RentalID (Khóa chính, kiểu dữ liệu: INT): Mã số duy nhất cho mỗi giao dịch thuê phim.
	CustomerID (Khóa ngoại, tham chiếu đến Customer.CustomerID): Liên kết với thông tin của khách hàng.
	RentalDate (kiểu dữ liệu: DATE hoặc DATETIME): Ngày giao dịch thuê phim.
	ReturnDate (kiểu dữ liệu: DATE hoặc DATETIME): Ngày dự kiến trả phim.
5. Bảng "Rental_detail":

	Tên bảng: Rental_detail
	Mô tả: Chi tiết thuê phim
	Các cột:
	RentalDetailID (Khóa chính, kiểu dữ liệu: INT): Mã số duy nhất cho mỗi chi tiết giao dịch thuê phim.
	RentalID (Khóa ngoại, tham chiếu đến Rental.RentalID): Liên kết với thông tin giao dịch thuê phim.
	MovieID (Khóa ngoại, tham chiếu đến Movie.MovieID): Liên kết với thông tin bộ phim được thuê.
	RentalFee (kiểu dữ liệu: DECIMAL hoặc FLOAT): Phí thuê cho mỗi bộ phim.
	ReturnDate (kiểu dữ liệu: DATE hoặc DATETIME): Ngày trả phim.

Mối quan hệ giữa các bảng:
+ Bảng "Rental" có khóa ngoại liên kết với bảng "Customer" thông qua cột "CustomerID."
+ Bảng "Rental_detail" có khóa ngoại liên kết với bảng "Rental" thông qua cột "RentalID" và với bảng "Movie" thông qua cột "MovieID."
+ các bảng "Rental" và "Rental_detail" có mối quan hệ giữa các cột "RentalID" và "RentalDetailID."

Các ràng buộc toàn vẹn thường bao gồm khóa chính, khóa ngoại và ràng buộc kiểm tra để đảm bảo tính toàn vẹn của dữ liệu trong CSDL.

--5. Thực hiện định nghĩa các user-defined datatype sau trong CSDL Movies. Kiểm tra sau khi tạo.
	--DINH NGHIA
	sp_addtype Movie_num, 'Int', 'NOT NULL'
	sp_addtype Category_num, 'Int', 'NOT NULL'
	sp_addtype Cust_num, 'Int', 'NOT NULL'
	sp_addtype Invoice_num, 'Int', 'NOT NULL'
	--KIEM TRA
	SELECT domain_name, data_type, character_maximum_length
	FROM information_schema.domains
	ORDER BY domain_name
--6. Thực hiện tạo các bảng vào CSDL Movies, kiểm tra kết quả bằng sp_help

	CREATE TABLE Customer	(Cust_num Cust_num IDENTITY(300,1),	 Lname varchar(20) NOT NULL,	 Fname varchar(20) NOT NULL,	 Address1 varchar(30) NULL,	 Address2 varchar(30) NULL,	 City varchar(20) NULL,	 State Char(2) NULL,	 Zip Char(10) NULL,	 Phone Varchar(10) NOT NULL,	 Join_date Smalldatetime NOT NULL)	 CREATE TABLE Category	 (Category_num Category_num IDENTITY(1,1) NOT NULL,	  Description Varchar(20) NOT NULL)		 CREATE TABLE Movie	 (Movie_num Movie_num NOT NULL,	 Title Cust_num NOT NULL,	 Category_Numm category_num NOT NULL,	 Date_purch Smalldatetime NULL,	 Rental_price Int NULL,	 Rating Char(5) NULL)	 CREATE TABLE Rental	 (Invoice_num Invoice_num NOT NULL,	 Cust_numm Cust_num NOT NULL,	 Rental_date Smalldatetime NOT NULL,	 Due_date Smalldatetime NOT NULL)	 CREATE TABLE Rental_Detail	 (Invoice_numm Invoice_num NOT NULL,	 Line_num Int NOT NULL,	 Movie_numm Movie_num NOT NULL,	 Rental_price Smallmoney NOT NULL)--7.Thực hiện phát sinh tập tin script cho CSDL Movies với các lựa chọn sau, lưu tên Movies.sql:	--All Tables, All user-defined data types		--ALL TABLE	USE [Movies]
	GO

/****** Object:  Table [dbo].[Category]    Script Date: 9/24/2023 2:51:01 AM ******/
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Category]') AND type in (N'U'))
	DROP TABLE [dbo].[Category]
	GO

/****** Object:  Table [dbo].[Category]    Script Date: 9/24/2023 2:51:01 AM ******/
	SET ANSI_NULLS ON
	GO

	SET QUOTED_IDENTIFIER ON
	GO

	CREATE TABLE [dbo].[Category](
	[Category_num] [dbo].[Category_num] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](20) NOT NULL
	) ON [PRIMARY]
	GO

/****** Object:  Table [dbo].[Customer]    Script Date: 9/24/2023 2:52:04 AM ******/
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Customer]') AND type in (N'U'))
	DROP TABLE [dbo].[Customer]
	GO

/****** Object:  Table [dbo].[Customer]    Script Date: 9/24/2023 2:52:04 AM ******/
	SET ANSI_NULLS ON
	GO

	SET QUOTED_IDENTIFIER ON
	GO

	CREATE TABLE [dbo].[Customer](
	[Cust_num] [dbo].[Cust_num] IDENTITY(300,1) NOT NULL,
	[Lname] [varchar](20) NOT NULL,
	[Fname] [varchar](20) NOT NULL,
	[Address1] [varchar](30) NULL,
	[Address2] [varchar](30) NULL,
	[City] [varchar](20) NULL,
	[State] [char](2) NULL,
	[Zip] [char](10) NULL,
	[Phone] [varchar](10) NOT NULL,
	[Join_date] [smalldatetime] NOT NULL
	) ON [PRIMARY]
	GO

	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Movie]') AND type in (N'U'))
	DROP TABLE [dbo].[Movie]
	GO

/****** Object:  Table [dbo].[Movie]    Script Date: 9/24/2023 2:53:45 AM ******/
	SET ANSI_NULLS ON
	GO

	SET QUOTED_IDENTIFIER ON
	GO

	CREATE TABLE [dbo].[Movie](
	[Movie_num] [dbo].[Movie_num] NOT NULL,
	[Title] [dbo].[Cust_num] NOT NULL,
	[Category_Numm] [dbo].[Category_num] NOT NULL,
	[Date_purch] [smalldatetime] NULL,
	[Rental_price] [int] NULL,
	[Rating] [char](5) NULL
	) ON [PRIMARY]
	GO

	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Rental]') AND type in (N'U'))
	DROP TABLE [dbo].[Rental]
	GO

/****** Object:  Table [dbo].[Rental]    Script Date: 9/24/2023 2:54:42 AM ******/
	SET ANSI_NULLS ON
	GO

	SET QUOTED_IDENTIFIER ON
	GO

	CREATE TABLE [dbo].[Rental](
	[Invoice_num] [dbo].[Invoice_num] NOT NULL,
	[Cust_numm] [dbo].[Cust_num] NOT NULL,
	[Rental_date] [smalldatetime] NOT NULL,
	[Due_date] [smalldatetime] NOT NULL
	) ON [PRIMARY]
	GO

	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Rental_Detail]') AND type in (N'U'))
	DROP TABLE [dbo].[Rental_Detail]
	GO

/****** Object:  Table [dbo].[Rental_Detail]    Script Date: 9/24/2023 2:55:21 AM ******/
	SET ANSI_NULLS ON
	GO

	SET QUOTED_IDENTIFIER ON
	GO

	CREATE TABLE [dbo].[Rental_Detail](
	[Invoice_numm] [dbo].[Invoice_num] NOT NULL,
	[Line_num] [int] NOT NULL,
	[Movie_numm] [dbo].[Movie_num] NOT NULL,
	[Rental_price] [smallmoney] NOT NULL
	) ON [PRIMARY]
	GO

	--All user-defined data types

	/****** Object:  UserDefinedDataType [dbo].[Category_num]    Script Date: 9/24/2023 2:56:01 AM ******/
	DROP TYPE [dbo].[Category_num]
	GO

	/****** Object:  UserDefinedDataType [dbo].[Category_num]    Script Date: 9/24/2023 2:56:01 AM ******/
	CREATE TYPE [dbo].[Category_num] FROM [int] NOT NULL
	GO

	/****** Object:  UserDefinedDataType [dbo].[Cust_num]    Script Date: 9/24/2023 2:56:38 AM ******/
	DROP TYPE [dbo].[Cust_num]
	GO

	/****** Object:  UserDefinedDataType [dbo].[Cust_num]    Script Date: 9/24/2023 2:56:38 AM ******/
	CREATE TYPE [dbo].[Cust_num] FROM [int] NOT NULL
	GO

	/****** Object:  UserDefinedDataType [dbo].[Invoice_num]    Script Date: 9/24/2023 2:56:57 AM ******/
	DROP TYPE [dbo].[Invoice_num]
	GO
	
	/****** Object:  UserDefinedDataType [dbo].[Invoice_num]    Script Date: 9/24/2023 2:56:57 AM ******/
	CREATE TYPE [dbo].[Invoice_num] FROM [int] NOT NULL
	GO

	/****** Object:  UserDefinedDataType [dbo].[Movie_num]    Script Date: 9/24/2023 2:57:17 AM ******/
	DROP TYPE [dbo].[Movie_num]
	GO

	/****** Object:  UserDefinedDataType [dbo].[Movie_num]    Script Date: 9/24/2023 2:57:17 AM ******/
	CREATE TYPE [dbo].[Movie_num] FROM [int] NOT NULL
	GO

--9. Thực hiện định nghĩa các khoá chính (Primary Key Constraint) cho các bảng, kiểm tra kết quả bằng lệnh sp_helpconstraint

	ALTER TABLE Movie
		ADD CONSTRAINT PK_movie PRIMARY KEY (Movie_num)

	ALTER TABLE Customer
		ADD CONSTRAINT PK_customer PRIMARY KEY (Cust_num)

	ALTER TABLE Category
		ADD CONSTRAINT PK_category PRIMARY KEY (Category_num)

	ALTER TABLE Rental
		ADD CONSTRAINT PK_rental PRIMARY KEY (Invoice_num)

	--KIEM TRA KET QUA
	sp_helpconstraint Movie	sp_helpconstraint Customer	sp_helpconstraint Category	sp_helpconstraint Rental
--10. Thực hiện định nghĩa các khoá ngoại (Foreign Key Constraint) cho các bảng, kiểm tra kết quả bằng lệnh sp_helpconstraint
	ALTER TABLE Movie WITH CHECK
		ADD CONSTRAINT FK_movie Foreign key (Category_num) REFERENCES Category(Category_num)

	ALTER TABLE Rental WITH CHECK
		ADD CONSTRAINT FK_rental FOREIGN KEY (Cust_num) REFERENCES Customer(Cust_num)

	ALTER TABLE Rental_Detail WITH CHECK
		ADD CONSTRAINT FK_detail_invoice FOREIGN key (Invoice_num) REFERENCES Rental(Invoice_num) 
		ON DELETE Cascade
	
	ALTER TABLE Rental_Detail WITH CHECK
		ADD CONSTRAINT PK_detail_movie FOREIGN KEY (Movie_num) REFERENCES Movie(Movie_num)

	--KIỂM TRA
	sp_helpconstraint Movie	sp_helpconstraint Customer	sp_helpconstraint Category	sp_helpconstraint Rental

--12. Thực hiện định nghĩa các giá trị mặc định (Default Constraint) cho các cột ở các bảng như mô tả sau, kiểm tra kết quả bằng lệnh sp_helpconstraint	ALTER TABLE Movie
		ADD CONSTRAINT DK_movie_date_purch DEFAULT Getdate() FOR Date_purch
	ALTER TABLE Customer 
		ADD CONSTRAINT DK_customer_join_date DEFAULT Getdate() FOR Join_date

	ALTER TABLE Rental
		ADD CONSTRAINT DK_rental_rental_date DEFAULT Getdate() FOR Rental_date

	ALTER TABLE Rental
		ADD CONSTRAINT DK_rental_due_date DEFAULT Getdate()+2 FOR Due_date
		
	--KIỂM TRA
	sp_helpconstraint Movie	sp_helpconstraint Customer	sp_helpconstraint Rental

--13. Thực hiện định nghĩa các ràng buộc miền giá trị (Check Constraint) 
	ALTER TABLE Movie
		ADD CONSTRAINT CK_movie CHECK (Rating IN ('G', 'PG', 'R', 'NC17', 'NR'))

	ALTER TABLE Rental
		ADD CONSTRAINT CK_Due_date CHECK (Due_date >= Rental_date)

	--KIEM TRA
	sp_helpconstraint Movie
	sp_helpconstraint Rental

--14. .Thực hiện phát sinh tập tin script cho các đối tượng trong CSDL Movie.	--Script Primary Keys,Foreign Keys, Default, and Check Constraints. 
	--Table Category
	/****** Object:  Table [dbo].[Category]    Script Date: 9/24/2023 9:20:50 AM ******/
	SET ANSI_NULLS ON
	GO

	SET QUOTED_IDENTIFIER ON
	GO

	CREATE TABLE [dbo].[Category](
		[Category_num] [dbo].[Category_num] IDENTITY(1,1) NOT NULL,
		[Description] [varchar](20) NOT NULL,
	CONSTRAINT [PK_category] PRIMARY KEY CLUSTERED 
	(
		[Category_num] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY]
	GO

	--Table Customer
	SET ANSI_NULLS ON
	GO

	SET QUOTED_IDENTIFIER ON
	GO

	CREATE TABLE [dbo].[Customer](
		[Cust_num] [dbo].[Cust_num] IDENTITY(300,1) NOT NULL,
		[Lname] [varchar](20) NOT NULL,
		[Fname] [varchar](20) NOT NULL,
		[Address1] [varchar](30) NULL,
		[Address2] [varchar](30) NULL,
		[City] [varchar](20) NULL,
		[State] [char](2) NULL,
		[Zip] [char](10) NULL,
		[Phone] [varchar](10) NOT NULL,
		[Join_date] [smalldatetime] NOT NULL,
	CONSTRAINT [PK_customer] PRIMARY KEY CLUSTERED 
	(
		[Cust_num] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY]
	GO

	ALTER TABLE [dbo].[Customer] ADD  CONSTRAINT [DK_customer_join_date]  DEFAULT (getdate()) FOR [Join_date]
	GO

	--Table Movie
	SET ANSI_NULLS ON
	GO

	SET QUOTED_IDENTIFIER ON
	GO

	CREATE TABLE [dbo].[Movie](
		[Movie_num] [dbo].[Movie_num] NOT NULL,
		[Title] [dbo].[Cust_num] NOT NULL,
		[Category_Num] [dbo].[Category_num] NOT NULL,
		[Date_purch] [smalldatetime] NULL,
		[Rental_price] [int] NULL,
		[Rating] [char](5) NULL,
	CONSTRAINT [PK_movie] PRIMARY KEY CLUSTERED 
	(
		[Movie_num] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY]
	GO

	ALTER TABLE [dbo].[Movie] ADD  CONSTRAINT [DK_movie_date_purch]  DEFAULT (getdate()) FOR [Date_purch]
	GO

	ALTER TABLE [dbo].[Movie]  WITH CHECK ADD FOREIGN KEY([Category_Num])
	REFERENCES [dbo].[Category] ([Category_num])
	GO

	ALTER TABLE [dbo].[Movie]  WITH CHECK ADD  CONSTRAINT [FK_movie] FOREIGN KEY([Category_Num])
	REFERENCES [dbo].[Category] ([Category_num])
	GO

	ALTER TABLE [dbo].[Movie] CHECK CONSTRAINT [FK_movie]
	GO

	ALTER TABLE [dbo].[Movie]  WITH CHECK ADD  CONSTRAINT [CK_movie] CHECK  (([Rating]='NR' OR [Rating]='NC17' OR [Rating]='R' OR [Rating]='PG' OR [Rating]='G'))
	GO

	ALTER TABLE [dbo].[Movie] CHECK CONSTRAINT [CK_movie]
	GO
	
	--Table Rental
	SET ANSI_NULLS ON
	GO

	SET QUOTED_IDENTIFIER ON
	GO

	CREATE TABLE [dbo].[Rental](
		[Invoice_num] [dbo].[Invoice_num] NOT NULL,
		[Cust_num] [dbo].[Cust_num] NOT NULL,
		[Rental_date] [smalldatetime] NOT NULL,
		[Due_date] [smalldatetime] NOT NULL,
	 CONSTRAINT [PK_rental] PRIMARY KEY CLUSTERED 
	(
		[Invoice_num] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY]
	GO

	ALTER TABLE [dbo].[Rental] ADD  CONSTRAINT [DK_rental_rental_date]  DEFAULT (getdate()) FOR [Rental_date]
	GO

	ALTER TABLE [dbo].[Rental] ADD  CONSTRAINT [DK_rental_due_date]  DEFAULT (getdate()+(2)) FOR [Due_date]
	GO

	ALTER TABLE [dbo].[Rental]  WITH CHECK ADD  CONSTRAINT [FK_rental] FOREIGN KEY([Cust_num])
	REFERENCES [dbo].[Customer] ([Cust_num])
	GO

	ALTER TABLE [dbo].[Rental] CHECK CONSTRAINT [FK_rental]
	GO

	ALTER TABLE [dbo].[Rental]  WITH CHECK ADD  CONSTRAINT [CK_Due_date] CHECK  (([Due_date]>=[Rental_date]))
	GO

	ALTER TABLE [dbo].[Rental] CHECK CONSTRAINT [CK_Due_date]
	GO

	--Table Rental_Detail
	SET ANSI_NULLS ON
	GO

	SET QUOTED_IDENTIFIER ON
	GO

	CREATE TABLE [dbo].[Rental_Detail](
		[Invoice_num] [dbo].[Invoice_num] NOT NULL,
		[Line_num] [int] NOT NULL,
		[Movie_num] [dbo].[Movie_num] NOT NULL,
		[Rental_price] [smallmoney] NOT NULL,
	PRIMARY KEY CLUSTERED 
	(
		[Invoice_num] ASC,
		[Line_num] ASC,
		[Movie_num] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY]
	GO

	ALTER TABLE [dbo].[Rental_Detail]  WITH CHECK ADD  CONSTRAINT [FK_detail_invoice] FOREIGN KEY([Invoice_num])
	REFERENCES [dbo].[Rental] ([Invoice_num])
	ON DELETE CASCADE
	GO

	ALTER TABLE [dbo].[Rental_Detail] CHECK CONSTRAINT [FK_detail_invoice]
	GO

	ALTER TABLE [dbo].[Rental_Detail]  WITH CHECK ADD  CONSTRAINT [PK_detail_movie] FOREIGN KEY([Movie_num])
	REFERENCES [dbo].[Movie] ([Movie_num])
	GO

	ALTER TABLE [dbo].[Rental_Detail] CHECK CONSTRAINT [PK_detail_movie]
	GO





