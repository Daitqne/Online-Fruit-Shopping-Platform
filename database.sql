USE [master]
GO
/****** Object:  Database [GreenStockDB]    Script Date: 08/06/2026 09:07:40 PM ******/
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'GreenStockDB')
BEGIN
    ALTER DATABASE GreenStockDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE GreenStockDB;
END
GO

CREATE DATABASE [GreenStockDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'GreenStockDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\DATA\GreenStockDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'GreenStockDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\DATA\GreenStockDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [GreenStockDB] SET COMPATIBILITY_LEVEL = 170
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GreenStockDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [GreenStockDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GreenStockDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GreenStockDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GreenStockDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GreenStockDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [GreenStockDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [GreenStockDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GreenStockDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GreenStockDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GreenStockDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GreenStockDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GreenStockDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GreenStockDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GreenStockDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GreenStockDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [GreenStockDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GreenStockDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GreenStockDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GreenStockDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GreenStockDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GreenStockDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [GreenStockDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GreenStockDB] SET RECOVERY FULL 
GO
ALTER DATABASE [GreenStockDB] SET  MULTI_USER 
GO
ALTER DATABASE [GreenStockDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GreenStockDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [GreenStockDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [GreenStockDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [GreenStockDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [GreenStockDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [GreenStockDB] SET OPTIMIZED_LOCKING = OFF 
GO
ALTER DATABASE [GreenStockDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [GreenStockDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [GreenStockDB]
GO
/****** Object:  Table [dbo].[Import_Order]    Script Date: 08/06/2026 09:07:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Import_Order](
	[import_order_id] [int] IDENTITY(1,1) NOT NULL,
	[import_date] [datetime] NOT NULL,
	[created_by] [int] NOT NULL,
	[note] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[import_order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Import_Order_Item]    Script Date: 08/06/2026 09:07:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Import_Order_Item](
	[import_item_id] [int] IDENTITY(1,1) NOT NULL,
	[import_order_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[import_price] [decimal](10, 2) NOT NULL,
	[expired_date] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[import_item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 08/06/2026 09:07:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventory](
	[inventory_id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[last_updated] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[inventory_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Permission]    Script Date: 08/06/2026 09:07:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permission](
	[permission_id] [int] IDENTITY(1,1) NOT NULL,
	[permission_code] [nvarchar](100) NOT NULL,
	[description] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[permission_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 08/06/2026 09:07:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[product_id] [int] IDENTITY(1,1) NOT NULL,
	[product_name] [nvarchar](150) NOT NULL,
	[category_id] [int] NOT NULL,
	[price] [decimal](10, 2) NOT NULL DEFAULT 0, -- [GỘP BỔ SUNG] Giá bán niêm yết của sản phẩm
	[discount_price] [decimal](10, 2) NULL DEFAULT 0, -- [GỘP BỔ SUNG] Giá sau giảm giá
	[unit] [nvarchar](50) NULL,
	[origin] [nvarchar](100) NULL,
	[status] [nvarchar](20) NULL,
	[description] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product_Category]    Script Date: 08/06/2026 09:07:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product_Category](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[category_name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product_Image]    Script Date: 08/06/2026 09:07:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product_Image](
	[image_id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [int] NOT NULL,
	[image_url] [nvarchar](255) NOT NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[image_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ResetPasswordToken]    Script Date: 08/06/2026 09:07:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ResetPasswordToken](
	[token_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[token] [nvarchar](255) NOT NULL,
	[expiry_time] [datetime] NOT NULL,
	[used] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[token_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role_Permission]    Script Date: 08/06/2026 09:07:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role_Permission](
	[role_id] [int] NOT NULL,
	[permission_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[role_id] ASC,
	[permission_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 08/06/2026 09:07:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[role_id] [int] IDENTITY(1,1) NOT NULL,
	[role_name] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sale_Order]    Script Date: 08/06/2026 09:07:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sale_Order](
	[sale_order_id] [int] IDENTITY(1,1) NOT NULL,
	[order_date] [datetime] NOT NULL,
	[created_by] [int] NOT NULL,
	[order_status] [nvarchar](30) NOT NULL,
	[payment_method] [nvarchar](50) NULL,
	[payment_status] [nvarchar](20) NULL DEFAULT 'Pending', -- [GỘP BỔ SUNG] Trạng thái thanh toán (Pending, Paid)
	[shipping_address] [nvarchar](255) NULL, -- [GỘP BỔ SUNG] Địa chỉ nhận đơn
	[shipping_phone] [nvarchar](20) NULL, -- [GỘP BỔ SUNG] Số điện thoại nhận
	[shipper_id] [int] NULL, -- [GỘP BỔ SUNG] Tài xế phụ trách giao
	[shipped_date] [datetime] NULL, -- [GỘP BỔ SUNG] Thời gian bắt đầu giao
	[delivered_date] [datetime] NULL, -- [GỘP BỔ SUNG] Thời gian giao thành công
	[shipper_note] [nvarchar](255) NULL, -- [GỘP BỔ SUNG] Ghi chú giao hàng
PRIMARY KEY CLUSTERED 
(
	[sale_order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sale_Order_Item]    Script Date: 08/06/2026 09:07:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sale_Order_Item](
	[sale_item_id] [int] IDENTITY(1,1) NOT NULL,
	[sale_order_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[unit_price] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[sale_item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User_Role]    Script Date: 08/06/2026 09:07:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Role](
	[user_id] [int] NOT NULL,
	[role_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserInfo]    Script Date: 08/06/2026 09:07:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserInfo](
	[user_info_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[full_name] [nvarchar](150) NOT NULL,
	[phone] [nvarchar](20) NULL,
	[email] [nvarchar](150) NULL,
	[avatar] [nvarchar](255) NULL,
	[gender] [nvarchar](20) NULL,
	[dob] [date] NULL,
	[address] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[user_info_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 08/06/2026 09:07:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[password] [nvarchar](255) NOT NULL,
	[status] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

-- =========================================================================
-- [GỘP BỔ SUNG] TẠO CÁC BẢNG TRUY CẬP ĐỊA CHỈ, REVIEW, PROMOTION & NOTIFICATION
-- =========================================================================

CREATE TABLE [dbo].[CustomerAddresses](
	[address_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[label] [nvarchar](50) NOT NULL, -- Ví dụ: Nhà riêng, Văn phòng
	[receiver_name] [nvarchar](150) NOT NULL,
	[receiver_phone] [nvarchar](20) NOT NULL,
	[address_details] [nvarchar](255) NOT NULL,
	[is_default] [bit] NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[address_id] ASC
)
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Promotions](
	[promo_id] [int] IDENTITY(1,1) NOT NULL,
	[promo_code] [varchar](50) NOT NULL UNIQUE,
	[discount_value] [decimal](10, 2) NOT NULL,
	[discount_type] [nvarchar](20) NOT NULL, -- Percentage, Fixed
	[start_date] [datetime] NOT NULL,
	[end_date] [datetime] NOT NULL,
	[min_order_value] [decimal](10, 2) NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[promo_id] ASC
)
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Reviews](
	[review_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[rating] [int] NOT NULL CHECK (rating BETWEEN 1 AND 5),
	[comment] [nvarchar](500) NULL,
	[status] [nvarchar](20) NULL DEFAULT 'Pending', -- Pending, Approved, Rejected
	[created_at] [datetime] NULL DEFAULT (getdate()),
PRIMARY KEY CLUSTERED 
(
	[review_id] ASC
)
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Notifications](
	[notification_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[title] [nvarchar](100) NOT NULL,
	[content] [nvarchar](500) NOT NULL,
	[is_read] [bit] NULL DEFAULT ((0)),
	[created_at] [datetime] NULL DEFAULT (getdate()),
PRIMARY KEY CLUSTERED 
(
	[notification_id] ASC
)
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Cart](
	[cart_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL UNIQUE,
	[created_at] [datetime] NULL DEFAULT (getdate()),
PRIMARY KEY CLUSTERED 
(
	[cart_id] ASC
)
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Cart_Item](
	[cart_item_id] [int] IDENTITY(1,1) NOT NULL,
	[cart_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[quantity] [int] NOT NULL CHECK (quantity > 0),
PRIMARY KEY CLUSTERED 
(
	[cart_item_id] ASC
)
) ON [PRIMARY]
GO

-- =========================================================================
-- NẠP DỮ LIỆU MẪU CỦA NHÓM BẠN (GỮI NGUYÊN HOÀN TOÀN)
-- =========================================================================

SET IDENTITY_INSERT [dbo].[Inventory] ON 
INSERT [dbo].[Inventory] ([inventory_id], [product_id], [quantity], [last_updated]) VALUES (1, 1, 100, CAST(N'2026-01-27T23:30:12.487' AS DateTime))
INSERT [dbo].[Inventory] ([inventory_id], [product_id], [quantity], [last_updated]) VALUES (2, 2, 200, CAST(N'2026-01-27T23:30:12.487' AS DateTime))
SET IDENTITY_INSERT [dbo].[Inventory] OFF
GO

SET IDENTITY_INSERT [dbo].[Permission] ON 
INSERT [dbo].[Permission] ([permission_id], [permission_code], [description]) VALUES (1, N'VIEW_PRODUCT', N'View product list and details')
INSERT [dbo].[Permission] ([permission_id], [permission_code], [description]) VALUES (2, N'MANAGE_PRODUCT', N'Create, update, delete products')
INSERT [dbo].[Permission] ([permission_id], [permission_code], [description]) VALUES (3, N'MANAGE_INVENTORY', N'Manage inventory quantities')
INSERT [dbo].[Permission] ([permission_id], [permission_code], [description]) VALUES (4, N'PROCESS_ORDER', N'Process and update order status')
INSERT [dbo].[Permission] ([permission_id], [permission_code], [description]) VALUES (5, N'MANAGE_USER', N'Manage users and roles')
SET IDENTITY_INSERT [dbo].[Permission] OFF
GO

SET IDENTITY_INSERT [dbo].[Product] ON 
-- Apple (ID 1) có giá 65,000đ, Carrot (ID 2) có giá 35,000đ
INSERT [dbo].[Product] ([product_id], [product_name], [category_id], [price], [discount_price], [unit], [origin], [status], [description]) VALUES (1, N'Apple', 1, 65000, 60000, N'kg', N'Vietnam', N'Available', N'Fresh red apples')
INSERT [dbo].[Product] ([product_id], [product_name], [category_id], [price], [discount_price], [unit], [origin], [status], [description]) VALUES (2, N'Carrot', 2, 35000, 0, N'kg', N'Vietnam', N'Available', N'Organic carrots')
SET IDENTITY_INSERT [dbo].[Product] OFF
GO

SET IDENTITY_INSERT [dbo].[Product_Category] ON 
INSERT [dbo].[Product_Category] ([category_id], [category_name]) VALUES (1, N'Fruit')
INSERT [dbo].[Product_Category] ([category_id], [category_name]) VALUES (2, N'Vegetable')
SET IDENTITY_INSERT [dbo].[Product_Category] OFF
GO

SET IDENTITY_INSERT [dbo].[Product_Image] ON 
INSERT [dbo].[Product_Image] ([image_id], [product_id], [image_url], [created_at]) VALUES (1, 1, N'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?auto=format&fit=crop&q=80&w=600', CAST(N'2026-01-27T23:30:12.480' AS DateTime))
INSERT [dbo].[Product_Image] ([image_id], [product_id], [image_url], [created_at]) VALUES (2, 2, N'https://images.unsplash.com/photo-1611080626919-7cf5a9dbab5b?auto=format&fit=crop&q=80&w=600', CAST(N'2026-01-27T23:30:12.483' AS DateTime))
SET IDENTITY_INSERT [dbo].[Product_Image] OFF
GO

INSERT [dbo].[Role_Permission] ([role_id], [permission_id]) VALUES (1, 1)
INSERT [dbo].[Role_Permission] ([role_id], [permission_id]) VALUES (3, 1)
INSERT [dbo].[Role_Permission] ([role_id], [permission_id]) VALUES (3, 2)
INSERT [dbo].[Role_Permission] ([role_id], [permission_id]) VALUES (3, 3)
INSERT [dbo].[Role_Permission] ([role_id], [permission_id]) VALUES (3, 4)
INSERT [dbo].[Role_Permission] ([role_id], [permission_id]) VALUES (3, 5)
GO

SET IDENTITY_INSERT [dbo].[Roles] ON 
INSERT [dbo].[Roles] ([role_id], [role_name]) VALUES (3, N'Admin')
INSERT [dbo].[Roles] ([role_id], [role_name]) VALUES (1, N'Customer')
INSERT [dbo].[Roles] ([role_id], [role_name]) VALUES (5, N'Delivery')
INSERT [dbo].[Roles] ([role_id], [role_name]) VALUES (4, N'Shop Owner')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO

INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (8, 1)
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (9, 3)
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (11, 4)
GO

SET IDENTITY_INSERT [dbo].[UserInfo] ON 
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email]) VALUES (8, 8, N'trần hữu vinh', N'0999999999', N'thoike2304@gmail.com')
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email]) VALUES (9, 9, N'trần hữu vinh', N'0999999999', N'vinhthhe176773@fpt.edu.vn')
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email]) VALUES (10, 11, N'trần hữu vinh', N'0999999999', N'vinhthhe@fpt.edu.vn')
SET IDENTITY_INSERT [dbo].[UserInfo] OFF
GO

SET IDENTITY_INSERT [dbo].[Users] ON 
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (8, N'vinh12345', N'$2a$10$CE/KWFfqH7T/BmzGnSsA4u37ctbC9W2uUXWr9..m5wNZqatDFU13y', N'Active')
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (9, N'vinh1234', N'$2a$10$fJVGHjeejDnYmKs1tszB.O5nucgVmxnc1buKZ5SpHGnM5DHMAYW4y', N'Active')
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (11, N'vinh123456', N'$2a$10$hkYq0GTA4SWPnsYfwNZ2WuHZKR16GwAWJ3feuH4L.olq0WsTZbrSa', N'Active')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO

-- Nạp địa chỉ nhận hàng mẫu cho user 8 (customer)
INSERT [dbo].[CustomerAddresses] ([user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default])
VALUES (8, N'Nhà riêng', N'Trần Hữu Vinh', N'0999999999', N'123 Nguyễn Văn Cừ, Quận 5, TP. HCM', 1)
INSERT [dbo].[CustomerAddresses] ([user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default])
VALUES (8, N'Văn phòng', N'Trần Hữu Vinh', N'0999999999', N'Tòa nhà FPT, Khu Công Nghệ Cao, Quận 9, TP. HCM', 0)
GO

-- Nạp chương trình khuyến mãi mẫu
INSERT [dbo].[Promotions] (promo_code, discount_value, discount_type, start_date, end_date, min_order_value) VALUES
('FRUIT10', 10, 'Percentage', '2026-01-01', '2026-12-31', 100000),
('FREESHIP', 25000, 'Fixed', '2026-01-01', '2026-12-31', 150000);
GO


-- =========================================================================
-- CÁC RÀNG BUỘC INDEX VÀ KHOÁ NGOẠI CỦA BẠN (GIỮ NGUYÊN)
-- =========================================================================

SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[Permission] ADD UNIQUE NONCLUSTERED 
(
	[permission_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[ResetPasswordToken] ADD UNIQUE NONCLUSTERED 
(
	[token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[Roles] ADD UNIQUE NONCLUSTERED 
(
	[role_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[UserInfo] ADD UNIQUE NONCLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Inventory] ADD  DEFAULT (getdate()) FOR [last_updated]
GO
ALTER TABLE [dbo].[Product_Image] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[ResetPasswordToken] ADD  DEFAULT ((0)) FOR [used]
GO
ALTER TABLE [dbo].[Import_Order]  WITH CHECK ADD FOREIGN KEY([created_by])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Import_Order_Item]  WITH CHECK ADD FOREIGN KEY([import_order_id])
REFERENCES [dbo].[Import_Order] ([import_order_id])
GO
ALTER TABLE [dbo].[Import_Order_Item]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([product_id])
GO
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([product_id])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([category_id])
REFERENCES [dbo].[Product_Category] ([category_id])
GO
ALTER TABLE [dbo].[Product_Image]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([product_id])
GO
ALTER TABLE [dbo].[ResetPasswordToken]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Role_Permission]  WITH CHECK ADD FOREIGN KEY([permission_id])
REFERENCES [dbo].[Permission] ([permission_id])
GO
ALTER TABLE [dbo].[Role_Permission]  WITH CHECK ADD FOREIGN KEY([role_id])
REFERENCES [dbo].[Roles] ([role_id])
GO
ALTER TABLE [dbo].[Sale_Order]  WITH CHECK ADD FOREIGN KEY([created_by])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Sale_Order_Item]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([product_id])
GO
ALTER TABLE [dbo].[Sale_Order_Item]  WITH CHECK ADD FOREIGN KEY([sale_order_id])
REFERENCES [dbo].[Sale_Order] ([sale_order_id])
GO
ALTER TABLE [dbo].[User_Role]  WITH CHECK ADD FOREIGN KEY([role_id])
REFERENCES [dbo].[Roles] ([role_id])
GO
ALTER TABLE [dbo].[User_Role]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[UserInfo]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO

-- Ràng buộc khoá ngoại bổ sung [GỘP BỔ SUNG]
ALTER TABLE [dbo].[CustomerAddresses] WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Reviews] WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Reviews] WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([product_id]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Notifications] WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Sale_Order] WITH CHECK ADD FOREIGN KEY([shipper_id])
REFERENCES [dbo].[Users] ([user_id])
GO

-- Ràng buộc khóa ngoại cho Cart và Cart_Item
ALTER TABLE [dbo].[Cart] WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Cart_Item] WITH CHECK ADD FOREIGN KEY([cart_id])
REFERENCES [dbo].[Cart] ([cart_id]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Cart_Item] WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([product_id]) ON DELETE CASCADE
GO

USE [master]
GO
ALTER DATABASE [GreenStockDB] SET  READ_WRITE 
GO
