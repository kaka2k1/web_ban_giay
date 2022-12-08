USE [master]
GO
/****** Object:  Database [QuanLyBanGiay]    Script Date: 12/7/2022 10:40:44 AM ******/
CREATE DATABASE [QuanLyBanGiay]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuanLyBanGiay', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER19\MSSQL\DATA\QuanLyBanGiay.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QuanLyBanGiay_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER19\MSSQL\DATA\QuanLyBanGiay_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [QuanLyBanGiay] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLyBanGiay].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLyBanGiay] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLyBanGiay] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLyBanGiay] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLyBanGiay] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLyBanGiay] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLyBanGiay] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QuanLyBanGiay] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLyBanGiay] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyBanGiay] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLyBanGiay] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLyBanGiay] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLyBanGiay] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLyBanGiay] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLyBanGiay] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLyBanGiay] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QuanLyBanGiay] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLyBanGiay] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLyBanGiay] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLyBanGiay] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLyBanGiay] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLyBanGiay] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLyBanGiay] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLyBanGiay] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QuanLyBanGiay] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLyBanGiay] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLyBanGiay] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLyBanGiay] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLyBanGiay] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QuanLyBanGiay] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QuanLyBanGiay] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'QuanLyBanGiay', N'ON'
GO
ALTER DATABASE [QuanLyBanGiay] SET QUERY_STORE = OFF
GO
USE [QuanLyBanGiay]
GO
/****** Object:  UserDefinedFunction [dbo].[ComputeOrderTotal]    Script Date: 12/7/2022 10:40:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[ComputeOrderTotal] (@MAHD INT)
returns int
as
begin
	return (select SUM(GIA) from PHONG where HOADON.MAHD=@MAHD)
end
GO
/****** Object:  Table [dbo].[Account]    Script Date: 12/7/2022 10:40:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[uID] [int] IDENTITY(1,1) NOT NULL,
	[user] [nchar](10) NULL,
	[pass] [nchar](10) NULL,
	[isSell] [bit] NULL,
	[isAdmin] [bit] NULL,
	[email] [nvarchar](50) NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[uID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 12/7/2022 10:40:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[accountID] [int] NOT NULL,
	[productID] [int] NOT NULL,
	[amount] [int] NULL,
	[maCart] [int] IDENTITY(1,1) NOT NULL,
	[size] [nvarchar](50) NULL,
 CONSTRAINT [PK_Cart] PRIMARY KEY CLUSTERED 
(
	[maCart] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 12/7/2022 10:40:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[cid] [int] NOT NULL,
	[cname] [nvarchar](50) NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[cid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Invoice]    Script Date: 12/7/2022 10:40:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoice](
	[maHD] [int] IDENTITY(1,1) NOT NULL,
	[accountID] [int] NULL,
	[tongGia] [float] NULL,
	[ngayXuat] [datetime] NULL,
 CONSTRAINT [PK_Invoice] PRIMARY KEY CLUSTERED 
(
	[maHD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 12/7/2022 10:40:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](200) NULL,
	[image] [nvarchar](500) NULL,
	[price] [float] NULL,
	[title] [nvarchar](500) NULL,
	[description] [nvarchar](max) NULL,
	[cateID] [int] NOT NULL,
	[sell_ID] [int] NOT NULL,
	[model] [nvarchar](50) NULL,
	[color] [nvarchar](50) NULL,
	[delivery] [nvarchar](50) NULL,
	[image2] [nvarchar](500) NULL,
	[image3] [nvarchar](500) NULL,
	[image4] [nvarchar](500) NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Review]    Script Date: 12/7/2022 10:40:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Review](
	[accountID] [int] NULL,
	[productID] [int] NULL,
	[contentReview] [nvarchar](500) NULL,
	[dateReview] [date] NULL,
	[maReview] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Review] PRIMARY KEY CLUSTERED 
(
	[maReview] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Account] ON 

INSERT [dbo].[Account] ([uID], [user], [pass], [isSell], [isAdmin], [email]) VALUES (1, N'phong     ', N'phong     ', 1, 1, N'quyetphonga3@gmail.com')
INSERT [dbo].[Account] ([uID], [user], [pass], [isSell], [isAdmin], [email]) VALUES (2, N'phu2      ', N'123456    ', 0, 0, N'daoquyetphonga3@gmail.com')
INSERT [dbo].[Account] ([uID], [user], [pass], [isSell], [isAdmin], [email]) VALUES (3, N'thanh     ', N'123456    ', 1, 0, N'quyetphonga3@gmail.com')
INSERT [dbo].[Account] ([uID], [user], [pass], [isSell], [isAdmin], [email]) VALUES (1010, N'phu       ', N'phu       ', 0, 1, N'quyetphonga3@gmail.com')
INSERT [dbo].[Account] ([uID], [user], [pass], [isSell], [isAdmin], [email]) VALUES (1011, N'thanh     ', N'thanh     ', 0, 0, N'thanh03@gmail.com')
INSERT [dbo].[Account] ([uID], [user], [pass], [isSell], [isAdmin], [email]) VALUES (2010, N'thanh     ', N'thanh     ', 1, NULL, N'thanh@gmail.com')
SET IDENTITY_INSERT [dbo].[Account] OFF
GO
INSERT [dbo].[Category] ([cid], [cname]) VALUES (1, N'GIAY ADIDAS')
INSERT [dbo].[Category] ([cid], [cname]) VALUES (2, N'GIAY NIKE')
INSERT [dbo].[Category] ([cid], [cname]) VALUES (3, N'GIAY BITIS')
INSERT [dbo].[Category] ([cid], [cname]) VALUES (4, N'GIAY CONVERSE')
GO
SET IDENTITY_INSERT [dbo].[Invoice] ON 

INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (1, 1, 999, CAST(N'2021-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (2, 1, 800, CAST(N'2021-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (3, 1, 400, CAST(N'2021-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (4, 1, 511.2, CAST(N'2021-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (5, 1, 241.20000000000002, CAST(N'2021-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (6, 1, 392.40000000000003, CAST(N'2021-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (7, 1, 482.40000000000003, CAST(N'2021-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (8, 2, 300, CAST(N'2021-11-18T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (9, 2, 400, CAST(N'2021-11-17T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (10, 1, 180, CAST(N'2021-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (11, 1, 1079.1000000000001, CAST(N'2021-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (12, 1, 122.4, CAST(N'2021-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (13, 1, 1394.1000000000001, CAST(N'2021-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (14, 2, 256, CAST(N'2021-10-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (15, 3, 450, CAST(N'2021-10-03T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (16, 2, 200, CAST(N'2021-09-05T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (17, 2, 100, CAST(N'2021-08-06T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (18, 3, 156, CAST(N'2021-07-07T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (19, 3, 256, CAST(N'2021-06-06T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (20, 3, 158, CAST(N'2021-05-05T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (21, 2, 800, CAST(N'2021-04-04T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (22, 3, 750, CAST(N'2021-03-03T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (23, 2, 657, CAST(N'2021-02-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (24, 1, 800, CAST(N'2021-01-01T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Invoice] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (11, N'GIÀY NIKE AIR MAX AP NAM - XÁM XANH', N'https://myshoes.vn/image/cache/catalog/nike1/NIKE-CU4826_003_A_PREM-550x550.jpg', 180, N'GIÀY NIKE AIR MAX AP NAM - XÁM XANH', N'Giày Nike Air Max AP là mẫu giày với thiết kế vô cùng thời trang của Nike với sự kết hợp hài hòa giữa quá khứ và hiện đại.

Phần đế giữa của Nike Air Max AP được thiết kế rất hợp lý mềm mại với công nghệ tiên tiến nhất của Nike. Chắc chắn đây là mẫu giày mà bất cứ fan Sneaker không thể bỏ qua', 2, 1, N'G87', N'Gray', N'Hải Phòng', N'https://myshoes.vn/image/cache/catalog/nike1/NIKE-CU4826_003_C_PREM-550x550.jpg', N'https://myshoes.vn/image/cache/catalog/nike1/NIKE-CU4826_003_D_PREM-550x550.jpg', N'https://myshoes.vn/image/cache/catalog/nike1/NIKE-CU4826_003_F_PREM-550x550.jpg')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (15, N'Adidas Ultraboost 4.0', N'https://product.hstatic.net/1000282067/product/giay_ultraboost_mau_xanh_da_troi_g54002_e902370c1de04294ad2602df86bc7c7c_1024x1024.jpg', 156, N'Adidas Ultraboost 4.0', N'KIỂM SOÁT LỰC KHI CHẠM ĐẤT, THOẢI MÁI TRONG TỪNG BƯỚC CHẠY.

Giày Sneaker Nam Nữ Adidas Ultraboost 4.0 FU9993 – Hàng Chính Hãng

', 2, 1, N'G87', N'Blue', N'Long An', N'https://images.solecollector.com/complex/images/fl_lossy,q_auto/c_scale,w_690,dpr_2.0/v1/dq2zuhqxoufskbl1ycjd/adidas-ultra-boost-4-navy', N'https://product.hstatic.net/1000282067/product/529360_01.jpg_37102ca9b517400d8159d0dd501ac79e_1024x1024.jpeg', N'https://product.hstatic.net/1000282067/product/ultraboost_shoes_blue_g54002_05_standard_bc063c8c6fa5466f868a6765dd896386_1024x1024.jpg')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (17, N'Giay nghi ngoi', N'https://myshoes.vn/image/cache/data/nike%202019/7.6.19/giay-nike-revolution-5-nam-den-trang-03-550x550.jpg', 600, N'title title', N'description 2', 2, 1, N'G68', N'Blue', N'Long An', N'https://myshoes.vn/image/cache/data/nike%202019/7.6.19/giay-nike-revolution-5-nam-den-trang-04-550x550.jpg', N'https://myshoes.vn/image/cache/data/nike%202019/7.6.19/giay-nike-revolution-5-nam-den-trang-05-550x550.jpg', N'https://myshoes.vn/image/cache/data/nike%202019/7.6.19/giay-nike-revolution-5-nam-den-trang-06-550x550.jpg')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (18, N'Giày Nike Revolution 5 Nam - Đen Trắng', N'https://myshoes.vn/image/cache/data/nike%202019/7.6.19/giay-nike-revolution-5-nam-den-trang-01-550x550.jpg', 690, N'Giày Nike Revolution 5 Nam - Đen Trắng', N'Bạn đang tìm kiếm cho mình một đôi giày chạy bộ, tập thể thao nhẹ nhàng nhưng vẫn có mức giá tốt thì hãy để Myshoes.vn- Giày Chính Hãng giúp bạn. Mẫu giày Nike Revolution 5 sẽ là lựa chọn hoàn hảo, hợp lý,chính xác cho bạn. Với công nghệ được thiết kế để vừa chạy vừa có thể tập được thể thao nhưng lại không quá đắt như Zoom hay React. Nike Revolution 5 sẽ là mẫu giày mà các tín đồ yêu thích thể thao nên có cho mình một đôi. Đồng thời với lối thiết kế trẻ trung, hiện đại thì bạn có thể dùng chính đôi giày này để kết hợp với các Outfit thường ngày.', 2, 1, N'G68', N'Blue', N'Long An', N'https://myshoes.vn/image/cache/data/nike%202019/7.6.19/giay-nike-revolution-5-nam-den-trang-02-550x550.jpg', N'https://myshoes.vn/image/cache/data/nike%202019/7.6.19/giay-nike-revolution-5-nam-den-trang-03-550x550.jpg', N'https://myshoes.vn/image/cache/data/nike%202019/7.6.19/giay-nike-revolution-5-nam-den-trang-04-550x550.jpg')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (19, N'Giày Nike Air Max SC Nam- Đen Trắng', N'https://myshoes.vn/image/cache/catalog/nike/24.10/giay-nike-air-max-sc-nam-den-trang-01-550x550.jpg', 190, N'Giày Nike Air Max SC Nam- Đen Trắng', N'mang nét huyền thoại của Nike, với bộ đệm Air Max trứ danh đây là mẫu giày có thể kết hợp với bất cứ trang phục nào mà bạn vẫn hoàn toàn tự tin trong mọi hoàn cảnh.', 2, 1, N'G68', N'Black', N'Long An', N'https://myshoes.vn/image/cache/catalog/nike/24.10/giay-nike-air-max-sc-nam-den-trang-06-550x550.jpg', N'https://myshoes.vn/image/cache/catalog/nike/24.10/giay-nike-air-max-sc-nam-den-trang-05-550x550.jpg', N'https://myshoes.vn/image/cache/catalog/nike/24.10/giay-nike-air-max-sc-nam-den-trang-04-550x550.jpg')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (20, N'Giày Nike Court Royale 2 Nam - Đen', N'https://myshoes.vn/image/cache/catalog/nike/22.10/Nike-Court-Royale-2-Nam-den-01-550x550.jpg', 490, N'Giày Nike Court Royale 2 Nam - Đen', N'', 2, 1, N'G68', N'Black', N'Long An', N'https://myshoes.vn/image/cache/catalog/nike/22.10/Nike-Court-Royale-2-Nam-den-06-550x550.jpg', N'https://myshoes.vn/image/cache/catalog/nike/22.10/Nike-Court-Royale-2-Nam-den-05-550x550.jpg', N'https://myshoes.vn/image/cache/catalog/nike/22.10/Nike-Court-Royale-2-Nam-den-04-550x550.jpg')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (21, N'Giày Nike Air Max AP Nam - Đen', N'https://myshoes.vn/image/cache/catalog/nike/22.10/giay-Nike-Air-Max-AP-nam-den-01-550x550.jpg', 690, N'Giày Nike Air Max AP Nam - Đen', N'', 2, 1, N'G68', N'Black', N'Long An', N'https://myshoes.vn/image/cache/catalog/nike/22.10/giay-Nike-Air-Max-AP-nam-den-06-550x550.jpg', N'https://myshoes.vn/image/cache/catalog/nike/22.10/giay-Nike-Air-Max-AP-nam-den-05-550x550.jpg', N'https://myshoes.vn/image/cache/catalog/nike/22.10/giay-Nike-Air-Max-AP-nam-den-04-550x550.jpg')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (22, N'Giày Nike Renew Retaliation TR 3 Nam - Đen Trắng', N'https://myshoes.vn/image/cache/catalog/nike1/giay-Nike-Renew-Retaliation-TR-3-01-550x550.jpg', 890, N'Giày Nike Renew Retaliation TR 3 Nam - Đen Trắng', N'', 2, 1, N'G68', N'Black', N'Long An', N'https://myshoes.vn/image/cache/catalog/nike1/giay-Nike-Renew-Retaliation-TR-3-03-550x550.jpg', N'https://myshoes.vn/image/cache/catalog/nike1/giay-Nike-Renew-Retaliation-TR-3-02-550x550.jpg', N'https://myshoes.vn/image/cache/catalog/nike1/giay-Nike-Renew-Retaliation-TR-3-05-550x550.jpg')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (23, N'Giày Nike Downshifter 11 Nam- Đen Full', N'https://myshoes.vn/image/cache/catalog/nike2021/2021/giay-nike-downshifter-11-nam-den-full-01-550x550.jpg', 690, N'Giày Nike Downshifter 11 Nam- Đen Full', N'×', 2, 1, N'G68', N'Black', N'Long An', N'https://myshoes.vn/image/cache/catalog/nike2021/2021/giay-nike-downshifter-11-nam-den-full-03-550x550.jpg', N'https://myshoes.vn/image/cache/catalog/nike2021/2021/giay-nike-downshifter-11-nam-den-full-04-550x550.jpg', N'https://myshoes.vn/image/cache/catalog/nike2021/2021/giay-nike-downshifter-11-nam-den-full-05-550x550.jpg')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (24, N'Giày Nike Air Zoom Structure 24 Nam - Trắng', N'https://myshoes.vn/image/cache/catalog/nike/10.11/giay-nike-air-zoom-structure-24-nam-trang-01-550x550.jpg', 390, N'Giày Nike Air Zoom Structure 24 Nam - Trắng', N'Ở phiên bản này được các chuyên gia đánh giá cao phần bởi sự ổn định nhưng vẫn có cảm giác êm chân trong suốt quá trình sử dụng. Bạn yêu thích thể thao và đang tìm kiếm cho mình một đôi giày để tập luyện thì Nike Air Zoom Structure 24 sẽ là một lựa chọn hoàn toàn chính xác. Bởi một đôi giày tốt sẽ là một người đồng hành quan trọng trong cả 1 quá trình.', 2, 1, N'G68', N'White', N'Long An', N'https://myshoes.vn/image/cache/catalog/nike/10.11/giay-nike-air-zoom-structure-24-nam-trang-02-550x550.jpg', N'https://myshoes.vn/image/cache/catalog/nike/10.11/giay-nike-air-zoom-structure-24-nam-trang-03-550x550.jpg', N'https://myshoes.vn/image/cache/catalog/nike/10.11/giay-nike-air-zoom-structure-24-nam-trang-04-550x550.jpg')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (25, N'Giày Nike Court Royale 2 Nam Nữ - Trắng', N'https://myshoes.vn/image/cache/catalog/nike/22.10/Nike-Court-Royale-2-Nam-trang-01-550x550.jpg', 490, N'Giày Nike Court Royale 2 Nam Nữ - Trắng', N'Mua Hàng Ngay', 2, 1, N'G68', N'White', N'Long An', N'https://myshoes.vn/image/cache/catalog/nike/22.10/Nike-Court-Royale-2-Nam-trang-06-550x550.jpg', N'https://myshoes.vn/image/cache/catalog/nike/22.10/Nike-Court-Royale-2-Nam-trang-05-550x550.jpg', N'https://myshoes.vn/image/cache/catalog/nike/22.10/Nike-Court-Royale-2-Nam-trang-02-550x550.jpg')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (26, N'Giày Nike Revolution 5 Nữ - Trắng Full', N'https://myshoes.vn/image/cache/data/nike%202019/nike/nike%202021/giay-nike-revolution-5-nu-trang-full-01-550x550.jpg', 590, N'Giày Nike Revolution 5 Nữ - Trắng Full', N'', 2, 1, N'G68', N'White', N'Long An', N'https://myshoes.vn/image/cache/data/nike%202019/nike/nike%202021/giay-nike-revolution-5-nu-trang-full-06-550x550.jpg', N'https://myshoes.vn/image/cache/data/nike%202019/nike/nike%202021/giay-nike-revolution-5-nu-trang-full-02-550x550.jpg', N'https://myshoes.vn/image/cache/data/nike%202019/nike/nike%202021/giay-nike-revolution-5-nu-trang-full-04-550x550.jpg')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (27, N'Giày Nike Air Max Zero Essential Nam Trắng Full', N'https://myshoes.vn/image/cache/data/nike%202019/3.5.19/giay-nike-air-max-zero-essential-nam-trang-full-01-550x550.jpg', 690, N'Giày Nike Air Max Zero Essential Nam Trắng Full', N'', 2, 1, N'G68', N'White', N'Long An', N'https://myshoes.vn/image/cache/data/nike%202019/3.5.19/giay-nike-air-max-zero-essential-nam-trang-full-03-550x550.jpg', N'https://myshoes.vn/image/cache/data/nike%202019/3.5.19/giay-nike-air-max-zero-essential-nam-trang-full-05-550x550.jpg', N'https://myshoes.vn/image/cache/data/nike%202019/3.5.19/giay-nike-air-max-zero-essential-nam-trang-full-04-550x550.jpg')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (28, N'Giày Nike Court Majestic Leather Nam Trắng Đen', N'https://myshoes.vn/image/cache/data/nike%202019/3.5.19/giay-nike-court-majestic-leather-nam-trang-den-01-550x550.jpg', 890, N'Giày Nike Court Majestic Leather Nam Trắng Đen', N'- Giày Nike Court Royale SL chính hãng 100%. Phát hiện hàng Fake đền tiền gấp 2 lần giá sản phẩm.', 2, 1, N'G68', N'White', N'Long An', N'https://myshoes.vn/image/cache/data/nike%202019/3.5.19/giay-nike-court-majestic-leather-nam-trang-den-05-550x550.jpg', N'https://myshoes.vn/image/cache/data/nike%202019/3.5.19/giay-nike-court-majestic-leather-nam-trang-den-06-550x550.jpg', N'https://myshoes.vn/image/cache/data/nike%202019/3.5.19/giay-nike-court-majestic-leather-nam-trang-den-04-550x550.jpg')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (29, N'Giày Puma Smash V2 L Nam Xám', N'https://myshoes.vn/image/cache/data/PUMA%202019/thang7/giay-puma-smash-v2-l-nam-xam-01-550x550.jpg', 590, N'Giày Puma Smash V2 L Nam Xám', N'', 2, 1, N'G68', N'Gray', N'Long An', N'https://myshoes.vn/image/cache/data/PUMA%202019/thang7/giay-puma-smash-v2-l-nam-xam-07-550x550.jpg', N'https://myshoes.vn/image/cache/data/PUMA%202019/thang7/giay-puma-smash-v2-l-nam-xam-02-550x550.jpg', N'https://myshoes.vn/image/cache/data/PUMA%202019/thang7/giay-puma-smash-v2-l-nam-xam-01-80x80.jpg')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (30, N'Giày Lacoste Europa 120 Nam - Xám Trắng', N'https://myshoes.vn/image/cache/data/lacoste%202019/thang%206/lc/giay-lacoste-europa-120-nam-xam-trang-01-550x550.jpg', 590, N'Giày Lacoste Europa 120 Nam - Xám Trắng', N'', 2, 1, N'G68', N'Gray', N'Long An', N'https://myshoes.vn/image/cache/data/lacoste%202019/thang%206/lc/giay-lacoste-europa-120-nam-xam-trang-05-550x550.jpg', N'https://myshoes.vn/image/cache/data/lacoste%202019/thang%206/lc/giay-lacoste-europa-120-nam-xam-trang-04-550x550.jpg', N'https://myshoes.vn/image/cache/data/lacoste%202019/thang%206/lc/giay-lacoste-europa-120-nam-xam-trang-03-550x550.jpg')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (31, N'Giày Nike Air Zoom Structure 23 Nam - Xám', N'https://myshoes.vn/image/cache/catalog/nike/25.10/giay-nike-structure-23-nam-xam-01-550x550.jpg', 90, N'Giày Nike Air Zoom Structure 23 Nam - Xám', N'', 2, 1, N'G68', N'Gray', N'Long An', N'https://myshoes.vn/image/cache/catalog/nike/25.10/giay-nike-structure-23-nam-xam-06-550x550.jpg', N'https://myshoes.vn/image/cache/catalog/nike/25.10/giay-nike-structure-23-nam-xam-05-550x550.jpg', N'https://myshoes.vn/image/cache/catalog/nike/25.10/giay-nike-structure-23-nam-xam-04-550x550.jpg')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (32, N'Giày Nike Air Max AP Nam - Xám Xanh', N'https://myshoes.vn/image/cache/catalog/nike1/NIKE-CU4826_003_A_PREM-550x550.jpg', 690, N'Giày Nike Air Max AP Nam - Xám Xanh', N'', 2, 1, N'G68', N'Gray', N'Long An', N'https://myshoes.vn/image/cache/catalog/nike1/NIKE-CU4826_003_C_PREM-550x550.jpg', N'https://myshoes.vn/image/cache/catalog/nike1/NIKE-CU4826_003_D_PREM-550x550.jpg', N'https://myshoes.vn/image/cache/catalog/nike1/NIKE-CU4826_003_E_PREM-550x550.jpg')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (33, N'Giày adidas Edge Lux Nữ - Xám', N'https://myshoes.vn/image/cache/data/adidas%202019/22.3.19/giay-adidas-edge-lux-nu-xam-01-550x550.jpg', 90, N'Giày adidas Edge Lux Nữ - Xám', N'* Myshoes.vn cam kết:', 2, 1, N'G68', N'Gray', N'Long An', N'https://myshoes.vn/image/cache/data/adidas%202019/22.3.19/giay-adidas-edge-lux-nu-xam-06-550x550.jpg', N'https://myshoes.vn/image/cache/data/adidas%202019/22.3.19/giay-adidas-edge-lux-nu-xam-05-550x550.jpg', N'https://myshoes.vn/image/cache/data/adidas%202019/22.3.19/giay-adidas-edge-lux-nu-xam-04-550x550.jpg')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (34, N'Giày adidas Super Nova Nữ Xám', N'https://myshoes.vn/image/cache/data/adidas%202019/22.3.19/giay-adidas-super-nova-nu-xam-01-550x550.jpg', 390, N'Giày adidas Super Nova Nữ Xám', N'', 2, 1, N'G68', N'Gray', N'Long An', N'https://myshoes.vn/image/cache/data/adidas%202019/22.3.19/giay-adidas-super-nova-nu-xam-02-550x550.jpg', N'https://myshoes.vn/image/cache/data/adidas%202019/22.3.19/giay-adidas-super-nova-nu-xam-03-550x550.jpg', N'https://myshoes.vn/image/cache/data/adidas%202019/22.3.19/giay-adidas-super-nova-nu-xam-04-550x550.jpg')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (35, N'Giày Nike Epic React Flyknit 2 Nam - Xám Xanh', N'https://myshoes.vn/image/cache/data/nike%202019/7.6.19/giay-nike-epic-react-2%20flyknit-nam-xam-xanh-01-550x550.jpg', 790, N'Giày Nike Epic React Flyknit 2 Nam - Xám Xanh', N'* Myshoes.vn cam kết:', 2, 1, N'G68', N'Gray', N'Long An', N'https://myshoes.vn/image/cache/data/nike%202019/7.6.19/giay-nike-epic-react-2%20flyknit-nam-xam-xanh-06-550x550.jpg', N'https://myshoes.vn/image/cache/data/nike%202019/7.6.19/giay-nike-epic-react-2%20flyknit-nam-xam-xanh-05-550x550.jpg', N'https://myshoes.vn/image/cache/data/nike%202019/7.6.19/giay-nike-epic-react-2%20flyknit-nam-xam-xanh-04-550x550.jpg')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (36, N'Giày Nike Air Zoom Pegasus 37 Nam - Đen Vàng', N'https://myshoes.vn/image/cache/data/nike%202019/nike/giay-nike-air-zoom-pegasus-37-nam-den-vang-01-550x550.jpg', 790, N'Giày Nike Air Zoom Pegasus 37 Nam - Đen Vàng', N'Tiếp theo, phần Upper đã được cải tiến, thay thế bằng một lớp Mesh khác hoàn toàn trước kia. Lớp lưới này nhẹ hơn, dày hơn nhưng tuyệt đối vẫn giữ được sự thông thoáng, thoải mái trong từng mọi hoạt động của bàn chân. Lưỡi gà, cũng được Cut Out tinh tế để fit vừa vặn với các kiểu cổ chân khác nhau đồng thời tăng khả năng điều chỉnh đến một cách linh hoạt nhất.', 2, 1, N'G68', N'Black', N'Long An', N'https://myshoes.vn/image/cache/data/nike%202019/nike/giay-nike-air-zoom-pegasus-37-nam-den-vang-04-550x550.jpg', N'https://myshoes.vn/image/cache/data/nike%202019/nike/giay-nike-air-zoom-pegasus-37-nam-den-vang-06-550x550.jpg', N'https://myshoes.vn/image/cache/data/nike%202019/nike/giay-nike-air-zoom-pegasus-37-nam-den-vang-05-550x550.jpg')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (37, N'Giày Thể Thao Asics GEL-Nimbus® 19 Nam - Xanh vàng', N'https://myshoes.vn/image/cache/data/product10/8.8.17/giay-asics-gel-nimbus-19-nam-xanh-vang-0-550x550.jpg', 490, N'Giày Thể Thao Asics GEL-Nimbus® 19 Nam - Xanh vàng', N'Giày Thể Thao Asics GEL-Nimbus® 19 là đôi giày được ứng dụng công nghệ FlyteFoam™ sau khi được thay đổi hoàn toàn, mang lại sự thoải mái tối ưu nhất và một bộ đệm đàn hồi cho bàn chân người sử dụng. Upper lưới dệt 3D độc đáo, không đường may, có thể linh hoạt theo từng chuyển động chân một cách tự nhiên nhất.', 2, 1, N'G68', N'Blue
', N'Long An', N'https://myshoes.vn/image/cache/data/product10/8.8.17/giay-asics-gel-nimbus-19-nam-xanh-vang-04-550x550.jpg', N'https://myshoes.vn/image/cache/data/product10/8.8.17/giay-asics-gel-nimbus-19-nam-xanh-vang-02-550x550.jpg', N'https://myshoes.vn/image/cache/data/product10/8.8.17/giay-asics-gel-nimbus-19-nam-xanh-vang-06-550x550.jpg')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (38, N'Giày Bóng Đá Nam Bitis Hunter Football', N'https://product.hstatic.net/1000230642/product/02400vag__1__5d559f914caf4864ad99a37c18cc1a1b_1024x1024.jpg', 535, N'Giày Bóng Đá Nam Biti Hunter Football', N'Với thiết kế năng động, Giày bóng đá Biti’s Hunter được tung ra với 5 màu sắc nổi bật tạo điểm nhấn trên sân đấu.', 3, 1, N'G39', N'Yellow', N'Ho Chi Minh', N'https://product.hstatic.net/1000230642/product/02400vag__3__3a83e45335054285a27fba37cafb23c1_1024x1024.jpg', N'https://product.hstatic.net/1000230642/product/02400vag__4__d3693ef3babe4fc3a2908d8eb2df6e3b_1024x1024.jpg', N'https://product.hstatic.net/1000230642/product/02400vag__4__d3693ef3babe4fc3a2908d8eb2df6e3b_1024x1024.jpg')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (39, N'Converse Chuck Taylor 1970s Sunflower', N'https://drake.vn/image/catalog/H%C3%ACnh%20content/B%E1%BA%AFt%20trend%20v%E1%BB%9Bi%20converse%20v%C3%A0ng/battrendmuahe3.jpg', 399, N'Converse Chuck Taylor 1970s Sunflower', N'Thiết kế 1970s Sunflower vẫn giữ nguyên bản của dòng Chuck 70. Đôi giày Converse vàng Sunflower là sự kết hợp giữa hai yếu tố cổ điển và hiện đại, mang màu sắc rất riêng biệt . Phần vải ở thân giày được làm bằng chất liệu vải nặng và dày hơn một chút, phần logo được may thẳng vào thân giày với lớp da cực mướt, tạo vẻ tinh tế và cổ điển cho đôi giày. Bên trong giày sử dụng lớp đệm xốp đặc biệt thoải mái, trong khi bên ngoài đế giày có lớp cao su bóng, vừa dễ vệ sinh lại mang vẻ đẹp vintage cực đẹp.

', 4, 1, N'G89', N'Yellow', N'Hà Nội', N'https://drake.vn/image/catalog/H%C3%ACnh%20content/giay-converse-vang/giay-converse-vang-5.jpg', N'https://drake.vn/image/catalog/H%C3%ACnh%20content/giay-converse-vang/giay-converse-vang-12.jpg', N'https://drake.vn/image/catalog/H%C3%ACnh%20content/B%E1%BA%AFt%20trend%20v%E1%BB%9Bi%20converse%20v%C3%A0ng/battrendmuahe3.jpg')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (40, N'GIÀY ADIDAS ADVANTAGE BASE NAM - TRẮNG XANH', N'https://myshoes.vn/image/cache/data/adidas/giay-adidas-advantage-base-nam-trang-xanh-01.html-550x550.jpg', 140, N'GIÀY ADIDAS ADVANTAGE BASE NAM - TRẮNG XANH', N'Được thừa hưởng lối thiết kế của đàn anh Giày adidas VS Advantage CL song vẫn có thêm nhiều điểm mới cải thiện.Với thiết kế đơn giản nhưng lại vô cùng thanh lịch. Phần Upper của giày được các nhà thiết kế của Adidas sử dụng bằng da bạn tăng thêm độ lịch lãm khi mang. Với các đường kim mũi chỉ hoàn hảo đến từng chi tiết giúp bạn tự tin sải bước. Đây quả thật là một lựa chọn mà các phải mạnh không nên bỏ lỡ. ', 1, 1, N'G76', N'White', N'Nha Trang', N'https://myshoes.vn/image/cache/data/adidas/giay-adidas-advantage-base-nam-trang-xanh-02.html-550x550.jpg', N'https://myshoes.vn/image/cache/data/adidas/giay-adidas-advantage-base-nam-trang-xanh-04.html-550x550.jpg', N'https://myshoes.vn/image/cache/data/adidas/giay-adidas-advantage-base-nam-trang-xanh-03.html-550x550.jpg')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (41, N'GIÀY ADIDAS SUPER COURT NỮ TRẮNG FULL', N'https://myshoes.vn/image/cache/data/adidas%202019/22.3.19/giay-adidas-super-court-nu-trang-full-01-550x550.jpg', 189, N'GIÀY ADIDAS SUPER COURT NỮ TRẮNG FULL', N'Bạn đang tìm kiếm cho mình một đôi giày sẽ có thể trường tồn với thời gian, không bị lỗi mốt theo năm tháng. Adidas Super Court là 1 lựa chọn không nên bỏ lỡ . Kiểu dáng thiết kế trẻ trung, màu sắc tươi sắc nên Adidas Super Court sẽ là kiểu giày giúp bạn dễ dàng chuyển từ ''bánh bèo" sang '' cá tính'' trong một nốt nhạc.', 1, 1, N'G89', N'White', N'Nha Trang', N'https://myshoes.vn/image/cache/data/giay-adidas-super-court-nu-trang-full-05-550x550.jpg', N'https://myshoes.vn/image/cache/data/giay-adidas-super-court-nu-trang-full-03-550x550.jpg', N'https://myshoes.vn/image/cache/data/giay-adidas-super-court-nu-trang-full-02-550x550.jpg')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (42, N'GIÀY ADIDAS SUPER COURT NỮ TRẮNG FULL', N'https://myshoes.vn/image/cache/data/adidas%202019/22.3.19/giay-adidas-super-court-nu-trang-full-01-550x550.jpg', 190, N'GIÀY ADIDAS SUPER COURT NỮ TRẮNG FULL', N'Bạn đang tìm kiếm cho mình một đôi giày sẽ có thể trường tồn với thời gian, không bị lỗi mốt theo năm tháng. Adidas Super Court là 1 lựa chọn không nên bỏ lỡ . Kiểu dáng thiết kế trẻ trung, màu sắc tươi sắc nên Adidas Super Court sẽ là kiểu giày giúp bạn dễ dàng chuyển từ ''bánh bèo" sang '' cá tính'' trong một nốt nhạc.', 1, 1, N'G76', N'White', N'Nha Trang', N'https://myshoes.vn/image/cache/data/giay-adidas-super-court-nu-trang-full-05-550x550.jpg', N'https://myshoes.vn/image/cache/data/giay-adidas-super-court-nu-trang-full-03-550x550.jpg', N'https://myshoes.vn/image/cache/data/giay-adidas-super-court-nu-trang-full-02-550x550.jpg')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (43, N'Converse Run Star Hike Keith Haring', N'https://sneakernews.com/wp-content/uploads/2021/05/SU21_KEITH_HARING_PS_INLINE_PS_CTAS_OX_G40044.jpg?w=1140', 225, N'Converse Run Star Hike Keith Haring', N'Thiết kế Run Star Hike mang tone màu Black làm nổi bật những hình ảnh ngộ nghĩnh thuộc phong cách vẽ Botanical Art đầy bắt mắt của Keith Haring. Đặc biệt, gây ấn tượng là sự xuất hiện của chữ ký của Keith Haring xuất hiện trên lưỡi gà và cả trong lót giày. Đôi giày hứa hẹn sẽ mang lại cho bạn trải nghiệm tuyệt vời trên bộ đế chunky răng cưa đầy táo bạo cùng nội thất đáng “đồng tiền bát gạo”.', 1, 1, N'G89', N'White', N'Nha Trang', N'https://sneakernews.com/wp-content/uploads/2021/05/SU21_KEITH_HARING_PS_INLINE_PS_CTAS_OX_G40044.jpg?w=1140', N'https://sneakernews.com/wp-content/uploads/2021/05/SU21_KEITH_HARING_PS_INLINE_PS_CTAS_OX_G40044.jpg?w=1140', N'https://sneakernews.com/wp-content/uploads/2021/05/SU21_KEITH_HARING_PS_INLINE_PS_CTAS_OX_G40044.jpg?w=1140')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (44, N'Converse Chuck Taylor All Star Renew Sock Knit', N'https://salt.tikicdn.com/cache/750x750/ts/product/8f/13/8b/8d18a462bac8259a91cf0cbdbf96f5a6.jpg.webp', 198, N'Converse Chuck Taylor All Star Renew Sock Knit', N'Converse Chuck Taylor All Star Crate Knit đã trở lại để mang sự cổ điển đến gần hơn với một tương lai không lãng phí. Kiểu dáng Chuck Taylor với phần đế cao su được làm từ Công nghệ Nike Grind kết hợp với xốp Nike và cao su tái chế. Ngoài ra, upper được làm từ chất vải Polyester với công nghệ dệt kỹ thuật tiên tiến, sợi vải được dệt từ 75% poly tái chế và 25% nilon spandex (loại sợi nhân tạo có khả năng co giãn 4 chiều). ', 1, 1, N'G87', N'Gray', N'Nha Trang', N'https://salt.tikicdn.com/cache/750x750/ts/product/8f/13/8b/8d18a462bac8259a91cf0cbdbf96f5a6.jpg.webp', N'https://salt.tikicdn.com/cache/750x750/ts/product/8f/13/8b/8d18a462bac8259a91cf0cbdbf96f5a6.jpg.webp', N'https://salt.tikicdn.com/cache/750x750/ts/product/8f/13/8b/8d18a462bac8259a91cf0cbdbf96f5a6.jpg.webp')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (45, N'Hunter Layered Upper', N'https://product.hstatic.net/1000230642/product/dsc_0024_a6274cb2948449c785a7269de5fa6349_1024x1024.jpg', 800, N'Hunter Layered Upper', N'Sản phẩm rất tốt đi thoải mái', 3, 1, N'G68', N'White', N'Nha Trang', N'https://product.hstatic.net/1000230642/product/dsc_0025_703ee09f5db24cd9a0c8604cdd2592aa_1024x1024.jpg', N'https://product.hstatic.net/1000230642/product/dsc_0026_60087f45b9394f0682f5126309f5d3f6_1024x1024.jpg', N'https://product.hstatic.net/1000230642/product/dsc_0027_647fb72ecf3d455590cddb79c2418458_1024x1024.jpg')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (46, N'Hunter Layered Upper', N'https://product.hstatic.net/1000230642/product/02800den__2__f00d5533d44b47ac84212239f93ebac6_1024x1024.jpg', 767, N'Hunter Layered Upper', N'Sản phẩm rất tốt đi rất thoải mái', 3, 1, N'G45', N'Black', N'Nha Trang', N'https://product.hstatic.net/1000230642/product/02800den__3__0f4c2b667bb44347ac302726b71ce9a2_1024x1024.jpg', N'https://product.hstatic.net/1000230642/product/02800den__4__ef90bd83d09942fd87d72165e5ce2fc7_1024x1024.jpg', N'https://product.hstatic.net/1000230642/product/02800den__5__fb6f5367106342348f60cd7b9b70dee6_1024x1024.jpg')
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[Review] ON 

INSERT [dbo].[Review] ([accountID], [productID], [contentReview], [dateReview], [maReview]) VALUES (1, 15, N'xin chao san pham nay rat tot', CAST(N'2021-11-19' AS Date), 2)
INSERT [dbo].[Review] ([accountID], [productID], [contentReview], [dateReview], [maReview]) VALUES (1, 11, N'xin chào', CAST(N'2021-11-24' AS Date), 14)
SET IDENTITY_INSERT [dbo].[Review] OFF
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Account] FOREIGN KEY([accountID])
REFERENCES [dbo].[Account] ([uID])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Account]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Product] FOREIGN KEY([productID])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Product]
GO
ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_Account] FOREIGN KEY([accountID])
REFERENCES [dbo].[Account] ([uID])
GO
ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [FK_Invoice_Account]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Account] FOREIGN KEY([sell_ID])
REFERENCES [dbo].[Account] ([uID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Account]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([cateID])
REFERENCES [dbo].[Category] ([cid])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_Account] FOREIGN KEY([accountID])
REFERENCES [dbo].[Account] ([uID])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_Review_Account]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_Product] FOREIGN KEY([productID])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_Review_Product]
GO
/****** Object:  StoredProcedure [dbo].[pr_HienThiChiTiet]    Script Date: 12/7/2022 10:40:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[pr_HienThiChiTiet] @MASD int, @MADV int
as
begin
	select * from CHITIETSDDV
end
GO
/****** Object:  StoredProcedure [dbo].[pr_SuaKH]    Script Date: 12/7/2022 10:40:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[pr_SuaKH]
@MAKH INT ,@HOTEN NVARCHAR(50), @SDT nvarchar(10), @DIACHI NVARCHAR(100), @CMND NVARCHAR(9), @GIOITINH NVARCHAR(10) 
as
begin
	update dbo.KHACHHANG set KHACHHANG.MAKH = @MAKH, KHACHHANG.HOTEN = @HOTEN, KHACHHANG.SDT = @SDT, KHACHHANG.DIACHI = @DIACHI, KHACHHANG.CMND = @CMND, KHACHHANG.GIOITINH = @GIOITINH  where KHACHHANG.MAKH = @MAKH 
end
GO
/****** Object:  StoredProcedure [dbo].[pr_SuaLoaiDV]    Script Date: 12/7/2022 10:40:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[pr_SuaLoaiDV] @MADV int, @TENDV nvarchar(50)
as
begin
	update dbo.DICHVU set DICHVU.TENDV = @TENDV where DICHVU.MADV = @MADV
end
GO
/****** Object:  StoredProcedure [dbo].[pr_SuaNV]    Script Date: 12/7/2022 10:40:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[pr_SuaNV]
@MANV INT, @HOTEN NVARCHAR(50), @DIACHI NVARCHAR(50), @SDT VARCHAR(10), @CMND VARCHAR(9), @GIOITINH NVARCHAR(10), @NHOMQL NVARCHAR(50),@TAIKHOAN VARCHAR(50), @MATKHAU VARCHAR(50), @EMAIL NVARCHAR(50)
as
begin
	UPDATE dbo.NHANVIEN SET NHANVIEN.MANV = @MANV, NHANVIEN.HOTEN = @HOTEN, NHANVIEN.DIACHI = @DIACHI, NHANVIEN.SDT = @SDT, NHANVIEN.CMND = @CMND, NHANVIEN.GIOITINH = @GIOITINH, NHANVIEN.NHOMQL = @NHOMQL, NHANVIEN.TAIKHOAN = @TAIKHOAN, NHANVIEN.MATKHAU = @MATKHAU, NHANVIEN.EMAIL = @EMAIL WHERE NHANVIEN.MANV = @MANV
end
GO
/****** Object:  StoredProcedure [dbo].[pr_ThemBillOut]    Script Date: 12/7/2022 10:40:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--thủ tục nhập HÓA ĐƠN
create proc [dbo].[pr_ThemBillOut] @MANV INT
as
begin
	insert into HOADON(MANV) values (@MANV)
end
GO
/****** Object:  StoredProcedure [dbo].[pr_ThemKH]    Script Date: 12/7/2022 10:40:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[pr_ThemKH]
@MAKH INT ,@HOTEN NVARCHAR(50), @SDT nvarchar(10), @DIACHI NVARCHAR(100), @CMND NVARCHAR(9), @GIOITINH NVARCHAR(10) 
as
begin
	insert into KHACHHANG(MAKH,HOTEN, SDT, DIACHI, CMND, GIOITINH)
	values (@MAKH, @HOTEN, @SDT, @DIACHI, @CMND,@GIOITINH)
end
GO
/****** Object:  StoredProcedure [dbo].[pr_ThemLoaiDV]    Script Date: 12/7/2022 10:40:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[pr_ThemLoaiDV] @MADV int, @TENDV nvarchar(50)
as
begin
	insert into DICHVU(TENDV) values (@TENDV);
	insert into DICHVU(MADV) values (@MADV)
end
GO
/****** Object:  StoredProcedure [dbo].[pr_ThemNV]    Script Date: 12/7/2022 10:40:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[pr_ThemNV]
@MANV INT, @HOTEN NVARCHAR(50), @DIACHI NVARCHAR(50), @SDT VARCHAR(10), @CMND VARCHAR(9), @GIOITINH NVARCHAR(10), @NHOMQL NVARCHAR(50),@TAIKHOAN VARCHAR(50), @MATKHAU VARCHAR(50), @EMAIL NVARCHAR(50)
as
begin
	insert into NHANVIEN(MANV, HOTEN, DIACHI, SDT, CMND, GIOITINH, NHOMQL, TAIKHOAN, MATKHAU, EMAIL)
	values (@MANV, @HOTEN, @DIACHI, @SDT, @CMND, @GIOITINH, @NHOMQL, @TAIKHOAN, @MATKHAU, @EMAIL)
end
GO
/****** Object:  StoredProcedure [dbo].[pr_XoaBillOut]    Script Date: 12/7/2022 10:40:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[pr_XoaBillOut] @MAHD INT
as
begin
	delete from HOADON where HOADON.MAHD = @MAHD
end
GO
/****** Object:  StoredProcedure [dbo].[pr_XoaKH]    Script Date: 12/7/2022 10:40:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[pr_XoaKH]
@MAKH INT
as
begin
	delete from KHACHHANG where KHACHHANG.MAKH = @MAKH
end
GO
/****** Object:  StoredProcedure [dbo].[pr_XoaLoaiDV]    Script Date: 12/7/2022 10:40:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[pr_XoaLoaiDV] @MADV int
as
begin
	delete from DICHVU where DICHVU.MADV = @MADV
end
GO
/****** Object:  StoredProcedure [dbo].[pr_XoaNV]    Script Date: 12/7/2022 10:40:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[pr_XoaNV]
@MANV INT
as
begin
	delete from NHANVIEN where NHANVIEN.MANV = @MANV
end
GO
USE [master]
GO
ALTER DATABASE [QuanLyBanGiay] SET  READ_WRITE 
GO
