USE [master]
GO
/****** Object:  Database [ERP]    Script Date: 03/12/2022 06:56:54 p. m. ******/
CREATE DATABASE [ERP]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ERP', FILENAME = N'C:\ProgramData\SOLIDWORKS Electrical\MSSQL12.TEW_SQLEXPRESS\MSSQL\DATA\ERP.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ERP_log', FILENAME = N'C:\ProgramData\SOLIDWORKS Electrical\MSSQL12.TEW_SQLEXPRESS\MSSQL\DATA\ERP_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ERP] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ERP].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ERP] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ERP] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ERP] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ERP] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ERP] SET ARITHABORT OFF 
GO
ALTER DATABASE [ERP] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ERP] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ERP] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ERP] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ERP] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ERP] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ERP] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ERP] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ERP] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ERP] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ERP] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ERP] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ERP] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ERP] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ERP] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ERP] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ERP] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ERP] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ERP] SET  MULTI_USER 
GO
ALTER DATABASE [ERP] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ERP] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ERP] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ERP] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [ERP] SET DELAYED_DURABILITY = DISABLED 
GO
USE [ERP]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 03/12/2022 06:56:54 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[id_employee] [int] IDENTITY(1,1) NOT NULL,
	[id_evaluation] [int] NOT NULL,
	[id_moudle] [int] NOT NULL,
	[position] [nvarchar](50) NOT NULL,
	[pay] [nvarchar](50) NOT NULL,
	[work_days] [nvarchar](10) NOT NULL,
	[work_hours] [int] NOT NULL,
	[remaining_holidays] [int] NOT NULL,
	[paid_holidays] [int] NOT NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[id_employee] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Evaluation]    Script Date: 03/12/2022 06:56:54 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Evaluation](
	[id_evaluation] [int] IDENTITY(1,1) NOT NULL,
	[id_us] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[lastname] [nvarchar](50) NOT NULL,
	[age] [int] NOT NULL,
	[email] [nvarchar](70) NULL,
	[phone] [nvarchar](15) NULL,
	[address] [nvarchar](50) NULL,
	[answers] [nvarchar](100) NOT NULL,
	[result] [nvarchar](50) NOT NULL,
	[notes] [nvarchar](150) NULL,
 CONSTRAINT [PK_Evaluation] PRIMARY KEY CLUSTERED 
(
	[id_evaluation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Module]    Script Date: 03/12/2022 06:56:54 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Module](
	[id_module] [int] IDENTITY(1,1) NOT NULL,
	[module] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Module] PRIMARY KEY CLUSTERED 
(
	[id_module] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Operation]    Script Date: 03/12/2022 06:56:54 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Operation](
	[id_operation] [int] IDENTITY(1,1) NOT NULL,
	[operation] [nvarchar](50) NOT NULL,
	[id_module] [int] NOT NULL,
 CONSTRAINT [PK_Operation] PRIMARY KEY CLUSTERED 
(
	[id_operation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Question]    Script Date: 03/12/2022 06:56:54 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question](
	[id_evaluation] [int] NOT NULL,
	[question] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Report]    Script Date: 03/12/2022 06:56:54 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Report](
	[id_report] [int] IDENTITY(1,1) NOT NULL,
	[id_us] [int] NOT NULL,
	[type_report] [int] NOT NULL,
	[data] [nvarchar](500) NOT NULL,
	[date] [date] NOT NULL,
 CONSTRAINT [PK_Report] PRIMARY KEY CLUSTERED 
(
	[id_report] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rol]    Script Date: 03/12/2022 06:56:54 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rol](
	[id_rol] [int] IDENTITY(1,1) NOT NULL,
	[rol] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Rol] PRIMARY KEY CLUSTERED 
(
	[id_rol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rol_Operation]    Script Date: 03/12/2022 06:56:54 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rol_Operation](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_rol] [int] NOT NULL,
	[id_operation] [int] NOT NULL,
 CONSTRAINT [PK_Rol_Operation] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 03/12/2022 06:56:54 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[id_us] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[password] [nvarchar](200) NOT NULL,
	[id_rol] [int] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[id_us] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Evaluation] ON 

