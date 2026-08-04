USE [master]
GO
/****** Object:  Database [GreenStockDB1]    Script Date: 7/16/2026 10:13:15 PM ******/
CREATE DATABASE [GreenStockDB1]
GO
ALTER DATABASE [GreenStockDB1] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GreenStockDB1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [GreenStockDB1] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GreenStockDB1] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GreenStockDB1] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GreenStockDB1] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GreenStockDB1] SET ARITHABORT OFF 
GO
ALTER DATABASE [GreenStockDB1] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [GreenStockDB1] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GreenStockDB1] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GreenStockDB1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GreenStockDB1] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GreenStockDB1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GreenStockDB1] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GreenStockDB1] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GreenStockDB1] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GreenStockDB1] SET  ENABLE_BROKER 
GO
ALTER DATABASE [GreenStockDB1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GreenStockDB1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GreenStockDB1] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GreenStockDB1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GreenStockDB1] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GreenStockDB1] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [GreenStockDB1] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GreenStockDB1] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [GreenStockDB1] SET  MULTI_USER 
GO
ALTER DATABASE [GreenStockDB1] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GreenStockDB1] SET DB_CHAINING OFF 
GO
ALTER DATABASE [GreenStockDB1] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [GreenStockDB1] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [GreenStockDB1] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [GreenStockDB1] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [GreenStockDB1] SET QUERY_STORE = ON
GO
ALTER DATABASE [GreenStockDB1] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [GreenStockDB1]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 7/16/2026 10:13:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[cart_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[cart_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart_Item]    Script Date: 7/16/2026 10:13:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart_Item](
	[cart_item_id] [int] IDENTITY(1,1) NOT NULL,
	[cart_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[cart_item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerAddresses]    Script Date: 7/16/2026 10:13:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerAddresses](
	[address_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[label] [nvarchar](50) NOT NULL,
	[receiver_name] [nvarchar](150) NOT NULL,
	[receiver_phone] [nvarchar](20) NOT NULL,
	[address_details] [nvarchar](255) NOT NULL,
	[is_default] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[address_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Import_Order]    Script Date: 7/16/2026 10:13:15 PM ******/
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
/****** Object:  Table [dbo].[Import_Order_Item]    Script Date: 7/16/2026 10:13:15 PM ******/
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
/****** Object:  Table [dbo].[Import_Receipt]    Script Date: 7/16/2026 10:13:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Import_Receipt](
	[receipt_id] [int] IDENTITY(1,1) NOT NULL,
	[import_date] [datetime] NOT NULL,
	[created_by] [int] NOT NULL,
	[note] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[receipt_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Import_Receipt_Item]    Script Date: 7/16/2026 10:13:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Import_Receipt_Item](
	[item_id] [int] IDENTITY(1,1) NOT NULL,
	[receipt_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[manufacture_date] [date] NULL,
	[expiry_date] [date] NOT NULL,
	[batch_number] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 7/16/2026 10:13:15 PM ******/
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
/****** Object:  Table [dbo].[Inventory_Batch]    Script Date: 7/16/2026 10:13:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventory_Batch](
	[batch_id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [int] NOT NULL,
	[receipt_item_id] [int] NOT NULL,
	[batch_number] [varchar](50) NOT NULL,
	[quantity_in] [int] NOT NULL,
	[quantity_remain] [int] NOT NULL,
	[manufacture_date] [date] NULL,
	[expiry_date] [date] NOT NULL,
	[created_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[batch_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notifications]    Script Date: 7/16/2026 10:13:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notifications](
	[notification_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[title] [nvarchar](100) NOT NULL,
	[content] [nvarchar](500) NOT NULL,
	[is_read] [bit] NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[notification_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Permission]    Script Date: 7/16/2026 10:13:15 PM ******/
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
/****** Object:  Table [dbo].[Product]    Script Date: 7/16/2026 10:13:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[product_id] [int] IDENTITY(1,1) NOT NULL,
	[product_name] [nvarchar](150) NOT NULL,
	[category_id] [int] NOT NULL,
	[price] [decimal](10, 2) NOT NULL,
	[discount_price] [decimal](10, 2) NULL,
	[unit] [nvarchar](50) NULL,
	[origin] [nvarchar](100) NULL,
	[status] [nvarchar](20) NULL,
	[description] [nvarchar](500) NULL,
	[shop_owner_id] [int] NULL,
	[low_stock_threshold] [int] NOT NULL,
	[import_price] [decimal](10, 2) NULL,
	[import_date] [datetime] NULL,
	[expired_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product_Category]    Script Date: 7/16/2026 10:13:15 PM ******/
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
/****** Object:  Table [dbo].[Product_Image]    Script Date: 7/16/2026 10:13:15 PM ******/
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
/****** Object:  Table [dbo].[Product_Packaging]    Script Date: 7/16/2026 10:13:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product_Packaging](
	[packaging_id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [int] NOT NULL,
	[packaging_name] [nvarchar](100) NOT NULL,
	[price_adjustment] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[packaging_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product_Weight_Variant]    Script Date: 7/16/2026 10:13:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product_Weight_Variant](
	[variant_id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [int] NOT NULL,
	[weight_label] [nvarchar](50) NOT NULL,
	[price_adjustment] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[variant_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Promotions]    Script Date: 7/16/2026 10:13:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Promotions](
	[promo_id] [int] IDENTITY(1,1) NOT NULL,
	[promo_code] [varchar](50) NOT NULL,
	[discount_value] [decimal](10, 2) NOT NULL,
	[discount_type] [nvarchar](20) NOT NULL,
	[start_date] [datetime] NOT NULL,
	[end_date] [datetime] NOT NULL,
	[min_order_value] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[promo_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ResetPasswordToken]    Script Date: 7/16/2026 10:13:15 PM ******/
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
/****** Object:  Table [dbo].[Reviews]    Script Date: 7/16/2026 10:13:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reviews](
	[review_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[rating] [int] NOT NULL,
	[comment] [nvarchar](500) NULL,
	[status] [nvarchar](20) NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[review_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role_Permission]    Script Date: 7/16/2026 10:13:15 PM ******/
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
/****** Object:  Table [dbo].[Roles]    Script Date: 7/16/2026 10:13:15 PM ******/
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
/****** Object:  Table [dbo].[Sale_Order]    Script Date: 7/16/2026 10:13:15 PM ******/
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
	[payment_status] [nvarchar](20) NULL,
	[shipping_address] [nvarchar](255) NULL,
	[shipping_phone] [nvarchar](20) NULL,
	[shipper_id] [int] NULL,
	[shipped_date] [datetime] NULL,
	[delivered_date] [datetime] NULL,
	[shipper_note] [nvarchar](255) NULL,
	[discount_amount] [decimal](10, 2) NULL,
	[promo_code] [varchar](50) NULL,
	[shipping_fee] [decimal](10, 2) NULL,
	[total_payment] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[sale_order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sale_Order_Item]    Script Date: 7/16/2026 10:13:15 PM ******/
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
/****** Object:  Table [dbo].[User_Role]    Script Date: 7/16/2026 10:13:15 PM ******/
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
/****** Object:  Table [dbo].[UserInfo]    Script Date: 7/16/2026 10:13:15 PM ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 7/16/2026 10:13:15 PM ******/
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
SET IDENTITY_INSERT [dbo].[Cart] ON 

INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (1, 13, CAST(N'2026-06-16T14:19:50.197' AS DateTime))
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (2, 8, CAST(N'2026-06-18T13:20:19.627' AS DateTime))
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (3, 11, CAST(N'2026-06-27T23:58:11.843' AS DateTime))
SET IDENTITY_INSERT [dbo].[Cart] OFF
GO
SET IDENTITY_INSERT [dbo].[CustomerAddresses] ON 

INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (1, 8, N'Nhà riêng', N'Trần Hữu Vinh', N'0999999999', N'123 Nguyễn Văn Cừ, Quận 5, TP. HCM', 1)
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (2, 8, N'Văn phòng', N'Trần Hữu Vinh', N'0999999999', N'Tòa nhà FPT, Khu Công Nghệ Cao, Quận 9, TP. HCM', 0)
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (3, 13, N'Công ty', N'Nguyễn Đại Kỳ', N'0976927564', N'Đại Đồng - Đại Mạch  - Đông Anh - Hà Nội', 1)
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (4, 13, N'Trường Học', N'Vương Ngọc Cường', N'0979517431', N'Mạch Lũng - Đại Mạch  - Đông Anh - Hà Nội', 0)
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (6, 11, N'Công ty', N'Trần Hữu Vinh', N'0976926742', N'Đại Đồng - Đại Mạch  - Đông Anh - Hà Nội', 1)
SET IDENTITY_INSERT [dbo].[CustomerAddresses] OFF
GO
SET IDENTITY_INSERT [dbo].[Import_Receipt] ON 

INSERT [dbo].[Import_Receipt] ([receipt_id], [import_date], [created_by], [note]) VALUES (1, CAST(N'2026-07-13T22:32:37.060' AS DateTime), 11, N'')
INSERT [dbo].[Import_Receipt] ([receipt_id], [import_date], [created_by], [note]) VALUES (2, CAST(N'2026-07-13T23:11:58.463' AS DateTime), 11, N'')
INSERT [dbo].[Import_Receipt] ([receipt_id], [import_date], [created_by], [note]) VALUES (3, CAST(N'2026-07-13T23:26:35.890' AS DateTime), 11, N'')
INSERT [dbo].[Import_Receipt] ([receipt_id], [import_date], [created_by], [note]) VALUES (4, CAST(N'2026-07-13T23:36:36.577' AS DateTime), 11, N'')
INSERT [dbo].[Import_Receipt] ([receipt_id], [import_date], [created_by], [note]) VALUES (9, CAST(N'2026-07-20T22:05:39.000' AS DateTime), 11, N'Nhập hàng 10 sản phẩm mới phân phối đều cho các shop owner')
SET IDENTITY_INSERT [dbo].[Import_Receipt] OFF
GO
SET IDENTITY_INSERT [dbo].[Import_Receipt_Item] ON 

INSERT [dbo].[Import_Receipt_Item] ([item_id], [receipt_id], [product_id], [quantity], [manufacture_date], [expiry_date], [batch_number]) VALUES (1, 1, 3, 100, CAST(N'2026-07-12' AS Date), CAST(N'2026-07-15' AS Date), N'P3-20260713-R1')
INSERT [dbo].[Import_Receipt_Item] ([item_id], [receipt_id], [product_id], [quantity], [manufacture_date], [expiry_date], [batch_number]) VALUES (2, 2, 13, 10, CAST(N'2026-07-13' AS Date), CAST(N'2026-07-14' AS Date), N'P13-20260713-R2')
INSERT [dbo].[Import_Receipt_Item] ([item_id], [receipt_id], [product_id], [quantity], [manufacture_date], [expiry_date], [batch_number]) VALUES (3, 2, 12, 10, CAST(N'2026-07-13' AS Date), CAST(N'2026-07-14' AS Date), N'P12-20260713-R2')
INSERT [dbo].[Import_Receipt_Item] ([item_id], [receipt_id], [product_id], [quantity], [manufacture_date], [expiry_date], [batch_number]) VALUES (5, 3, 10, 10, CAST(N'2026-07-13' AS Date), CAST(N'2026-07-14' AS Date), N'P10-20260713-R3')
INSERT [dbo].[Import_Receipt_Item] ([item_id], [receipt_id], [product_id], [quantity], [manufacture_date], [expiry_date], [batch_number]) VALUES (6, 4, 3, 10000, CAST(N'2026-07-12' AS Date), CAST(N'2026-07-23' AS Date), N'P3-20260713-R4')
INSERT [dbo].[Import_Receipt_Item] ([item_id], [receipt_id], [product_id], [quantity], [manufacture_date], [expiry_date], [batch_number]) VALUES (14, 9, 14, 100, CAST(N'2026-07-19' AS Date), CAST(N'2026-07-26' AS Date), N'P14-20260720-B1')
INSERT [dbo].[Import_Receipt_Item] ([item_id], [receipt_id], [product_id], [quantity], [manufacture_date], [expiry_date], [batch_number]) VALUES (15, 9, 15, 120, CAST(N'2026-07-19' AS Date), CAST(N'2026-07-29' AS Date), N'P15-20260720-B1')
INSERT [dbo].[Import_Receipt_Item] ([item_id], [receipt_id], [product_id], [quantity], [manufacture_date], [expiry_date], [batch_number]) VALUES (16, 9, 16, 80, CAST(N'2026-07-19' AS Date), CAST(N'2026-07-24' AS Date), N'P16-20260720-B1')
INSERT [dbo].[Import_Receipt_Item] ([item_id], [receipt_id], [product_id], [quantity], [manufacture_date], [expiry_date], [batch_number]) VALUES (17, 9, 17, 150, CAST(N'2026-07-19' AS Date), CAST(N'2026-07-25' AS Date), N'P17-20260720-B1')
INSERT [dbo].[Import_Receipt_Item] ([item_id], [receipt_id], [product_id], [quantity], [manufacture_date], [expiry_date], [batch_number]) VALUES (18, 9, 18, 50, CAST(N'2026-07-19' AS Date), CAST(N'2026-07-30' AS Date), N'P18-20260720-B1')
INSERT [dbo].[Import_Receipt_Item] ([item_id], [receipt_id], [product_id], [quantity], [manufacture_date], [expiry_date], [batch_number]) VALUES (19, 9, 19, 70, CAST(N'2026-07-19' AS Date), CAST(N'2026-08-05' AS Date), N'P19-20260720-B1')
INSERT [dbo].[Import_Receipt_Item] ([item_id], [receipt_id], [product_id], [quantity], [manufacture_date], [expiry_date], [batch_number]) VALUES (20, 9, 20, 60, CAST(N'2026-07-19' AS Date), CAST(N'2026-07-27' AS Date), N'P20-20260720-B1')
INSERT [dbo].[Import_Receipt_Item] ([item_id], [receipt_id], [product_id], [quantity], [manufacture_date], [expiry_date], [batch_number]) VALUES (21, 9, 21, 110, CAST(N'2026-07-19' AS Date), CAST(N'2026-07-29' AS Date), N'P21-20260720-B1')
INSERT [dbo].[Import_Receipt_Item] ([item_id], [receipt_id], [product_id], [quantity], [manufacture_date], [expiry_date], [batch_number]) VALUES (22, 9, 22, 90, CAST(N'2026-07-19' AS Date), CAST(N'2026-07-24' AS Date), N'P22-20260720-B1')
INSERT [dbo].[Import_Receipt_Item] ([item_id], [receipt_id], [product_id], [quantity], [manufacture_date], [expiry_date], [batch_number]) VALUES (23, 9, 23, 130, CAST(N'2026-07-19' AS Date), CAST(N'2026-08-10' AS Date), N'P23-20260720-B1')
SET IDENTITY_INSERT [dbo].[Import_Receipt_Item] OFF
GO
SET IDENTITY_INSERT [dbo].[Inventory] ON 

INSERT [dbo].[Inventory] ([inventory_id], [product_id], [quantity], [last_updated]) VALUES (1, 1, 95, CAST(N'2026-01-27T23:30:12.487' AS DateTime))
INSERT [dbo].[Inventory] ([inventory_id], [product_id], [quantity], [last_updated]) VALUES (4, 7, 208, CAST(N'2026-06-21T17:06:08.653' AS DateTime))
INSERT [dbo].[Inventory] ([inventory_id], [product_id], [quantity], [last_updated]) VALUES (5, 3, 10000, CAST(N'2026-07-13T23:42:06.590' AS DateTime))
INSERT [dbo].[Inventory] ([inventory_id], [product_id], [quantity], [last_updated]) VALUES (6, 4, 99, CAST(N'2026-06-21T17:09:59.153' AS DateTime))
INSERT [dbo].[Inventory] ([inventory_id], [product_id], [quantity], [last_updated]) VALUES (10, 10, 106, CAST(N'2026-07-13T23:26:35.920' AS DateTime))
INSERT [dbo].[Inventory] ([inventory_id], [product_id], [quantity], [last_updated]) VALUES (11, 11, 89, CAST(N'2026-06-21T21:35:47.437' AS DateTime))
INSERT [dbo].[Inventory] ([inventory_id], [product_id], [quantity], [last_updated]) VALUES (12, 12, 106, CAST(N'2026-07-13T23:11:58.527' AS DateTime))
INSERT [dbo].[Inventory] ([inventory_id], [product_id], [quantity], [last_updated]) VALUES (13, 13, 110, CAST(N'2026-07-13T23:11:58.523' AS DateTime))
INSERT [dbo].[Inventory] ([inventory_id], [product_id], [quantity], [last_updated]) VALUES (14, 14, 100, GETDATE())
INSERT [dbo].[Inventory] ([inventory_id], [product_id], [quantity], [last_updated]) VALUES (15, 15, 120, GETDATE())
INSERT [dbo].[Inventory] ([inventory_id], [product_id], [quantity], [last_updated]) VALUES (16, 16, 80, GETDATE())
INSERT [dbo].[Inventory] ([inventory_id], [product_id], [quantity], [last_updated]) VALUES (17, 17, 150, GETDATE())
INSERT [dbo].[Inventory] ([inventory_id], [product_id], [quantity], [last_updated]) VALUES (18, 18, 50, GETDATE())
INSERT [dbo].[Inventory] ([inventory_id], [product_id], [quantity], [last_updated]) VALUES (19, 19, 70, GETDATE())
INSERT [dbo].[Inventory] ([inventory_id], [product_id], [quantity], [last_updated]) VALUES (20, 20, 60, GETDATE())
INSERT [dbo].[Inventory] ([inventory_id], [product_id], [quantity], [last_updated]) VALUES (21, 21, 110, GETDATE())
INSERT [dbo].[Inventory] ([inventory_id], [product_id], [quantity], [last_updated]) VALUES (22, 22, 90, GETDATE())
INSERT [dbo].[Inventory] ([inventory_id], [product_id], [quantity], [last_updated]) VALUES (23, 23, 130, GETDATE())
SET IDENTITY_INSERT [dbo].[Inventory] OFF
GO
SET IDENTITY_INSERT [dbo].[Inventory_Batch] ON 

INSERT [dbo].[Inventory_Batch] ([batch_id], [product_id], [receipt_item_id], [batch_number], [quantity_in], [quantity_remain], [manufacture_date], [expiry_date], [created_at]) VALUES (1, 3, 1, N'P3-20260713-R1', 100, 0, CAST(N'2026-07-12' AS Date), CAST(N'2026-07-15' AS Date), CAST(N'2026-07-13T22:32:37.113' AS DateTime))
INSERT [dbo].[Inventory_Batch] ([batch_id], [product_id], [receipt_item_id], [batch_number], [quantity_in], [quantity_remain], [manufacture_date], [expiry_date], [created_at]) VALUES (2, 13, 2, N'P13-20260713-R2', 10, 10, CAST(N'2026-07-13' AS Date), CAST(N'2026-07-14' AS Date), CAST(N'2026-07-13T23:11:58.527' AS DateTime))
INSERT [dbo].[Inventory_Batch] ([batch_id], [product_id], [receipt_item_id], [batch_number], [quantity_in], [quantity_remain], [manufacture_date], [expiry_date], [created_at]) VALUES (3, 12, 3, N'P12-20260713-R2', 10, 10, CAST(N'2026-07-13' AS Date), CAST(N'2026-07-14' AS Date), CAST(N'2026-07-13T23:11:58.530' AS DateTime))
INSERT [dbo].[Inventory_Batch] ([batch_id], [product_id], [receipt_item_id], [batch_number], [quantity_in], [quantity_remain], [manufacture_date], [expiry_date], [created_at]) VALUES (5, 10, 5, N'P10-20260713-R3', 10, 10, CAST(N'2026-07-13' AS Date), CAST(N'2026-07-14' AS Date), CAST(N'2026-07-13T23:26:35.920' AS DateTime))
INSERT [dbo].[Inventory_Batch] ([batch_id], [product_id], [receipt_item_id], [batch_number], [quantity_in], [quantity_remain], [manufacture_date], [expiry_date], [created_at]) VALUES (6, 3, 6, N'P3-20260713-R4', 10000, 10000, CAST(N'2026-07-12' AS Date), CAST(N'2026-07-23' AS Date), CAST(N'2026-07-13T23:36:36.660' AS DateTime))
INSERT [dbo].[Inventory_Batch] ([batch_id], [product_id], [receipt_item_id], [batch_number], [quantity_in], [quantity_remain], [manufacture_date], [expiry_date], [created_at]) VALUES (14, 14, 14, N'P14-20260720-B1', 100, 100, CAST(N'2026-07-19' AS Date), CAST(N'2026-07-26' AS Date), GETDATE())
INSERT [dbo].[Inventory_Batch] ([batch_id], [product_id], [receipt_item_id], [batch_number], [quantity_in], [quantity_remain], [manufacture_date], [expiry_date], [created_at]) VALUES (15, 15, 15, N'P15-20260720-B1', 120, 120, CAST(N'2026-07-19' AS Date), CAST(N'2026-07-29' AS Date), GETDATE())
INSERT [dbo].[Inventory_Batch] ([batch_id], [product_id], [receipt_item_id], [batch_number], [quantity_in], [quantity_remain], [manufacture_date], [expiry_date], [created_at]) VALUES (16, 16, 16, N'P16-20260720-B1', 80, 80, CAST(N'2026-07-19' AS Date), CAST(N'2026-07-24' AS Date), GETDATE())
INSERT [dbo].[Inventory_Batch] ([batch_id], [product_id], [receipt_item_id], [batch_number], [quantity_in], [quantity_remain], [manufacture_date], [expiry_date], [created_at]) VALUES (17, 17, 17, N'P17-20260720-B1', 150, 150, CAST(N'2026-07-19' AS Date), CAST(N'2026-07-25' AS Date), GETDATE())
INSERT [dbo].[Inventory_Batch] ([batch_id], [product_id], [receipt_item_id], [batch_number], [quantity_in], [quantity_remain], [manufacture_date], [expiry_date], [created_at]) VALUES (18, 18, 18, N'P18-20260720-B1', 50, 50, CAST(N'2026-07-19' AS Date), CAST(N'2026-07-30' AS Date), GETDATE())
INSERT [dbo].[Inventory_Batch] ([batch_id], [product_id], [receipt_item_id], [batch_number], [quantity_in], [quantity_remain], [manufacture_date], [expiry_date], [created_at]) VALUES (19, 19, 19, N'P19-20260720-B1', 70, 70, CAST(N'2026-07-19' AS Date), CAST(N'2026-08-05' AS Date), GETDATE())
INSERT [dbo].[Inventory_Batch] ([batch_id], [product_id], [receipt_item_id], [batch_number], [quantity_in], [quantity_remain], [manufacture_date], [expiry_date], [created_at]) VALUES (20, 20, 20, N'P20-20260720-B1', 60, 60, CAST(N'2026-07-19' AS Date), CAST(N'2026-07-27' AS Date), GETDATE())
INSERT [dbo].[Inventory_Batch] ([batch_id], [product_id], [receipt_item_id], [batch_number], [quantity_in], [quantity_remain], [manufacture_date], [expiry_date], [created_at]) VALUES (21, 21, 21, N'P21-20260720-B1', 110, 110, CAST(N'2026-07-19' AS Date), CAST(N'2026-07-29' AS Date), GETDATE())
INSERT [dbo].[Inventory_Batch] ([batch_id], [product_id], [receipt_item_id], [batch_number], [quantity_in], [quantity_remain], [manufacture_date], [expiry_date], [created_at]) VALUES (22, 22, 22, N'P22-20260720-B1', 90, 90, CAST(N'2026-07-19' AS Date), CAST(N'2026-07-24' AS Date), GETDATE())
INSERT [dbo].[Inventory_Batch] ([batch_id], [product_id], [receipt_item_id], [batch_number], [quantity_in], [quantity_remain], [manufacture_date], [expiry_date], [created_at]) VALUES (23, 23, 23, N'P23-20260720-B1', 130, 130, CAST(N'2026-07-19' AS Date), CAST(N'2026-08-10' AS Date), GETDATE())
SET IDENTITY_INSERT [dbo].[Inventory_Batch] OFF
GO
SET IDENTITY_INSERT [dbo].[Notifications] ON 

INSERT [dbo].[Notifications] ([notification_id], [user_id], [title], [content], [is_read], [created_at]) VALUES (1, 11, N'Sản phẩm được duyệt', N'Sản phẩm #6 của bạn đã được Admin PHÊ DUYỆT và hiện có thể hiển thị cho khách hàng.', 0, CAST(N'2026-06-21T16:37:24.003' AS DateTime))
INSERT [dbo].[Notifications] ([notification_id], [user_id], [title], [content], [is_read], [created_at]) VALUES (2, 11, N'Sản phẩm được duyệt', N'Sản phẩm #7 của bạn đã được Admin PHÊ DUYỆT và hiện có thể hiển thị cho khách hàng.', 0, CAST(N'2026-06-21T16:52:38.187' AS DateTime))
INSERT [dbo].[Notifications] ([notification_id], [user_id], [title], [content], [is_read], [created_at]) VALUES (3, 11, N'Sản phẩm được duyệt', N'Sản phẩm #7 của bạn đã được Admin PHÊ DUYỆT và hiện có thể hiển thị cho khách hàng.', 0, CAST(N'2026-06-21T17:23:47.523' AS DateTime))
INSERT [dbo].[Notifications] ([notification_id], [user_id], [title], [content], [is_read], [created_at]) VALUES (4, 11, N'Sản phẩm được duyệt', N'Sản phẩm #10 của bạn đã được Admin PHÊ DUYỆT và hiện có thể hiển thị cho khách hàng.', 0, CAST(N'2026-06-21T17:44:48.773' AS DateTime))
INSERT [dbo].[Notifications] ([notification_id], [user_id], [title], [content], [is_read], [created_at]) VALUES (5, 11, N'Sản phẩm được duyệt', N'Sản phẩm #3 của bạn đã được Admin PHÊ DUYỆT và hiện có thể hiển thị cho khách hàng.', 0, CAST(N'2026-06-21T17:44:52.933' AS DateTime))
INSERT [dbo].[Notifications] ([notification_id], [user_id], [title], [content], [is_read], [created_at]) VALUES (6, 11, N'Sản phẩm được duyệt', N'Sản phẩm #13 của bạn đã được Admin PHÊ DUYỆT và hiện có thể hiển thị cho khách hàng.', 0, CAST(N'2026-06-24T14:36:09.483' AS DateTime))
INSERT [dbo].[Notifications] ([notification_id], [user_id], [title], [content], [is_read], [created_at]) VALUES (7, 13, N'Đặt hàng thành công', N'Đơn hàng #10 đã được đặt thành công! Tổng thanh toán: 186,000đ. Cảm ơn bạn đã mua hàng tại GreenStock!', 0, CAST(N'2026-06-27T23:53:45.440' AS DateTime))
INSERT [dbo].[Notifications] ([notification_id], [user_id], [title], [content], [is_read], [created_at]) VALUES (8, 11, N'Đặt hàng thành công', N'Đơn hàng #11 đã được đặt thành công! Tổng thanh toán: 137,700đ. Cảm ơn bạn đã mua hàng tại GreenStock!', 0, CAST(N'2026-06-27T23:59:22.093' AS DateTime))
INSERT [dbo].[Notifications] ([notification_id], [user_id], [title], [content], [is_read], [created_at]) VALUES (9, 13, N'Đặt hàng thành công', N'Đơn hàng #12 đã được đặt thành công! Tổng thanh toán: 73,000đ. Cảm ơn bạn đã mua hàng tại GreenStock!', 0, CAST(N'2026-06-28T00:00:35.323' AS DateTime))
INSERT [dbo].[Notifications] ([notification_id], [user_id], [title], [content], [is_read], [created_at]) VALUES (10, 13, N'Đặt hàng thành công', N'Đơn hàng #13 đã được đặt thành công! Tổng thanh toán: 73,000đ. Cảm ơn bạn đã mua hàng tại GreenStock!', 0, CAST(N'2026-06-28T00:04:16.927' AS DateTime))
INSERT [dbo].[Notifications] ([notification_id], [user_id], [title], [content], [is_read], [created_at]) VALUES (11, 11, N'Đặt hàng thành công', N'Đơn hàng #14 đã được đặt thành công! Tổng thanh toán: 175,000đ. Cảm ơn bạn đã mua hàng tại GreenStock!', 0, CAST(N'2026-06-28T00:14:11.050' AS DateTime))
INSERT [dbo].[Notifications] ([notification_id], [user_id], [title], [content], [is_read], [created_at]) VALUES (12, 13, N'Đặt hàng thành công', N'Đơn hàng #15 đã được đặt thành công! Tổng thanh toán: 88,000đ. Cảm ơn bạn đã mua hàng tại GreenStock!', 0, CAST(N'2026-06-28T00:26:44.310' AS DateTime))
INSERT [dbo].[Notifications] ([notification_id], [user_id], [title], [content], [is_read], [created_at]) VALUES (13, 13, N'Đặt hàng thành công', N'Đơn hàng #16 đã được đặt thành công! Tổng thanh toán: 53,000đ. Cảm ơn bạn đã mua hàng tại GreenStock!', 0, CAST(N'2026-06-28T00:27:29.853' AS DateTime))
INSERT [dbo].[Notifications] ([notification_id], [user_id], [title], [content], [is_read], [created_at]) VALUES (14, 13, N'Đặt hàng thành công', N'Đơn hàng #17 đã được đặt thành công! Tổng thanh toán: 100,000đ. Cảm ơn bạn đã mua hàng tại GreenStock!', 0, CAST(N'2026-06-28T21:10:19.323' AS DateTime))
INSERT [dbo].[Notifications] ([notification_id], [user_id], [title], [content], [is_read], [created_at]) VALUES (15, 13, N'Đặt hàng thành công', N'Đơn hàng #18 đã được đặt thành công! Tổng thanh toán: 165,000đ. Cảm ơn bạn đã mua hàng tại GreenStock!', 0, CAST(N'2026-06-29T16:49:58.637' AS DateTime))
INSERT [dbo].[Notifications] ([notification_id], [user_id], [title], [content], [is_read], [created_at]) VALUES (16, 11, N'Nhập kho thành công', N'Phiếu nhập kho #1 đã được tạo với 1 sản phẩm, tổng 100 đơn vị.', 0, CAST(N'2026-07-13T22:32:37.140' AS DateTime))
INSERT [dbo].[Notifications] ([notification_id], [user_id], [title], [content], [is_read], [created_at]) VALUES (17, 11, N'Nhập kho thành công', N'Phiếu nhập kho #2 đã được tạo với 3 sản phẩm, tổng 30 đơn vị.', 0, CAST(N'2026-07-13T23:11:58.547' AS DateTime))
INSERT [dbo].[Notifications] ([notification_id], [user_id], [title], [content], [is_read], [created_at]) VALUES (18, 11, N'Nhập kho thành công', N'Phiếu nhập kho #3 đã được tạo với 1 sản phẩm, tổng 10 đơn vị.', 0, CAST(N'2026-07-13T23:26:35.937' AS DateTime))
INSERT [dbo].[Notifications] ([notification_id], [user_id], [title], [content], [is_read], [created_at]) VALUES (19, 11, N'Nhập kho thành công', N'Phiếu nhập kho #4 đã được tạo với 1 sản phẩm, tổng 10000 đơn vị.', 0, CAST(N'2026-07-13T23:36:36.677' AS DateTime))
INSERT [dbo].[Notifications] ([notification_id], [user_id], [title], [content], [is_read], [created_at]) VALUES (20, 8, N'Đặt hàng thành công', N'Đơn hàng #19 đã được đặt thành công! Tổng thanh toán: 2,500,000đ. Cảm ơn bạn đã mua hàng tại GreenStock!', 0, CAST(N'2026-07-13T23:42:06.620' AS DateTime))
SET IDENTITY_INSERT [dbo].[Notifications] OFF
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

INSERT [dbo].[Product] ([product_id], [product_name], [category_id], [price], [discount_price], [unit], [origin], [status], [description], [shop_owner_id], [low_stock_threshold]) VALUES (1, N'Táo Đỏ Mỹ', 4, CAST(65000.00 AS Decimal(10, 2)), CAST(60000.00 AS Decimal(10, 2)), N'kg', N'Mỹ', N'Available', N'Táo đỏ Mỹ giòn ngọt, mọng nước, nhiều vitamin.', 11, 10)
INSERT [dbo].[Product] ([product_id], [product_name], [category_id], [price], [discount_price], [unit], [origin], [status], [description], [shop_owner_id], [low_stock_threshold]) VALUES (3, N'Chuối Tiêu Chín', 5, CAST(25000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), N'kg', N'Việt Nam', N'Approved', N'Chuối tiêu chín vàng tự nhiên, ngọt thơm bổ dưỡng.', 11, 10)
INSERT [dbo].[Product] ([product_id], [product_name], [category_id], [price], [discount_price], [unit], [origin], [status], [description], [shop_owner_id], [low_stock_threshold]) VALUES (4, N'Cam Sành', 5, CAST(45000.00 AS Decimal(10, 2)), CAST(40000.00 AS Decimal(10, 2)), N'kg', N'Việt Nam', N'Available', N'Cam sành vỏ mỏng, mọng nước, vị chua ngọt thanh mát.', 14, 10)
INSERT [dbo].[Product] ([product_id], [product_name], [category_id], [price], [discount_price], [unit], [origin], [status], [description], [shop_owner_id], [low_stock_threshold]) VALUES (7, N'Cam Cao Phong', 5, CAST(130000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), N'kg', N'Hòa Bình', N'Approved', N'Cam Cao Phong đặc sản vỏ mỏng, mọng nước, ngọt thanh.', 11, 10)
INSERT [dbo].[Product] ([product_id], [product_name], [category_id], [price], [discount_price], [unit], [origin], [status], [description], [shop_owner_id], [low_stock_threshold]) VALUES (10, N'Chuối Laba Đà Lạt', 5, CAST(45000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), N'kg', N'Đà Lạt', N'Approved', N'Chuối Laba Đà Lạt dẻo ngọt, thơm ngon đặc trưng.', 11, 10)
INSERT [dbo].[Product] ([product_id], [product_name], [category_id], [price], [discount_price], [unit], [origin], [status], [description], [shop_owner_id], [low_stock_threshold]) VALUES (11, N'Đào Mỹ Nhập Khẩu', 4, CAST(240000.00 AS Decimal(10, 2)), CAST(220000.00 AS Decimal(10, 2)), N'kg', N'Mỹ', N'Available', N'Đào Mỹ nhập khẩu quả to tròn, ngọt lịm, hương thơm dịu.', 11, 10)
INSERT [dbo].[Product] ([product_id], [product_name], [category_id], [price], [discount_price], [unit], [origin], [status], [description], [shop_owner_id], [low_stock_threshold]) VALUES (12, N'Táo Fuji Nhật Bản', 4, CAST(85000.00 AS Decimal(10, 2)), CAST(75000.00 AS Decimal(10, 2)), N'kg', N'Nhật Bản', N'Approved', N'Táo Fuji Nhật Bản nhập khẩu giòn ngọt đậm đà.', 11, 10)
INSERT [dbo].[Product] ([product_id], [product_name], [category_id], [price], [discount_price], [unit], [origin], [status], [description], [shop_owner_id], [low_stock_threshold]) VALUES (13, N'Đào Mỹ Đóng Hộp', 4, CAST(150000.00 AS Decimal(10, 2)), CAST(135000.00 AS Decimal(10, 2)), N'Hộp', N'Mỹ', N'Approved', N'Đào Mỹ ngâm đường đóng hộp thơm ngon, giòn ngọt mát.', 11, 10)
INSERT [dbo].[Product] ([product_id], [product_name], [category_id], [price], [discount_price], [unit], [origin], [status], [description], [shop_owner_id], [low_stock_threshold]) VALUES (14, N'Xoài Cát Hòa Lộc', 5, CAST(75000.00 AS Decimal(10, 2)), CAST(70000.00 AS Decimal(10, 2)), N'kg', N'Tiền Giang', N'Available', N'Xoài cát Hòa Lộc chín tự nhiên, quả to, vị ngọt lịm thơm ngon hảo hạng.', 11, 10)
INSERT [dbo].[Product] ([product_id], [product_name], [category_id], [price], [discount_price], [unit], [origin], [status], [description], [shop_owner_id], [low_stock_threshold]) VALUES (15, N'Dưa Hấu Không Hạt', 5, CAST(22000.00 AS Decimal(10, 2)), CAST(18000.00 AS Decimal(10, 2)), N'kg', N'Long An', N'Available', N'Dưa hấu không hạt ruột đỏ ngọt mát, vỏ mỏng, mọng nước giải nhiệt cực tốt.', 11, 10)
INSERT [dbo].[Product] ([product_id], [product_name], [category_id], [price], [discount_price], [unit], [origin], [status], [description], [shop_owner_id], [low_stock_threshold]) VALUES (16, N'Măng Cụt Chín', 6, CAST(95000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), N'kg', N'Bến Tre', N'Available', N'Măng cụt Bến Tre vỏ mỏng, múi trắng muốt, chua ngọt hài hòa rất ngon.', 14, 10)
INSERT [dbo].[Product] ([product_id], [product_name], [category_id], [price], [discount_price], [unit], [origin], [status], [description], [shop_owner_id], [low_stock_threshold]) VALUES (17, N'Vải Thiều Lục Ngạn', 6, CAST(60000.00 AS Decimal(10, 2)), CAST(50000.00 AS Decimal(10, 2)), N'kg', N'Bắc Giang', N'Available', N'Vải thiều Lục Ngạn hạt nhỏ cùi dày, mọng nước, ngọt lịm đặc trưng.', 14, 10)
INSERT [dbo].[Product] ([product_id], [product_name], [category_id], [price], [discount_price], [unit], [origin], [status], [description], [shop_owner_id], [low_stock_threshold]) VALUES (18, N'Nho Mẫu Đơn Shine Muscat', 4, CAST(650000.00 AS Decimal(10, 2)), CAST(580000.00 AS Decimal(10, 2)), N'kg', N'Hàn Quốc', N'Available', N'Nho mẫu đơn Shine Muscat Hàn Quốc trái to tròn, giòn ngọt, thơm mùi sữa đặc biệt.', 14, 10)
INSERT [dbo].[Product] ([product_id], [product_name], [category_id], [price], [discount_price], [unit], [origin], [status], [description], [shop_owner_id], [low_stock_threshold]) VALUES (19, N'Kiwi Vàng New Zealand', 4, CAST(180000.00 AS Decimal(10, 2)), CAST(160000.00 AS Decimal(10, 2)), N'kg', N'New Zealand', N'Available', N'Kiwi vàng nhập khẩu tươi ngon, cùi vàng ươm, vị ngọt thanh giàu vitamin C.', 15, 10)
INSERT [dbo].[Product] ([product_id], [product_name], [category_id], [price], [discount_price], [unit], [origin], [status], [description], [shop_owner_id], [low_stock_threshold]) VALUES (20, N'Sầu Riêng Ri6', 3, CAST(150000.00 AS Decimal(10, 2)), CAST(135000.00 AS Decimal(10, 2)), N'kg', N'Vĩnh Long', N'Approved', N'Sầu riêng Ri6 cơm vàng hạt lép, thơm nức mũi, vị béo ngậy ngọt đậm.', 15, 10)
INSERT [dbo].[Product] ([product_id], [product_name], [category_id], [price], [discount_price], [unit], [origin], [status], [description], [shop_owner_id], [low_stock_threshold]) VALUES (21, N'Bơ Sáp Lâm Đồng', 3, CAST(45000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), N'kg', N'Lâm Đồng', N'Approved', N'Bơ sáp Lâm Đồng quả thon dài, hạt nhỏ, cơm bơ vàng dẻo béo ngậy tự nhiên.', 15, 10)
INSERT [dbo].[Product] ([product_id], [product_name], [category_id], [price], [discount_price], [unit], [origin], [status], [description], [shop_owner_id], [low_stock_threshold]) VALUES (22, N'Dâu Tây Đà Lạt', 5, CAST(250000.00 AS Decimal(10, 2)), CAST(220000.00 AS Decimal(10, 2)), N'kg', N'Đà Lạt', N'Available', N'Dâu tây Đà Lạt trái đỏ chín mọng, thơm tự nhiên, vị chua ngọt thanh mát.', 16, 10)
INSERT [dbo].[Product] ([product_id], [product_name], [category_id], [price], [discount_price], [unit], [origin], [status], [description], [shop_owner_id], [low_stock_threshold]) VALUES (23, N'Bưởi Da Xanh Bến Tre', 5, CAST(80000.00 AS Decimal(10, 2)), CAST(72000.00 AS Decimal(10, 2)), N'kg', N'Bến Tre', N'Available', N'Bưởi da xanh đặc sản Bến Tre tép hồng căng mọng, ngọt thanh dễ bóc vỏ.', 16, 10)
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
UPDATE Product SET import_date = '2026-07-15', import_price = 45000.00 WHERE product_id = 1;
UPDATE Product SET import_date = '2026-07-13', import_price = 15000.00 WHERE product_id = 3;
UPDATE Product SET import_date = '2026-07-18', import_price = 30000.00 WHERE product_id = 4;
UPDATE Product SET import_date = '2026-07-16', import_price = 90000.00 WHERE product_id = 7;
UPDATE Product SET import_date = '2026-07-13', import_price = 30000.00 WHERE product_id = 10;
UPDATE Product SET import_date = '2026-07-22', import_price = 170000.00 WHERE product_id = 11;
UPDATE Product SET import_date = '2026-07-13', import_price = 55000.00 WHERE product_id = 12;
UPDATE Product SET import_date = '2026-07-13', import_price = 100000.00 WHERE product_id = 13;
UPDATE Product SET import_date = '2026-07-20', import_price = 50000.00 WHERE product_id = 14;
UPDATE Product SET import_date = '2026-07-20', import_price = 12000.00 WHERE product_id = 15;
UPDATE Product SET import_date = '2026-07-20', import_price = 65000.00 WHERE product_id = 16;
UPDATE Product SET import_date = '2026-07-20', import_price = 40000.00 WHERE product_id = 17;
UPDATE Product SET import_date = '2026-07-20', import_price = 450000.00 WHERE product_id = 18;
UPDATE Product SET import_date = '2026-07-20', import_price = 120000.00 WHERE product_id = 19;
UPDATE Product SET import_date = '2026-07-20', import_price = 100000.00 WHERE product_id = 20;
UPDATE Product SET import_date = '2026-07-20', import_price = 30000.00 WHERE product_id = 21;
UPDATE Product SET import_date = '2026-07-20', import_price = 170000.00 WHERE product_id = 22;
UPDATE Product SET import_date = '2026-07-20', import_price = 55000.00 WHERE product_id = 23;
UPDATE Product SET import_date = '2026-07-25' WHERE import_date IS NULL;
GO
SET IDENTITY_INSERT [dbo].[Product_Category] ON 

INSERT [dbo].[Product_Category] ([category_id], [category_name]) VALUES (3, N'Trái Cây Mới')
INSERT [dbo].[Product_Category] ([category_id], [category_name]) VALUES (4, N'Trái Cây Nhập Khẩu')
INSERT [dbo].[Product_Category] ([category_id], [category_name]) VALUES (5, N'Trái Cây Nội Địa')
INSERT [dbo].[Product_Category] ([category_id], [category_name]) VALUES (6, N'Trái Cây Trái Mùa')
SET IDENTITY_INSERT [dbo].[Product_Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Product_Image] ON 

INSERT [dbo].[Product_Image] ([image_id], [product_id], [image_url], [created_at]) VALUES (1, 1, N'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?auto=format&fit=crop&q=80&w=600', CAST(N'2026-01-27T23:30:12.480' AS DateTime))
INSERT [dbo].[Product_Image] ([image_id], [product_id], [image_url], [created_at]) VALUES (3, 3, N'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?auto=format&fit=crop&q=80&w=600', CAST(N'2026-06-21T17:44:08.747' AS DateTime))
INSERT [dbo].[Product_Image] ([image_id], [product_id], [image_url], [created_at]) VALUES (4, 4, N'https://images.unsplash.com/photo-1582979512210-99b6a53386f9?auto=format&fit=crop&q=80&w=600', CAST(N'2026-06-17T20:53:15.297' AS DateTime))
INSERT [dbo].[Product_Image] ([image_id], [product_id], [image_url], [created_at]) VALUES (7, 7, N'https://images.unsplash.com/photo-1547514701-42782101795e?auto=format&fit=crop&q=80&w=600', CAST(N'2026-06-21T17:23:27.763' AS DateTime))
INSERT [dbo].[Product_Image] ([image_id], [product_id], [image_url], [created_at]) VALUES (10, 10, N'https://images.unsplash.com/photo-1603833665858-e61d17a86224?auto=format&fit=crop&q=80&w=600', CAST(N'2026-06-21T17:24:13.567' AS DateTime))
INSERT [dbo].[Product_Image] ([image_id], [product_id], [image_url], [created_at]) VALUES (11, 11, N'https://images.unsplash.com/photo-1595124253349-0d3674299004?auto=format&fit=crop&q=80&w=600', CAST(N'2026-06-21T21:35:47.437' AS DateTime))
INSERT [dbo].[Product_Image] ([image_id], [product_id], [image_url], [created_at]) VALUES (12, 12, N'https://images.unsplash.com/photo-1570913149827-d2ac223ed3e8?auto=format&fit=crop&q=80&w=600', CAST(N'2026-06-23T13:34:36.860' AS DateTime))
INSERT [dbo].[Product_Image] ([image_id], [product_id], [image_url], [created_at]) VALUES (13, 13, N'https://images.unsplash.com/photo-1601004890684-d8cbf643f5f2?auto=format&fit=crop&q=80&w=600', CAST(N'2026-06-24T14:35:34.813' AS DateTime))
INSERT [dbo].[Product_Image] ([image_id], [product_id], [image_url], [created_at]) VALUES (14, 14, N'https://images.unsplash.com/photo-1553279768-865429fa0078?auto=format&fit=crop&q=80&w=600', GETDATE())
INSERT [dbo].[Product_Image] ([image_id], [product_id], [image_url], [created_at]) VALUES (15, 15, N'https://images.unsplash.com/photo-1587049352846-4a222e784d38?auto=format&fit=crop&q=80&w=600', GETDATE())
INSERT [dbo].[Product_Image] ([image_id], [product_id], [image_url], [created_at]) VALUES (16, 16, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGqTqqOuAuBV0zEepHPFbnTvGLolJMVbDzaLCD2tXZFg&s=10', GETDATE())
INSERT [dbo].[Product_Image] ([image_id], [product_id], [image_url], [created_at]) VALUES (17, 17, N'https://images.unsplash.com/photo-1597975371270-cf80e4f54921?auto=format&fit=crop&q=80&w=600', GETDATE())
INSERT [dbo].[Product_Image] ([image_id], [product_id], [image_url], [created_at]) VALUES (18, 18, N'https://images.unsplash.com/photo-1537084642907-629340c7e09e?auto=format&fit=crop&q=80&w=600', GETDATE())
INSERT [dbo].[Product_Image] ([image_id], [product_id], [image_url], [created_at]) VALUES (19, 19, N'https://images.unsplash.com/photo-1585059895524-72359e06133a?auto=format&fit=crop&q=80&w=600', GETDATE())
INSERT [dbo].[Product_Image] ([image_id], [product_id], [image_url], [created_at]) VALUES (20, 20, N'https://images.unsplash.com/photo-1627931326466-2ad0cb2e2609?auto=format&fit=crop&q=80&w=600', GETDATE())
INSERT [dbo].[Product_Image] ([image_id], [product_id], [image_url], [created_at]) VALUES (21, 21, N'https://images.unsplash.com/photo-1523049673857-eb18f1d7b578?auto=format&fit=crop&q=80&w=600', GETDATE())
INSERT [dbo].[Product_Image] ([image_id], [product_id], [image_url], [created_at]) VALUES (22, 22, N'https://images.unsplash.com/photo-1464965911861-746a04b4bca6?auto=format&fit=crop&q=80&w=600', GETDATE())
INSERT [dbo].[Product_Image] ([image_id], [product_id], [image_url], [created_at]) VALUES (23, 23, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7KvlaWqsgIqIAwcjCFmCKAfjo4kZg6DGLlU5YxSr9BQ&s=10', GETDATE())
SET IDENTITY_INSERT [dbo].[Product_Image] OFF
GO
SET IDENTITY_INSERT [dbo].[Product_Weight_Variant] ON

INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (1, 1, N'500g', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (2, 1, N'1kg', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (3, 1, N'2kg', CAST(-5000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (6, 3, N'1kg', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (7, 3, N'2kg', CAST(-3000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (8, 4, N'1kg', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (9, 4, N'2kg', CAST(-4000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (10, 4, N'5kg', CAST(-15000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (13, 7, N'1kg', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (14, 7, N'2kg', CAST(-10000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (15, 7, N'5kg', CAST(-3000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (16, 10, N'1kg', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (17, 10, N'2kg', CAST(-5000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (18, 11, N'500g', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (19, 11, N'1kg', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (20, 11, N'2kg', CAST(-20000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (21, 12, N'500g', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (22, 12, N'1kg', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (23, 12, N'2kg', CAST(-10000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (24, 13, N'1 Hộp (425g)', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (25, 13, N'1 Hộp lớn (825g)', CAST(50000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (26, 14, N'500g', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (27, 14, N'1kg', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (28, 14, N'2kg', CAST(-5000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (29, 15, N'1kg', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (30, 15, N'2kg', CAST(-3000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (31, 15, N'5kg', CAST(-10000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (32, 16, N'500g', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (33, 16, N'1kg', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (34, 17, N'1kg', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (35, 17, N'2kg', CAST(-5000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (36, 18, N'500g', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (37, 18, N'1kg', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (38, 18, N'2kg', CAST(-20000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (39, 19, N'500g', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (40, 19, N'1kg', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (41, 20, N'1kg', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (42, 20, N'2kg', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (43, 20, N'5kg', CAST(-20000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (44, 21, N'1kg', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (45, 21, N'2kg', CAST(-5000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (46, 22, N'500g', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (47, 22, N'1kg', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (48, 23, N'1kg', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Weight_Variant] ([variant_id], [product_id], [weight_label], [price_adjustment]) VALUES (49, 23, N'2kg', CAST(-5000.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[Product_Weight_Variant] OFF
GO
SET IDENTITY_INSERT [dbo].[Product_Packaging] ON

INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (1, 1, N'Túi giấy thân thiện môi trường', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (2, 1, N'Hộp nhựa PET tiện lợi', CAST(5000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (3, 1, N'Giỏ quà sang trọng', CAST(35000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (5, 3, N'Túi giấy thân thiện môi trường', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (6, 3, N'Hộp giấy Carton bảo vệ', CAST(4000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (7, 4, N'Túi lưới tiện lợi', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (8, 4, N'Hộp giấy Carton bảo vệ', CAST(5000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (11, 7, N'Túi lưới tiện lợi', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (12, 7, N'Hộp giấy Carton bảo vệ', CAST(5000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (13, 7, N'Hộp quà tặng cao cấp', CAST(20000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (14, 10, N'Túi giấy thân thiện môi trường', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (15, 10, N'Hộp giấy Carton bảo vệ', CAST(5000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (16, 11, N'Túi giấy thân thiện môi trường', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (17, 11, N'Hộp nhựa PET tiện lợi', CAST(5000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (18, 11, N'Giỏ quà sang trọng', CAST(35000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (19, 12, N'Túi giấy thân thiện môi trường', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (20, 12, N'Hộp nhựa PET tiện lợi', CAST(5000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (21, 12, N'Giỏ quà sang trọng', CAST(35000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (22, 13, N'Đóng gói mặc định', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (23, 13, N'Hộp quà tặng', CAST(10000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (24, 14, N'Túi giấy thân thiện môi trường', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (25, 14, N'Hộp nhựa PET tiện lợi', CAST(5000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (26, 15, N'Mặc định', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (27, 16, N'Túi giấy thân thiện môi trường', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (28, 17, N'Túi giấy thân thiện môi trường', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (29, 17, N'Hộp giấy Carton bảo vệ', CAST(4000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (30, 18, N'Túi giấy thân thiện môi trường', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (31, 18, N'Hộp nhựa PET tiện lợi', CAST(5000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (32, 18, N'Giỏ quà sang trọng', CAST(35000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (33, 19, N'Túi giấy thân thiện môi trường', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (34, 19, N'Hộp nhựa PET tiện lợi', CAST(5000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (35, 20, N'Túi lưới tiện lợi', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (36, 20, N'Hộp giấy Carton bảo vệ', CAST(5000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (37, 21, N'Túi giấy thân thiện môi trường', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (38, 22, N'Túi giấy thân thiện môi trường', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (39, 22, N'Hộp nhựa PET tiện lợi', CAST(5000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (40, 22, N'Giỏ quà sang trọng', CAST(35000.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (41, 23, N'Túi lưới tiện lợi', CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Product_Packaging] ([packaging_id], [product_id], [packaging_name], [price_adjustment]) VALUES (42, 23, N'Hộp giấy Carton bảo vệ', CAST(5000.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[Product_Packaging] OFF
GO

SET IDENTITY_INSERT [dbo].[Promotions] ON 

INSERT [dbo].[Promotions] ([promo_id], [promo_code], [discount_value], [discount_type], [start_date], [end_date], [min_order_value]) VALUES (1, N'FRUIT10', CAST(10.00 AS Decimal(10, 2)), N'Percentage', CAST(N'2026-01-01T00:00:00.000' AS DateTime), CAST(N'2026-12-31T00:00:00.000' AS DateTime), CAST(100000.00 AS Decimal(10, 2)))
INSERT [dbo].[Promotions] ([promo_id], [promo_code], [discount_value], [discount_type], [start_date], [end_date], [min_order_value]) VALUES (2, N'FREESHIP', CAST(25000.00 AS Decimal(10, 2)), N'Fixed', CAST(N'2026-01-01T00:00:00.000' AS DateTime), CAST(N'2026-12-31T00:00:00.000' AS DateTime), CAST(150000.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[Promotions] OFF
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
SET IDENTITY_INSERT [dbo].[Sale_Order] ON 

INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [shipper_note], [discount_amount], [promo_code], [shipping_fee], [total_payment]) VALUES (1, CAST(N'2026-06-21T16:39:02.383' AS DateTime), 8, N'Cancelled', N'Bank Transfer', N'Pending', N'Nhà riêng: Trần Hữu Vinh (0999999999) - 123 Nguyễn Văn Cừ, Quận 5, TP. HCM', N'0999999999', NULL, NULL, NULL, N'ok', CAST(0.00 AS Decimal(10, 2)), NULL, CAST(30000.00 AS Decimal(10, 2)), CAST(55000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [shipper_note], [discount_amount], [promo_code], [shipping_fee], [total_payment]) VALUES (2, CAST(N'2026-06-21T17:15:40.577' AS DateTime), 8, N'Delivered', N'COD', N'Pending', N'Nhà riêng: Trần Hữu Vinh (0999999999) - 123 Nguyễn Văn Cừ, Quận 5, TP. HCM', N'0999999999', NULL, NULL, CAST(N'2026-06-21T17:15:40.577' AS DateTime), N'', CAST(0.00 AS Decimal(10, 2)), NULL, CAST(0.00 AS Decimal(10, 2)), CAST(2750000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [shipper_note], [discount_amount], [promo_code], [shipping_fee], [total_payment]) VALUES (3, CAST(N'2026-06-21T21:33:54.090' AS DateTime), 13, N'Delivered', N'COD', N'Pending', N'Công ty: Nguyễn Đại Kỳ (0976927564) - Đại Đồng - Đại Mạch  - Đông Anh - Hà Nội', N'0976927564', NULL, NULL, CAST(N'2026-06-21T21:33:54.090' AS DateTime), N'', CAST(0.00 AS Decimal(10, 2)), NULL, CAST(0.00 AS Decimal(10, 2)), CAST(485000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [shipper_note], [discount_amount], [promo_code], [shipping_fee], [total_payment]) VALUES (4, CAST(N'2026-06-23T12:00:43.487' AS DateTime), 13, N'Pending', N'COD', N'Pending', N'Công ty: Nguyễn Đại Kỳ (0976927564) - Đại Đồng - Đại Mạch  - Đông Anh - Hà Nội', N'0976927564', NULL, NULL, NULL, N'', CAST(0.00 AS Decimal(10, 2)), NULL, CAST(0.00 AS Decimal(10, 2)), CAST(24325000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [shipper_note], [discount_amount], [promo_code], [shipping_fee], [total_payment]) VALUES (5, CAST(N'2026-06-23T13:33:25.903' AS DateTime), 13, N'Delivered', N'COD', N'Pending', N'Công ty: Nguyễn Đại Kỳ (0976927564) - Đại Đồng - Đại Mạch  - Đông Anh - Hà Nội', N'0976927564', NULL, NULL, CAST(N'2026-06-23T13:33:25.903' AS DateTime), N'', CAST(0.00 AS Decimal(10, 2)), NULL, CAST(0.00 AS Decimal(10, 2)), CAST(24445000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [shipper_note], [discount_amount], [promo_code], [shipping_fee], [total_payment]) VALUES (6, CAST(N'2026-06-23T13:36:50.127' AS DateTime), 13, N'Pending', N'COD', N'Pending', N'Công ty: Nguyễn Đại Kỳ (0976927564) - Đại Đồng - Đại Mạch  - Đông Anh - Hà Nội', N'0976927564', NULL, NULL, NULL, N'', CAST(0.00 AS Decimal(10, 2)), NULL, CAST(30000.00 AS Decimal(10, 2)), CAST(30000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [shipper_note], [discount_amount], [promo_code], [shipping_fee], [total_payment]) VALUES (7, CAST(N'2026-06-23T13:50:24.887' AS DateTime), 13, N'Pending', N'COD', N'Pending', N'Công ty: Nguyễn Đại Kỳ (0976927564) - Đại Đồng - Đại Mạch  - Đông Anh - Hà Nội', N'0976927564', NULL, NULL, NULL, N'', CAST(0.00 AS Decimal(10, 2)), NULL, CAST(0.00 AS Decimal(10, 2)), CAST(24325000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [shipper_note], [discount_amount], [promo_code], [shipping_fee], [total_payment]) VALUES (8, CAST(N'2026-06-23T13:50:40.607' AS DateTime), 13, N'Pending', N'COD', N'Pending', N'Công ty: Nguyễn Đại Kỳ (0976927564) - Đại Đồng - Đại Mạch  - Đông Anh - Hà Nội', N'0976927564', NULL, NULL, NULL, N'', CAST(0.00 AS Decimal(10, 2)), NULL, CAST(30000.00 AS Decimal(10, 2)), CAST(30000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [shipper_note], [discount_amount], [promo_code], [shipping_fee], [total_payment]) VALUES (9, CAST(N'2026-06-24T20:30:30.670' AS DateTime), 13, N'Delivered', N'COD', N'Pending', N'íaduuuuuaiudui%đâs: dă21eqdwda33@ (01321298933) - 123123asfw3fr23fds', N'01321298933', NULL, NULL, CAST(N'2026-06-24T20:30:30.670' AS DateTime), N'', CAST(0.00 AS Decimal(10, 2)), NULL, CAST(0.00 AS Decimal(10, 2)), CAST(24455000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [shipper_note], [discount_amount], [promo_code], [shipping_fee], [total_payment]) VALUES (10, CAST(N'2026-06-27T23:53:45.397' AS DateTime), 13, N'Delivered', N'COD', N'Pending', N'Công ty: Nguyễn Đại Kỳ (0976927564) - Đại Đồng - Đại Mạch  - Đông Anh - Hà Nội', N'0976927564', NULL, NULL, CAST(N'2026-06-27T23:53:45.397' AS DateTime), N'', CAST(0.00 AS Decimal(10, 2)), NULL, CAST(0.00 AS Decimal(10, 2)), CAST(186000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [shipper_note], [discount_amount], [promo_code], [shipping_fee], [total_payment]) VALUES (11, CAST(N'2026-06-27T23:59:22.060' AS DateTime), 11, N'Pending', N'COD', N'Pending', N'Công ty: Trần Hữu Vinh (0976926742) - Đại Đồng - Đại Mạch  - Đông Anh - Hà Nội', N'0976926742', NULL, NULL, NULL, N'', CAST(15300.00 AS Decimal(10, 2)), N'FRUIT10', CAST(0.00 AS Decimal(10, 2)), CAST(137700.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [shipper_note], [discount_amount], [promo_code], [shipping_fee], [total_payment]) VALUES (12, CAST(N'2026-06-28T00:00:35.297' AS DateTime), 13, N'Pending', N'COD', N'Pending', N'íaduuuuuaiudui%đâs: dă21eqdwda33@ (01321298933) - 123123asfw3fr23fds', N'01321298933', NULL, NULL, NULL, N'', CAST(0.00 AS Decimal(10, 2)), NULL, CAST(30000.00 AS Decimal(10, 2)), CAST(73000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [shipper_note], [discount_amount], [promo_code], [shipping_fee], [total_payment]) VALUES (13, CAST(N'2026-06-28T00:04:16.900' AS DateTime), 13, N'Delivered', N'COD', N'Pending', N'íaduuuuuaiudui%đâs: dă21eqdwda33@ (01321298933) - 123123asfw3fr23fds', N'01321298933', NULL, CAST(N'2026-06-28T00:05:14.810' AS DateTime), CAST(N'2026-06-28T00:05:25.830' AS DateTime), N'', CAST(0.00 AS Decimal(10, 2)), NULL, CAST(30000.00 AS Decimal(10, 2)), CAST(73000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [shipper_note], [discount_amount], [promo_code], [shipping_fee], [total_payment]) VALUES (14, CAST(N'2026-06-28T00:14:11.017' AS DateTime), 11, N'Delivered', N'COD', N'Pending', N'Công ty: Trần Hữu Vinh (0976926742) - Đại Đồng - Đại Mạch  - Đông Anh - Hà Nội', N'0976926742', NULL, CAST(N'2026-06-28T00:14:30.087' AS DateTime), CAST(N'2026-06-28T00:14:34.073' AS DateTime), N'', CAST(0.00 AS Decimal(10, 2)), NULL, CAST(0.00 AS Decimal(10, 2)), CAST(175000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [shipper_note], [discount_amount], [promo_code], [shipping_fee], [total_payment]) VALUES (15, CAST(N'2026-06-28T00:26:44.287' AS DateTime), 13, N'Delivered', N'COD', N'Pending', N'íaduuuuuaiudui%đâs: dă21eqdwda33@ (01321298933) - 123123asfw3fr23fds', N'01321298933', NULL, CAST(N'2026-06-28T00:32:47.963' AS DateTime), CAST(N'2026-06-28T00:32:51.880' AS DateTime), N'', CAST(0.00 AS Decimal(10, 2)), NULL, CAST(30000.00 AS Decimal(10, 2)), CAST(88000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [shipper_note], [discount_amount], [promo_code], [shipping_fee], [total_payment]) VALUES (16, CAST(N'2026-06-18T00:27:29.837' AS DateTime), 13, N'Delivered', N'COD', N'Pending', N'íaduuuuuaiudui%đâs: dă21eqdwda33@ (01321298933) - 123123asfw3fr23fds', N'01321298933', NULL, CAST(N'2026-06-28T00:28:17.927' AS DateTime), CAST(N'2026-06-28T00:28:21.643' AS DateTime), N'', CAST(0.00 AS Decimal(10, 2)), NULL, CAST(30000.00 AS Decimal(10, 2)), CAST(53000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [shipper_note], [discount_amount], [promo_code], [shipping_fee], [total_payment]) VALUES (17, CAST(N'2026-06-28T21:10:19.280' AS DateTime), 13, N'Delivered', N'COD', N'Pending', N'íaduuuuuaiudui%đâs: dă21eqdwda33@ (01321298933) - 123123asfw3fr23fds', N'01321298933', NULL, CAST(N'2026-06-28T21:10:49.230' AS DateTime), CAST(N'2026-06-28T21:10:53.800' AS DateTime), N'', CAST(0.00 AS Decimal(10, 2)), NULL, CAST(30000.00 AS Decimal(10, 2)), CAST(100000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [shipper_note], [discount_amount], [promo_code], [shipping_fee], [total_payment]) VALUES (18, CAST(N'2026-06-29T16:49:58.590' AS DateTime), 13, N'Delivered', N'COD', N'Pending', N'Công ty: Nguyễn Đại Kỳ (0976927564) - Đại Đồng - Đại Mạch  - Đông Anh - Hà Nội', N'0976927564', NULL, CAST(N'2026-06-29T16:50:22.833' AS DateTime), CAST(N'2026-06-29T16:50:24.907' AS DateTime), N'', CAST(0.00 AS Decimal(10, 2)), NULL, CAST(30000.00 AS Decimal(10, 2)), CAST(165000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [shipper_note], [discount_amount], [promo_code], [shipping_fee], [total_payment]) VALUES (19, CAST(N'2026-07-13T23:42:06.573' AS DateTime), 8, N'Delivered', N'COD', N'Pending', N'Nhà riêng: Trần Hữu Vinh (0999999999) - 123 Nguyễn Văn Cừ, Quận 5, TP. HCM', N'0999999999', NULL, CAST(N'2026-07-13T23:42:34.727' AS DateTime), CAST(N'2026-07-13T23:42:36.890' AS DateTime), N'', CAST(0.00 AS Decimal(10, 2)), NULL, CAST(0.00 AS Decimal(10, 2)), CAST(2500000.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[Sale_Order] OFF
GO
SET IDENTITY_INSERT [dbo].[Sale_Order_Item] ON 

INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (1, 1, 3, 1, CAST(25000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (2, 2, 3, 110, CAST(25000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (3, 3, 10, 1, CAST(120000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (4, 3, 1, 4, CAST(65000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (6, 4, 11, 1, CAST(24325000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (7, 5, 10, 1, CAST(120000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (8, 5, 11, 1, CAST(24325000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (9, 6, 12, 1, CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (10, 7, 11, 1, CAST(24325000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (11, 8, 12, 1, CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (12, 9, 11, 1, CAST(24325000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (13, 9, 12, 1, CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (14, 9, 7, 1, CAST(130000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (15, 10, 10, 1, CAST(120000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (16, 10, 13, 1, CAST(20000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (17, 10, 11, 2, CAST(23000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (18, 11, 7, 1, CAST(130000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (19, 11, 11, 1, CAST(23000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (20, 12, 11, 1, CAST(23000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (21, 12, 13, 1, CAST(20000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (22, 13, 11, 1, CAST(23000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (23, 13, 13, 1, CAST(20000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (25, 14, 10, 1, CAST(120000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (26, 14, 13, 1, CAST(20000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (28, 15, 11, 1, CAST(23000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (29, 16, 12, 1, CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (30, 16, 11, 1, CAST(23000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (32, 18, 4, 1, CAST(40000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (33, 18, 1, 1, CAST(60000.00 AS Decimal(10, 2)))
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (35, 19, 3, 100, CAST(25000.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[Sale_Order_Item] OFF
GO
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (8, 1)
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (9, 3)
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (11, 4)
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (12, 3)
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (13, 1)
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (14, 4)
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (15, 4)
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (16, 4)
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (17, 5)
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (18, 1)
GO
SET IDENTITY_INSERT [dbo].[UserInfo] ON 

INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [avatar], [gender], [dob], [address]) VALUES (8, 8, N'trần hữu vinh', N'0999999999', N'thoike2304@gmail.com', NULL, NULL, NULL, NULL)
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [avatar], [gender], [dob], [address]) VALUES (9, 9, N'trần hữu vinh', N'0999999999', N'vinhthhe176773@fpt.edu.vn', NULL, NULL, NULL, NULL)
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [avatar], [gender], [dob], [address]) VALUES (10, 11, N'trần hữu vinh', N'0999999999', N'vinhthhe@fpt.edu.vn', NULL, NULL, NULL, NULL)
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [avatar], [gender], [dob], [address]) VALUES (11, 12, N'Nguyễn Đại Kỳ', N'0975123455', N'nguyendaiky9d@gmail.com', NULL, NULL, NULL, NULL)
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [avatar], [gender], [dob], [address]) VALUES (12, 13, N'Nguyen Dai Ky', N'0975123455', N'kyndhe172542@fpt.edu.vn', N'', N'Nam', NULL, N'')
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [avatar], [gender], [dob], [address]) VALUES (13, 14, N'Nguyễn Văn B', N'0988888888', N'shopowner2@greenstock.vn', NULL, NULL, NULL, NULL)
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [avatar], [gender], [dob], [address]) VALUES (14, 15, N'Trần Thị C', N'0977777777', N'shopowner3@greenstock.vn', NULL, NULL, NULL, NULL)
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [avatar], [gender], [dob], [address]) VALUES (15, 16, N'Nguyễn Đại Kỳ', N'0975123455', N'nguyendaiky2003@gmail.com', NULL, NULL, NULL, NULL)
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [avatar], [gender], [dob], [address]) VALUES (16, 17, N'Shipper Mặc Định', N'0987654321', N'shipper@greenstock.vn', NULL, NULL, NULL, NULL)
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [avatar], [gender], [dob], [address]) VALUES (17, 18, N'minionscc', N'0971760000', N'minionscc@greenstock.vn', NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[UserInfo] OFF

GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (8, N'vinh12345', N'$2a$10$CE/KWFfqH7T/BmzGnSsA4u37ctbC9W2uUXWr9..m5wNZqatDFU13y', N'Active')
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (9, N'vinh1234', N'$2a$10$fJVGHjeejDnYmKs1tszB.O5nucgVmxnc1buKZ5SpHGnM5DHMAYW4y', N'Active')
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (11, N'vinh123456', N'$2a$10$hkYq0GTA4SWPnsYfwNZ2WuHZKR16GwAWJ3feuH4L.olq0WsTZbrSa', N'Active')
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (12, N'nguyendaiky', N'$2a$10$zcQSdOgM6RoLXA/cTm3JyOkTdX1VozZ.YIymoHjWQBpyzj4rnyFaa', N'Active')
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (13, N'kynd123', N'$2a$10$H0NqJGpiPB563RgelKPaUO1HawXRx6iwrgjRWFQpSm8KU2JeP/wrO', N'Active')
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (14, N'shopowner2', N'$2a$10$hkYq0GTA4SWPnsYfwNZ2WuHZKR16GwAWJ3feuH4L.olq0WsTZbrSa', N'Active')
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (15, N'shopowner3', N'$2a$10$hkYq0GTA4SWPnsYfwNZ2WuHZKR16GwAWJ3feuH4L.olq0WsTZbrSa', N'Active')
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (16, N'kynd2003', N'$2a$10$abIO4PiSHjOOl1ZxRLSvr.mvNgTUb0Nwbb8lCyguDya.T/v6zsgPO', N'Active')
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (17, N'shipper', N'$2a$10$GgsG/mfBqB37meg5sq4LpeYh05AfZ.QT6M6XdqBuSSK7N5fjN4dE6', N'Active')
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (18, N'minionscc', N'$2a$10$GgsG/mfBqB37meg5sq4LpeYh05AfZ.QT6M6XdqBuSSK7N5fjN4dE6', N'Active')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
/****** Object:  Index [UQ__Cart__B9BE370EA0E0E866]    Script Date: 7/16/2026 10:13:15 PM ******/
ALTER TABLE [dbo].[Cart] ADD UNIQUE NONCLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Permissi__A98A808EADA6C390]    Script Date: 7/16/2026 10:13:15 PM ******/
ALTER TABLE [dbo].[Permission] ADD UNIQUE NONCLUSTERED 
(
	[permission_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Promotio__C07E2315AE127556]    Script Date: 7/16/2026 10:13:15 PM ******/
ALTER TABLE [dbo].[Promotions] ADD UNIQUE NONCLUSTERED 
(
	[promo_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__ResetPas__CA90DA7AF9D15BE3]    Script Date: 7/16/2026 10:13:15 PM ******/
ALTER TABLE [dbo].[ResetPasswordToken] ADD UNIQUE NONCLUSTERED 
(
	[token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Roles__783254B1BCB9613B]    Script Date: 7/16/2026 10:13:15 PM ******/
ALTER TABLE [dbo].[Roles] ADD UNIQUE NONCLUSTERED 
(
	[role_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__UserInfo__B9BE370E4E683CFD]    Script Date: 7/16/2026 10:13:15 PM ******/
ALTER TABLE [dbo].[UserInfo] ADD UNIQUE NONCLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__F3DBC5726E4041C3]    Script Date: 7/16/2026 10:13:15 PM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Cart] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[CustomerAddresses] ADD  DEFAULT ((0)) FOR [is_default]
GO
ALTER TABLE [dbo].[Import_Receipt] ADD  DEFAULT (getdate()) FOR [import_date]
GO
ALTER TABLE [dbo].[Inventory] ADD  DEFAULT (getdate()) FOR [last_updated]
GO
ALTER TABLE [dbo].[Inventory_Batch] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Notifications] ADD  DEFAULT ((0)) FOR [is_read]
GO
ALTER TABLE [dbo].[Notifications] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0)) FOR [discount_price]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((10)) FOR [low_stock_threshold]
GO
ALTER TABLE [dbo].[Product_Image] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Product_Packaging] ADD  DEFAULT ((0.00)) FOR [price_adjustment]
GO
ALTER TABLE [dbo].[Product_Weight_Variant] ADD  DEFAULT ((0.00)) FOR [price_adjustment]
GO
ALTER TABLE [dbo].[Promotions] ADD  DEFAULT ((0)) FOR [min_order_value]
GO
ALTER TABLE [dbo].[ResetPasswordToken] ADD  DEFAULT ((0)) FOR [used]
GO
ALTER TABLE [dbo].[Reviews] ADD  DEFAULT ('Pending') FOR [status]
GO
ALTER TABLE [dbo].[Reviews] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Sale_Order] ADD  DEFAULT ('Pending') FOR [payment_status]
GO
ALTER TABLE [dbo].[Sale_Order] ADD  DEFAULT ((0)) FOR [discount_amount]
GO
ALTER TABLE [dbo].[Sale_Order] ADD  DEFAULT ((0)) FOR [shipping_fee]
GO
ALTER TABLE [dbo].[Sale_Order] ADD  DEFAULT ((0)) FOR [total_payment]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Cart_Item]  WITH CHECK ADD FOREIGN KEY([cart_id])
REFERENCES [dbo].[Cart] ([cart_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Cart_Item]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([product_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomerAddresses]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
ON DELETE CASCADE
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
ALTER TABLE [dbo].[Notifications]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([category_id])
REFERENCES [dbo].[Product_Category] ([category_id])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_ShopOwner] FOREIGN KEY([shop_owner_id])
REFERENCES [dbo].[Users] ([user_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_ShopOwner]
GO
ALTER TABLE [dbo].[Product_Image]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([product_id])
GO
ALTER TABLE [dbo].[Product_Packaging]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([product_id])
GO
ALTER TABLE [dbo].[Product_Weight_Variant]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([product_id])
GO
ALTER TABLE [dbo].[ResetPasswordToken]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([product_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD FOREIGN KEY([user_id])
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
ALTER TABLE [dbo].[Sale_Order]  WITH CHECK ADD FOREIGN KEY([shipper_id])
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
ALTER TABLE [dbo].[Cart_Item]  WITH CHECK ADD CHECK  (([quantity]>(0)))
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD CHECK  (([rating]>=(1) AND [rating]<=(5)))
GO

-- ============================================================
-- 1. Bang MembershipTier: Quan ly quy dinh cac Hang thanh vien (Luat chung)
-- ============================================================
IF NOT EXISTS (
    SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'MembershipTier'
)
BEGIN
    CREATE TABLE [dbo].[MembershipTier] (
        [tier_id]                [int] IDENTITY(1,1) NOT NULL,
        [tier_name]              [nvarchar](50) NOT NULL,
        [min_points]             [int] NOT NULL CONSTRAINT [DF_MembershipTier_min_points] DEFAULT (0),
        [discount_percent]      [int] NOT NULL CONSTRAINT [DF_MembershipTier_discount]   DEFAULT (0),
        [point_conversion_rate]  [int] NOT NULL CONSTRAINT [DF_MembershipTier_conv_rate]  DEFAULT (10000),
        CONSTRAINT [PK_MembershipTier] PRIMARY KEY CLUSTERED ([tier_id] ASC),
        CONSTRAINT [UQ_MembershipTier_name] UNIQUE ([tier_name])
    );

    -- Chen du lieu quy dinh mac dinh cho 4 Hang thành viên
    INSERT INTO [dbo].[MembershipTier] ([tier_name], [min_points], [discount_percent], [point_conversion_rate])
    VALUES 
    (N'Normal',  0,    0,  10000),
    (N'Silver',  100,  5,  10000),
    (N'Gold',    500,  10, 10000),
    (N'Diamond', 1000, 15, 10000);
END
GO

-- ============================================================
-- 2. Bang Membership: Quan ly diem tich luy cua tung Khach hang
-- ============================================================
IF NOT EXISTS (
    SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Membership'
)
BEGIN
    CREATE TABLE [dbo].[Membership] (
        [membership_id]   [int] IDENTITY(1,1) NOT NULL,
        [user_id]         [int] NOT NULL,
        [current_points]  [int] NOT NULL CONSTRAINT [DF_Membership_points]    DEFAULT (0),
        [tier_id]         [int] NOT NULL CONSTRAINT [DF_Membership_tier_id] DEFAULT (1), -- Default 1 (Normal)
        [manual_override] [bit] NOT NULL CONSTRAINT [DF_Membership_override]  DEFAULT (0),
        [tier_updated_at] [datetime] NOT NULL CONSTRAINT [DF_Membership_updated] DEFAULT (GETDATE()),
        CONSTRAINT [PK_Membership] PRIMARY KEY CLUSTERED ([membership_id] ASC)
    );
END
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'UQ_Membership_User')
BEGIN
    ALTER TABLE [dbo].[Membership] ADD CONSTRAINT [UQ_Membership_User] UNIQUE ([user_id])
END
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_Membership_User')
BEGIN
    ALTER TABLE [dbo].[Membership] WITH CHECK ADD CONSTRAINT [FK_Membership_User]
        FOREIGN KEY ([user_id]) REFERENCES [dbo].[Users] ([user_id]) ON DELETE CASCADE
END
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_Membership_Tier')
BEGIN
    ALTER TABLE [dbo].[Membership] WITH CHECK ADD CONSTRAINT [FK_Membership_Tier]
        FOREIGN KEY ([tier_id]) REFERENCES [dbo].[MembershipTier] ([tier_id])
END
GO

-- ============================================================
-- Bang Delivery: Quan ly giao hang cho Shipper
-- ============================================================
IF NOT EXISTS (
    SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Delivery'
)
BEGIN
    CREATE TABLE [dbo].[Delivery] (
        [delivery_id]      [int] IDENTITY(1,1) NOT NULL,
        [order_id]         [int] NOT NULL,
        [shipper_id]       [int] NULL,
        [status]           [nvarchar](50) NOT NULL CONSTRAINT [DF_Delivery_status] DEFAULT (N'Pending'),
        [shipping_address] [nvarchar](500) NULL,
        [shipped_date]     [datetime] NULL,
        [delivered_date]   [datetime] NULL,
        [failure_reason]   [nvarchar](500) NULL,
        CONSTRAINT [PK_Delivery] PRIMARY KEY CLUSTERED ([delivery_id] ASC)
    )
END
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_Delivery_SaleOrder')
BEGIN
    ALTER TABLE [dbo].[Delivery] ADD CONSTRAINT [FK_Delivery_SaleOrder]
        FOREIGN KEY ([order_id]) REFERENCES [dbo].[Sale_Order] ([sale_order_id])
END
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_Delivery_Shipper')
BEGIN
    ALTER TABLE [dbo].[Delivery] ADD CONSTRAINT [FK_Delivery_Shipper]
        FOREIGN KEY ([shipper_id]) REFERENCES [dbo].[Users] ([user_id])
END
GO

-- Dong bo don hang dang active vao bang Delivery
INSERT INTO [dbo].[Delivery] ([order_id], [shipping_address], [status])
SELECT so.[sale_order_id], ISNULL(so.[shipping_address], N'Chua cap nhat'), N'Pending'
FROM [dbo].[Sale_Order] so
WHERE (so.[order_status] IS NULL OR so.[order_status] NOT IN (N'Cancelled', N'Delivered', N'Delivery Failed'))
  AND NOT EXISTS (SELECT 1 FROM [dbo].[Delivery] d WHERE d.[order_id] = so.[sale_order_id]);
GO

USE [master]
GO
ALTER DATABASE [GreenStockDB1] SET  READ_WRITE 
GO


USE [GreenStockDB1];
GO

-- 1. CHÈN 60 NGƯỜI DÙNG MỚI
SET IDENTITY_INSERT [dbo].[Users] ON;
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (19, N'hoathao137', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (20, N'hanhkim148', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (21, N'namduc117', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (22, N'huyminh304', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (23, N'namthai399', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (24, N'phuongthao528', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (25, N'thinhthai10', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (26, N'tuyetthao713', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (27, N'tungtuan247', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (28, N'hayen55', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (29, N'cuonganh434', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (30, N'ngakim316', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (31, N'chauyen139', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (32, N'duongthanh524', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (33, N'cucthanh332', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (34, N'thinhhuu787', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (35, N'hoathu679', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (36, N'tunganh922', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (37, N'phongminh385', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (38, N'hanhquynh923', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (39, N'vinhdai542', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (40, N'bichyen269', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (41, N'dathoang89', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (42, N'datduc317', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (43, N'dunghong837', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (44, N'kientrong653', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (45, N'khoahoang42', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (46, N'nhithanh132', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (47, N'vinhminh779', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (48, N'phongthai729', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (49, N'tamduc808', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (50, N'hungtrong156', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (51, N'dungphuong919', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (52, N'dungminh573', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (53, N'binhduc728', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (54, N'trangkim884', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (55, N'huongyen650', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (56, N'anhthu25', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (57, N'maithao601', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (58, N'toandai972', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (59, N'linhyen544', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (60, N'ngathanh611', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (61, N'phucduc768', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (62, N'namanh576', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (63, N'tamduc94', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (64, N'phuongyen453', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (65, N'namthanh66', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (66, N'duonganh426', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (67, N'oanhyen306', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (68, N'longtuan935', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (69, N'haibao680', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (70, N'cuonggia641', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (71, N'huytrong605', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (72, N'huydai165', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (73, N'datthai951', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (74, N'lanyen734', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (75, N'cuongtuan763', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (76, N'hanhthi763', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (77, N'sonquoc419', N'123', N'Active');
INSERT [dbo].[Users] ([user_id], [username], [password], [status]) VALUES (78, N'ngayen537', N'123', N'Active');
SET IDENTITY_INSERT [dbo].[Users] OFF;
GO

-- CHÈN THÔNG TIN CÁ NHÂN USERINFO
SET IDENTITY_INSERT [dbo].[UserInfo] ON;
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (19, 19, N'Dương Thảo Hoa', N'0989048300', N'hoathao137@gmail.com', N'Female', '1995-08-27', N'84 Trường Chinh, Quận Tân Bình, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (20, 20, N'Vũ Kim Hạnh', N'0935508368', N'hanhkim148@gmail.com', N'Female', '2000-07-18', N'174 Giải Phóng, Quận Hoàng Mai, Hà Nội');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (21, 21, N'Trịnh Đức Nam', N'0979061779', N'namduc117@gmail.com', N'Male', '1987-12-18', N'296 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (22, 22, N'Võ Minh Huy', N'0964930787', N'huyminh304@gmail.com', N'Male', '2001-02-10', N'42 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (23, 23, N'Đinh Thái Nam', N'0944896016', N'namthai399@gmail.com', N'Male', '1985-01-24', N'190 Hoàng Văn Thụ, Quận Phú Nhuận, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (24, 24, N'Vũ Thảo Phượng', N'0914663645', N'phuongthao528@gmail.com', N'Female', '2003-12-21', N'56 Kim Mã, Quận Ba Đình, Hà Nội');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (25, 25, N'Lê Thái Thịnh', N'0915443219', N'thinhthai10@gmail.com', N'Male', '1998-11-16', N'409 Kim Mã, Quận Ba Đình, Hà Nội');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (26, 26, N'Dương Thảo Tuyết', N'0988765596', N'tuyetthao713@gmail.com', N'Female', '1987-07-09', N'112 Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (27, 27, N'Đặng Tuấn Tùng', N'0921839592', N'tungtuan247@gmail.com', N'Male', '1989-10-09', N'65 Cộng Hòa, Quận Tân Bình, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (28, 28, N'Hồ Yến Hà', N'0943375178', N'hayen55@gmail.com', N'Female', '1995-02-05', N'355 Đỗ Xuân Hợp, Thành phố Thủ Đức, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (29, 29, N'Đặng Anh Cường', N'0940335752', N'cuonganh434@gmail.com', N'Male', '2001-11-14', N'77 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (30, 30, N'Nguyễn Kim Nga', N'0992726184', N'ngakim316@gmail.com', N'Female', '1999-06-16', N'139 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (31, 31, N'Trần Yến Châu', N'0953167592', N'chauyen139@gmail.com', N'Female', '1986-07-23', N'419 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (32, 32, N'Đặng Thanh Dương', N'0979821349', N'duongthanh524@gmail.com', N'Female', '1997-07-25', N'83 Cộng Hòa, Quận Tân Bình, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (33, 33, N'Hoàng Thanh Cúc', N'0989636713', N'cucthanh332@gmail.com', N'Female', '1988-01-13', N'353 Giải Phóng, Quận Hoàng Mai, Hà Nội');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (34, 34, N'Trần Hữu Thịnh', N'0924166464', N'thinhhuu787@gmail.com', N'Male', '1988-03-05', N'116 Cầu Giấy, Quận Cầu Giấy, Hà Nội');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (35, 35, N'Đỗ Thu Hoa', N'0911568802', N'hoathu679@gmail.com', N'Female', '1988-06-15', N'412 Cầu Giấy, Quận Cầu Giấy, Hà Nội');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (36, 36, N'Phạm Anh Tùng', N'0992055812', N'tunganh922@gmail.com', N'Male', '1990-06-27', N'333 Hoàng Văn Thụ, Quận Phú Nhuận, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (37, 37, N'Đinh Minh Phong', N'0912414341', N'phongminh385@gmail.com', N'Male', '1994-09-07', N'400 Trường Chinh, Quận Tân Bình, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (38, 38, N'Dương Quỳnh Hạnh', N'0968334152', N'hanhquynh923@gmail.com', N'Female', '2001-06-05', N'202 Giải Phóng, Quận Hoàng Mai, Hà Nội');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (39, 39, N'Lý Đại Vinh', N'0942565355', N'vinhdai542@gmail.com', N'Male', '1987-01-17', N'326 Kim Mã, Quận Ba Đình, Hà Nội');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (40, 40, N'Phạm Yến Bích', N'0924499254', N'bichyen269@gmail.com', N'Female', '1993-04-24', N'300 Cầu Giấy, Quận Cầu Giấy, Hà Nội');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (41, 41, N'Đỗ Hoàng Đạt', N'0992990913', N'dathoang89@gmail.com', N'Male', '1998-06-03', N'302 Giải Phóng, Quận Hoàng Mai, Hà Nội');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (42, 42, N'Dương Đức Đạt', N'0912334063', N'datduc317@gmail.com', N'Male', '1991-11-21', N'24 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (43, 43, N'Nguyễn Hồng Dung', N'0963047157', N'dunghong837@gmail.com', N'Female', '1997-09-22', N'396 Cộng Hòa, Quận Tân Bình, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (44, 44, N'Phạm Trọng Kiên', N'0948987373', N'kientrong653@gmail.com', N'Male', '1993-06-09', N'44 Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (45, 45, N'Đặng Hoàng Khoa', N'0930282332', N'khoahoang42@gmail.com', N'Male', '1993-12-18', N'404 Tây Sơn, Quận Đống Đa, Hà Nội');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (46, 46, N'Lê Thanh Nhi', N'0915753635', N'nhithanh132@gmail.com', N'Female', '1987-11-26', N'370 Nguyễn Văn Cừ, Quận Long Biên, Hà Nội');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (47, 47, N'Huỳnh Minh Vinh', N'0974231272', N'vinhminh779@gmail.com', N'Male', '2003-06-02', N'329 Trường Chinh, Quận Tân Bình, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (48, 48, N'Lý Thái Phong', N'0926192013', N'phongthai729@gmail.com', N'Male', '1993-08-15', N'345 Cộng Hòa, Quận Tân Bình, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (49, 49, N'Ngô Đức Tâm', N'0943027319', N'tamduc808@gmail.com', N'Male', '1989-11-08', N'290 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (50, 50, N'Đặng Trọng Hùng', N'0955722703', N'hungtrong156@gmail.com', N'Male', '1988-06-12', N'191 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (51, 51, N'Bùi Phương Dung', N'0920299584', N'dungphuong919@gmail.com', N'Female', '1991-09-05', N'81 Phạm Văn Đồng, Quận Bắc Từ Liêm, Hà Nội');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (52, 52, N'Trịnh Minh Dũng', N'0917233473', N'dungminh573@gmail.com', N'Male', '1993-05-19', N'241 Nguyễn Văn Cừ, Quận Long Biên, Hà Nội');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (53, 53, N'Đinh Đức Bình', N'0977561845', N'binhduc728@gmail.com', N'Male', '1988-03-08', N'373 Cộng Hòa, Quận Tân Bình, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (54, 54, N'Bùi Kim Trang', N'0994612439', N'trangkim884@gmail.com', N'Female', '2000-12-14', N'393 Nguyễn Văn Cừ, Quận Long Biên, Hà Nội');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (55, 55, N'Hồ Yến Hương', N'0946876036', N'huongyen650@gmail.com', N'Female', '1990-10-01', N'370 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (56, 56, N'Đinh Thu Anh', N'0974890830', N'anhthu25@gmail.com', N'Female', '1989-07-15', N'41 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (57, 57, N'Trịnh Thảo Mai', N'0987398497', N'maithao601@gmail.com', N'Female', '1997-02-24', N'140 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (58, 58, N'Dương Đại Toàn', N'0968098489', N'toandai972@gmail.com', N'Male', '2000-01-26', N'76 Cầu Giấy, Quận Cầu Giấy, Hà Nội');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (59, 59, N'Lê Yến Linh', N'0958055996', N'linhyen544@gmail.com', N'Female', '1991-10-05', N'139 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (60, 60, N'Huỳnh Thanh Nga', N'0926950264', N'ngathanh611@gmail.com', N'Female', '1988-08-18', N'162 Đỗ Xuân Hợp, Thành phố Thủ Đức, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (61, 61, N'Lý Đức Phúc', N'0993491477', N'phucduc768@gmail.com', N'Male', '2001-03-18', N'71 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (62, 62, N'Bùi Anh Nam', N'0980337539', N'namanh576@gmail.com', N'Male', '1985-10-21', N'75 Đại Cồ Việt, Quận Hai Bà Trưng, Hà Nội');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (63, 63, N'Nguyễn Đức Tâm', N'0993406735', N'tamduc94@gmail.com', N'Male', '1996-05-27', N'47 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (64, 64, N'Dương Yến Phượng', N'0996326320', N'phuongyen453@gmail.com', N'Female', '1999-08-08', N'293 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (65, 65, N'Đào Thành Nam', N'0951205360', N'namthanh66@gmail.com', N'Male', '2004-02-26', N'251 Cách Mạng Tháng 8, Quận 10, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (66, 66, N'Hoàng Ánh Dương', N'0969756580', N'duonganh426@gmail.com', N'Female', '1992-10-13', N'95 Hoàng Văn Thụ, Quận Phú Nhuận, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (67, 67, N'Trịnh Yến Oanh', N'0931088639', N'oanhyen306@gmail.com', N'Female', '1997-11-20', N'133 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (68, 68, N'Dương Tuấn Long', N'0984724597', N'longtuan935@gmail.com', N'Male', '1986-08-06', N'11 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (69, 69, N'Dương Bảo Hải', N'0913041374', N'haibao680@gmail.com', N'Male', '1994-11-06', N'247 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (70, 70, N'Võ Gia Cường', N'0981551653', N'cuonggia641@gmail.com', N'Male', '1998-04-26', N'372 Lê Văn Sỹ, Quận 3, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (71, 71, N'Ngô Trọng Huy', N'0961109648', N'huytrong605@gmail.com', N'Male', '1990-03-24', N'172 Tây Sơn, Quận Đống Đa, Hà Nội');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (72, 72, N'Nguyễn Đại Huy', N'0989573530', N'huydai165@gmail.com', N'Male', '2002-03-17', N'243 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (73, 73, N'Nguyễn Thái Đạt', N'0987948020', N'datthai951@gmail.com', N'Male', '2002-10-19', N'168 Cầu Giấy, Quận Cầu Giấy, Hà Nội');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (74, 74, N'Trần Yến Lan', N'0967416454', N'lanyen734@gmail.com', N'Female', '1991-07-24', N'129 Cách Mạng Tháng 8, Quận 10, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (75, 75, N'Đinh Tuấn Cường', N'0965207717', N'cuongtuan763@gmail.com', N'Male', '1991-06-22', N'166 Giải Phóng, Quận Hoàng Mai, Hà Nội');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (76, 76, N'Dương Thị Hạnh', N'0969373262', N'hanhthi763@gmail.com', N'Female', '1998-08-18', N'415 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (77, 77, N'Huỳnh Quốc Sơn', N'0961456391', N'sonquoc419@gmail.com', N'Male', '1985-08-23', N'86 Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh');
INSERT [dbo].[UserInfo] ([user_info_id], [user_id], [full_name], [phone], [email], [gender], [dob], [address]) VALUES (78, 78, N'Vũ Yến Nga', N'0920078778', N'ngayen537@gmail.com', N'Female', '1992-04-18', N'210 Tây Sơn, Quận Đống Đa, Hà Nội');
SET IDENTITY_INSERT [dbo].[UserInfo] OFF;
GO

-- PHÂN QUYỀN CUSTOMER CHO USER
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (19, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (20, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (21, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (22, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (23, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (24, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (25, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (26, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (27, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (28, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (29, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (30, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (31, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (32, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (33, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (34, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (35, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (36, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (37, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (38, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (39, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (40, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (41, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (42, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (43, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (44, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (45, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (46, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (47, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (48, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (49, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (50, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (51, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (52, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (53, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (54, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (55, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (56, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (57, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (58, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (59, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (60, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (61, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (62, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (63, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (64, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (65, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (66, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (67, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (68, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (69, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (70, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (71, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (72, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (73, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (74, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (75, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (76, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (77, 1);
INSERT [dbo].[User_Role] ([user_id], [role_id]) VALUES (78, 1);
GO

-- CHÈN SỔ ĐỊA CHỈ CUSTOMERADDRESSES
SET IDENTITY_INSERT [dbo].[CustomerAddresses] ON;
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (7, 19, N'Nhà riêng', N'Dương Thảo Hoa', N'0989048300', N'84 Trường Chinh, Quận Tân Bình, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (8, 20, N'Nhà riêng', N'Vũ Kim Hạnh', N'0935508368', N'174 Giải Phóng, Quận Hoàng Mai, Hà Nội', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (9, 21, N'Nhà riêng', N'Trịnh Đức Nam', N'0979061779', N'296 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (10, 22, N'Nhà riêng', N'Võ Minh Huy', N'0964930787', N'42 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (11, 23, N'Nhà riêng', N'Đinh Thái Nam', N'0944896016', N'190 Hoàng Văn Thụ, Quận Phú Nhuận, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (12, 24, N'Nhà riêng', N'Vũ Thảo Phượng', N'0914663645', N'56 Kim Mã, Quận Ba Đình, Hà Nội', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (13, 25, N'Nhà riêng', N'Lê Thái Thịnh', N'0915443219', N'409 Kim Mã, Quận Ba Đình, Hà Nội', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (14, 26, N'Nhà riêng', N'Dương Thảo Tuyết', N'0988765596', N'112 Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (15, 27, N'Nhà riêng', N'Đặng Tuấn Tùng', N'0921839592', N'65 Cộng Hòa, Quận Tân Bình, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (16, 28, N'Nhà riêng', N'Hồ Yến Hà', N'0943375178', N'355 Đỗ Xuân Hợp, Thành phố Thủ Đức, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (17, 29, N'Nhà riêng', N'Đặng Anh Cường', N'0940335752', N'77 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (18, 30, N'Nhà riêng', N'Nguyễn Kim Nga', N'0992726184', N'139 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (19, 31, N'Nhà riêng', N'Trần Yến Châu', N'0953167592', N'419 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (20, 32, N'Nhà riêng', N'Đặng Thanh Dương', N'0979821349', N'83 Cộng Hòa, Quận Tân Bình, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (21, 33, N'Nhà riêng', N'Hoàng Thanh Cúc', N'0989636713', N'353 Giải Phóng, Quận Hoàng Mai, Hà Nội', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (22, 34, N'Nhà riêng', N'Trần Hữu Thịnh', N'0924166464', N'116 Cầu Giấy, Quận Cầu Giấy, Hà Nội', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (23, 35, N'Nhà riêng', N'Đỗ Thu Hoa', N'0911568802', N'412 Cầu Giấy, Quận Cầu Giấy, Hà Nội', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (24, 36, N'Nhà riêng', N'Phạm Anh Tùng', N'0992055812', N'333 Hoàng Văn Thụ, Quận Phú Nhuận, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (25, 37, N'Nhà riêng', N'Đinh Minh Phong', N'0912414341', N'400 Trường Chinh, Quận Tân Bình, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (26, 38, N'Nhà riêng', N'Dương Quỳnh Hạnh', N'0968334152', N'202 Giải Phóng, Quận Hoàng Mai, Hà Nội', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (27, 39, N'Nhà riêng', N'Lý Đại Vinh', N'0942565355', N'326 Kim Mã, Quận Ba Đình, Hà Nội', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (28, 40, N'Nhà riêng', N'Phạm Yến Bích', N'0924499254', N'300 Cầu Giấy, Quận Cầu Giấy, Hà Nội', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (29, 41, N'Nhà riêng', N'Đỗ Hoàng Đạt', N'0992990913', N'302 Giải Phóng, Quận Hoàng Mai, Hà Nội', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (30, 42, N'Nhà riêng', N'Dương Đức Đạt', N'0912334063', N'24 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (31, 43, N'Nhà riêng', N'Nguyễn Hồng Dung', N'0963047157', N'396 Cộng Hòa, Quận Tân Bình, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (32, 44, N'Nhà riêng', N'Phạm Trọng Kiên', N'0948987373', N'44 Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (33, 45, N'Nhà riêng', N'Đặng Hoàng Khoa', N'0930282332', N'404 Tây Sơn, Quận Đống Đa, Hà Nội', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (34, 46, N'Nhà riêng', N'Lê Thanh Nhi', N'0915753635', N'370 Nguyễn Văn Cừ, Quận Long Biên, Hà Nội', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (35, 47, N'Nhà riêng', N'Huỳnh Minh Vinh', N'0974231272', N'329 Trường Chinh, Quận Tân Bình, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (36, 48, N'Nhà riêng', N'Lý Thái Phong', N'0926192013', N'345 Cộng Hòa, Quận Tân Bình, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (37, 49, N'Nhà riêng', N'Ngô Đức Tâm', N'0943027319', N'290 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (38, 50, N'Nhà riêng', N'Đặng Trọng Hùng', N'0955722703', N'191 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (39, 51, N'Nhà riêng', N'Bùi Phương Dung', N'0920299584', N'81 Phạm Văn Đồng, Quận Bắc Từ Liêm, Hà Nội', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (40, 52, N'Nhà riêng', N'Trịnh Minh Dũng', N'0917233473', N'241 Nguyễn Văn Cừ, Quận Long Biên, Hà Nội', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (41, 53, N'Nhà riêng', N'Đinh Đức Bình', N'0977561845', N'373 Cộng Hòa, Quận Tân Bình, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (42, 54, N'Nhà riêng', N'Bùi Kim Trang', N'0994612439', N'393 Nguyễn Văn Cừ, Quận Long Biên, Hà Nội', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (43, 55, N'Nhà riêng', N'Hồ Yến Hương', N'0946876036', N'370 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (44, 56, N'Nhà riêng', N'Đinh Thu Anh', N'0974890830', N'41 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (45, 57, N'Nhà riêng', N'Trịnh Thảo Mai', N'0987398497', N'140 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (46, 58, N'Nhà riêng', N'Dương Đại Toàn', N'0968098489', N'76 Cầu Giấy, Quận Cầu Giấy, Hà Nội', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (47, 59, N'Nhà riêng', N'Lê Yến Linh', N'0958055996', N'139 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (48, 60, N'Nhà riêng', N'Huỳnh Thanh Nga', N'0926950264', N'162 Đỗ Xuân Hợp, Thành phố Thủ Đức, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (49, 61, N'Nhà riêng', N'Lý Đức Phúc', N'0993491477', N'71 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (50, 62, N'Nhà riêng', N'Bùi Anh Nam', N'0980337539', N'75 Đại Cồ Việt, Quận Hai Bà Trưng, Hà Nội', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (51, 63, N'Nhà riêng', N'Nguyễn Đức Tâm', N'0993406735', N'47 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (52, 64, N'Nhà riêng', N'Dương Yến Phượng', N'0996326320', N'293 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (53, 65, N'Nhà riêng', N'Đào Thành Nam', N'0951205360', N'251 Cách Mạng Tháng 8, Quận 10, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (54, 66, N'Nhà riêng', N'Hoàng Ánh Dương', N'0969756580', N'95 Hoàng Văn Thụ, Quận Phú Nhuận, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (55, 67, N'Nhà riêng', N'Trịnh Yến Oanh', N'0931088639', N'133 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (56, 68, N'Nhà riêng', N'Dương Tuấn Long', N'0984724597', N'11 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (57, 69, N'Nhà riêng', N'Dương Bảo Hải', N'0913041374', N'247 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (58, 70, N'Nhà riêng', N'Võ Gia Cường', N'0981551653', N'372 Lê Văn Sỹ, Quận 3, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (59, 71, N'Nhà riêng', N'Ngô Trọng Huy', N'0961109648', N'172 Tây Sơn, Quận Đống Đa, Hà Nội', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (60, 72, N'Nhà riêng', N'Nguyễn Đại Huy', N'0989573530', N'243 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (61, 73, N'Nhà riêng', N'Nguyễn Thái Đạt', N'0987948020', N'168 Cầu Giấy, Quận Cầu Giấy, Hà Nội', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (62, 74, N'Nhà riêng', N'Trần Yến Lan', N'0967416454', N'129 Cách Mạng Tháng 8, Quận 10, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (63, 75, N'Nhà riêng', N'Đinh Tuấn Cường', N'0965207717', N'166 Giải Phóng, Quận Hoàng Mai, Hà Nội', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (64, 76, N'Nhà riêng', N'Dương Thị Hạnh', N'0969373262', N'415 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (65, 77, N'Nhà riêng', N'Huỳnh Quốc Sơn', N'0961456391', N'86 Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh', 1);
INSERT [dbo].[CustomerAddresses] ([address_id], [user_id], [label], [receiver_name], [receiver_phone], [address_details], [is_default]) VALUES (66, 78, N'Nhà riêng', N'Vũ Yến Nga', N'0920078778', N'210 Tây Sơn, Quận Đống Đa, Hà Nội', 1);
SET IDENTITY_INSERT [dbo].[CustomerAddresses] OFF;
GO

-- TẠO GIỎ HÀNG CART
SET IDENTITY_INSERT [dbo].[Cart] ON;
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (4, 19, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (5, 20, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (6, 21, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (7, 22, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (8, 23, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (9, 24, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (10, 25, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (11, 26, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (12, 27, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (13, 28, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (14, 29, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (15, 30, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (16, 31, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (17, 32, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (18, 33, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (19, 34, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (20, 35, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (21, 36, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (22, 37, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (23, 38, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (24, 39, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (25, 40, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (26, 41, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (27, 42, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (28, 43, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (29, 44, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (30, 45, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (31, 46, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (32, 47, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (33, 48, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (34, 49, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (35, 50, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (36, 51, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (37, 52, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (38, 53, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (39, 54, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (40, 55, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (41, 56, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (42, 57, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (43, 58, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (44, 59, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (45, 60, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (46, 61, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (47, 62, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (48, 63, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (49, 64, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (50, 65, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (51, 66, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (52, 67, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (53, 68, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (54, 69, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (55, 70, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (56, 71, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (57, 72, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (58, 73, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (59, 74, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (60, 75, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (61, 76, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (62, 77, '2026-07-01 08:00:00');
INSERT [dbo].[Cart] ([cart_id], [user_id], [created_at]) VALUES (63, 78, '2026-07-01 08:00:00');
SET IDENTITY_INSERT [dbo].[Cart] OFF;
GO

-- 2. CHÈN 250 ĐƠN HÀNG MỚI (TỪ 01/07/2026 ĐẾN 03/08/2026)
SET IDENTITY_INSERT [dbo].[Sale_Order] ON;
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (20, '2026-07-01 01:33:12', 13, N'Pending', N'Momo', N'Unpaid', N'123 Nguyễn Văn Cừ, Quận 5, TP. HCM', N'0999999999', 17, NULL, NULL, 15000.00, 25000.00, 562000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (21, '2026-07-01 03:42:55', 58, N'Cancelled', N'COD', N'Refunded', N'76 Cầu Giấy, Quận Cầu Giấy, Hà Nội', N'0968098489', 17, NULL, NULL, 15000.00, 20000.00, 445000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (22, '2026-07-01 07:40:10', 40, N'Delivered', N'Bank Transfer', N'Paid', N'300 Cầu Giấy, Quận Cầu Giấy, Hà Nội', N'0924499254', 17, '2026-07-01 11:25:11', '2026-07-01 12:33:29', 0.00, 30000.00, 120000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (23, '2026-07-01 10:23:58', 74, N'Delivered', N'VNPAY', N'Paid', N'129 Cách Mạng Tháng 8, Quận 10, TP. Hồ Chí Minh', N'0967416454', 17, '2026-07-01 12:49:01', '2026-07-01 14:41:43', 0.00, 30000.00, 375000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (24, '2026-07-01 13:51:38', 36, N'Delivered', N'VNPAY', N'Paid', N'333 Hoàng Văn Thụ, Quận Phú Nhuận, TP. Hồ Chí Minh', N'0992055812', 17, '2026-07-01 16:06:06', '2026-07-01 17:59:12', 20000.00, 25000.00, 445000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (25, '2026-07-01 16:44:38', 64, N'Delivered', N'Bank Transfer', N'Paid', N'293 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', N'0996326320', 17, '2026-07-01 19:17:38', '2026-07-01 20:21:52', 0.00, 20000.00, 280000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (26, '2026-07-01 20:17:45', 19, N'Completed', N'Bank Transfer', N'Paid', N'84 Trường Chinh, Quận Tân Bình, TP. Hồ Chí Minh', N'0989048300', 17, '2026-07-01 22:13:58', '2026-07-01 23:22:33', 0.00, 25000.00, 2625000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (27, '2026-07-01 23:36:46', 66, N'Pending', N'Bank Transfer', N'Unpaid', N'95 Hoàng Văn Thụ, Quận Phú Nhuận, TP. Hồ Chí Minh', N'0969756580', 17, NULL, NULL, 0.00, 20000.00, 1340000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (28, '2026-07-02 02:46:07', 29, N'Completed', N'Momo', N'Paid', N'77 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', N'0940335752', 17, '2026-07-02 04:16:58', '2026-07-02 05:55:42', 15000.00, 25000.00, 35000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (29, '2026-07-02 06:12:35', 62, N'Shipping', N'Bank Transfer', N'Unpaid', N'75 Đại Cồ Việt, Quận Hai Bà Trưng, Hà Nội', N'0980337539', 17, '2026-07-02 09:24:48', NULL, 15000.00, 30000.00, 425000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (30, '2026-07-02 09:31:00', 18, N'Cancelled', N'Momo', N'Refunded', N'123 Nguyễn Văn Cừ, Quận 5, TP. HCM', N'0999999999', 17, NULL, NULL, 15000.00, 25000.00, 550000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (31, '2026-07-02 12:22:43', 57, N'Completed', N'Momo', N'Paid', N'140 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', N'0987398497', 17, '2026-07-02 13:57:26', '2026-07-02 15:45:39', 10000.00, 20000.00, 1750000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (32, '2026-07-02 15:55:42', 35, N'Delivered', N'VNPAY', N'Paid', N'412 Cầu Giấy, Quận Cầu Giấy, Hà Nội', N'0911568802', 17, '2026-07-02 18:40:53', '2026-07-02 19:55:14', 10000.00, 25000.00, 455000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (33, '2026-07-02 18:39:38', 32, N'Cancelled', N'Bank Transfer', N'Refunded', N'83 Cộng Hòa, Quận Tân Bình, TP. Hồ Chí Minh', N'0979821349', 17, NULL, NULL, 15000.00, 20000.00, 545000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (34, '2026-07-02 21:56:16', 42, N'Pending', N'Momo', N'Unpaid', N'24 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh', N'0912334063', 17, NULL, NULL, 0.00, 20000.00, 150000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (35, '2026-07-03 00:50:09', 34, N'Pending', N'COD', N'Unpaid', N'116 Cầu Giấy, Quận Cầu Giấy, Hà Nội', N'0924166464', 17, NULL, NULL, 10000.00, 30000.00, 590000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (36, '2026-07-03 04:16:45', 29, N'Completed', N'COD', N'Paid', N'77 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', N'0940335752', 17, '2026-07-03 07:05:40', '2026-07-03 08:55:59', 0.00, 30000.00, 210000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (37, '2026-07-03 08:00:03', 73, N'Delivered', N'VNPAY', N'Paid', N'168 Cầu Giấy, Quận Cầu Giấy, Hà Nội', N'0987948020', 17, '2026-07-03 10:38:23', '2026-07-03 12:02:28', 0.00, 30000.00, 630000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (38, '2026-07-03 11:05:53', 62, N'Cancelled', N'VNPAY', N'Refunded', N'75 Đại Cồ Việt, Quận Hai Bà Trưng, Hà Nội', N'0980337539', 17, NULL, NULL, 0.00, 30000.00, 84000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (39, '2026-07-03 13:50:40', 47, N'Cancelled', N'COD', N'Refunded', N'329 Trường Chinh, Quận Tân Bình, TP. Hồ Chí Minh', N'0974231272', 17, NULL, NULL, 0.00, 20000.00, 305000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (40, '2026-07-03 16:50:42', 54, N'Completed', N'COD', N'Paid', N'393 Nguyễn Văn Cừ, Quận Long Biên, Hà Nội', N'0994612439', 17, '2026-07-03 19:16:25', '2026-07-03 21:11:25', 15000.00, 20000.00, 227000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (41, '2026-07-03 20:04:21', 70, N'Completed', N'Bank Transfer', N'Paid', N'372 Lê Văn Sỹ, Quận 3, TP. Hồ Chí Minh', N'0981551653', 17, '2026-07-03 21:47:33', '2026-07-03 23:44:45', 30000.00, 20000.00, 62000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (42, '2026-07-03 23:41:10', 31, N'Completed', N'Momo', N'Paid', N'419 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', N'0953167592', 17, '2026-07-04 01:47:43', '2026-07-04 03:46:58', 0.00, 30000.00, 465000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (43, '2026-07-04 02:57:39', 44, N'Delivered', N'Momo', N'Paid', N'44 Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh', N'0948987373', 17, '2026-07-04 04:46:02', '2026-07-04 06:45:40', 0.00, 30000.00, 698000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (44, '2026-07-04 06:08:00', 41, N'Delivered', N'VNPAY', N'Paid', N'302 Giải Phóng, Quận Hoàng Mai, Hà Nội', N'0992990913', 17, '2026-07-04 07:46:08', '2026-07-04 09:15:19', 0.00, 30000.00, 460000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (45, '2026-07-04 09:02:09', 58, N'Delivered', N'Bank Transfer', N'Paid', N'76 Cầu Giấy, Quận Cầu Giấy, Hà Nội', N'0968098489', 17, '2026-07-04 10:05:04', '2026-07-04 11:12:15', 0.00, 30000.00, 485000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (46, '2026-07-04 12:49:47', 61, N'Completed', N'COD', N'Paid', N'71 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', N'0993491477', 17, '2026-07-04 16:20:48', '2026-07-04 18:17:31', 10000.00, 30000.00, 155000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (47, '2026-07-04 15:50:55', 28, N'Shipping', N'Bank Transfer', N'Unpaid', N'355 Đỗ Xuân Hợp, Thành phố Thủ Đức, TP. Hồ Chí Minh', N'0943375178', 17, '2026-07-04 17:39:46', NULL, 0.00, 25000.00, 685000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (48, '2026-07-04 19:17:27', 20, N'Delivered', N'COD', N'Paid', N'174 Giải Phóng, Quận Hoàng Mai, Hà Nội', N'0935508368', 17, '2026-07-04 22:40:48', '2026-07-04 23:47:12', 0.00, 20000.00, 245000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (49, '2026-07-04 22:11:14', 19, N'Delivered', N'COD', N'Paid', N'84 Trường Chinh, Quận Tân Bình, TP. Hồ Chí Minh', N'0989048300', 17, '2026-07-05 01:09:01', '2026-07-05 02:29:39', 10000.00, 25000.00, 215000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (50, '2026-07-05 00:56:53', 46, N'Pending', N'COD', N'Unpaid', N'370 Nguyễn Văn Cừ, Quận Long Biên, Hà Nội', N'0915753635', 17, NULL, NULL, 0.00, 30000.00, 760000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (51, '2026-07-05 04:19:08', 59, N'Delivered', N'VNPAY', N'Paid', N'139 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', N'0958055996', 17, '2026-07-05 06:40:56', '2026-07-05 08:21:45', 10000.00, 20000.00, 415000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (52, '2026-07-05 07:12:51', 55, N'Shipping', N'Momo', N'Unpaid', N'370 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh', N'0946876036', 17, '2026-07-05 09:50:18', NULL, 20000.00, 30000.00, 325000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (53, '2026-07-05 10:52:47', 27, N'Completed', N'COD', N'Paid', N'65 Cộng Hòa, Quận Tân Bình, TP. Hồ Chí Minh', N'0921839592', 17, '2026-07-05 14:03:28', '2026-07-05 15:34:52', 20000.00, 20000.00, 340000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (54, '2026-07-05 13:47:19', 20, N'Shipping', N'Bank Transfer', N'Unpaid', N'174 Giải Phóng, Quận Hoàng Mai, Hà Nội', N'0935508368', 17, '2026-07-05 17:45:17', NULL, 20000.00, 25000.00, 265000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (55, '2026-07-05 17:31:05', 54, N'Delivered', N'Bank Transfer', N'Paid', N'393 Nguyễn Văn Cừ, Quận Long Biên, Hà Nội', N'0994612439', 17, '2026-07-05 19:48:07', '2026-07-05 21:17:33', 0.00, 25000.00, 180000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (56, '2026-07-05 20:09:13', 49, N'Completed', N'Bank Transfer', N'Paid', N'290 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', N'0943027319', 17, '2026-07-05 23:09:09', '2026-07-06 00:29:13', 0.00, 25000.00, 630000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (57, '2026-07-05 23:50:50', 26, N'Pending', N'COD', N'Unpaid', N'112 Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh', N'0988765596', 17, NULL, NULL, 20000.00, 25000.00, 1070000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (58, '2026-07-06 03:05:17', 51, N'Delivered', N'COD', N'Paid', N'81 Phạm Văn Đồng, Quận Bắc Từ Liêm, Hà Nội', N'0920299584', 17, '2026-07-06 04:42:41', '2026-07-06 06:04:03', 0.00, 20000.00, 200000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (59, '2026-07-06 06:08:14', 65, N'Cancelled', N'Momo', N'Refunded', N'251 Cách Mạng Tháng 8, Quận 10, TP. Hồ Chí Minh', N'0951205360', 17, NULL, NULL, 0.00, 30000.00, 315000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (60, '2026-07-06 08:53:39', 41, N'Completed', N'COD', N'Paid', N'302 Giải Phóng, Quận Hoàng Mai, Hà Nội', N'0992990913', 17, '2026-07-06 11:26:00', '2026-07-06 12:39:21', 0.00, 20000.00, 460000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (61, '2026-07-06 12:13:32', 8, N'Delivered', N'VNPAY', N'Paid', N'123 Nguyễn Văn Cừ, Quận 5, TP. HCM', N'0999999999', 17, '2026-07-06 14:27:03', '2026-07-06 15:37:41', 0.00, 20000.00, 460000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (62, '2026-07-06 15:27:28', 52, N'Delivered', N'COD', N'Paid', N'241 Nguyễn Văn Cừ, Quận Long Biên, Hà Nội', N'0917233473', 17, '2026-07-06 17:56:51', '2026-07-06 19:56:44', 30000.00, 20000.00, 835000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (63, '2026-07-06 18:38:35', 73, N'Delivered', N'Momo', N'Paid', N'168 Cầu Giấy, Quận Cầu Giấy, Hà Nội', N'0987948020', 17, '2026-07-06 21:29:39', '2026-07-06 23:09:04', 15000.00, 20000.00, 1745000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (64, '2026-07-06 21:54:54', 72, N'Completed', N'Bank Transfer', N'Paid', N'243 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh', N'0989573530', 17, '2026-07-06 23:49:37', '2026-07-07 01:01:52', 0.00, 25000.00, 291000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (65, '2026-07-07 00:53:43', 29, N'Shipping', N'Momo', N'Unpaid', N'77 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', N'0940335752', 17, '2026-07-07 02:05:36', NULL, 0.00, 20000.00, 545000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (66, '2026-07-07 04:18:46', 55, N'Delivered', N'Bank Transfer', N'Paid', N'370 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh', N'0946876036', 17, '2026-07-07 06:07:51', '2026-07-07 07:46:08', 20000.00, 20000.00, 276000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (67, '2026-07-07 08:15:33', 71, N'Completed', N'COD', N'Paid', N'172 Tây Sơn, Quận Đống Đa, Hà Nội', N'0961109648', 17, '2026-07-07 11:33:46', '2026-07-07 13:09:14', 0.00, 30000.00, 228000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (68, '2026-07-07 11:01:49', 63, N'Cancelled', N'Bank Transfer', N'Refunded', N'47 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', N'0993406735', 17, NULL, NULL, 0.00, 30000.00, 105000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (69, '2026-07-07 14:01:54', 22, N'Cancelled', N'Momo', N'Refunded', N'42 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', N'0964930787', 17, NULL, NULL, 0.00, 25000.00, 120000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (70, '2026-07-07 17:09:26', 45, N'Completed', N'VNPAY', N'Paid', N'404 Tây Sơn, Quận Đống Đa, Hà Nội', N'0930282332', 17, '2026-07-07 19:43:03', '2026-07-07 20:48:21', 15000.00, 20000.00, 205000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (71, '2026-07-07 20:37:14', 58, N'Completed', N'COD', N'Paid', N'76 Cầu Giấy, Quận Cầu Giấy, Hà Nội', N'0968098489', 17, '2026-07-07 23:51:37', '2026-07-08 01:38:22', 20000.00, 30000.00, 795000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (72, '2026-07-07 23:23:05', 8, N'Delivered', N'VNPAY', N'Paid', N'123 Nguyễn Văn Cừ, Quận 5, TP. HCM', N'0999999999', 17, '2026-07-08 03:07:27', '2026-07-08 05:07:06', 10000.00, 20000.00, 2446000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (73, '2026-07-08 03:30:39', 33, N'Completed', N'VNPAY', N'Paid', N'353 Giải Phóng, Quận Hoàng Mai, Hà Nội', N'0989636713', 17, '2026-07-08 07:26:02', '2026-07-08 09:10:07', 0.00, 20000.00, 225000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (74, '2026-07-08 06:41:38', 64, N'Delivered', N'Momo', N'Paid', N'293 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', N'0996326320', 17, '2026-07-08 10:31:53', '2026-07-08 11:34:44', 0.00, 30000.00, 660000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (75, '2026-07-08 09:55:46', 56, N'Completed', N'COD', N'Paid', N'41 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', N'0974890830', 17, '2026-07-08 13:49:04', '2026-07-08 15:01:18', 0.00, 25000.00, 2320000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (76, '2026-07-08 12:56:27', 23, N'Completed', N'VNPAY', N'Paid', N'190 Hoàng Văn Thụ, Quận Phú Nhuận, TP. Hồ Chí Minh', N'0944896016', 17, '2026-07-08 16:06:07', '2026-07-08 17:32:22', 0.00, 25000.00, 915000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (77, '2026-07-08 15:55:34', 46, N'Delivered', N'COD', N'Paid', N'370 Nguyễn Văn Cừ, Quận Long Biên, Hà Nội', N'0915753635', 17, '2026-07-08 18:38:44', '2026-07-08 20:07:24', 0.00, 25000.00, 405000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (78, '2026-07-08 18:34:07', 63, N'Pending', N'Momo', N'Unpaid', N'47 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', N'0993406735', 17, NULL, NULL, 15000.00, 25000.00, 2330000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (79, '2026-07-08 22:34:43', 34, N'Shipping', N'Bank Transfer', N'Unpaid', N'116 Cầu Giấy, Quận Cầu Giấy, Hà Nội', N'0924166464', 17, '2026-07-09 01:10:23', NULL, 0.00, 30000.00, 1982000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (80, '2026-07-09 01:25:11', 37, N'Completed', N'VNPAY', N'Paid', N'400 Trường Chinh, Quận Tân Bình, TP. Hồ Chí Minh', N'0912414341', 17, '2026-07-09 04:41:20', '2026-07-09 06:30:38', 30000.00, 20000.00, 1240000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (81, '2026-07-09 04:43:09', 28, N'Delivered', N'VNPAY', N'Paid', N'355 Đỗ Xuân Hợp, Thành phố Thủ Đức, TP. Hồ Chí Minh', N'0943375178', 17, '2026-07-09 06:44:22', '2026-07-09 07:57:53', 15000.00, 30000.00, 1042000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (82, '2026-07-09 08:06:34', 58, N'Delivered', N'VNPAY', N'Paid', N'76 Cầu Giấy, Quận Cầu Giấy, Hà Nội', N'0968098489', 17, '2026-07-09 11:33:53', '2026-07-09 13:20:52', 15000.00, 25000.00, 585000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (83, '2026-07-09 10:58:09', 37, N'Delivered', N'VNPAY', N'Paid', N'400 Trường Chinh, Quận Tân Bình, TP. Hồ Chí Minh', N'0912414341', 17, '2026-07-09 14:56:32', '2026-07-09 16:47:15', 0.00, 30000.00, 632000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (84, '2026-07-09 14:03:30', 36, N'Shipping', N'Momo', N'Unpaid', N'333 Hoàng Văn Thụ, Quận Phú Nhuận, TP. Hồ Chí Minh', N'0992055812', 17, '2026-07-09 17:03:13', NULL, 0.00, 20000.00, 817000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (85, '2026-07-09 17:20:46', 45, N'Delivered', N'Bank Transfer', N'Paid', N'404 Tây Sơn, Quận Đống Đa, Hà Nội', N'0930282332', 17, '2026-07-09 19:37:39', '2026-07-09 21:24:55', 0.00, 30000.00, 170000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (86, '2026-07-09 20:51:13', 74, N'Pending', N'Momo', N'Unpaid', N'129 Cách Mạng Tháng 8, Quận 10, TP. Hồ Chí Minh', N'0967416454', 17, NULL, NULL, 30000.00, 30000.00, 565000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (87, '2026-07-10 00:18:42', 45, N'Delivered', N'COD', N'Paid', N'404 Tây Sơn, Quận Đống Đa, Hà Nội', N'0930282332', 17, '2026-07-10 02:34:31', '2026-07-10 04:07:03', 0.00, 25000.00, 136000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (88, '2026-07-10 03:14:16', 76, N'Completed', N'COD', N'Paid', N'415 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', N'0969373262', 17, '2026-07-10 06:34:53', '2026-07-10 07:57:45', 15000.00, 30000.00, 470000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (89, '2026-07-10 05:55:55', 67, N'Completed', N'COD', N'Paid', N'133 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', N'0931088639', 17, '2026-07-10 07:10:57', '2026-07-10 08:36:52', 15000.00, 25000.00, 82000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (90, '2026-07-10 09:56:00', 56, N'Delivered', N'Momo', N'Paid', N'41 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', N'0974890830', 17, '2026-07-10 13:41:25', '2026-07-10 14:59:24', 30000.00, 20000.00, 260000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (91, '2026-07-10 12:59:43', 24, N'Completed', N'Momo', N'Paid', N'56 Kim Mã, Quận Ba Đình, Hà Nội', N'0914663645', 17, '2026-07-10 16:47:15', '2026-07-10 18:43:16', 20000.00, 20000.00, 550000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (92, '2026-07-10 15:36:17', 26, N'Cancelled', N'VNPAY', N'Refunded', N'112 Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh', N'0988765596', 17, NULL, NULL, 0.00, 30000.00, 600000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (93, '2026-07-10 19:28:19', 13, N'Completed', N'Momo', N'Paid', N'123 Nguyễn Văn Cừ, Quận 5, TP. HCM', N'0999999999', 17, '2026-07-10 21:58:35', '2026-07-10 23:31:44', 15000.00, 25000.00, 170000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (94, '2026-07-10 21:54:07', 8, N'Cancelled', N'VNPAY', N'Refunded', N'123 Nguyễn Văn Cừ, Quận 5, TP. HCM', N'0999999999', 17, NULL, NULL, 15000.00, 25000.00, 1300000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (95, '2026-07-11 01:32:02', 44, N'Shipping', N'Momo', N'Unpaid', N'44 Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh', N'0948987373', 17, '2026-07-11 03:17:15', NULL, 10000.00, 20000.00, 970000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (96, '2026-07-11 05:17:46', 20, N'Shipping', N'Momo', N'Unpaid', N'174 Giải Phóng, Quận Hoàng Mai, Hà Nội', N'0935508368', 17, '2026-07-11 06:25:36', NULL, 0.00, 30000.00, 440000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (97, '2026-07-11 07:33:18', 44, N'Delivered', N'Momo', N'Paid', N'44 Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh', N'0948987373', 17, '2026-07-11 09:47:06', '2026-07-11 11:01:43', 0.00, 20000.00, 610000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (98, '2026-07-11 11:02:38', 48, N'Delivered', N'COD', N'Paid', N'345 Cộng Hòa, Quận Tân Bình, TP. Hồ Chí Minh', N'0926192013', 17, '2026-07-11 14:22:40', '2026-07-11 15:26:20', 0.00, 25000.00, 2345000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (99, '2026-07-11 14:42:07', 36, N'Completed', N'Bank Transfer', N'Paid', N'333 Hoàng Văn Thụ, Quận Phú Nhuận, TP. Hồ Chí Minh', N'0992055812', 17, '2026-07-11 16:28:57', '2026-07-11 18:15:28', 0.00, 30000.00, 670000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (100, '2026-07-11 17:18:09', 40, N'Completed', N'Bank Transfer', N'Paid', N'300 Cầu Giấy, Quận Cầu Giấy, Hà Nội', N'0924499254', 17, '2026-07-11 20:13:03', '2026-07-11 21:42:13', 0.00, 30000.00, 300000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (101, '2026-07-11 21:02:12', 28, N'Delivered', N'Bank Transfer', N'Paid', N'355 Đỗ Xuân Hợp, Thành phố Thủ Đức, TP. Hồ Chí Minh', N'0943375178', 17, '2026-07-11 23:09:07', '2026-07-12 01:07:58', 15000.00, 30000.00, 730000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (102, '2026-07-11 23:54:34', 74, N'Delivered', N'COD', N'Paid', N'129 Cách Mạng Tháng 8, Quận 10, TP. Hồ Chí Minh', N'0967416454', 17, '2026-07-12 02:19:12', '2026-07-12 03:50:59', 0.00, 25000.00, 297000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (103, '2026-07-12 02:59:24', 56, N'Completed', N'VNPAY', N'Paid', N'41 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', N'0974890830', 17, '2026-07-12 04:33:16', '2026-07-12 05:41:34', 0.00, 20000.00, 120000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (104, '2026-07-12 06:43:57', 58, N'Shipping', N'COD', N'Unpaid', N'76 Cầu Giấy, Quận Cầu Giấy, Hà Nội', N'0968098489', 17, '2026-07-12 10:11:45', NULL, 15000.00, 20000.00, 100000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (105, '2026-07-12 10:09:19', 31, N'Delivered', N'VNPAY', N'Paid', N'419 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', N'0953167592', 17, '2026-07-12 13:11:43', '2026-07-12 14:56:32', 0.00, 25000.00, 1225000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (106, '2026-07-12 13:08:10', 29, N'Delivered', N'VNPAY', N'Paid', N'77 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', N'0940335752', 17, '2026-07-12 16:58:08', '2026-07-12 18:12:56', 0.00, 25000.00, 305000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (107, '2026-07-12 15:54:17', 63, N'Delivered', N'Bank Transfer', N'Paid', N'47 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', N'0993406735', 17, '2026-07-12 18:23:33', '2026-07-12 20:04:23', 0.00, 30000.00, 125000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (108, '2026-07-12 19:32:14', 26, N'Cancelled', N'Momo', N'Refunded', N'112 Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh', N'0988765596', 17, NULL, NULL, 30000.00, 30000.00, 555000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (109, '2026-07-12 22:19:47', 30, N'Shipping', N'Bank Transfer', N'Unpaid', N'139 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh', N'0992726184', 17, '2026-07-13 02:19:26', NULL, 30000.00, 25000.00, 205000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (110, '2026-07-13 01:36:47', 74, N'Pending', N'Momo', N'Unpaid', N'129 Cách Mạng Tháng 8, Quận 10, TP. Hồ Chí Minh', N'0967416454', 17, NULL, NULL, 0.00, 20000.00, 354000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (111, '2026-07-13 05:15:16', 25, N'Completed', N'COD', N'Paid', N'409 Kim Mã, Quận Ba Đình, Hà Nội', N'0915443219', 17, '2026-07-13 06:30:30', '2026-07-13 07:32:59', 0.00, 20000.00, 815000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (112, '2026-07-13 07:49:58', 61, N'Delivered', N'VNPAY', N'Paid', N'71 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', N'0993491477', 17, '2026-07-13 11:31:38', '2026-07-13 13:16:27', 0.00, 30000.00, 162000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (113, '2026-07-13 10:56:03', 55, N'Delivered', N'Bank Transfer', N'Paid', N'370 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh', N'0946876036', 17, '2026-07-13 13:25:59', '2026-07-13 15:22:09', 0.00, 30000.00, 2030000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (114, '2026-07-13 14:49:18', 75, N'Delivered', N'COD', N'Paid', N'166 Giải Phóng, Quận Hoàng Mai, Hà Nội', N'0965207717', 17, '2026-07-13 16:55:49', '2026-07-13 18:22:20', 0.00, 30000.00, 790000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (115, '2026-07-13 17:17:30', 38, N'Shipping', N'Momo', N'Unpaid', N'202 Giải Phóng, Quận Hoàng Mai, Hà Nội', N'0968334152', 17, '2026-07-13 18:44:07', NULL, 20000.00, 30000.00, 200000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (116, '2026-07-13 20:48:26', 35, N'Completed', N'Bank Transfer', N'Paid', N'412 Cầu Giấy, Quận Cầu Giấy, Hà Nội', N'0911568802', 17, '2026-07-14 00:14:44', '2026-07-14 01:48:23', 20000.00, 20000.00, 485000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (117, '2026-07-14 00:20:47', 34, N'Delivered', N'Momo', N'Paid', N'116 Cầu Giấy, Quận Cầu Giấy, Hà Nội', N'0924166464', 17, '2026-07-14 02:25:56', '2026-07-14 03:48:28', 30000.00, 20000.00, 425000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (118, '2026-07-14 02:58:24', 66, N'Completed', N'Momo', N'Paid', N'95 Hoàng Văn Thụ, Quận Phú Nhuận, TP. Hồ Chí Minh', N'0969756580', 17, '2026-07-14 05:52:17', '2026-07-14 07:37:59', 30000.00, 25000.00, 295000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (119, '2026-07-14 06:23:44', 77, N'Cancelled', N'COD', N'Refunded', N'86 Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh', N'0961456391', 17, NULL, NULL, 0.00, 25000.00, 2965000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (120, '2026-07-14 09:23:13', 68, N'Delivered', N'Momo', N'Paid', N'11 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', N'0984724597', 17, '2026-07-14 11:22:55', '2026-07-14 12:58:43', 30000.00, 20000.00, 282000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (121, '2026-07-14 13:16:43', 27, N'Completed', N'COD', N'Paid', N'65 Cộng Hòa, Quận Tân Bình, TP. Hồ Chí Minh', N'0921839592', 17, '2026-07-14 15:23:46', '2026-07-14 17:15:54', 0.00, 30000.00, 944000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (122, '2026-07-14 16:03:30', 70, N'Shipping', N'Bank Transfer', N'Unpaid', N'372 Lê Văn Sỹ, Quận 3, TP. Hồ Chí Minh', N'0981551653', 17, '2026-07-14 18:58:45', NULL, 0.00, 25000.00, 215000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (123, '2026-07-14 19:43:47', 61, N'Delivered', N'COD', N'Paid', N'71 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', N'0993491477', 17, '2026-07-14 21:41:06', '2026-07-14 22:52:35', 15000.00, 25000.00, 115000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (124, '2026-07-14 22:50:55', 63, N'Shipping', N'Momo', N'Unpaid', N'47 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', N'0993406735', 17, '2026-07-15 00:05:36', NULL, 20000.00, 30000.00, 350000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (125, '2026-07-15 01:38:33', 52, N'Completed', N'Momo', N'Paid', N'241 Nguyễn Văn Cừ, Quận Long Biên, Hà Nội', N'0917233473', 17, '2026-07-15 04:30:21', '2026-07-15 05:58:47', 0.00, 25000.00, 430000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (126, '2026-07-15 04:36:25', 19, N'Completed', N'Bank Transfer', N'Paid', N'84 Trường Chinh, Quận Tân Bình, TP. Hồ Chí Minh', N'0989048300', 17, '2026-07-15 06:42:21', '2026-07-15 08:14:07', 0.00, 20000.00, 290000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (127, '2026-07-15 08:22:02', 64, N'Pending', N'VNPAY', N'Unpaid', N'293 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', N'0996326320', 17, NULL, NULL, 20000.00, 25000.00, 385000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (128, '2026-07-15 11:42:19', 45, N'Pending', N'Bank Transfer', N'Unpaid', N'404 Tây Sơn, Quận Đống Đa, Hà Nội', N'0930282332', 17, NULL, NULL, 0.00, 30000.00, 1465000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (129, '2026-07-15 14:54:12', 60, N'Completed', N'Momo', N'Paid', N'162 Đỗ Xuân Hợp, Thành phố Thủ Đức, TP. Hồ Chí Minh', N'0926950264', 17, '2026-07-15 17:12:43', '2026-07-15 18:28:37', 0.00, 30000.00, 465000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (130, '2026-07-15 17:28:50', 63, N'Delivered', N'Bank Transfer', N'Paid', N'47 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', N'0993406735', 17, '2026-07-15 20:11:20', '2026-07-15 21:17:00', 0.00, 20000.00, 875000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (131, '2026-07-15 21:02:26', 39, N'Cancelled', N'VNPAY', N'Refunded', N'326 Kim Mã, Quận Ba Đình, Hà Nội', N'0942565355', 17, NULL, NULL, 0.00, 20000.00, 1975000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (132, '2026-07-16 00:23:43', 56, N'Shipping', N'VNPAY', N'Unpaid', N'41 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', N'0974890830', 17, '2026-07-16 02:16:46', NULL, 20000.00, 30000.00, 220000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (133, '2026-07-16 03:44:49', 8, N'Delivered', N'Momo', N'Paid', N'123 Nguyễn Văn Cừ, Quận 5, TP. HCM', N'0999999999', 17, '2026-07-16 06:59:51', '2026-07-16 08:06:20', 15000.00, 30000.00, 410000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (134, '2026-07-16 06:56:47', 42, N'Delivered', N'COD', N'Paid', N'24 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh', N'0912334063', 17, '2026-07-16 09:08:29', '2026-07-16 10:43:33', 20000.00, 30000.00, 480000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (135, '2026-07-16 10:06:51', 8, N'Pending', N'COD', N'Unpaid', N'123 Nguyễn Văn Cừ, Quận 5, TP. HCM', N'0999999999', 17, NULL, NULL, 20000.00, 25000.00, 1465000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (136, '2026-07-16 12:45:06', 75, N'Completed', N'COD', N'Paid', N'166 Giải Phóng, Quận Hoàng Mai, Hà Nội', N'0965207717', 17, '2026-07-16 15:11:24', '2026-07-16 17:06:41', 10000.00, 30000.00, 743000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (137, '2026-07-16 16:30:35', 50, N'Completed', N'VNPAY', N'Paid', N'191 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', N'0955722703', 17, '2026-07-16 19:30:45', '2026-07-16 20:57:06', 0.00, 30000.00, 690000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (138, '2026-07-16 19:58:40', 76, N'Delivered', N'Momo', N'Paid', N'415 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', N'0969373262', 17, '2026-07-16 21:33:01', '2026-07-16 22:33:53', 10000.00, 30000.00, 395000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (139, '2026-07-16 23:02:51', 18, N'Completed', N'Bank Transfer', N'Paid', N'123 Nguyễn Văn Cừ, Quận 5, TP. HCM', N'0999999999', 17, '2026-07-17 01:54:09', '2026-07-17 03:31:10', 10000.00, 25000.00, 1065000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (140, '2026-07-17 01:39:48', 38, N'Shipping', N'Bank Transfer', N'Unpaid', N'202 Giải Phóng, Quận Hoàng Mai, Hà Nội', N'0968334152', 17, '2026-07-17 03:42:20', NULL, 0.00, 20000.00, 1140000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (141, '2026-07-17 05:37:20', 51, N'Cancelled', N'Momo', N'Refunded', N'81 Phạm Văn Đồng, Quận Bắc Từ Liêm, Hà Nội', N'0920299584', 17, NULL, NULL, 0.00, 25000.00, 232000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (142, '2026-07-17 08:35:49', 69, N'Cancelled', N'Momo', N'Refunded', N'247 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', N'0913041374', 17, NULL, NULL, 0.00, 20000.00, 45000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (143, '2026-07-17 11:46:34', 47, N'Pending', N'VNPAY', N'Unpaid', N'329 Trường Chinh, Quận Tân Bình, TP. Hồ Chí Minh', N'0974231272', 17, NULL, NULL, 30000.00, 20000.00, 840000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (144, '2026-07-17 14:52:34', 29, N'Pending', N'Bank Transfer', N'Unpaid', N'77 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', N'0940335752', 17, NULL, NULL, 0.00, 20000.00, 394000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (145, '2026-07-17 17:35:05', 64, N'Delivered', N'Bank Transfer', N'Paid', N'293 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', N'0996326320', 17, '2026-07-17 18:39:15', '2026-07-17 20:32:34', 30000.00, 25000.00, 571000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (146, '2026-07-17 21:05:44', 78, N'Completed', N'Bank Transfer', N'Paid', N'210 Tây Sơn, Quận Đống Đa, Hà Nội', N'0920078778', 17, '2026-07-17 22:44:08', '2026-07-18 00:35:26', 10000.00, 25000.00, 495000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (147, '2026-07-18 00:08:08', 60, N'Completed', N'Bank Transfer', N'Paid', N'162 Đỗ Xuân Hợp, Thành phố Thủ Đức, TP. Hồ Chí Minh', N'0926950264', 17, '2026-07-18 01:29:09', '2026-07-18 03:07:14', 0.00, 25000.00, 115000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (148, '2026-07-18 03:38:27', 65, N'Delivered', N'Bank Transfer', N'Paid', N'251 Cách Mạng Tháng 8, Quận 10, TP. Hồ Chí Minh', N'0951205360', 17, '2026-07-18 05:17:40', '2026-07-18 06:59:03', 15000.00, 30000.00, 150000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (149, '2026-07-18 07:04:01', 69, N'Cancelled', N'Bank Transfer', N'Refunded', N'247 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', N'0913041374', 17, NULL, NULL, 30000.00, 25000.00, 193000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (150, '2026-07-18 10:02:38', 76, N'Delivered', N'Bank Transfer', N'Paid', N'415 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', N'0969373262', 17, '2026-07-18 13:34:27', '2026-07-18 14:35:50', 0.00, 30000.00, 785000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (151, '2026-07-18 13:36:52', 24, N'Cancelled', N'VNPAY', N'Refunded', N'56 Kim Mã, Quận Ba Đình, Hà Nội', N'0914663645', 17, NULL, NULL, 15000.00, 25000.00, 685000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (152, '2026-07-18 16:48:25', 40, N'Delivered', N'VNPAY', N'Paid', N'300 Cầu Giấy, Quận Cầu Giấy, Hà Nội', N'0924499254', 17, '2026-07-18 17:50:34', '2026-07-18 19:38:50', 0.00, 25000.00, 210000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (153, '2026-07-18 19:45:23', 36, N'Completed', N'COD', N'Paid', N'333 Hoàng Văn Thụ, Quận Phú Nhuận, TP. Hồ Chí Minh', N'0992055812', 17, '2026-07-18 23:06:38', '2026-07-19 00:26:33', 15000.00, 30000.00, 885000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (154, '2026-07-18 22:43:14', 8, N'Delivered', N'Bank Transfer', N'Paid', N'123 Nguyễn Văn Cừ, Quận 5, TP. HCM', N'0999999999', 17, '2026-07-19 01:02:07', '2026-07-19 03:00:57', 0.00, 20000.00, 120000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (155, '2026-07-19 02:25:39', 21, N'Completed', N'Bank Transfer', N'Paid', N'296 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', N'0979061779', 17, '2026-07-19 03:39:05', '2026-07-19 05:22:53', 0.00, 25000.00, 75000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (156, '2026-07-19 05:29:37', 38, N'Delivered', N'Momo', N'Paid', N'202 Giải Phóng, Quận Hoàng Mai, Hà Nội', N'0968334152', 17, '2026-07-19 08:42:10', '2026-07-19 10:03:41', 0.00, 20000.00, 155000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (157, '2026-07-19 08:03:04', 26, N'Completed', N'COD', N'Paid', N'112 Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh', N'0988765596', 17, '2026-07-19 10:26:52', '2026-07-19 11:56:16', 0.00, 25000.00, 515000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (158, '2026-07-19 11:49:15', 68, N'Delivered', N'COD', N'Paid', N'11 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', N'0984724597', 17, '2026-07-19 15:32:14', '2026-07-19 16:57:40', 0.00, 30000.00, 1920000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (159, '2026-07-19 15:11:54', 78, N'Delivered', N'Bank Transfer', N'Paid', N'210 Tây Sơn, Quận Đống Đa, Hà Nội', N'0920078778', 17, '2026-07-19 16:32:51', '2026-07-19 18:14:10', 0.00, 30000.00, 309000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (160, '2026-07-19 17:56:14', 71, N'Delivered', N'VNPAY', N'Paid', N'172 Tây Sơn, Quận Đống Đa, Hà Nội', N'0961109648', 17, '2026-07-19 21:06:06', '2026-07-19 22:35:04', 15000.00, 20000.00, 2375000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (161, '2026-07-19 20:58:07', 72, N'Shipping', N'COD', N'Unpaid', N'243 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh', N'0989573530', 17, '2026-07-19 23:50:20', NULL, 30000.00, 30000.00, 440000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (162, '2026-07-20 00:45:42', 35, N'Delivered', N'VNPAY', N'Paid', N'412 Cầu Giấy, Quận Cầu Giấy, Hà Nội', N'0911568802', 17, '2026-07-20 03:51:00', '2026-07-20 05:41:10', 0.00, 20000.00, 945000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (163, '2026-07-20 03:36:50', 18, N'Completed', N'VNPAY', N'Paid', N'123 Nguyễn Văn Cừ, Quận 5, TP. HCM', N'0999999999', 17, '2026-07-20 04:37:03', '2026-07-20 06:19:35', 30000.00, 30000.00, 1235000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (164, '2026-07-20 07:14:31', 71, N'Cancelled', N'Momo', N'Refunded', N'172 Tây Sơn, Quận Đống Đa, Hà Nội', N'0961109648', 17, NULL, NULL, 0.00, 30000.00, 180000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (165, '2026-07-20 10:31:10', 31, N'Shipping', N'Momo', N'Unpaid', N'419 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', N'0953167592', 17, '2026-07-20 12:49:21', NULL, 0.00, 20000.00, 240000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (166, '2026-07-20 13:21:20', 63, N'Completed', N'Momo', N'Paid', N'47 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', N'0993406735', 17, '2026-07-20 16:37:42', '2026-07-20 18:15:14', 0.00, 30000.00, 240000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (167, '2026-07-20 16:57:10', 54, N'Delivered', N'Momo', N'Paid', N'393 Nguyễn Văn Cừ, Quận Long Biên, Hà Nội', N'0994612439', 17, '2026-07-20 18:58:07', '2026-07-20 20:28:41', 0.00, 30000.00, 165000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (168, '2026-07-20 20:00:51', 35, N'Delivered', N'Bank Transfer', N'Paid', N'412 Cầu Giấy, Quận Cầu Giấy, Hà Nội', N'0911568802', 17, '2026-07-20 21:55:16', '2026-07-20 23:04:22', 0.00, 25000.00, 430000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (169, '2026-07-20 22:58:41', 42, N'Delivered', N'COD', N'Paid', N'24 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh', N'0912334063', 17, '2026-07-21 01:21:57', '2026-07-21 03:05:53', 0.00, 20000.00, 160000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (170, '2026-07-21 02:18:21', 20, N'Delivered', N'COD', N'Paid', N'174 Giải Phóng, Quận Hoàng Mai, Hà Nội', N'0935508368', 17, '2026-07-21 03:39:05', '2026-07-21 05:13:38', 0.00, 25000.00, 670000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (171, '2026-07-21 05:31:36', 63, N'Delivered', N'VNPAY', N'Paid', N'47 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', N'0993406735', 17, '2026-07-21 09:26:03', '2026-07-21 10:42:22', 0.00, 30000.00, 1520000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (172, '2026-07-21 08:58:47', 69, N'Shipping', N'COD', N'Unpaid', N'247 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', N'0913041374', 17, '2026-07-21 11:20:57', NULL, 0.00, 20000.00, 290000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (173, '2026-07-21 11:58:25', 73, N'Pending', N'COD', N'Unpaid', N'168 Cầu Giấy, Quận Cầu Giấy, Hà Nội', N'0987948020', 17, NULL, NULL, 0.00, 20000.00, 560000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (174, '2026-07-21 15:28:56', 58, N'Completed', N'VNPAY', N'Paid', N'76 Cầu Giấy, Quận Cầu Giấy, Hà Nội', N'0968098489', 17, '2026-07-21 19:24:10', '2026-07-21 21:04:01', 0.00, 20000.00, 245000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (175, '2026-07-21 18:34:17', 44, N'Pending', N'COD', N'Unpaid', N'44 Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh', N'0948987373', 17, NULL, NULL, 20000.00, 25000.00, 1375000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (176, '2026-07-21 21:28:40', 42, N'Shipping', N'VNPAY', N'Unpaid', N'24 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh', N'0912334063', 17, '2026-07-22 01:04:11', NULL, 0.00, 20000.00, 595000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (177, '2026-07-22 00:58:33', 30, N'Completed', N'Bank Transfer', N'Paid', N'139 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh', N'0992726184', 17, '2026-07-22 03:53:54', '2026-07-22 04:54:36', 20000.00, 20000.00, 75000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (178, '2026-07-22 03:37:09', 27, N'Completed', N'VNPAY', N'Paid', N'65 Cộng Hòa, Quận Tân Bình, TP. Hồ Chí Minh', N'0921839592', 17, '2026-07-22 04:52:52', '2026-07-22 06:27:18', 0.00, 25000.00, 605000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (179, '2026-07-22 07:18:02', 24, N'Delivered', N'Momo', N'Paid', N'56 Kim Mã, Quận Ba Đình, Hà Nội', N'0914663645', 17, '2026-07-22 11:00:50', '2026-07-22 12:17:47', 0.00, 20000.00, 412000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (180, '2026-07-22 10:22:02', 22, N'Delivered', N'COD', N'Paid', N'42 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', N'0964930787', 17, '2026-07-22 14:11:41', '2026-07-22 15:37:50', 0.00, 20000.00, 1920000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (181, '2026-07-22 13:36:46', 68, N'Delivered', N'VNPAY', N'Paid', N'11 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', N'0984724597', 17, '2026-07-22 16:24:28', '2026-07-22 17:36:39', 15000.00, 25000.00, 2585000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (182, '2026-07-22 17:08:52', 45, N'Completed', N'Momo', N'Paid', N'404 Tây Sơn, Quận Đống Đa, Hà Nội', N'0930282332', 17, '2026-07-22 19:47:03', '2026-07-22 21:07:46', 0.00, 20000.00, 760000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (183, '2026-07-22 20:04:12', 18, N'Delivered', N'VNPAY', N'Paid', N'123 Nguyễn Văn Cừ, Quận 5, TP. HCM', N'0999999999', 17, '2026-07-22 22:36:51', '2026-07-23 00:00:23', 10000.00, 25000.00, 845000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (184, '2026-07-22 23:00:16', 64, N'Cancelled', N'Momo', N'Refunded', N'293 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', N'0996326320', 17, NULL, NULL, 15000.00, 20000.00, 950000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (185, '2026-07-23 01:52:23', 45, N'Delivered', N'Momo', N'Paid', N'404 Tây Sơn, Quận Đống Đa, Hà Nội', N'0930282332', 17, '2026-07-23 05:15:13', '2026-07-23 07:01:46', 10000.00, 20000.00, 450000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (186, '2026-07-23 05:09:28', 71, N'Delivered', N'VNPAY', N'Paid', N'172 Tây Sơn, Quận Đống Đa, Hà Nội', N'0961109648', 17, '2026-07-23 06:32:22', '2026-07-23 08:17:31', 0.00, 20000.00, 60000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (187, '2026-07-23 08:47:35', 35, N'Pending', N'COD', N'Unpaid', N'412 Cầu Giấy, Quận Cầu Giấy, Hà Nội', N'0911568802', 17, NULL, NULL, 0.00, 30000.00, 486000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (188, '2026-07-23 11:51:51', 50, N'Delivered', N'Momo', N'Paid', N'191 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', N'0955722703', 17, '2026-07-23 15:10:19', '2026-07-23 16:58:29', 0.00, 30000.00, 1018000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (189, '2026-07-23 14:44:22', 67, N'Shipping', N'Momo', N'Unpaid', N'133 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', N'0931088639', 17, '2026-07-23 17:06:31', NULL, 0.00, 20000.00, 360000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (190, '2026-07-23 18:10:34', 64, N'Completed', N'VNPAY', N'Paid', N'293 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', N'0996326320', 17, '2026-07-23 20:43:20', '2026-07-23 22:19:15', 0.00, 20000.00, 74000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (191, '2026-07-23 21:16:07', 70, N'Delivered', N'Bank Transfer', N'Paid', N'372 Lê Văn Sỹ, Quận 3, TP. Hồ Chí Minh', N'0981551653', 17, '2026-07-23 23:54:10', '2026-07-24 01:41:53', 10000.00, 30000.00, 500000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (192, '2026-07-24 01:12:24', 40, N'Completed', N'VNPAY', N'Paid', N'300 Cầu Giấy, Quận Cầu Giấy, Hà Nội', N'0924499254', 17, '2026-07-24 04:54:56', '2026-07-24 06:23:56', 0.00, 30000.00, 240000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (193, '2026-07-24 04:16:42', 18, N'Cancelled', N'Momo', N'Refunded', N'123 Nguyễn Văn Cừ, Quận 5, TP. HCM', N'0999999999', 17, NULL, NULL, 20000.00, 20000.00, 277000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (194, '2026-07-24 06:55:37', 76, N'Shipping', N'COD', N'Unpaid', N'415 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', N'0969373262', 17, '2026-07-24 08:45:03', NULL, 0.00, 25000.00, 245000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (195, '2026-07-24 09:59:10', 77, N'Shipping', N'VNPAY', N'Unpaid', N'86 Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh', N'0961456391', 17, '2026-07-24 11:19:38', NULL, 0.00, 30000.00, 48000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (196, '2026-07-24 13:27:42', 23, N'Delivered', N'COD', N'Paid', N'190 Hoàng Văn Thụ, Quận Phú Nhuận, TP. Hồ Chí Minh', N'0944896016', 17, '2026-07-24 15:45:24', '2026-07-24 17:08:49', 0.00, 30000.00, 732000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (197, '2026-07-24 16:30:59', 56, N'Completed', N'COD', N'Paid', N'41 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', N'0974890830', 17, '2026-07-24 19:11:42', '2026-07-24 20:38:58', 30000.00, 25000.00, 410000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (198, '2026-07-24 19:55:40', 50, N'Shipping', N'VNPAY', N'Unpaid', N'191 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', N'0955722703', 17, '2026-07-24 22:02:27', NULL, 0.00, 30000.00, 580000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (199, '2026-07-24 23:11:06', 66, N'Completed', N'Bank Transfer', N'Paid', N'95 Hoàng Văn Thụ, Quận Phú Nhuận, TP. Hồ Chí Minh', N'0969756580', 17, '2026-07-25 01:46:32', '2026-07-25 03:18:24', 20000.00, 30000.00, 805000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (200, '2026-07-25 02:29:27', 49, N'Shipping', N'Momo', N'Unpaid', N'290 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', N'0943027319', 17, '2026-07-25 04:59:29', NULL, 0.00, 20000.00, 160000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (201, '2026-07-25 06:00:43', 58, N'Delivered', N'VNPAY', N'Paid', N'76 Cầu Giấy, Quận Cầu Giấy, Hà Nội', N'0968098489', 17, '2026-07-25 09:29:10', '2026-07-25 10:45:06', 0.00, 30000.00, 165000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (202, '2026-07-25 08:59:20', 65, N'Completed', N'Momo', N'Paid', N'251 Cách Mạng Tháng 8, Quận 10, TP. Hồ Chí Minh', N'0951205360', 17, '2026-07-25 12:52:51', '2026-07-25 14:22:59', 0.00, 25000.00, 585000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (203, '2026-07-25 11:42:26', 40, N'Delivered', N'COD', N'Paid', N'300 Cầu Giấy, Quận Cầu Giấy, Hà Nội', N'0924499254', 17, '2026-07-25 14:21:44', '2026-07-25 16:10:50', 0.00, 20000.00, 260000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (204, '2026-07-25 15:22:43', 68, N'Shipping', N'Momo', N'Unpaid', N'11 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', N'0984724597', 17, '2026-07-25 16:27:15', NULL, 0.00, 25000.00, 245000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (205, '2026-07-25 18:51:57', 47, N'Delivered', N'VNPAY', N'Paid', N'329 Trường Chinh, Quận Tân Bình, TP. Hồ Chí Minh', N'0974231272', 17, '2026-07-25 21:46:49', '2026-07-25 22:55:10', 0.00, 20000.00, 65000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (206, '2026-07-25 21:17:53', 62, N'Shipping', N'Momo', N'Unpaid', N'75 Đại Cồ Việt, Quận Hai Bà Trưng, Hà Nội', N'0980337539', 17, '2026-07-25 22:30:11', NULL, 0.00, 20000.00, 360000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (207, '2026-07-26 01:02:28', 36, N'Shipping', N'VNPAY', N'Unpaid', N'333 Hoàng Văn Thụ, Quận Phú Nhuận, TP. Hồ Chí Minh', N'0992055812', 17, '2026-07-26 03:16:50', NULL, 0.00, 30000.00, 215000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (208, '2026-07-26 04:07:44', 28, N'Pending', N'COD', N'Unpaid', N'355 Đỗ Xuân Hợp, Thành phố Thủ Đức, TP. Hồ Chí Minh', N'0943375178', 17, NULL, NULL, 10000.00, 30000.00, 200000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (209, '2026-07-26 07:24:00', 39, N'Delivered', N'Bank Transfer', N'Paid', N'326 Kim Mã, Quận Ba Đình, Hà Nội', N'0942565355', 17, '2026-07-26 10:22:41', '2026-07-26 11:47:42', 0.00, 20000.00, 748000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (210, '2026-07-26 10:11:15', 69, N'Delivered', N'COD', N'Paid', N'247 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', N'0913041374', 17, '2026-07-26 12:43:57', '2026-07-26 14:18:11', 0.00, 25000.00, 575000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (211, '2026-07-26 14:13:20', 57, N'Completed', N'Bank Transfer', N'Paid', N'140 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', N'0987398497', 17, '2026-07-26 16:30:10', '2026-07-26 18:24:58', 20000.00, 20000.00, 880000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (212, '2026-07-26 17:21:30', 32, N'Delivered', N'Bank Transfer', N'Paid', N'83 Cộng Hòa, Quận Tân Bình, TP. Hồ Chí Minh', N'0979821349', 17, '2026-07-26 21:12:29', '2026-07-26 22:48:25', 0.00, 20000.00, 155000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (213, '2026-07-26 20:16:18', 19, N'Completed', N'Momo', N'Paid', N'84 Trường Chinh, Quận Tân Bình, TP. Hồ Chí Minh', N'0989048300', 17, '2026-07-26 23:13:53', '2026-07-27 00:34:31', 10000.00, 25000.00, 250000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (214, '2026-07-26 23:39:49', 77, N'Delivered', N'VNPAY', N'Paid', N'86 Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh', N'0961456391', 17, '2026-07-27 01:22:24', '2026-07-27 02:57:34', 0.00, 25000.00, 469000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (215, '2026-07-27 02:20:29', 32, N'Cancelled', N'Momo', N'Refunded', N'83 Cộng Hòa, Quận Tân Bình, TP. Hồ Chí Minh', N'0979821349', 17, NULL, NULL, 0.00, 25000.00, 620000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (216, '2026-07-27 05:58:18', 52, N'Pending', N'VNPAY', N'Unpaid', N'241 Nguyễn Văn Cừ, Quận Long Biên, Hà Nội', N'0917233473', 17, NULL, NULL, 15000.00, 25000.00, 550000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (217, '2026-07-27 08:41:59', 68, N'Delivered', N'VNPAY', N'Paid', N'11 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', N'0984724597', 17, '2026-07-27 10:11:08', '2026-07-27 12:08:05', 10000.00, 30000.00, 162000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (218, '2026-07-27 11:47:40', 66, N'Delivered', N'Bank Transfer', N'Paid', N'95 Hoàng Văn Thụ, Quận Phú Nhuận, TP. Hồ Chí Minh', N'0969756580', 17, '2026-07-27 13:54:03', '2026-07-27 15:21:00', 20000.00, 25000.00, 628000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (219, '2026-07-27 15:15:55', 60, N'Completed', N'Bank Transfer', N'Paid', N'162 Đỗ Xuân Hợp, Thành phố Thủ Đức, TP. Hồ Chí Minh', N'0926950264', 17, '2026-07-27 18:14:36', '2026-07-27 19:17:38', 0.00, 20000.00, 270000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (220, '2026-07-27 18:07:02', 21, N'Completed', N'VNPAY', N'Paid', N'296 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', N'0979061779', 17, '2026-07-27 20:30:52', '2026-07-27 21:56:48', 0.00, 30000.00, 1190000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (221, '2026-07-27 21:57:36', 77, N'Cancelled', N'VNPAY', N'Refunded', N'86 Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh', N'0961456391', 17, NULL, NULL, 0.00, 30000.00, 179000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (222, '2026-07-28 01:10:36', 52, N'Pending', N'VNPAY', N'Unpaid', N'241 Nguyễn Văn Cừ, Quận Long Biên, Hà Nội', N'0917233473', 17, NULL, NULL, 10000.00, 20000.00, 154000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (223, '2026-07-28 04:21:30', 44, N'Delivered', N'COD', N'Paid', N'44 Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh', N'0948987373', 17, '2026-07-28 07:51:24', '2026-07-28 09:44:18', 0.00, 25000.00, 247000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (224, '2026-07-28 07:01:16', 73, N'Completed', N'VNPAY', N'Paid', N'168 Cầu Giấy, Quận Cầu Giấy, Hà Nội', N'0987948020', 17, '2026-07-28 08:40:00', '2026-07-28 09:50:21', 30000.00, 30000.00, 2760000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (225, '2026-07-28 11:06:48', 63, N'Cancelled', N'VNPAY', N'Refunded', N'47 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', N'0993406735', 17, NULL, NULL, 0.00, 25000.00, 385000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (226, '2026-07-28 14:02:41', 28, N'Pending', N'COD', N'Unpaid', N'355 Đỗ Xuân Hợp, Thành phố Thủ Đức, TP. Hồ Chí Minh', N'0943375178', 17, NULL, NULL, 20000.00, 20000.00, 1200000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (227, '2026-07-28 17:12:32', 73, N'Shipping', N'Momo', N'Unpaid', N'168 Cầu Giấy, Quận Cầu Giấy, Hà Nội', N'0987948020', 17, '2026-07-28 18:22:46', NULL, 10000.00, 30000.00, 230000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (228, '2026-07-28 19:54:05', 36, N'Delivered', N'Bank Transfer', N'Paid', N'333 Hoàng Văn Thụ, Quận Phú Nhuận, TP. Hồ Chí Minh', N'0992055812', 17, '2026-07-28 22:21:25', '2026-07-28 23:44:07', 0.00, 25000.00, 435000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (229, '2026-07-28 23:30:08', 77, N'Pending', N'Bank Transfer', N'Unpaid', N'86 Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh', N'0961456391', 17, NULL, NULL, 10000.00, 20000.00, 306000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (230, '2026-07-29 02:26:50', 73, N'Cancelled', N'Bank Transfer', N'Refunded', N'168 Cầu Giấy, Quận Cầu Giấy, Hà Nội', N'0987948020', 17, NULL, NULL, 0.00, 30000.00, 730000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (231, '2026-07-29 05:52:50', 20, N'Completed', N'Momo', N'Paid', N'174 Giải Phóng, Quận Hoàng Mai, Hà Nội', N'0935508368', 17, '2026-07-29 09:41:19', '2026-07-29 11:12:32', 0.00, 20000.00, 720000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (232, '2026-07-29 09:15:47', 37, N'Completed', N'Bank Transfer', N'Paid', N'400 Trường Chinh, Quận Tân Bình, TP. Hồ Chí Minh', N'0912414341', 17, '2026-07-29 11:28:44', '2026-07-29 12:57:51', 15000.00, 20000.00, 140000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (233, '2026-07-29 12:12:27', 72, N'Delivered', N'VNPAY', N'Paid', N'243 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh', N'0989573530', 17, '2026-07-29 16:04:50', '2026-07-29 17:39:55', 20000.00, 20000.00, 180000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (234, '2026-07-29 15:22:20', 30, N'Delivered', N'VNPAY', N'Paid', N'139 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh', N'0992726184', 17, '2026-07-29 17:23:20', '2026-07-29 18:50:54', 20000.00, 20000.00, 190000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (235, '2026-07-29 18:38:17', 51, N'Completed', N'COD', N'Paid', N'81 Phạm Văn Đồng, Quận Bắc Từ Liêm, Hà Nội', N'0920299584', 17, '2026-07-29 20:46:40', '2026-07-29 21:46:45', 0.00, 30000.00, 610000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (236, '2026-07-29 21:41:06', 67, N'Completed', N'COD', N'Paid', N'133 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', N'0931088639', 17, '2026-07-30 01:19:11', '2026-07-30 03:01:45', 30000.00, 25000.00, 2390000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (237, '2026-07-30 00:58:08', 31, N'Delivered', N'VNPAY', N'Paid', N'419 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', N'0953167592', 17, '2026-07-30 03:42:51', '2026-07-30 05:17:54', 20000.00, 30000.00, 1750000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (238, '2026-07-30 04:21:18', 24, N'Completed', N'Bank Transfer', N'Paid', N'56 Kim Mã, Quận Ba Đình, Hà Nội', N'0914663645', 17, '2026-07-30 05:45:58', '2026-07-30 07:14:50', 30000.00, 30000.00, 148000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (239, '2026-07-30 07:53:39', 64, N'Completed', N'Bank Transfer', N'Paid', N'293 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', N'0996326320', 17, '2026-07-30 11:26:30', '2026-07-30 13:21:38', 10000.00, 20000.00, 1110000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (240, '2026-07-30 10:57:20', 62, N'Delivered', N'Momo', N'Paid', N'75 Đại Cồ Việt, Quận Hai Bà Trưng, Hà Nội', N'0980337539', 17, '2026-07-30 14:29:12', '2026-07-30 16:21:25', 0.00, 25000.00, 79000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (241, '2026-07-30 14:06:37', 76, N'Delivered', N'Momo', N'Paid', N'415 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', N'0969373262', 17, '2026-07-30 16:31:32', '2026-07-30 17:45:55', 10000.00, 30000.00, 585000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (242, '2026-07-30 16:41:25', 45, N'Shipping', N'Bank Transfer', N'Unpaid', N'404 Tây Sơn, Quận Đống Đa, Hà Nội', N'0930282332', 17, '2026-07-30 19:56:33', NULL, 0.00, 25000.00, 789000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (243, '2026-07-30 20:25:52', 49, N'Completed', N'Momo', N'Paid', N'290 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', N'0943027319', 17, '2026-07-30 22:13:11', '2026-07-30 23:52:07', 0.00, 30000.00, 900000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (244, '2026-07-30 23:53:27', 20, N'Delivered', N'VNPAY', N'Paid', N'174 Giải Phóng, Quận Hoàng Mai, Hà Nội', N'0935508368', 17, '2026-07-31 03:03:07', '2026-07-31 04:52:45', 15000.00, 20000.00, 293000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (245, '2026-07-31 02:40:33', 72, N'Cancelled', N'VNPAY', N'Refunded', N'243 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh', N'0989573530', 17, NULL, NULL, 0.00, 30000.00, 710000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (246, '2026-07-31 06:22:28', 8, N'Delivered', N'COD', N'Paid', N'123 Nguyễn Văn Cừ, Quận 5, TP. HCM', N'0999999999', 17, '2026-07-31 08:09:46', '2026-07-31 10:02:46', 0.00, 30000.00, 282000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (247, '2026-07-31 09:23:32', 21, N'Delivered', N'Bank Transfer', N'Paid', N'296 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', N'0979061779', 17, '2026-07-31 11:54:20', '2026-07-31 13:50:16', 0.00, 25000.00, 1225000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (248, '2026-07-31 12:42:17', 30, N'Delivered', N'VNPAY', N'Paid', N'139 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh', N'0992726184', 17, '2026-07-31 14:35:19', '2026-07-31 16:10:46', 0.00, 30000.00, 110000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (249, '2026-07-31 15:50:24', 48, N'Delivered', N'Bank Transfer', N'Paid', N'345 Cộng Hòa, Quận Tân Bình, TP. Hồ Chí Minh', N'0926192013', 17, '2026-07-31 19:05:54', '2026-07-31 20:30:29', 10000.00, 20000.00, 430000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (250, '2026-07-31 19:17:32', 27, N'Delivered', N'VNPAY', N'Paid', N'65 Cộng Hòa, Quận Tân Bình, TP. Hồ Chí Minh', N'0921839592', 17, '2026-07-31 22:11:04', '2026-07-31 23:26:47', 0.00, 20000.00, 1215000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (251, '2026-07-31 21:46:35', 78, N'Delivered', N'Momo', N'Paid', N'210 Tây Sơn, Quận Đống Đa, Hà Nội', N'0920078778', 17, '2026-08-01 00:39:39', '2026-08-01 02:21:50', 30000.00, 20000.00, 480000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (252, '2026-08-01 01:32:18', 24, N'Pending', N'Bank Transfer', N'Unpaid', N'56 Kim Mã, Quận Ba Đình, Hà Nội', N'0914663645', 17, NULL, NULL, 30000.00, 25000.00, 1290000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (253, '2026-08-01 04:09:46', 29, N'Delivered', N'VNPAY', N'Paid', N'77 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', N'0940335752', 17, '2026-08-01 07:43:16', '2026-08-01 09:09:58', 0.00, 20000.00, 442000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (254, '2026-08-01 08:07:40', 43, N'Shipping', N'COD', N'Unpaid', N'396 Cộng Hòa, Quận Tân Bình, TP. Hồ Chí Minh', N'0963047157', 17, '2026-08-01 10:20:09', NULL, 20000.00, 20000.00, 100000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (255, '2026-08-01 10:32:43', 47, N'Delivered', N'COD', N'Paid', N'329 Trường Chinh, Quận Tân Bình, TP. Hồ Chí Minh', N'0974231272', 17, '2026-08-01 13:37:52', '2026-08-01 14:43:26', 0.00, 30000.00, 665000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (256, '2026-08-01 14:15:32', 35, N'Completed', N'Bank Transfer', N'Paid', N'412 Cầu Giấy, Quận Cầu Giấy, Hà Nội', N'0911568802', 17, '2026-08-01 15:47:28', '2026-08-01 17:34:07', 30000.00, 25000.00, 385000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (257, '2026-08-01 16:53:04', 8, N'Delivered', N'VNPAY', N'Paid', N'123 Nguyễn Văn Cừ, Quận 5, TP. HCM', N'0999999999', 17, '2026-08-01 18:24:45', '2026-08-01 19:53:03', 15000.00, 25000.00, 690000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (258, '2026-08-01 20:33:08', 48, N'Delivered', N'Momo', N'Paid', N'345 Cộng Hòa, Quận Tân Bình, TP. Hồ Chí Minh', N'0926192013', 17, '2026-08-02 00:05:41', '2026-08-02 01:13:59', 0.00, 25000.00, 1265000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (259, '2026-08-01 23:23:13', 70, N'Delivered', N'VNPAY', N'Paid', N'372 Lê Văn Sỹ, Quận 3, TP. Hồ Chí Minh', N'0981551653', 17, '2026-08-02 01:01:18', '2026-08-02 02:17:00', 10000.00, 20000.00, 495000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (260, '2026-08-02 03:02:35', 56, N'Pending', N'VNPAY', N'Unpaid', N'41 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', N'0974890830', 17, NULL, NULL, 10000.00, 25000.00, 110000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (261, '2026-08-02 05:58:23', 36, N'Completed', N'VNPAY', N'Paid', N'333 Hoàng Văn Thụ, Quận Phú Nhuận, TP. Hồ Chí Minh', N'0992055812', 17, '2026-08-02 07:38:15', '2026-08-02 09:28:25', 0.00, 30000.00, 510000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (262, '2026-08-02 09:14:28', 66, N'Delivered', N'COD', N'Paid', N'95 Hoàng Văn Thụ, Quận Phú Nhuận, TP. Hồ Chí Minh', N'0969756580', 17, '2026-08-02 12:24:50', '2026-08-02 13:34:14', 0.00, 25000.00, 75000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (263, '2026-08-02 12:41:21', 59, N'Delivered', N'Bank Transfer', N'Paid', N'139 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', N'0958055996', 17, '2026-08-02 14:46:13', '2026-08-02 16:02:18', 30000.00, 30000.00, 250000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (264, '2026-08-02 16:09:05', 57, N'Shipping', N'COD', N'Unpaid', N'140 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', N'0987398497', 17, '2026-08-02 20:07:40', NULL, 30000.00, 30000.00, 656000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (265, '2026-08-02 19:09:41', 33, N'Completed', N'Momo', N'Paid', N'353 Giải Phóng, Quận Hoàng Mai, Hà Nội', N'0989636713', 17, '2026-08-02 22:09:33', '2026-08-02 23:20:56', 0.00, 30000.00, 688000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (266, '2026-08-02 21:41:36', 68, N'Completed', N'COD', N'Paid', N'11 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', N'0984724597', 17, '2026-08-03 00:34:23', '2026-08-03 02:04:15', 0.00, 30000.00, 105000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (267, '2026-08-03 01:33:32', 28, N'Delivered', N'Momo', N'Paid', N'355 Đỗ Xuân Hợp, Thành phố Thủ Đức, TP. Hồ Chí Minh', N'0943375178', 17, '2026-08-03 04:25:28', '2026-08-03 05:27:27', 0.00, 25000.00, 915000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (268, '2026-08-03 04:08:07', 67, N'Delivered', N'Momo', N'Paid', N'133 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', N'0931088639', 17, '2026-08-03 06:29:25', '2026-08-03 08:21:13', 0.00, 25000.00, 660000.00);
INSERT [dbo].[Sale_Order] ([sale_order_id], [order_date], [created_by], [order_status], [payment_method], [payment_status], [shipping_address], [shipping_phone], [shipper_id], [shipped_date], [delivered_date], [discount_amount], [shipping_fee], [total_payment]) VALUES (269, '2026-08-03 07:51:19', 46, N'Completed', N'VNPAY', N'Paid', N'370 Nguyễn Văn Cừ, Quận Long Biên, Hà Nội', N'0915753635', 17, '2026-08-03 09:46:01', '2026-08-03 11:17:41', 30000.00, 25000.00, 175000.00);
SET IDENTITY_INSERT [dbo].[Sale_Order] OFF;
GO

-- CHÈN CHI TIẾT ĐƠN HÀNG SALE_ORDER_ITEM
SET IDENTITY_INSERT [dbo].[Sale_Order_Item] ON;
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (36, 20, 19, 3, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (37, 20, 15, 4, 18000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (38, 21, 21, 4, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (39, 21, 7, 2, 130000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (40, 22, 21, 2, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (41, 23, 3, 3, 25000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (42, 23, 13, 2, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (43, 24, 11, 2, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (44, 25, 7, 2, 130000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (45, 26, 18, 3, 580000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (46, 26, 19, 4, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (47, 26, 22, 1, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (48, 27, 22, 3, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (49, 27, 11, 3, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (50, 28, 3, 1, 25000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (51, 29, 19, 2, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (52, 29, 10, 2, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (53, 30, 20, 4, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (54, 31, 18, 3, 580000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (55, 32, 19, 2, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (56, 32, 1, 2, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (57, 33, 20, 4, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (58, 34, 7, 1, 130000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (59, 35, 10, 4, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (60, 35, 7, 3, 130000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (61, 36, 1, 3, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (62, 37, 1, 1, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (63, 37, 13, 4, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (64, 38, 15, 3, 18000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (65, 39, 16, 3, 95000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (66, 40, 12, 2, 75000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (67, 40, 15, 4, 18000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (68, 41, 15, 4, 18000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (69, 42, 14, 3, 70000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (70, 42, 17, 3, 50000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (71, 42, 3, 3, 25000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (72, 43, 23, 4, 72000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (73, 43, 17, 4, 50000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (74, 43, 21, 4, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (75, 44, 3, 4, 25000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (76, 44, 1, 4, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (77, 44, 10, 2, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (78, 45, 13, 1, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (79, 45, 19, 2, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (80, 46, 21, 3, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (81, 47, 14, 2, 70000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (82, 47, 7, 4, 130000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (83, 48, 12, 3, 75000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (84, 49, 17, 4, 50000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (85, 50, 22, 3, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (86, 50, 14, 1, 70000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (87, 51, 3, 1, 25000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (88, 51, 17, 4, 50000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (89, 51, 1, 3, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (90, 52, 1, 3, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (91, 52, 13, 1, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (92, 53, 4, 4, 40000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (93, 53, 10, 4, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (94, 54, 7, 2, 130000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (95, 55, 7, 1, 130000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (96, 55, 3, 1, 25000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (97, 56, 1, 1, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (98, 56, 19, 2, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (99, 56, 12, 3, 75000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (100, 57, 16, 3, 95000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (101, 57, 12, 4, 75000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (102, 57, 19, 3, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (103, 58, 10, 4, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (104, 59, 16, 3, 95000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (105, 60, 22, 2, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (106, 61, 11, 2, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (107, 62, 13, 3, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (108, 62, 19, 1, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (109, 62, 14, 4, 70000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (110, 63, 18, 3, 580000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (111, 64, 23, 3, 72000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (112, 64, 17, 1, 50000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (113, 65, 20, 3, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (114, 65, 4, 3, 40000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (115, 66, 15, 2, 18000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (116, 66, 1, 4, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (117, 67, 15, 1, 18000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (118, 67, 10, 4, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (119, 68, 3, 3, 25000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (120, 69, 17, 1, 50000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (121, 69, 21, 1, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (122, 70, 17, 4, 50000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (123, 71, 21, 1, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (124, 71, 11, 1, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (125, 71, 7, 4, 130000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (126, 72, 18, 4, 580000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (127, 72, 4, 2, 40000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (128, 72, 15, 2, 18000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (129, 73, 21, 1, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (130, 73, 4, 4, 40000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (131, 74, 21, 2, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (132, 74, 13, 4, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (133, 75, 13, 2, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (134, 75, 16, 3, 95000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (135, 75, 18, 3, 580000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (136, 76, 13, 4, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (137, 76, 12, 4, 75000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (138, 76, 17, 1, 50000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (139, 77, 19, 1, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (140, 77, 4, 4, 40000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (141, 77, 1, 1, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (142, 78, 18, 4, 580000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (143, 79, 18, 3, 580000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (144, 79, 14, 2, 70000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (145, 79, 15, 4, 18000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (146, 80, 13, 4, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (147, 80, 20, 2, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (148, 80, 22, 2, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (149, 81, 3, 3, 25000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (150, 81, 22, 4, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (151, 81, 15, 4, 18000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (152, 82, 10, 3, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (153, 82, 11, 2, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (154, 83, 11, 2, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (155, 83, 15, 4, 18000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (156, 83, 21, 2, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (157, 84, 23, 1, 72000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (158, 84, 11, 2, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (159, 84, 16, 3, 95000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (160, 85, 14, 2, 70000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (161, 86, 13, 2, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (162, 86, 22, 1, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (163, 86, 12, 1, 75000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (164, 87, 3, 3, 25000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (165, 87, 15, 2, 18000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (166, 88, 19, 1, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (167, 88, 12, 3, 75000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (168, 88, 14, 1, 70000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (169, 89, 15, 4, 18000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (170, 90, 20, 2, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (171, 91, 7, 2, 130000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (172, 91, 17, 4, 50000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (173, 91, 21, 2, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (174, 92, 22, 2, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (175, 92, 7, 1, 130000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (176, 93, 1, 1, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (177, 93, 17, 2, 50000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (178, 94, 19, 3, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (179, 94, 11, 3, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (180, 94, 12, 2, 75000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (181, 95, 19, 1, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (182, 95, 11, 1, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (183, 95, 18, 1, 580000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (184, 96, 14, 2, 70000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (185, 96, 13, 2, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (186, 97, 20, 2, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (187, 97, 1, 4, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (188, 97, 4, 2, 40000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (189, 98, 18, 4, 580000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (190, 99, 19, 4, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (191, 100, 14, 1, 70000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (192, 100, 17, 4, 50000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (193, 101, 3, 3, 25000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (194, 101, 19, 4, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (195, 102, 17, 4, 50000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (196, 102, 15, 4, 18000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (197, 103, 17, 2, 50000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (198, 104, 16, 1, 95000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (199, 105, 22, 4, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (200, 105, 17, 4, 50000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (201, 105, 1, 2, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (202, 106, 14, 4, 70000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (203, 107, 16, 1, 95000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (204, 108, 16, 3, 95000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (205, 108, 20, 2, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (206, 109, 17, 1, 50000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (207, 109, 19, 1, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (208, 110, 14, 4, 70000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (209, 110, 15, 3, 18000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (210, 111, 3, 3, 25000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (211, 111, 1, 1, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (212, 111, 22, 3, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (213, 112, 23, 1, 72000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (214, 112, 1, 1, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (215, 113, 18, 3, 580000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (216, 113, 7, 2, 130000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (217, 114, 1, 2, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (218, 114, 19, 4, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (219, 115, 16, 2, 95000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (220, 116, 20, 3, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (221, 116, 4, 2, 40000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (222, 117, 7, 3, 130000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (223, 117, 10, 1, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (224, 118, 12, 4, 75000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (225, 119, 18, 3, 580000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (226, 119, 22, 3, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (227, 119, 20, 4, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (228, 120, 11, 1, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (229, 120, 23, 1, 72000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (230, 121, 15, 3, 18000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (231, 121, 19, 4, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (232, 121, 22, 1, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (233, 122, 16, 2, 95000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (234, 123, 3, 1, 25000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (235, 123, 4, 2, 40000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (236, 124, 19, 1, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (237, 124, 10, 4, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (238, 125, 20, 1, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (239, 125, 11, 1, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (240, 125, 3, 2, 25000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (241, 126, 13, 2, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (242, 127, 16, 4, 95000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (243, 128, 11, 3, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (244, 128, 13, 1, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (245, 128, 19, 4, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (246, 129, 10, 1, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (247, 129, 4, 3, 40000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (248, 129, 13, 2, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (249, 130, 18, 1, 580000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (250, 130, 17, 1, 50000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (251, 130, 12, 3, 75000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (252, 131, 22, 3, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (253, 131, 10, 3, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (254, 131, 18, 2, 580000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (255, 132, 12, 1, 75000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (256, 132, 21, 3, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (257, 133, 7, 2, 130000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (258, 133, 10, 3, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (259, 134, 16, 2, 95000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (260, 134, 22, 1, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (261, 134, 1, 1, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (262, 135, 22, 4, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (263, 135, 17, 4, 50000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (264, 135, 16, 4, 95000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (265, 136, 15, 1, 18000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (266, 136, 19, 3, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (267, 136, 12, 3, 75000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (268, 137, 11, 3, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (269, 138, 16, 1, 95000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (270, 138, 14, 4, 70000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (271, 139, 11, 4, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (272, 139, 3, 2, 25000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (273, 139, 1, 2, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (274, 140, 14, 1, 70000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (275, 140, 7, 3, 130000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (276, 140, 11, 3, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (277, 141, 20, 1, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (278, 141, 23, 1, 72000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (279, 142, 3, 1, 25000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (280, 143, 22, 2, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (281, 143, 17, 4, 50000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (282, 143, 14, 3, 70000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (283, 144, 19, 2, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (284, 144, 15, 3, 18000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (285, 145, 20, 4, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (286, 145, 15, 2, 18000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (287, 146, 19, 3, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (288, 147, 21, 2, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (289, 148, 10, 3, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (290, 149, 15, 1, 18000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (291, 149, 10, 4, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (292, 150, 16, 1, 95000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (293, 150, 1, 2, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (294, 150, 20, 4, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (295, 151, 13, 3, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (296, 151, 20, 2, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (297, 152, 3, 1, 25000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (298, 152, 4, 4, 40000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (299, 153, 22, 2, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (300, 153, 13, 2, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (301, 153, 19, 1, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (302, 154, 3, 4, 25000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (303, 155, 3, 2, 25000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (304, 156, 13, 1, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (305, 157, 13, 2, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (306, 157, 14, 1, 70000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (307, 157, 17, 3, 50000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (308, 158, 17, 3, 50000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (309, 158, 18, 3, 580000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (310, 159, 23, 1, 72000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (311, 159, 15, 4, 18000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (312, 159, 10, 3, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (313, 160, 17, 1, 50000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (314, 160, 18, 4, 580000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (315, 161, 11, 2, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (316, 162, 12, 2, 75000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (317, 162, 13, 1, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (318, 162, 19, 4, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (319, 163, 16, 1, 95000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (320, 163, 22, 4, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (321, 163, 7, 2, 130000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (322, 164, 17, 3, 50000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (323, 165, 22, 1, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (324, 166, 19, 1, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (325, 166, 17, 1, 50000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (326, 167, 21, 3, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (327, 168, 10, 2, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (328, 168, 21, 1, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (329, 168, 13, 2, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (330, 169, 14, 2, 70000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (331, 170, 16, 3, 95000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (332, 170, 13, 2, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (333, 170, 21, 2, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (334, 171, 21, 4, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (335, 171, 18, 2, 580000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (336, 171, 12, 2, 75000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (337, 172, 13, 2, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (338, 173, 13, 4, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (339, 174, 21, 2, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (340, 174, 10, 3, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (341, 175, 22, 1, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (342, 175, 11, 4, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (343, 175, 13, 2, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (344, 176, 22, 1, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (345, 176, 21, 3, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (346, 176, 11, 1, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (347, 177, 3, 3, 25000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (348, 178, 18, 1, 580000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (349, 179, 23, 1, 72000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (350, 179, 17, 1, 50000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (351, 179, 20, 2, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (352, 180, 1, 2, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (353, 180, 18, 3, 580000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (354, 180, 4, 1, 40000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (355, 181, 3, 3, 25000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (356, 181, 21, 4, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (357, 181, 18, 4, 580000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (358, 182, 19, 3, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (359, 182, 7, 2, 130000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (360, 183, 22, 1, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (361, 183, 14, 1, 70000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (362, 183, 20, 4, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (363, 184, 19, 3, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (364, 184, 16, 3, 95000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (365, 184, 10, 4, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (366, 185, 22, 2, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (367, 186, 4, 1, 40000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (368, 187, 23, 3, 72000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (369, 187, 1, 4, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (370, 188, 13, 4, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (371, 188, 23, 4, 72000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (372, 188, 19, 1, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (373, 189, 3, 4, 25000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (374, 189, 1, 4, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (375, 190, 15, 3, 18000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (376, 191, 19, 3, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (377, 192, 12, 1, 75000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (378, 192, 13, 1, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (379, 193, 23, 1, 72000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (380, 193, 10, 1, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (381, 193, 4, 4, 40000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (382, 194, 17, 2, 50000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (383, 194, 1, 2, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (384, 195, 15, 1, 18000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (385, 196, 15, 4, 18000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (386, 196, 17, 1, 50000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (387, 196, 18, 1, 580000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (388, 197, 14, 4, 70000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (389, 197, 21, 3, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (390, 198, 21, 4, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (391, 198, 1, 3, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (392, 198, 16, 2, 95000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (393, 199, 13, 3, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (394, 199, 7, 3, 130000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (395, 200, 14, 2, 70000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (396, 201, 10, 3, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (397, 202, 7, 1, 130000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (398, 202, 17, 1, 50000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (399, 202, 16, 4, 95000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (400, 203, 1, 4, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (401, 204, 11, 1, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (402, 205, 21, 1, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (403, 206, 13, 2, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (404, 206, 14, 1, 70000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (405, 207, 20, 1, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (406, 207, 3, 2, 25000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (407, 208, 1, 3, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (408, 209, 22, 2, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (409, 209, 23, 4, 72000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (410, 210, 12, 4, 75000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (411, 210, 1, 1, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (412, 210, 16, 2, 95000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (413, 211, 11, 4, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (414, 212, 20, 1, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (415, 213, 3, 4, 25000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (416, 213, 10, 3, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (417, 214, 7, 3, 130000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (418, 214, 15, 3, 18000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (419, 215, 20, 1, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (420, 215, 1, 4, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (421, 215, 22, 1, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (422, 216, 20, 3, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (423, 216, 10, 3, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (424, 217, 15, 4, 18000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (425, 217, 14, 1, 70000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (426, 218, 16, 1, 95000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (427, 218, 1, 4, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (428, 218, 23, 4, 72000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (429, 219, 14, 1, 70000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (430, 219, 10, 4, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (431, 220, 18, 2, 580000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (432, 221, 3, 2, 25000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (433, 221, 10, 1, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (434, 221, 15, 3, 18000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (435, 222, 23, 2, 72000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (436, 223, 17, 3, 50000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (437, 223, 15, 4, 18000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (438, 224, 18, 4, 580000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (439, 224, 11, 2, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (440, 225, 12, 4, 75000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (441, 225, 1, 1, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (442, 226, 13, 4, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (443, 226, 21, 4, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (444, 226, 19, 3, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (445, 227, 3, 2, 25000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (446, 227, 4, 4, 40000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (447, 228, 7, 1, 130000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (448, 228, 14, 4, 70000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (449, 229, 7, 2, 130000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (450, 229, 15, 2, 18000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (451, 230, 1, 2, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (452, 230, 18, 1, 580000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (453, 231, 7, 4, 130000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (454, 231, 1, 3, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (455, 232, 3, 2, 25000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (456, 232, 4, 1, 40000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (457, 232, 10, 1, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (458, 233, 10, 4, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (459, 234, 16, 2, 95000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (460, 235, 18, 1, 580000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (461, 236, 18, 4, 580000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (462, 236, 12, 1, 75000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (463, 237, 18, 3, 580000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (464, 238, 7, 1, 130000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (465, 238, 15, 1, 18000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (466, 239, 22, 2, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (467, 239, 11, 3, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (468, 240, 15, 3, 18000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (469, 241, 19, 1, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (470, 241, 13, 3, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (471, 242, 19, 2, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (472, 242, 7, 3, 130000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (473, 242, 15, 3, 18000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (474, 243, 13, 4, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (475, 243, 1, 3, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (476, 243, 17, 3, 50000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (477, 244, 23, 4, 72000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (478, 245, 20, 4, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (479, 245, 14, 2, 70000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (480, 246, 1, 3, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (481, 246, 15, 4, 18000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (482, 247, 22, 3, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (483, 247, 20, 4, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (484, 248, 4, 2, 40000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (485, 249, 1, 1, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (486, 249, 10, 2, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (487, 249, 13, 2, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (488, 250, 18, 1, 580000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (489, 250, 20, 4, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (490, 250, 3, 3, 25000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (491, 251, 14, 4, 70000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (492, 251, 3, 2, 25000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (493, 251, 19, 1, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (494, 252, 21, 3, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (495, 252, 18, 2, 580000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (496, 253, 19, 1, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (497, 253, 16, 2, 95000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (498, 253, 23, 1, 72000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (499, 254, 17, 2, 50000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (500, 255, 16, 1, 95000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (501, 255, 13, 4, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (502, 256, 7, 3, 130000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (503, 257, 1, 4, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (504, 257, 11, 2, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (505, 258, 18, 1, 580000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (506, 258, 11, 3, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (507, 259, 11, 1, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (508, 259, 22, 1, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (509, 259, 21, 1, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (510, 260, 16, 1, 95000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (511, 261, 19, 3, 160000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (512, 262, 3, 2, 25000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (513, 263, 3, 4, 25000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (514, 263, 17, 3, 50000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (515, 264, 23, 3, 72000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (516, 264, 11, 2, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (517, 265, 23, 4, 72000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (518, 265, 1, 4, 60000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (519, 265, 7, 1, 130000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (520, 266, 12, 1, 75000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (521, 267, 20, 4, 135000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (522, 267, 10, 2, 45000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (523, 267, 7, 2, 130000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (524, 268, 22, 2, 220000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (525, 268, 17, 2, 50000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (526, 268, 16, 1, 95000.00);
INSERT [dbo].[Sale_Order_Item] ([sale_item_id], [sale_order_id], [product_id], [quantity], [unit_price]) VALUES (527, 269, 1, 3, 60000.00);
SET IDENTITY_INSERT [dbo].[Sale_Order_Item] OFF;
GO

-- 3. CHÈN BẢNG DELIVERY CHO CÁC ĐƠN HÀNG
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (20, 17, N'Pending', N'123 Nguyễn Văn Cừ, Quận 5, TP. HCM', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (21, 17, N'Delivery Failed', N'76 Cầu Giấy, Quận Cầu Giấy, Hà Nội', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (22, 17, N'Delivered', N'300 Cầu Giấy, Quận Cầu Giấy, Hà Nội', '2026-07-01 11:25:11', '2026-07-01 12:33:29');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (23, 17, N'Delivered', N'129 Cách Mạng Tháng 8, Quận 10, TP. Hồ Chí Minh', '2026-07-01 12:49:01', '2026-07-01 14:41:43');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (24, 17, N'Delivered', N'333 Hoàng Văn Thụ, Quận Phú Nhuận, TP. Hồ Chí Minh', '2026-07-01 16:06:06', '2026-07-01 17:59:12');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (25, 17, N'Delivered', N'293 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', '2026-07-01 19:17:38', '2026-07-01 20:21:52');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (26, 17, N'Delivered', N'84 Trường Chinh, Quận Tân Bình, TP. Hồ Chí Minh', '2026-07-01 22:13:58', '2026-07-01 23:22:33');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (27, 17, N'Pending', N'95 Hoàng Văn Thụ, Quận Phú Nhuận, TP. Hồ Chí Minh', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (28, 17, N'Delivered', N'77 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', '2026-07-02 04:16:58', '2026-07-02 05:55:42');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (29, 17, N'Shipping', N'75 Đại Cồ Việt, Quận Hai Bà Trưng, Hà Nội', '2026-07-02 09:24:48', NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (30, 17, N'Delivery Failed', N'123 Nguyễn Văn Cừ, Quận 5, TP. HCM', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (31, 17, N'Delivered', N'140 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', '2026-07-02 13:57:26', '2026-07-02 15:45:39');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (32, 17, N'Delivered', N'412 Cầu Giấy, Quận Cầu Giấy, Hà Nội', '2026-07-02 18:40:53', '2026-07-02 19:55:14');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (33, 17, N'Delivery Failed', N'83 Cộng Hòa, Quận Tân Bình, TP. Hồ Chí Minh', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (34, 17, N'Pending', N'24 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (35, 17, N'Pending', N'116 Cầu Giấy, Quận Cầu Giấy, Hà Nội', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (36, 17, N'Delivered', N'77 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', '2026-07-03 07:05:40', '2026-07-03 08:55:59');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (37, 17, N'Delivered', N'168 Cầu Giấy, Quận Cầu Giấy, Hà Nội', '2026-07-03 10:38:23', '2026-07-03 12:02:28');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (38, 17, N'Delivery Failed', N'75 Đại Cồ Việt, Quận Hai Bà Trưng, Hà Nội', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (39, 17, N'Delivery Failed', N'329 Trường Chinh, Quận Tân Bình, TP. Hồ Chí Minh', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (40, 17, N'Delivered', N'393 Nguyễn Văn Cừ, Quận Long Biên, Hà Nội', '2026-07-03 19:16:25', '2026-07-03 21:11:25');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (41, 17, N'Delivered', N'372 Lê Văn Sỹ, Quận 3, TP. Hồ Chí Minh', '2026-07-03 21:47:33', '2026-07-03 23:44:45');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (42, 17, N'Delivered', N'419 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', '2026-07-04 01:47:43', '2026-07-04 03:46:58');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (43, 17, N'Delivered', N'44 Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh', '2026-07-04 04:46:02', '2026-07-04 06:45:40');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (44, 17, N'Delivered', N'302 Giải Phóng, Quận Hoàng Mai, Hà Nội', '2026-07-04 07:46:08', '2026-07-04 09:15:19');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (45, 17, N'Delivered', N'76 Cầu Giấy, Quận Cầu Giấy, Hà Nội', '2026-07-04 10:05:04', '2026-07-04 11:12:15');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (46, 17, N'Delivered', N'71 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', '2026-07-04 16:20:48', '2026-07-04 18:17:31');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (47, 17, N'Shipping', N'355 Đỗ Xuân Hợp, Thành phố Thủ Đức, TP. Hồ Chí Minh', '2026-07-04 17:39:46', NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (48, 17, N'Delivered', N'174 Giải Phóng, Quận Hoàng Mai, Hà Nội', '2026-07-04 22:40:48', '2026-07-04 23:47:12');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (49, 17, N'Delivered', N'84 Trường Chinh, Quận Tân Bình, TP. Hồ Chí Minh', '2026-07-05 01:09:01', '2026-07-05 02:29:39');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (50, 17, N'Pending', N'370 Nguyễn Văn Cừ, Quận Long Biên, Hà Nội', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (51, 17, N'Delivered', N'139 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', '2026-07-05 06:40:56', '2026-07-05 08:21:45');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (52, 17, N'Shipping', N'370 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh', '2026-07-05 09:50:18', NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (53, 17, N'Delivered', N'65 Cộng Hòa, Quận Tân Bình, TP. Hồ Chí Minh', '2026-07-05 14:03:28', '2026-07-05 15:34:52');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (54, 17, N'Shipping', N'174 Giải Phóng, Quận Hoàng Mai, Hà Nội', '2026-07-05 17:45:17', NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (55, 17, N'Delivered', N'393 Nguyễn Văn Cừ, Quận Long Biên, Hà Nội', '2026-07-05 19:48:07', '2026-07-05 21:17:33');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (56, 17, N'Delivered', N'290 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', '2026-07-05 23:09:09', '2026-07-06 00:29:13');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (57, 17, N'Pending', N'112 Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (58, 17, N'Delivered', N'81 Phạm Văn Đồng, Quận Bắc Từ Liêm, Hà Nội', '2026-07-06 04:42:41', '2026-07-06 06:04:03');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (59, 17, N'Delivery Failed', N'251 Cách Mạng Tháng 8, Quận 10, TP. Hồ Chí Minh', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (60, 17, N'Delivered', N'302 Giải Phóng, Quận Hoàng Mai, Hà Nội', '2026-07-06 11:26:00', '2026-07-06 12:39:21');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (61, 17, N'Delivered', N'123 Nguyễn Văn Cừ, Quận 5, TP. HCM', '2026-07-06 14:27:03', '2026-07-06 15:37:41');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (62, 17, N'Delivered', N'241 Nguyễn Văn Cừ, Quận Long Biên, Hà Nội', '2026-07-06 17:56:51', '2026-07-06 19:56:44');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (63, 17, N'Delivered', N'168 Cầu Giấy, Quận Cầu Giấy, Hà Nội', '2026-07-06 21:29:39', '2026-07-06 23:09:04');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (64, 17, N'Delivered', N'243 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh', '2026-07-06 23:49:37', '2026-07-07 01:01:52');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (65, 17, N'Shipping', N'77 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', '2026-07-07 02:05:36', NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (66, 17, N'Delivered', N'370 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh', '2026-07-07 06:07:51', '2026-07-07 07:46:08');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (67, 17, N'Delivered', N'172 Tây Sơn, Quận Đống Đa, Hà Nội', '2026-07-07 11:33:46', '2026-07-07 13:09:14');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (68, 17, N'Delivery Failed', N'47 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (69, 17, N'Delivery Failed', N'42 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (70, 17, N'Delivered', N'404 Tây Sơn, Quận Đống Đa, Hà Nội', '2026-07-07 19:43:03', '2026-07-07 20:48:21');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (71, 17, N'Delivered', N'76 Cầu Giấy, Quận Cầu Giấy, Hà Nội', '2026-07-07 23:51:37', '2026-07-08 01:38:22');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (72, 17, N'Delivered', N'123 Nguyễn Văn Cừ, Quận 5, TP. HCM', '2026-07-08 03:07:27', '2026-07-08 05:07:06');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (73, 17, N'Delivered', N'353 Giải Phóng, Quận Hoàng Mai, Hà Nội', '2026-07-08 07:26:02', '2026-07-08 09:10:07');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (74, 17, N'Delivered', N'293 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', '2026-07-08 10:31:53', '2026-07-08 11:34:44');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (75, 17, N'Delivered', N'41 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', '2026-07-08 13:49:04', '2026-07-08 15:01:18');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (76, 17, N'Delivered', N'190 Hoàng Văn Thụ, Quận Phú Nhuận, TP. Hồ Chí Minh', '2026-07-08 16:06:07', '2026-07-08 17:32:22');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (77, 17, N'Delivered', N'370 Nguyễn Văn Cừ, Quận Long Biên, Hà Nội', '2026-07-08 18:38:44', '2026-07-08 20:07:24');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (78, 17, N'Pending', N'47 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (79, 17, N'Shipping', N'116 Cầu Giấy, Quận Cầu Giấy, Hà Nội', '2026-07-09 01:10:23', NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (80, 17, N'Delivered', N'400 Trường Chinh, Quận Tân Bình, TP. Hồ Chí Minh', '2026-07-09 04:41:20', '2026-07-09 06:30:38');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (81, 17, N'Delivered', N'355 Đỗ Xuân Hợp, Thành phố Thủ Đức, TP. Hồ Chí Minh', '2026-07-09 06:44:22', '2026-07-09 07:57:53');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (82, 17, N'Delivered', N'76 Cầu Giấy, Quận Cầu Giấy, Hà Nội', '2026-07-09 11:33:53', '2026-07-09 13:20:52');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (83, 17, N'Delivered', N'400 Trường Chinh, Quận Tân Bình, TP. Hồ Chí Minh', '2026-07-09 14:56:32', '2026-07-09 16:47:15');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (84, 17, N'Shipping', N'333 Hoàng Văn Thụ, Quận Phú Nhuận, TP. Hồ Chí Minh', '2026-07-09 17:03:13', NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (85, 17, N'Delivered', N'404 Tây Sơn, Quận Đống Đa, Hà Nội', '2026-07-09 19:37:39', '2026-07-09 21:24:55');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (86, 17, N'Pending', N'129 Cách Mạng Tháng 8, Quận 10, TP. Hồ Chí Minh', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (87, 17, N'Delivered', N'404 Tây Sơn, Quận Đống Đa, Hà Nội', '2026-07-10 02:34:31', '2026-07-10 04:07:03');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (88, 17, N'Delivered', N'415 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', '2026-07-10 06:34:53', '2026-07-10 07:57:45');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (89, 17, N'Delivered', N'133 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', '2026-07-10 07:10:57', '2026-07-10 08:36:52');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (90, 17, N'Delivered', N'41 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', '2026-07-10 13:41:25', '2026-07-10 14:59:24');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (91, 17, N'Delivered', N'56 Kim Mã, Quận Ba Đình, Hà Nội', '2026-07-10 16:47:15', '2026-07-10 18:43:16');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (92, 17, N'Delivery Failed', N'112 Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (93, 17, N'Delivered', N'123 Nguyễn Văn Cừ, Quận 5, TP. HCM', '2026-07-10 21:58:35', '2026-07-10 23:31:44');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (94, 17, N'Delivery Failed', N'123 Nguyễn Văn Cừ, Quận 5, TP. HCM', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (95, 17, N'Shipping', N'44 Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh', '2026-07-11 03:17:15', NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (96, 17, N'Shipping', N'174 Giải Phóng, Quận Hoàng Mai, Hà Nội', '2026-07-11 06:25:36', NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (97, 17, N'Delivered', N'44 Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh', '2026-07-11 09:47:06', '2026-07-11 11:01:43');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (98, 17, N'Delivered', N'345 Cộng Hòa, Quận Tân Bình, TP. Hồ Chí Minh', '2026-07-11 14:22:40', '2026-07-11 15:26:20');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (99, 17, N'Delivered', N'333 Hoàng Văn Thụ, Quận Phú Nhuận, TP. Hồ Chí Minh', '2026-07-11 16:28:57', '2026-07-11 18:15:28');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (100, 17, N'Delivered', N'300 Cầu Giấy, Quận Cầu Giấy, Hà Nội', '2026-07-11 20:13:03', '2026-07-11 21:42:13');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (101, 17, N'Delivered', N'355 Đỗ Xuân Hợp, Thành phố Thủ Đức, TP. Hồ Chí Minh', '2026-07-11 23:09:07', '2026-07-12 01:07:58');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (102, 17, N'Delivered', N'129 Cách Mạng Tháng 8, Quận 10, TP. Hồ Chí Minh', '2026-07-12 02:19:12', '2026-07-12 03:50:59');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (103, 17, N'Delivered', N'41 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', '2026-07-12 04:33:16', '2026-07-12 05:41:34');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (104, 17, N'Shipping', N'76 Cầu Giấy, Quận Cầu Giấy, Hà Nội', '2026-07-12 10:11:45', NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (105, 17, N'Delivered', N'419 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', '2026-07-12 13:11:43', '2026-07-12 14:56:32');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (106, 17, N'Delivered', N'77 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', '2026-07-12 16:58:08', '2026-07-12 18:12:56');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (107, 17, N'Delivered', N'47 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', '2026-07-12 18:23:33', '2026-07-12 20:04:23');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (108, 17, N'Delivery Failed', N'112 Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (109, 17, N'Shipping', N'139 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh', '2026-07-13 02:19:26', NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (110, 17, N'Pending', N'129 Cách Mạng Tháng 8, Quận 10, TP. Hồ Chí Minh', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (111, 17, N'Delivered', N'409 Kim Mã, Quận Ba Đình, Hà Nội', '2026-07-13 06:30:30', '2026-07-13 07:32:59');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (112, 17, N'Delivered', N'71 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', '2026-07-13 11:31:38', '2026-07-13 13:16:27');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (113, 17, N'Delivered', N'370 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh', '2026-07-13 13:25:59', '2026-07-13 15:22:09');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (114, 17, N'Delivered', N'166 Giải Phóng, Quận Hoàng Mai, Hà Nội', '2026-07-13 16:55:49', '2026-07-13 18:22:20');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (115, 17, N'Shipping', N'202 Giải Phóng, Quận Hoàng Mai, Hà Nội', '2026-07-13 18:44:07', NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (116, 17, N'Delivered', N'412 Cầu Giấy, Quận Cầu Giấy, Hà Nội', '2026-07-14 00:14:44', '2026-07-14 01:48:23');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (117, 17, N'Delivered', N'116 Cầu Giấy, Quận Cầu Giấy, Hà Nội', '2026-07-14 02:25:56', '2026-07-14 03:48:28');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (118, 17, N'Delivered', N'95 Hoàng Văn Thụ, Quận Phú Nhuận, TP. Hồ Chí Minh', '2026-07-14 05:52:17', '2026-07-14 07:37:59');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (119, 17, N'Delivery Failed', N'86 Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (120, 17, N'Delivered', N'11 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', '2026-07-14 11:22:55', '2026-07-14 12:58:43');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (121, 17, N'Delivered', N'65 Cộng Hòa, Quận Tân Bình, TP. Hồ Chí Minh', '2026-07-14 15:23:46', '2026-07-14 17:15:54');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (122, 17, N'Shipping', N'372 Lê Văn Sỹ, Quận 3, TP. Hồ Chí Minh', '2026-07-14 18:58:45', NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (123, 17, N'Delivered', N'71 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', '2026-07-14 21:41:06', '2026-07-14 22:52:35');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (124, 17, N'Shipping', N'47 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', '2026-07-15 00:05:36', NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (125, 17, N'Delivered', N'241 Nguyễn Văn Cừ, Quận Long Biên, Hà Nội', '2026-07-15 04:30:21', '2026-07-15 05:58:47');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (126, 17, N'Delivered', N'84 Trường Chinh, Quận Tân Bình, TP. Hồ Chí Minh', '2026-07-15 06:42:21', '2026-07-15 08:14:07');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (127, 17, N'Pending', N'293 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (128, 17, N'Pending', N'404 Tây Sơn, Quận Đống Đa, Hà Nội', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (129, 17, N'Delivered', N'162 Đỗ Xuân Hợp, Thành phố Thủ Đức, TP. Hồ Chí Minh', '2026-07-15 17:12:43', '2026-07-15 18:28:37');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (130, 17, N'Delivered', N'47 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', '2026-07-15 20:11:20', '2026-07-15 21:17:00');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (131, 17, N'Delivery Failed', N'326 Kim Mã, Quận Ba Đình, Hà Nội', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (132, 17, N'Shipping', N'41 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', '2026-07-16 02:16:46', NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (133, 17, N'Delivered', N'123 Nguyễn Văn Cừ, Quận 5, TP. HCM', '2026-07-16 06:59:51', '2026-07-16 08:06:20');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (134, 17, N'Delivered', N'24 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh', '2026-07-16 09:08:29', '2026-07-16 10:43:33');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (135, 17, N'Pending', N'123 Nguyễn Văn Cừ, Quận 5, TP. HCM', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (136, 17, N'Delivered', N'166 Giải Phóng, Quận Hoàng Mai, Hà Nội', '2026-07-16 15:11:24', '2026-07-16 17:06:41');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (137, 17, N'Delivered', N'191 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', '2026-07-16 19:30:45', '2026-07-16 20:57:06');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (138, 17, N'Delivered', N'415 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', '2026-07-16 21:33:01', '2026-07-16 22:33:53');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (139, 17, N'Delivered', N'123 Nguyễn Văn Cừ, Quận 5, TP. HCM', '2026-07-17 01:54:09', '2026-07-17 03:31:10');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (140, 17, N'Shipping', N'202 Giải Phóng, Quận Hoàng Mai, Hà Nội', '2026-07-17 03:42:20', NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (141, 17, N'Delivery Failed', N'81 Phạm Văn Đồng, Quận Bắc Từ Liêm, Hà Nội', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (142, 17, N'Delivery Failed', N'247 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (143, 17, N'Pending', N'329 Trường Chinh, Quận Tân Bình, TP. Hồ Chí Minh', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (144, 17, N'Pending', N'77 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (145, 17, N'Delivered', N'293 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', '2026-07-17 18:39:15', '2026-07-17 20:32:34');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (146, 17, N'Delivered', N'210 Tây Sơn, Quận Đống Đa, Hà Nội', '2026-07-17 22:44:08', '2026-07-18 00:35:26');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (147, 17, N'Delivered', N'162 Đỗ Xuân Hợp, Thành phố Thủ Đức, TP. Hồ Chí Minh', '2026-07-18 01:29:09', '2026-07-18 03:07:14');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (148, 17, N'Delivered', N'251 Cách Mạng Tháng 8, Quận 10, TP. Hồ Chí Minh', '2026-07-18 05:17:40', '2026-07-18 06:59:03');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (149, 17, N'Delivery Failed', N'247 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (150, 17, N'Delivered', N'415 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', '2026-07-18 13:34:27', '2026-07-18 14:35:50');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (151, 17, N'Delivery Failed', N'56 Kim Mã, Quận Ba Đình, Hà Nội', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (152, 17, N'Delivered', N'300 Cầu Giấy, Quận Cầu Giấy, Hà Nội', '2026-07-18 17:50:34', '2026-07-18 19:38:50');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (153, 17, N'Delivered', N'333 Hoàng Văn Thụ, Quận Phú Nhuận, TP. Hồ Chí Minh', '2026-07-18 23:06:38', '2026-07-19 00:26:33');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (154, 17, N'Delivered', N'123 Nguyễn Văn Cừ, Quận 5, TP. HCM', '2026-07-19 01:02:07', '2026-07-19 03:00:57');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (155, 17, N'Delivered', N'296 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', '2026-07-19 03:39:05', '2026-07-19 05:22:53');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (156, 17, N'Delivered', N'202 Giải Phóng, Quận Hoàng Mai, Hà Nội', '2026-07-19 08:42:10', '2026-07-19 10:03:41');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (157, 17, N'Delivered', N'112 Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh', '2026-07-19 10:26:52', '2026-07-19 11:56:16');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (158, 17, N'Delivered', N'11 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', '2026-07-19 15:32:14', '2026-07-19 16:57:40');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (159, 17, N'Delivered', N'210 Tây Sơn, Quận Đống Đa, Hà Nội', '2026-07-19 16:32:51', '2026-07-19 18:14:10');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (160, 17, N'Delivered', N'172 Tây Sơn, Quận Đống Đa, Hà Nội', '2026-07-19 21:06:06', '2026-07-19 22:35:04');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (161, 17, N'Shipping', N'243 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh', '2026-07-19 23:50:20', NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (162, 17, N'Delivered', N'412 Cầu Giấy, Quận Cầu Giấy, Hà Nội', '2026-07-20 03:51:00', '2026-07-20 05:41:10');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (163, 17, N'Delivered', N'123 Nguyễn Văn Cừ, Quận 5, TP. HCM', '2026-07-20 04:37:03', '2026-07-20 06:19:35');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (164, 17, N'Delivery Failed', N'172 Tây Sơn, Quận Đống Đa, Hà Nội', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (165, 17, N'Shipping', N'419 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', '2026-07-20 12:49:21', NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (166, 17, N'Delivered', N'47 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', '2026-07-20 16:37:42', '2026-07-20 18:15:14');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (167, 17, N'Delivered', N'393 Nguyễn Văn Cừ, Quận Long Biên, Hà Nội', '2026-07-20 18:58:07', '2026-07-20 20:28:41');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (168, 17, N'Delivered', N'412 Cầu Giấy, Quận Cầu Giấy, Hà Nội', '2026-07-20 21:55:16', '2026-07-20 23:04:22');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (169, 17, N'Delivered', N'24 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh', '2026-07-21 01:21:57', '2026-07-21 03:05:53');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (170, 17, N'Delivered', N'174 Giải Phóng, Quận Hoàng Mai, Hà Nội', '2026-07-21 03:39:05', '2026-07-21 05:13:38');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (171, 17, N'Delivered', N'47 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', '2026-07-21 09:26:03', '2026-07-21 10:42:22');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (172, 17, N'Shipping', N'247 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', '2026-07-21 11:20:57', NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (173, 17, N'Pending', N'168 Cầu Giấy, Quận Cầu Giấy, Hà Nội', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (174, 17, N'Delivered', N'76 Cầu Giấy, Quận Cầu Giấy, Hà Nội', '2026-07-21 19:24:10', '2026-07-21 21:04:01');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (175, 17, N'Pending', N'44 Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (176, 17, N'Shipping', N'24 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh', '2026-07-22 01:04:11', NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (177, 17, N'Delivered', N'139 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh', '2026-07-22 03:53:54', '2026-07-22 04:54:36');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (178, 17, N'Delivered', N'65 Cộng Hòa, Quận Tân Bình, TP. Hồ Chí Minh', '2026-07-22 04:52:52', '2026-07-22 06:27:18');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (179, 17, N'Delivered', N'56 Kim Mã, Quận Ba Đình, Hà Nội', '2026-07-22 11:00:50', '2026-07-22 12:17:47');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (180, 17, N'Delivered', N'42 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', '2026-07-22 14:11:41', '2026-07-22 15:37:50');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (181, 17, N'Delivered', N'11 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', '2026-07-22 16:24:28', '2026-07-22 17:36:39');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (182, 17, N'Delivered', N'404 Tây Sơn, Quận Đống Đa, Hà Nội', '2026-07-22 19:47:03', '2026-07-22 21:07:46');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (183, 17, N'Delivered', N'123 Nguyễn Văn Cừ, Quận 5, TP. HCM', '2026-07-22 22:36:51', '2026-07-23 00:00:23');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (184, 17, N'Delivery Failed', N'293 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (185, 17, N'Delivered', N'404 Tây Sơn, Quận Đống Đa, Hà Nội', '2026-07-23 05:15:13', '2026-07-23 07:01:46');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (186, 17, N'Delivered', N'172 Tây Sơn, Quận Đống Đa, Hà Nội', '2026-07-23 06:32:22', '2026-07-23 08:17:31');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (187, 17, N'Pending', N'412 Cầu Giấy, Quận Cầu Giấy, Hà Nội', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (188, 17, N'Delivered', N'191 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', '2026-07-23 15:10:19', '2026-07-23 16:58:29');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (189, 17, N'Shipping', N'133 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', '2026-07-23 17:06:31', NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (190, 17, N'Delivered', N'293 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', '2026-07-23 20:43:20', '2026-07-23 22:19:15');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (191, 17, N'Delivered', N'372 Lê Văn Sỹ, Quận 3, TP. Hồ Chí Minh', '2026-07-23 23:54:10', '2026-07-24 01:41:53');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (192, 17, N'Delivered', N'300 Cầu Giấy, Quận Cầu Giấy, Hà Nội', '2026-07-24 04:54:56', '2026-07-24 06:23:56');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (193, 17, N'Delivery Failed', N'123 Nguyễn Văn Cừ, Quận 5, TP. HCM', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (194, 17, N'Shipping', N'415 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', '2026-07-24 08:45:03', NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (195, 17, N'Shipping', N'86 Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh', '2026-07-24 11:19:38', NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (196, 17, N'Delivered', N'190 Hoàng Văn Thụ, Quận Phú Nhuận, TP. Hồ Chí Minh', '2026-07-24 15:45:24', '2026-07-24 17:08:49');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (197, 17, N'Delivered', N'41 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', '2026-07-24 19:11:42', '2026-07-24 20:38:58');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (198, 17, N'Shipping', N'191 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', '2026-07-24 22:02:27', NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (199, 17, N'Delivered', N'95 Hoàng Văn Thụ, Quận Phú Nhuận, TP. Hồ Chí Minh', '2026-07-25 01:46:32', '2026-07-25 03:18:24');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (200, 17, N'Shipping', N'290 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', '2026-07-25 04:59:29', NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (201, 17, N'Delivered', N'76 Cầu Giấy, Quận Cầu Giấy, Hà Nội', '2026-07-25 09:29:10', '2026-07-25 10:45:06');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (202, 17, N'Delivered', N'251 Cách Mạng Tháng 8, Quận 10, TP. Hồ Chí Minh', '2026-07-25 12:52:51', '2026-07-25 14:22:59');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (203, 17, N'Delivered', N'300 Cầu Giấy, Quận Cầu Giấy, Hà Nội', '2026-07-25 14:21:44', '2026-07-25 16:10:50');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (204, 17, N'Shipping', N'11 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', '2026-07-25 16:27:15', NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (205, 17, N'Delivered', N'329 Trường Chinh, Quận Tân Bình, TP. Hồ Chí Minh', '2026-07-25 21:46:49', '2026-07-25 22:55:10');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (206, 17, N'Shipping', N'75 Đại Cồ Việt, Quận Hai Bà Trưng, Hà Nội', '2026-07-25 22:30:11', NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (207, 17, N'Shipping', N'333 Hoàng Văn Thụ, Quận Phú Nhuận, TP. Hồ Chí Minh', '2026-07-26 03:16:50', NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (208, 17, N'Pending', N'355 Đỗ Xuân Hợp, Thành phố Thủ Đức, TP. Hồ Chí Minh', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (209, 17, N'Delivered', N'326 Kim Mã, Quận Ba Đình, Hà Nội', '2026-07-26 10:22:41', '2026-07-26 11:47:42');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (210, 17, N'Delivered', N'247 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', '2026-07-26 12:43:57', '2026-07-26 14:18:11');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (211, 17, N'Delivered', N'140 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', '2026-07-26 16:30:10', '2026-07-26 18:24:58');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (212, 17, N'Delivered', N'83 Cộng Hòa, Quận Tân Bình, TP. Hồ Chí Minh', '2026-07-26 21:12:29', '2026-07-26 22:48:25');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (213, 17, N'Delivered', N'84 Trường Chinh, Quận Tân Bình, TP. Hồ Chí Minh', '2026-07-26 23:13:53', '2026-07-27 00:34:31');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (214, 17, N'Delivered', N'86 Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh', '2026-07-27 01:22:24', '2026-07-27 02:57:34');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (215, 17, N'Delivery Failed', N'83 Cộng Hòa, Quận Tân Bình, TP. Hồ Chí Minh', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (216, 17, N'Pending', N'241 Nguyễn Văn Cừ, Quận Long Biên, Hà Nội', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (217, 17, N'Delivered', N'11 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', '2026-07-27 10:11:08', '2026-07-27 12:08:05');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (218, 17, N'Delivered', N'95 Hoàng Văn Thụ, Quận Phú Nhuận, TP. Hồ Chí Minh', '2026-07-27 13:54:03', '2026-07-27 15:21:00');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (219, 17, N'Delivered', N'162 Đỗ Xuân Hợp, Thành phố Thủ Đức, TP. Hồ Chí Minh', '2026-07-27 18:14:36', '2026-07-27 19:17:38');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (220, 17, N'Delivered', N'296 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', '2026-07-27 20:30:52', '2026-07-27 21:56:48');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (221, 17, N'Delivery Failed', N'86 Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (222, 17, N'Pending', N'241 Nguyễn Văn Cừ, Quận Long Biên, Hà Nội', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (223, 17, N'Delivered', N'44 Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh', '2026-07-28 07:51:24', '2026-07-28 09:44:18');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (224, 17, N'Delivered', N'168 Cầu Giấy, Quận Cầu Giấy, Hà Nội', '2026-07-28 08:40:00', '2026-07-28 09:50:21');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (225, 17, N'Delivery Failed', N'47 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (226, 17, N'Pending', N'355 Đỗ Xuân Hợp, Thành phố Thủ Đức, TP. Hồ Chí Minh', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (227, 17, N'Shipping', N'168 Cầu Giấy, Quận Cầu Giấy, Hà Nội', '2026-07-28 18:22:46', NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (228, 17, N'Delivered', N'333 Hoàng Văn Thụ, Quận Phú Nhuận, TP. Hồ Chí Minh', '2026-07-28 22:21:25', '2026-07-28 23:44:07');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (229, 17, N'Pending', N'86 Nguyễn Thị Minh Khai, Quận 1, TP. Hồ Chí Minh', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (230, 17, N'Delivery Failed', N'168 Cầu Giấy, Quận Cầu Giấy, Hà Nội', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (231, 17, N'Delivered', N'174 Giải Phóng, Quận Hoàng Mai, Hà Nội', '2026-07-29 09:41:19', '2026-07-29 11:12:32');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (232, 17, N'Delivered', N'400 Trường Chinh, Quận Tân Bình, TP. Hồ Chí Minh', '2026-07-29 11:28:44', '2026-07-29 12:57:51');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (233, 17, N'Delivered', N'243 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh', '2026-07-29 16:04:50', '2026-07-29 17:39:55');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (234, 17, N'Delivered', N'139 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh', '2026-07-29 17:23:20', '2026-07-29 18:50:54');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (235, 17, N'Delivered', N'81 Phạm Văn Đồng, Quận Bắc Từ Liêm, Hà Nội', '2026-07-29 20:46:40', '2026-07-29 21:46:45');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (236, 17, N'Delivered', N'133 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', '2026-07-30 01:19:11', '2026-07-30 03:01:45');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (237, 17, N'Delivered', N'419 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', '2026-07-30 03:42:51', '2026-07-30 05:17:54');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (238, 17, N'Delivered', N'56 Kim Mã, Quận Ba Đình, Hà Nội', '2026-07-30 05:45:58', '2026-07-30 07:14:50');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (239, 17, N'Delivered', N'293 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', '2026-07-30 11:26:30', '2026-07-30 13:21:38');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (240, 17, N'Delivered', N'75 Đại Cồ Việt, Quận Hai Bà Trưng, Hà Nội', '2026-07-30 14:29:12', '2026-07-30 16:21:25');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (241, 17, N'Delivered', N'415 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', '2026-07-30 16:31:32', '2026-07-30 17:45:55');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (242, 17, N'Shipping', N'404 Tây Sơn, Quận Đống Đa, Hà Nội', '2026-07-30 19:56:33', NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (243, 17, N'Delivered', N'290 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', '2026-07-30 22:13:11', '2026-07-30 23:52:07');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (244, 17, N'Delivered', N'174 Giải Phóng, Quận Hoàng Mai, Hà Nội', '2026-07-31 03:03:07', '2026-07-31 04:52:45');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (245, 17, N'Delivery Failed', N'243 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (246, 17, N'Delivered', N'123 Nguyễn Văn Cừ, Quận 5, TP. HCM', '2026-07-31 08:09:46', '2026-07-31 10:02:46');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (247, 17, N'Delivered', N'296 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', '2026-07-31 11:54:20', '2026-07-31 13:50:16');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (248, 17, N'Delivered', N'139 Phan Xích Long, Quận Phú Nhuận, TP. Hồ Chí Minh', '2026-07-31 14:35:19', '2026-07-31 16:10:46');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (249, 17, N'Delivered', N'345 Cộng Hòa, Quận Tân Bình, TP. Hồ Chí Minh', '2026-07-31 19:05:54', '2026-07-31 20:30:29');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (250, 17, N'Delivered', N'65 Cộng Hòa, Quận Tân Bình, TP. Hồ Chí Minh', '2026-07-31 22:11:04', '2026-07-31 23:26:47');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (251, 17, N'Delivered', N'210 Tây Sơn, Quận Đống Đa, Hà Nội', '2026-08-01 00:39:39', '2026-08-01 02:21:50');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (252, 17, N'Pending', N'56 Kim Mã, Quận Ba Đình, Hà Nội', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (253, 17, N'Delivered', N'77 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', '2026-08-01 07:43:16', '2026-08-01 09:09:58');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (254, 17, N'Shipping', N'396 Cộng Hòa, Quận Tân Bình, TP. Hồ Chí Minh', '2026-08-01 10:20:09', NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (255, 17, N'Delivered', N'329 Trường Chinh, Quận Tân Bình, TP. Hồ Chí Minh', '2026-08-01 13:37:52', '2026-08-01 14:43:26');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (256, 17, N'Delivered', N'412 Cầu Giấy, Quận Cầu Giấy, Hà Nội', '2026-08-01 15:47:28', '2026-08-01 17:34:07');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (257, 17, N'Delivered', N'123 Nguyễn Văn Cừ, Quận 5, TP. HCM', '2026-08-01 18:24:45', '2026-08-01 19:53:03');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (258, 17, N'Delivered', N'345 Cộng Hòa, Quận Tân Bình, TP. Hồ Chí Minh', '2026-08-02 00:05:41', '2026-08-02 01:13:59');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (259, 17, N'Delivered', N'372 Lê Văn Sỹ, Quận 3, TP. Hồ Chí Minh', '2026-08-02 01:01:18', '2026-08-02 02:17:00');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (260, 17, N'Pending', N'41 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', NULL, NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (261, 17, N'Delivered', N'333 Hoàng Văn Thụ, Quận Phú Nhuận, TP. Hồ Chí Minh', '2026-08-02 07:38:15', '2026-08-02 09:28:25');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (262, 17, N'Delivered', N'95 Hoàng Văn Thụ, Quận Phú Nhuận, TP. Hồ Chí Minh', '2026-08-02 12:24:50', '2026-08-02 13:34:14');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (263, 17, N'Delivered', N'139 Đinh Bộ Lĩnh, Quận Bình Thạnh, TP. Hồ Chí Minh', '2026-08-02 14:46:13', '2026-08-02 16:02:18');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (264, 17, N'Shipping', N'140 Nguyễn Văn Cừ, Quận 5, TP. Hồ Chí Minh', '2026-08-02 20:07:40', NULL);
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (265, 17, N'Delivered', N'353 Giải Phóng, Quận Hoàng Mai, Hà Nội', '2026-08-02 22:09:33', '2026-08-02 23:20:56');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (266, 17, N'Delivered', N'11 Xa Lộ Hà Nội, Thành phố Thủ Đức, TP. Hồ Chí Minh', '2026-08-03 00:34:23', '2026-08-03 02:04:15');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (267, 17, N'Delivered', N'355 Đỗ Xuân Hợp, Thành phố Thủ Đức, TP. Hồ Chí Minh', '2026-08-03 04:25:28', '2026-08-03 05:27:27');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (268, 17, N'Delivered', N'133 Nguyễn Hữu Thọ, Quận 7, TP. Hồ Chí Minh', '2026-08-03 06:29:25', '2026-08-03 08:21:13');
INSERT [dbo].[Delivery] ([order_id], [shipper_id], [status], [shipping_address], [shipped_date], [delivered_date]) VALUES (269, 17, N'Delivered', N'370 Nguyễn Văn Cừ, Quận Long Biên, Hà Nội', '2026-08-03 09:46:01', '2026-08-03 11:17:41');
GO

-- 4. CHÈN ĐÁNH GIÁ REVIEWS HÀNG HOÁ
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (40, 21, 5, N'Táo giòn ngọt, vỏ mỏng ngon lắm.', N'Approved', '2026-07-01 07:40:10');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (70, 15, 5, N'Giao hàng cực kỳ nhanh, hoa quả giòn ngọt mọng nước.', N'Approved', '2026-07-03 20:04:21');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (31, 14, 5, N'Trái cây tươi ngon, đóng gói rất cẩn thận!', N'Approved', '2026-07-03 23:41:10');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (44, 23, 5, N'Đóng gói thùng xốp cẩn thận, hoa quả không bị dập nát.', N'Approved', '2026-07-04 02:57:39');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (58, 13, 5, N'Trái cây tươi ngon, đóng gói rất cẩn thận!', N'Approved', '2026-07-04 09:02:09');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (61, 21, 5, N'Đóng gói thùng xốp cẩn thận, hoa quả không bị dập nát.', N'Approved', '2026-07-04 12:49:47');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (52, 13, 5, N'Đóng gói thùng xốp cẩn thận, hoa quả không bị dập nát.', N'Approved', '2026-07-06 15:27:28');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (8, 18, 5, N'Shipper nhiệt tình thân thiện, 5 sao chất lượng!', N'Approved', '2026-07-07 23:23:05');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (37, 13, 5, N'Đóng gói thùng xốp cẩn thận, hoa quả không bị dập nát.', N'Approved', '2026-07-09 01:25:11');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (28, 3, 5, N'Sầu riêng cơm dẻo hạt lép thơm nức mũi.', N'Approved', '2026-07-09 04:43:09');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (58, 10, 5, N'Giao hàng cực kỳ nhanh, hoa quả giòn ngọt mọng nước.', N'Approved', '2026-07-09 08:06:34');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (45, 3, 5, N'Dưa hấu ngọt mát, măng cụt chín mẩy tươi nguyên.', N'Approved', '2026-07-10 00:18:42');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (56, 20, 5, N'Sầu riêng cơm dẻo hạt lép thơm nức mũi.', N'Approved', '2026-07-10 09:56:00');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (31, 22, 4, N'Nho ngọt lịm không hạt, đáng tiền lắm!', N'Approved', '2026-07-12 10:09:19');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (61, 3, 5, N'Chất lượng tuyệt vời, sẽ ủng hộ shop dài dài.', N'Approved', '2026-07-14 19:43:47');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (63, 18, 5, N'Shipper nhiệt tình thân thiện, 5 sao chất lượng!', N'Approved', '2026-07-15 17:28:50');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (50, 11, 5, N'Shipper nhiệt tình thân thiện, 5 sao chất lượng!', N'Approved', '2026-07-16 16:30:35');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (76, 16, 4, N'Chất lượng tuyệt vời, sẽ ủng hộ shop dài dài.', N'Approved', '2026-07-16 19:58:40');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (64, 20, 5, N'Sầu riêng cơm dẻo hạt lép thơm nức mũi.', N'Approved', '2026-07-17 17:35:05');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (40, 3, 5, N'Sầu riêng cơm dẻo hạt lép thơm nức mũi.', N'Approved', '2026-07-18 16:48:25');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (36, 22, 5, N'Đóng gói thùng xốp cẩn thận, hoa quả không bị dập nát.', N'Approved', '2026-07-18 19:45:23');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (38, 13, 5, N'Shipper nhiệt tình thân thiện, 5 sao chất lượng!', N'Approved', '2026-07-19 05:29:37');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (71, 17, 5, N'Shipper nhiệt tình thân thiện, 5 sao chất lượng!', N'Approved', '2026-07-19 17:56:14');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (35, 10, 5, N'Nho ngọt lịm không hạt, đáng tiền lắm!', N'Approved', '2026-07-20 20:00:51');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (30, 3, 5, N'Trái cây tươi ngon, đóng gói rất cẩn thận!', N'Approved', '2026-07-22 00:58:33');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (22, 1, 5, N'Shipper nhiệt tình thân thiện, 5 sao chất lượng!', N'Approved', '2026-07-22 10:22:02');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (45, 22, 4, N'Đóng gói thùng xốp cẩn thận, hoa quả không bị dập nát.', N'Approved', '2026-07-23 01:52:23');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (64, 15, 4, N'Sầu riêng cơm dẻo hạt lép thơm nức mũi.', N'Approved', '2026-07-23 18:10:34');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (40, 12, 5, N'Shipper nhiệt tình thân thiện, 5 sao chất lượng!', N'Approved', '2026-07-24 01:12:24');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (32, 20, 5, N'Giao hàng cực kỳ nhanh, hoa quả giòn ngọt mọng nước.', N'Approved', '2026-07-26 17:21:30');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (44, 17, 5, N'Shipper nhiệt tình thân thiện, 5 sao chất lượng!', N'Approved', '2026-07-28 04:21:30');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (73, 18, 4, N'Shipper nhiệt tình thân thiện, 5 sao chất lượng!', N'Approved', '2026-07-28 07:01:16');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (36, 7, 5, N'Trái cây tươi ngon, đóng gói rất cẩn thận!', N'Approved', '2026-07-28 19:54:05');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (20, 7, 5, N'Nho ngọt lịm không hạt, đáng tiền lắm!', N'Approved', '2026-07-29 05:52:50');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (37, 3, 5, N'Nho ngọt lịm không hạt, đáng tiền lắm!', N'Approved', '2026-07-29 09:15:47');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (21, 22, 5, N'Dưa hấu ngọt mát, măng cụt chín mẩy tươi nguyên.', N'Approved', '2026-07-31 09:23:32');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (78, 14, 5, N'Chất lượng tuyệt vời, sẽ ủng hộ shop dài dài.', N'Approved', '2026-07-31 21:46:35');
INSERT [dbo].[Reviews] ([user_id], [product_id], [rating], [comment], [status], [created_at]) VALUES (46, 1, 5, N'Dưa hấu ngọt mát, măng cụt chín mẩy tươi nguyên.', N'Approved', '2026-08-03 07:51:19');
GO

-- 5. CẬP NHẬT ĐIỂM TÍCH LŨY MEMBERSHIP CHO KHÁCH HÀNG
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 8) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 440, [tier_id] = 2 WHERE [user_id] = 8; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (8, 440, 2); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 13) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 17, [tier_id] = 1 WHERE [user_id] = 13; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (13, 17, 1); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 18) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 314, [tier_id] = 2 WHERE [user_id] = 18; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (18, 314, 2); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 19) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 338, [tier_id] = 2 WHERE [user_id] = 19; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (19, 338, 2); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 20) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 192, [tier_id] = 2 WHERE [user_id] = 20; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (20, 192, 2); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 21) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 249, [tier_id] = 2 WHERE [user_id] = 21; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (21, 249, 2); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 22) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 192, [tier_id] = 2 WHERE [user_id] = 22; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (22, 192, 2); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 23) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 164, [tier_id] = 2 WHERE [user_id] = 23; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (23, 164, 2); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 24) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 111, [tier_id] = 2 WHERE [user_id] = 24; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (24, 111, 2); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 25) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 81, [tier_id] = 1 WHERE [user_id] = 25; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (25, 81, 1); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 26) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 51, [tier_id] = 1 WHERE [user_id] = 26; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (26, 51, 1); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 27) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 310, [tier_id] = 2 WHERE [user_id] = 27; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (27, 310, 2); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 28) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 268, [tier_id] = 2 WHERE [user_id] = 28; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (28, 268, 2); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 29) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 99, [tier_id] = 1 WHERE [user_id] = 29; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (29, 99, 1); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 30) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 37, [tier_id] = 1 WHERE [user_id] = 30; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (30, 37, 1); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 31) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 344, [tier_id] = 2 WHERE [user_id] = 31; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (31, 344, 2); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 32) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 15, [tier_id] = 1 WHERE [user_id] = 32; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (32, 15, 1); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 33) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 91, [tier_id] = 1 WHERE [user_id] = 33; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (33, 91, 1); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 34) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 42, [tier_id] = 1 WHERE [user_id] = 34; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (34, 42, 1); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 35) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 270, [tier_id] = 2 WHERE [user_id] = 35; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (35, 270, 2); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 36) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 294, [tier_id] = 2 WHERE [user_id] = 36; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (36, 294, 2); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 37) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 201, [tier_id] = 2 WHERE [user_id] = 37; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (37, 201, 2); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 38) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 15, [tier_id] = 1 WHERE [user_id] = 38; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (38, 15, 1); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 39) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 74, [tier_id] = 1 WHERE [user_id] = 39; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (39, 74, 1); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 40) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 113, [tier_id] = 2 WHERE [user_id] = 40; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (40, 113, 2); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 41) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 92, [tier_id] = 1 WHERE [user_id] = 41; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (41, 92, 1); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 42) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 64, [tier_id] = 1 WHERE [user_id] = 42; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (42, 64, 1); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 43) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 0, [tier_id] = 1 WHERE [user_id] = 43; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (43, 0, 1); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 44) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 155, [tier_id] = 2 WHERE [user_id] = 44; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (44, 155, 2); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 45) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 172, [tier_id] = 2 WHERE [user_id] = 45; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (45, 172, 2); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 46) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 58, [tier_id] = 1 WHERE [user_id] = 46; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (46, 58, 1); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 47) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 73, [tier_id] = 1 WHERE [user_id] = 47; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (47, 73, 1); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 48) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 404, [tier_id] = 2 WHERE [user_id] = 48; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (48, 404, 2); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 49) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 153, [tier_id] = 2 WHERE [user_id] = 49; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (49, 153, 2); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 50) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 170, [tier_id] = 2 WHERE [user_id] = 50; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (50, 170, 2); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 51) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 81, [tier_id] = 1 WHERE [user_id] = 51; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (51, 81, 1); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 52) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 126, [tier_id] = 2 WHERE [user_id] = 52; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (52, 126, 2); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 53) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 0, [tier_id] = 1 WHERE [user_id] = 53; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (53, 0, 1); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 54) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 57, [tier_id] = 1 WHERE [user_id] = 54; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (54, 57, 1); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 55) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 230, [tier_id] = 2 WHERE [user_id] = 55; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (55, 230, 2); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 56) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 311, [tier_id] = 2 WHERE [user_id] = 56; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (56, 311, 2); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 57) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 263, [tier_id] = 2 WHERE [user_id] = 57; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (57, 263, 2); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 58) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 227, [tier_id] = 2 WHERE [user_id] = 58; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (58, 227, 2); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 59) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 66, [tier_id] = 1 WHERE [user_id] = 59; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (59, 66, 1); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 60) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 85, [tier_id] = 1 WHERE [user_id] = 60; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (60, 85, 1); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 61) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 43, [tier_id] = 1 WHERE [user_id] = 61; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (61, 43, 1); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 62) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 7, [tier_id] = 1 WHERE [user_id] = 62; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (62, 7, 1); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 63) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 276, [tier_id] = 2 WHERE [user_id] = 63; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (63, 276, 2); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 64) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 269, [tier_id] = 2 WHERE [user_id] = 64; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (64, 269, 2); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 65) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 73, [tier_id] = 1 WHERE [user_id] = 65; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (65, 73, 1); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 66) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 180, [tier_id] = 2 WHERE [user_id] = 66; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (66, 180, 2); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 67) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 313, [tier_id] = 2 WHERE [user_id] = 67; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (67, 313, 2); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 68) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 505, [tier_id] = 3 WHERE [user_id] = 68; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (68, 505, 3); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 69) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 57, [tier_id] = 1 WHERE [user_id] = 69; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (69, 57, 1); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 70) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 105, [tier_id] = 2 WHERE [user_id] = 70; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (70, 105, 2); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 71) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 266, [tier_id] = 2 WHERE [user_id] = 71; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (71, 266, 2); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 72) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 47, [tier_id] = 1 WHERE [user_id] = 72; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (72, 47, 1); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 73) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 513, [tier_id] = 3 WHERE [user_id] = 73; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (73, 513, 3); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 74) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 67, [tier_id] = 1 WHERE [user_id] = 74; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (74, 67, 1); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 75) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 153, [tier_id] = 2 WHERE [user_id] = 75; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (75, 153, 2); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 76) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 223, [tier_id] = 2 WHERE [user_id] = 76; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (76, 223, 2); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 77) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 46, [tier_id] = 1 WHERE [user_id] = 77; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (77, 46, 1); END
IF EXISTS (SELECT 1 FROM [dbo].[Membership] WHERE [user_id] = 78) BEGIN UPDATE [dbo].[Membership] SET [current_points] = 128, [tier_id] = 2 WHERE [user_id] = 78; END ELSE BEGIN INSERT INTO [dbo].[Membership] ([user_id], [current_points], [tier_id]) VALUES (78, 128, 2); END
GO
