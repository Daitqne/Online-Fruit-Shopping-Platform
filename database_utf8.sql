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
-- Bang Membership: Quan ly diem tich luy va hang thanh vien
-- ============================================================
IF NOT EXISTS (
    SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Membership'
)
BEGIN
    CREATE TABLE [dbo].[Membership] (
        [membership_id]           [int] IDENTITY(1,1) NOT NULL,
        [user_id]                 [int] NOT NULL,
        [current_points]          [int] NOT NULL CONSTRAINT [DF_Membership_points]      DEFAULT (0),
        [current_tier]            [nvarchar](20) NOT NULL CONSTRAINT [DF_Membership_tier] DEFAULT (N'Normal'),
        [point_conversion_rate]   [int] NOT NULL CONSTRAINT [DF_Membership_conv_rate]   DEFAULT (10000),
        [silver_min_point]        [int] NOT NULL CONSTRAINT [DF_Membership_silver_min]  DEFAULT (100),
        [silver_discount_percent] [int] NOT NULL CONSTRAINT [DF_Membership_silver_disc] DEFAULT (5),
        [gold_min_point]          [int] NOT NULL CONSTRAINT [DF_Membership_gold_min]    DEFAULT (500),
        [gold_discount_percent]   [int] NOT NULL CONSTRAINT [DF_Membership_gold_disc]   DEFAULT (10),
        [diamond_min_point]       [int] NOT NULL CONSTRAINT [DF_Membership_diamond_min] DEFAULT (1000),
        [diamond_discount_percent][int] NOT NULL CONSTRAINT [DF_Membership_diamond_disc]DEFAULT (15),
        [manual_override]         [bit] NOT NULL CONSTRAINT [DF_Membership_override]    DEFAULT (0),
        [tier_updated_at]         [datetime] NOT NULL CONSTRAINT [DF_Membership_updated] DEFAULT (GETDATE()),
        CONSTRAINT [PK_Membership] PRIMARY KEY CLUSTERED ([membership_id] ASC)
    )
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