INSERT [dbo].[Evaluation] ([id_evaluation], [id_us], [name], [lastname], [age], [email], [phone], [address], [answers], [result], [notes]) VALUES (1, 10, N'asd', N'asd', 21, N'BrayanBHdzL@Gmail.com', N'912345678', N'asd', N',', N'100', N'...')
INSERT [dbo].[Evaluation] ([id_evaluation], [id_us], [name], [lastname], [age], [email], [phone], [address], [answers], [result], [notes]) VALUES (2, 10, N'asd', N'asd', 21, N'BrayanBHdzL@Gmail.com', N'7721460700', N'asd', N',', N'100', N'...')
INSERT [dbo].[Evaluation] ([id_evaluation], [id_us], [name], [lastname], [age], [email], [phone], [address], [answers], [result], [notes]) VALUES (3, 10, N'Brayan', N'Hernández', 20, N'BrayanBHdzL@Gmail.com2', N'7721460702', N'Actopan', N',', N'100', N'...')
INSERT [dbo].[Evaluation] ([id_evaluation], [id_us], [name], [lastname], [age], [email], [phone], [address], [answers], [result], [notes]) VALUES (4, 10, N'Brayan', N'Hernández', 0, N'BrayanBHdzL@Gmail.com1', N'7721460701', N'Actopan', N',', N'100', N'...')
INSERT [dbo].[Evaluation] ([id_evaluation], [id_us], [name], [lastname], [age], [email], [phone], [address], [answers], [result], [notes]) VALUES (5, 10, N'Brayan', N'Hernández', 20, N'BrayanBHdzL@Gmail.com222', N'7721460722', N'Actopan', N'b,c,d,d,d,d,', N'100', N'...')
INSERT [dbo].[Evaluation] ([id_evaluation], [id_us], [name], [lastname], [age], [email], [phone], [address], [answers], [result], [notes]) VALUES (6, 10, N'Brayan', N'Hernández', 0, N'BrayanBHdzL@Gmail.com212', N'7721460122', N'Actopan', N'a,a,a,a,a,a,', N'100', N'Hola')
INSERT [dbo].[Evaluation] ([id_evaluation], [id_us], [name], [lastname], [age], [email], [phone], [address], [answers], [result], [notes]) VALUES (7, 10, N'Brayan', N'Hernández', 0, N'BrayanBHdzL@Gmail.com2221', N'7721460721', N'Actopan', N'd,c,d,d,c,d,', N'100', N'Hola')
SET IDENTITY_INSERT [dbo].[Evaluation] OFF
GO
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Me preocupo por las cosas')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Creo que hago amigos fácilmente')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Tengo una imaginación vívida')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Confío en los demás')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Completo las tareas correctamente')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Suelo enojarme fácilmente')
GO
SET IDENTITY_INSERT [dbo].[Rol] ON 

INSERT [dbo].[Rol] ([id_rol], [rol]) VALUES (1, N'Super Administrador')
INSERT [dbo].[Rol] ([id_rol], [rol]) VALUES (2, N'Administrador de área')
INSERT [dbo].[Rol] ([id_rol], [rol]) VALUES (3, N'Empleado de área')
SET IDENTITY_INSERT [dbo].[Rol] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([id_us], [username], [password], [id_rol]) VALUES (10, N'Brayan', N'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb', 1)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Evaluation] FOREIGN KEY([id_evaluation])
REFERENCES [dbo].[Evaluation] ([id_evaluation])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Evaluation]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Module] FOREIGN KEY([id_moudle])
REFERENCES [dbo].[Module] ([id_module])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Module]
GO
ALTER TABLE [dbo].[Evaluation]  WITH CHECK ADD  CONSTRAINT [FK_Evaluation_User] FOREIGN KEY([id_us])
REFERENCES [dbo].[User] ([id_us])
GO
ALTER TABLE [dbo].[Evaluation] CHECK CONSTRAINT [FK_Evaluation_User]
GO
ALTER TABLE [dbo].[Operation]  WITH CHECK ADD  CONSTRAINT [FK_Operation_Module] FOREIGN KEY([id_module])
REFERENCES [dbo].[Module] ([id_module])
GO
ALTER TABLE [dbo].[Operation] CHECK CONSTRAINT [FK_Operation_Module]
GO
ALTER TABLE [dbo].[Report]  WITH CHECK ADD  CONSTRAINT [FK_Report_User] FOREIGN KEY([id_us])
REFERENCES [dbo].[User] ([id_us])
GO
ALTER TABLE [dbo].[Report] CHECK CONSTRAINT [FK_Report_User]
GO
ALTER TABLE [dbo].[Rol_Operation]  WITH CHECK ADD  CONSTRAINT [FK_Rol_Operation_Operation] FOREIGN KEY([id_operation])
REFERENCES [dbo].[Operation] ([id_operation])
GO
ALTER TABLE [dbo].[Rol_Operation] CHECK CONSTRAINT [FK_Rol_Operation_Operation]
GO
ALTER TABLE [dbo].[Rol_Operation]  WITH CHECK ADD  CONSTRAINT [FK_Rol_Operation_Rol] FOREIGN KEY([id_rol])
REFERENCES [dbo].[Rol] ([id_rol])
GO
ALTER TABLE [dbo].[Rol_Operation] CHECK CONSTRAINT [FK_Rol_Operation_Rol]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Rol] FOREIGN KEY([id_rol])
REFERENCES [dbo].[Rol] ([id_rol])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Rol]
GO
USE [master]
GO
ALTER DATABASE [ERP] SET  READ_WRITE 
GO
