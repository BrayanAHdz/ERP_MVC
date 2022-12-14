USE [ERP]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 09/12/2022 03:52:03 a. m. ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Evaluation]    Script Date: 09/12/2022 03:52:03 a. m. ******/
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
	[answers] [nvarchar](450) NOT NULL,
	[result] [nvarchar](150) NOT NULL,
	[notes] [nvarchar](150) NULL,
	[state] [int] NOT NULL,
 CONSTRAINT [PK_Evaluation] PRIMARY KEY CLUSTERED 
(
	[id_evaluation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Module]    Script Date: 09/12/2022 03:52:03 a. m. ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vEmployee]    Script Date: 09/12/2022 03:52:03 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vEmployee]
AS
SELECT        dbo.Employee.id_employee, dbo.Evaluation.lastname + ' ' + dbo.Evaluation.name AS 'fullname', dbo.Module.module, dbo.Employee.position, dbo.Employee.pay, dbo.Employee.work_days, dbo.Employee.work_hours
FROM            dbo.Employee INNER JOIN
                         dbo.Evaluation ON dbo.Employee.id_evaluation = dbo.Evaluation.id_evaluation INNER JOIN
                         dbo.Module ON dbo.Employee.id_moudle = dbo.Module.id_module
GO
/****** Object:  Table [dbo].[User]    Script Date: 09/12/2022 03:52:03 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[id_us] [int] IDENTITY(1,1) NOT NULL,
	[id_employee] [int] NULL,
	[username] [nvarchar](50) NOT NULL,
	[password] [nvarchar](200) NOT NULL,
	[id_rol] [int] NOT NULL,
	[state] [int] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[id_us] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vEvaluation]    Script Date: 09/12/2022 03:52:03 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vEvaluation]
AS
SELECT        dbo.Evaluation.id_evaluation, dbo.Evaluation.name, dbo.Evaluation.lastname, dbo.Evaluation.result, dbo.Evaluation.notes, dbo.[User].username, dbo.Evaluation.state
FROM            dbo.[User] INNER JOIN
                         dbo.Evaluation ON dbo.[User].id_us = dbo.Evaluation.id_us
GO
/****** Object:  View [dbo].[vStaffTracking]    Script Date: 09/12/2022 03:52:03 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vStaffTracking]
AS
SELECT        dbo.Employee.id_employee, dbo.Evaluation.lastname, dbo.Evaluation.name, dbo.Evaluation.age, dbo.Evaluation.email, dbo.Evaluation.phone, dbo.Evaluation.address, dbo.Module.module, dbo.Employee.position, 
                         dbo.Employee.pay, dbo.Evaluation.result, dbo.Employee.work_days, dbo.Employee.work_hours, dbo.Employee.remaining_holidays, dbo.Employee.paid_holidays
FROM            dbo.Employee INNER JOIN
                         dbo.Evaluation ON dbo.Employee.id_evaluation = dbo.Evaluation.id_evaluation INNER JOIN
                         dbo.Module ON dbo.Employee.id_moudle = dbo.Module.id_module
GO
/****** Object:  Table [dbo].[Operation]    Script Date: 09/12/2022 03:52:03 a. m. ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Question]    Script Date: 09/12/2022 03:52:03 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question](
	[id_evaluation] [int] NOT NULL,
	[question] [nvarchar](100) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Report]    Script Date: 09/12/2022 03:52:03 a. m. ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rol]    Script Date: 09/12/2022 03:52:03 a. m. ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rol_Operation]    Script Date: 09/12/2022 03:52:03 a. m. ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Employee] ON 

INSERT [dbo].[Employee] ([id_employee], [id_evaluation], [id_moudle], [position], [pay], [work_days], [work_hours], [remaining_holidays], [paid_holidays]) VALUES (13, 10, 3, N'Jefe', N'100', N'5', 9, 0, 0)
INSERT [dbo].[Employee] ([id_employee], [id_evaluation], [id_moudle], [position], [pay], [work_days], [work_hours], [remaining_holidays], [paid_holidays]) VALUES (14, 9, 8, N'Limpieza', N'1', N'7', 8, 0, 0)
SET IDENTITY_INSERT [dbo].[Employee] OFF
GO
SET IDENTITY_INSERT [dbo].[Evaluation] ON 

INSERT [dbo].[Evaluation] ([id_evaluation], [id_us], [name], [lastname], [age], [email], [phone], [address], [answers], [result], [notes], [state]) VALUES (9, 10, N'Brayan', N'Hernández', 20, N'Brayan@Gmail.com', N'7721220022', N'Actopan', N'2,3,3,2,3,3,3,3,3,5,4,3,5,3,4,4,4,3,5,5,3,4,3,4,3,3,1,5,3,2,2,4,3,4,5,2,5,3,3,3,2,3,5,4,2,4,4,3,5,4,4,3,1,4,2,3,3,5,5,3,3,2,5,4,4,3,5,3,5,5,2,5,1,1,3,5,1,2,3,3,2,5,4,4,4,3,2,5,2,3,4,4,2,2,3,2,5,5,5,2,2,2,3,4,3,3,3,2,5,4,2,4,4,2,5,3,2,5,3,4,', N'67-70,80,83,85,84-11,10,10,16,11,12|13,18,13,12,16,8|13,14,14,10,12,20|12,16,12,12,18,14|15,15,12,16,14,12', N'Ninguna', 1)
INSERT [dbo].[Evaluation] ([id_evaluation], [id_us], [name], [lastname], [age], [email], [phone], [address], [answers], [result], [notes], [state]) VALUES (10, 10, N'Brayan', N'Hernández', 20, N'Brayan@Gmail.com1', N'7721222022', N'Actopan', N'2,3,3,2,3,3,3,3,3,5,4,3,5,3,4,4,4,3,5,5,3,4,3,4,3,3,1,5,3,2,2,4,3,4,5,2,5,3,3,3,2,3,5,4,2,4,4,3,5,4,4,3,1,4,2,3,3,5,5,3,3,2,5,4,4,3,5,3,5,5,2,5,1,1,3,5,1,2,3,3,2,5,4,4,4,3,2,5,2,3,4,4,2,2,3,2,5,5,5,2,2,2,3,4,3,3,3,2,5,4,2,4,4,2,5,3,2,5,3,4,', N'67-70,80,83,85,84-11,10,10,16,11,12|13,18,13,12,16,8|13,14,14,10,12,20|12,16,12,12,18,14|15,15,12,16,14,12', N'Ninguna', 1)
INSERT [dbo].[Evaluation] ([id_evaluation], [id_us], [name], [lastname], [age], [email], [phone], [address], [answers], [result], [notes], [state]) VALUES (11, 10, N'Nombre_Empleado', N'Apellido_Empleado', 20, N'Empleado_1@Gmail.com', N'7721460701', N'Direccion 1', N'4,4,2,2,3,4,3,2,3,2,2,4,2,3,3,3,4,4,4,2,1,5,3,3,2,3,3,3,2,4,3,2,1,3,3,3,3,3,4,3,3,4,3,3,2,3,2,3,5,5,4,3,4,4,2,2,5,4,5,5,4,5,4,4,5,5,3,2,3,5,4,4,4,5,5,4,4,4,4,4,4,2,3,3,4,5,4,3,3,3,3,3,5,5,5,4,4,3,4,4,4,4,4,4,4,3,4,4,3,3,4,5,5,5,4,4,3,4,4,4,', N'70-83,87,79,88,86-14,16,13,13,13,14|14,13,16,14,15,15|12,10,13,15,15,14|14,14,15,15,16,15|16,14,14,14,12,16', N'Ninguna', 0)
INSERT [dbo].[Evaluation] ([id_evaluation], [id_us], [name], [lastname], [age], [email], [phone], [address], [answers], [result], [notes], [state]) VALUES (12, 10, N'Nombre_Empleado_2', N'Apellido_Empleado_2', 20, N'Empleado_2@Gmail.com', N'7721460702', N'Direccion 1', N'4,4,2,2,3,4,3,2,3,2,2,4,2,3,3,3,4,4,4,2,1,5,3,3,2,3,3,3,2,4,3,2,1,3,3,3,3,3,4,3,3,4,3,3,2,3,2,3,5,5,4,3,4,4,2,2,5,4,5,5,4,5,4,4,5,5,3,2,3,5,4,4,4,5,5,4,4,4,4,4,4,2,3,3,4,5,4,3,3,3,3,3,5,5,5,4,4,3,4,4,4,4,4,4,4,3,4,4,3,3,4,5,5,5,4,4,3,4,4,4,', N'70-83,87,79,88,86-14,16,13,13,13,14|14,13,16,14,15,15|12,10,13,15,15,14|14,14,15,15,16,15|16,14,14,14,12,16', N'Ninguna', 0)
INSERT [dbo].[Evaluation] ([id_evaluation], [id_us], [name], [lastname], [age], [email], [phone], [address], [answers], [result], [notes], [state]) VALUES (13, 10, N'Nombre_Empleado_3', N'Apellido_Empleado_3', 20, N'Empleado_3@Gmail.com', N'7721460703', N'Direccion 1', N'4,4,2,2,3,4,3,2,3,2,2,4,2,3,3,3,4,4,4,2,1,5,3,3,2,3,3,3,2,4,3,2,1,3,3,3,3,3,4,3,3,4,3,3,2,3,2,3,5,5,4,3,4,4,2,2,5,4,5,5,4,5,4,4,5,5,3,2,3,1,5,5,4,5,5,4,4,4,4,3,4,2,3,3,4,5,4,3,3,3,3,3,5,5,5,4,4,3,4,4,4,4,4,4,4,3,4,4,3,3,4,5,5,5,4,4,3,4,4,4,', N'70-84,88,79,88,81-14,16,14,13,13,14|14,13,17,14,15,15|12,10,13,15,15,14|14,14,15,15,16,15|16,10,14,13,12,16', N'Ninguna', 0)
INSERT [dbo].[Evaluation] ([id_evaluation], [id_us], [name], [lastname], [age], [email], [phone], [address], [answers], [result], [notes], [state]) VALUES (14, 10, N'Nombre_Empleado_4', N'Apellido_Empleado_4', 20, N'Empleado_4@Gmail.com', N'7721460704', N'Direccion 4', N'4,4,2,2,3,4,3,2,3,2,2,4,2,3,3,3,4,4,4,2,1,5,3,3,2,3,3,3,2,4,3,2,1,3,3,3,3,3,4,3,3,4,3,3,2,3,2,3,5,5,4,3,4,4,2,2,5,4,5,5,4,5,4,4,5,5,3,2,3,1,5,5,4,5,5,4,4,4,4,3,4,2,3,3,4,5,4,3,3,3,3,3,5,5,5,4,4,3,4,4,4,4,4,4,4,3,4,4,3,3,4,5,5,5,4,4,3,4,4,4,', N'70-84,88,79,88,81-14,16,14,13,13,14|14,13,17,14,15,15|12,10,13,15,15,14|14,14,15,15,16,15|16,10,14,13,12,16', N'Ninguna', 0)
INSERT [dbo].[Evaluation] ([id_evaluation], [id_us], [name], [lastname], [age], [email], [phone], [address], [answers], [result], [notes], [state]) VALUES (15, 10, N'Nombre_Empleado_5', N'Apellido_Empleado_5', 20, N'Empleado_5@Gmail.com', N'7721460705', N'Direccion 5', N'4,4,2,2,3,4,3,2,3,2,2,4,2,3,3,3,4,4,4,2,1,5,3,3,2,3,3,3,2,4,3,2,1,3,3,3,3,3,4,3,3,4,3,3,2,3,2,3,5,5,4,3,4,4,2,2,5,4,5,5,4,5,4,4,5,5,3,2,3,1,5,5,4,5,5,4,4,4,4,3,4,2,3,3,4,5,4,3,3,3,3,3,5,5,5,4,4,3,4,4,4,4,4,4,4,3,4,4,3,3,4,5,5,5,4,4,3,4,4,4,', N'70-84,88,79,88,81-14,16,14,13,13,14|14,13,17,14,15,15|12,10,13,15,15,14|14,14,15,15,16,15|16,10,14,13,12,16', N'Ninguna', 0)
INSERT [dbo].[Evaluation] ([id_evaluation], [id_us], [name], [lastname], [age], [email], [phone], [address], [answers], [result], [notes], [state]) VALUES (16, 10, N'Nombre_Empleado_6', N'Apellido_Empleado_6', 20, N'Empleado_6@Gmail.com', N'7721460706', N'Direccion 6', N'4,4,2,2,3,4,3,2,3,2,2,4,2,3,3,3,4,4,4,2,1,5,3,3,2,3,3,3,2,4,3,2,1,3,3,3,3,3,4,3,3,4,3,3,2,3,2,3,5,5,4,3,4,4,2,2,5,4,5,5,4,5,4,4,5,5,3,2,3,1,5,5,4,5,5,4,4,4,4,3,4,2,3,3,4,5,4,3,3,3,3,3,5,5,5,4,4,3,4,4,4,4,4,4,4,3,4,4,3,3,4,5,5,5,4,4,3,4,4,4,', N'70-84,88,79,88,81-14,16,14,13,13,14|14,13,17,14,15,15|12,10,13,15,15,14|14,14,15,15,16,15|16,10,14,13,12,16', N'Ninguna', 0)
INSERT [dbo].[Evaluation] ([id_evaluation], [id_us], [name], [lastname], [age], [email], [phone], [address], [answers], [result], [notes], [state]) VALUES (17, 10, N'Nombre_Empleado_7', N'Apellido_Empleado_7', 20, N'Empleado_7@Gmail.com', N'7721460707', N'Direccion 7', N'4,4,2,2,3,4,3,2,3,2,2,4,2,3,3,3,4,4,4,2,1,5,3,3,2,3,3,3,2,4,3,2,1,3,3,3,3,3,4,3,3,4,3,3,2,3,2,3,5,5,4,3,4,4,2,2,5,4,5,5,4,5,4,4,5,5,3,2,3,1,5,5,4,5,5,4,4,4,4,3,4,2,3,3,4,5,4,3,3,3,3,3,5,5,5,4,4,3,4,4,4,4,4,4,4,3,4,4,3,3,4,5,5,5,4,4,3,4,4,4,', N'70-84,88,79,88,81-14,16,14,13,13,14|14,13,17,14,15,15|12,10,13,15,15,14|14,14,15,15,16,15|16,10,14,13,12,16', N'Ninguna', 0)
INSERT [dbo].[Evaluation] ([id_evaluation], [id_us], [name], [lastname], [age], [email], [phone], [address], [answers], [result], [notes], [state]) VALUES (18, 11, N'Nombre_Empleado_8', N'Apellido_Empleado_8', 20, N'Empleado_8@Gmail.com', N'7721460708', N'Direccion 8', N'4,4,2,2,3,4,3,2,3,2,2,4,2,3,3,3,4,4,4,2,1,5,3,3,2,3,3,3,2,4,3,2,1,3,3,3,3,3,4,3,3,4,3,3,2,3,2,3,5,5,4,3,4,4,2,2,5,4,5,5,4,5,4,4,5,5,3,2,3,1,5,5,4,5,5,4,4,4,4,3,4,2,3,3,4,5,4,3,3,3,3,3,5,5,5,4,4,3,4,4,4,4,4,4,4,3,4,4,3,3,4,5,5,5,4,4,3,4,4,4,', N'70-84,88,79,88,81-14,16,14,13,13,14|14,13,17,14,15,15|12,10,13,15,15,14|14,14,15,15,16,15|16,10,14,13,12,16', N'Ninguna', 0)
INSERT [dbo].[Evaluation] ([id_evaluation], [id_us], [name], [lastname], [age], [email], [phone], [address], [answers], [result], [notes], [state]) VALUES (19, 11, N'Nombre_Empleado_9', N'Apellido_Empleado_9', 20, N'Empleado_9@Gmail.com', N'7721460709', N'Direccion 9', N'4,4,2,2,3,4,3,2,3,2,2,4,2,3,3,3,4,4,4,2,1,5,3,3,2,3,3,3,2,4,3,2,1,3,3,3,3,3,4,3,3,4,3,3,2,3,2,3,5,5,4,3,4,4,2,2,5,4,5,5,4,5,4,4,5,5,3,2,3,1,5,5,4,5,5,4,4,4,4,3,4,2,3,3,4,5,4,3,3,3,3,3,5,5,5,4,4,3,4,4,4,4,4,4,4,3,4,4,3,3,4,5,5,5,4,4,3,4,4,4,', N'70-84,88,79,88,81-14,16,14,13,13,14|14,13,17,14,15,15|12,10,13,15,15,14|14,14,15,15,16,15|16,10,14,13,12,16', N'Ninguna', 0)
INSERT [dbo].[Evaluation] ([id_evaluation], [id_us], [name], [lastname], [age], [email], [phone], [address], [answers], [result], [notes], [state]) VALUES (20, 12, N'Nombre_Empleado_10', N'Apellido_Empleado_10', 20, N'Empleado_10@Gmail.com', N'7721460710', N'Direccion 10', N'4,4,2,2,3,4,3,2,3,2,2,4,2,3,3,3,4,4,4,2,1,5,3,3,2,3,3,3,2,4,3,2,1,3,3,3,3,3,4,3,3,4,3,3,2,3,2,3,5,5,4,3,4,4,2,2,5,4,5,5,4,5,4,4,5,5,3,2,3,1,5,5,4,5,5,4,4,4,4,3,4,2,3,3,4,5,4,3,3,3,3,3,5,5,5,4,4,3,4,4,4,4,4,4,4,3,4,4,3,3,4,5,5,5,4,4,3,4,4,4,', N'70-84,88,79,88,81-14,16,14,13,13,14|14,13,17,14,15,15|12,10,13,15,15,14|14,14,15,15,16,15|16,10,14,13,12,16', N'Ninguna', 0)
INSERT [dbo].[Evaluation] ([id_evaluation], [id_us], [name], [lastname], [age], [email], [phone], [address], [answers], [result], [notes], [state]) VALUES (21, 12, N'Nombre_Empleado_11', N'Apellido_Empleado_11', 20, N'Empleado_11@Gmail.com', N'7721460711', N'Direccion 11', N'4,4,2,2,3,4,3,2,3,2,2,4,2,3,3,3,4,4,4,2,1,5,3,3,2,3,3,3,2,4,3,2,1,3,3,3,3,3,4,3,3,4,3,3,2,3,2,3,5,5,4,3,4,4,2,2,5,4,5,5,4,5,4,4,5,5,3,2,3,1,5,5,4,5,5,4,4,4,4,3,4,2,3,3,4,5,4,3,3,3,3,3,5,5,5,4,4,3,4,4,4,4,4,4,4,3,4,4,3,3,4,5,5,5,4,4,3,4,4,4,', N'70-84,88,79,88,81-14,16,14,13,13,14|14,13,17,14,15,15|12,10,13,15,15,14|14,14,15,15,16,15|16,10,14,13,12,16', N'Ninguna', 0)
INSERT [dbo].[Evaluation] ([id_evaluation], [id_us], [name], [lastname], [age], [email], [phone], [address], [answers], [result], [notes], [state]) VALUES (22, 12, N'Nombre_Empleado_12', N'Apellido_Empleado_12', 20, N'Empleado_12@Gmail.com', N'7721460712', N'Direccion 12', N'4,4,2,2,3,4,3,2,3,2,2,4,2,3,3,3,4,4,4,2,1,5,3,3,2,3,3,3,2,4,3,2,1,3,3,3,3,3,4,3,3,4,3,3,2,3,2,3,5,5,4,3,4,4,2,2,5,4,5,5,4,5,4,4,5,5,3,2,3,1,5,5,4,5,5,4,4,4,4,3,4,2,3,3,4,5,4,3,3,3,3,3,5,5,5,4,4,3,4,4,4,4,4,4,4,3,4,4,3,3,4,5,5,5,4,4,3,4,4,4,', N'70-84,88,79,88,81-14,16,14,13,13,14|14,13,17,14,15,15|12,10,13,15,15,14|14,14,15,15,16,15|16,10,14,13,12,16', N'Ninguna', 0)
INSERT [dbo].[Evaluation] ([id_evaluation], [id_us], [name], [lastname], [age], [email], [phone], [address], [answers], [result], [notes], [state]) VALUES (23, 11, N'Nombre_Empleado_13', N'Apellido_Empleado_13', 20, N'Empleado_13@Gmail.com', N'7721460713', N'Direccion 13', N'4,4,2,2,3,4,3,2,3,2,2,4,2,3,3,3,4,4,4,2,1,5,3,3,2,3,3,3,2,4,3,2,1,3,3,3,3,3,4,3,3,4,3,3,2,3,2,3,5,5,4,3,4,4,2,2,5,4,5,5,4,5,4,4,5,5,3,2,3,1,5,5,4,5,5,4,4,4,4,3,4,2,3,3,4,5,4,3,3,3,3,3,5,5,5,4,4,3,4,4,4,4,4,4,4,3,4,4,3,3,4,5,5,5,4,4,3,4,4,4,', N'70-84,88,79,88,81-14,16,14,13,13,14|14,13,17,14,15,15|12,10,13,15,15,14|14,14,15,15,16,15|16,10,14,13,12,16', N'Ninguna', 0)
INSERT [dbo].[Evaluation] ([id_evaluation], [id_us], [name], [lastname], [age], [email], [phone], [address], [answers], [result], [notes], [state]) VALUES (24, 12, N'Nombre_Empleado_14', N'Apellido_Empleado_14', 20, N'Empleado_14@Gmail.com', N'7721460714', N'Direccion 14', N'4,4,2,2,3,4,3,2,3,2,2,4,2,3,3,3,4,4,4,2,1,5,3,3,2,3,3,3,2,4,3,2,1,3,3,3,3,3,4,3,3,4,3,3,2,3,2,3,5,5,4,3,4,4,2,2,5,4,5,5,4,5,4,4,5,5,3,2,3,1,5,5,4,5,5,4,4,4,4,3,4,2,3,3,4,5,4,3,3,3,3,3,5,5,5,4,4,3,4,4,4,4,4,4,4,3,4,4,3,3,4,5,5,5,4,4,3,4,4,4,', N'70-84,88,79,88,81-14,16,14,13,13,14|14,13,17,14,15,15|12,10,13,15,15,14|14,14,15,15,16,15|16,10,14,13,12,16', N'Ninguna', 0)
INSERT [dbo].[Evaluation] ([id_evaluation], [id_us], [name], [lastname], [age], [email], [phone], [address], [answers], [result], [notes], [state]) VALUES (25, 12, N'Nombre_Empleado_14', N'Apellido_Empleado_14', 20, N'Empleado_14@Gmail.com', N'7721460714', N'Direccion 14', N'4,4,2,2,3,4,3,2,3,2,2,4,2,3,3,3,4,4,4,2,1,5,3,3,2,3,3,3,2,4,3,2,1,3,3,3,3,3,4,3,3,4,3,3,2,3,2,3,5,5,4,3,4,4,2,2,5,4,5,5,4,5,4,4,5,5,3,2,3,1,5,5,4,5,5,4,4,4,4,3,4,2,3,3,4,5,4,3,3,3,3,3,5,5,5,4,4,3,4,4,4,4,4,4,4,3,4,4,3,3,4,5,5,5,4,4,3,4,4,4,', N'70-84,88,79,88,81-14,16,14,13,13,14|14,13,17,14,15,15|12,10,13,15,15,14|14,14,15,15,16,15|16,10,14,13,12,16', N'Ninguna', 0)
INSERT [dbo].[Evaluation] ([id_evaluation], [id_us], [name], [lastname], [age], [email], [phone], [address], [answers], [result], [notes], [state]) VALUES (26, 12, N'Nombre_Empleado_14', N'Apellido_Empleado_14', 20, N'Empleado_14@Gmail.com', N'7721460714', N'Direccion 14', N'4,4,2,2,3,4,3,2,3,2,2,4,2,3,3,3,4,4,4,2,1,5,3,3,2,3,3,3,2,4,3,2,1,3,3,3,3,3,4,3,3,4,3,3,2,3,2,3,5,5,4,3,4,4,2,2,5,4,5,5,4,5,4,4,5,5,3,2,3,1,5,5,4,5,5,4,4,4,4,3,4,2,3,3,4,5,4,3,3,3,3,3,5,5,5,4,4,3,4,4,4,4,4,4,4,3,4,4,3,3,4,5,5,5,4,4,3,4,4,4,', N'70-84,88,79,88,81-14,16,14,13,13,14|14,13,17,14,15,15|12,10,13,15,15,14|14,14,15,15,16,15|16,10,14,13,12,16', N'Ninguna', 0)
INSERT [dbo].[Evaluation] ([id_evaluation], [id_us], [name], [lastname], [age], [email], [phone], [address], [answers], [result], [notes], [state]) VALUES (27, 12, N'Nombre_Empleado_14', N'Apellido_Empleado_14', 20, N'Empleado_14@Gmail.com', N'7721460714', N'Direccion 14', N'4,4,2,2,3,4,3,2,3,2,2,4,2,3,3,3,4,4,4,2,1,5,3,3,2,3,3,3,2,4,3,2,1,3,3,3,3,3,4,3,3,4,3,3,2,3,2,3,5,5,4,3,4,4,2,2,5,4,5,5,4,5,4,4,5,5,3,2,3,1,5,5,4,5,5,4,4,4,4,3,4,2,3,3,4,5,4,3,3,3,3,3,5,5,5,4,4,3,4,4,4,4,4,4,4,3,4,4,3,3,4,5,5,5,4,4,3,4,4,4,', N'70-84,88,79,88,81-14,16,14,13,13,14|14,13,17,14,15,15|12,10,13,15,15,14|14,14,15,15,16,15|16,10,14,13,12,16', N'Ninguna', 0)
INSERT [dbo].[Evaluation] ([id_evaluation], [id_us], [name], [lastname], [age], [email], [phone], [address], [answers], [result], [notes], [state]) VALUES (28, 12, N'Nombre_Empleado_14', N'Apellido_Empleado_14', 20, N'Empleado_14@Gmail.com', N'7721460714', N'Direccion 14', N'4,4,2,2,3,4,3,2,3,2,2,4,2,3,3,3,4,4,4,2,1,5,3,3,2,3,3,3,2,4,3,2,1,3,3,3,3,3,4,3,3,4,3,3,2,3,2,3,5,5,4,3,4,4,2,2,5,4,5,5,4,5,4,4,5,5,3,2,3,1,5,5,4,5,5,4,4,4,4,3,4,2,3,3,4,5,4,3,3,3,3,3,5,5,5,4,4,3,4,4,4,4,4,4,4,3,4,4,3,3,4,5,5,5,4,4,3,4,4,4,', N'70-84,88,79,88,81-14,16,14,13,13,14|14,13,17,14,15,15|12,10,13,15,15,14|14,14,15,15,16,15|16,10,14,13,12,16', N'Ninguna', 0)
INSERT [dbo].[Evaluation] ([id_evaluation], [id_us], [name], [lastname], [age], [email], [phone], [address], [answers], [result], [notes], [state]) VALUES (29, 12, N'Nombre_Empleado_14', N'Apellido_Empleado_14', 20, N'Empleado_14@Gmail.com', N'7721460714', N'Direccion 14', N'4,4,2,2,3,4,3,2,3,2,2,4,2,3,3,3,4,4,4,2,1,5,3,3,2,3,3,3,2,4,3,2,1,3,3,3,3,3,4,3,3,4,3,3,2,3,2,3,5,5,4,3,4,4,2,2,5,4,5,5,4,5,4,4,5,5,3,2,3,1,5,5,4,5,5,4,4,4,4,3,4,2,3,3,4,5,4,3,3,3,3,3,5,5,5,4,4,3,4,4,4,4,4,4,4,3,4,4,3,3,4,5,5,5,4,4,3,4,4,4,', N'70-84,88,79,88,81-14,16,14,13,13,14|14,13,17,14,15,15|12,10,13,15,15,14|14,14,15,15,16,15|16,10,14,13,12,16', N'Ninguna', 0)
INSERT [dbo].[Evaluation] ([id_evaluation], [id_us], [name], [lastname], [age], [email], [phone], [address], [answers], [result], [notes], [state]) VALUES (30, 10, N'Nombre_Empleado_15', N'Apellido_Empleado_15', 20, N'Empleado_15@Gmail.com', N'7721460715', N'Direccion 15', N'4,4,2,2,3,4,3,2,3,2,2,4,2,3,3,3,4,4,4,2,1,5,3,3,2,3,3,3,2,4,3,2,1,3,3,3,3,3,4,3,3,4,3,3,2,3,2,3,5,5,4,3,4,4,2,2,5,4,5,5,4,5,4,4,5,5,3,2,3,1,5,5,4,5,5,4,4,4,4,3,4,2,3,3,4,5,4,3,3,3,3,3,5,5,5,4,4,3,4,4,4,4,4,4,4,3,4,4,3,3,4,5,5,5,4,4,3,4,4,4,', N'70-84,88,79,88,81-14,16,14,13,13,14|14,13,17,14,15,15|12,10,13,15,15,14|14,14,15,15,16,15|16,10,14,13,12,16', N'Ninguna', 0)
SET IDENTITY_INSERT [dbo].[Evaluation] OFF
GO
SET IDENTITY_INSERT [dbo].[Module] ON 

INSERT [dbo].[Module] ([id_module], [module]) VALUES (1, N'Recursos Humanos')
INSERT [dbo].[Module] ([id_module], [module]) VALUES (2, N'Compras')
INSERT [dbo].[Module] ([id_module], [module]) VALUES (3, N'Calidad')
INSERT [dbo].[Module] ([id_module], [module]) VALUES (4, N'Producción')
INSERT [dbo].[Module] ([id_module], [module]) VALUES (5, N'Empaque')
INSERT [dbo].[Module] ([id_module], [module]) VALUES (6, N'Mantenimiento')
INSERT [dbo].[Module] ([id_module], [module]) VALUES (7, N'Contabilidad')
INSERT [dbo].[Module] ([id_module], [module]) VALUES (8, N'Almacen')
SET IDENTITY_INSERT [dbo].[Module] OFF
GO
SET IDENTITY_INSERT [dbo].[Operation] ON 

INSERT [dbo].[Operation] ([id_operation], [operation], [id_module]) VALUES (1, N'Reportes', 1)
INSERT [dbo].[Operation] ([id_operation], [operation], [id_module]) VALUES (2, N'Usuarios', 1)
SET IDENTITY_INSERT [dbo].[Operation] OFF
GO
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Me preocupo por las cosas')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Creo que hago amigos fácilmente')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Tengo una imaginación vívida')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Confío en los demás')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Completo las tareas correctamente')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Suelo enojarme fácilmente')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Me encantan las fiestas grandes')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Creo que el arte es importante')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Colaboro con otros solo si obtengo algún beneficio propio')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Me gusta mantener las cosas en orden')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'A menudo me siento triste')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Me gusta estar a cargo de las decisiones')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Considero que soy muy sentimental')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Me siento a gusto ayudando a los demás
')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Siempre cumplo mis promesas')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Tengo dificultades para acercarme a los demás')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Estoy ocupado/a todo el tiempo')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Prefiero la variedad antes que la rutina')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Me gusta pelear')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Siempre trabajo duro')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'A menudo voy de borracheras')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Amo la emoción')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Me gusta mucho leer')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Creo que soy mejor que los demás')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Siempre estoy preparado')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Me asusto fácilmente')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Soy una persona muy alegre')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Tiendo a votar por candidatos políticos liberales')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Me compadezco por la gente sin hogar')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Hago las cosas sin razonar mucho sobre ellas')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Temo que suceda lo peor
')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Me siento cómodo con la gente')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'
Disfruto de fantásticos vuelos de fantasía')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Creo que las personas tienen buenas intenciones')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Soy muy bueno en lo que hago')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Me suelo molestar con facilidad')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Me gusta hablar con muchas personas en las fiestas')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Veo belleza en cosas que otros podrían no notar')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Podría hacer trampa si eso me lleva adelante')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'A menudo olvido poner las cosas de vuelta donde las tomé
')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'No me siento bien conmigo mismo
')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Intento dirigir a los demás')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Puedo comprender bien las emociones de los demás')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Me preocupo por los demás
')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Siempre digo la verdad')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Temo ser el centro de atención')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Creo que soy una persona activa y vigorosa')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'
Prefiero quedarme cosas que conozco')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Suelo gritar a las personas')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Hago más de lo que se espera de mí')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'
Rara vez me dejo llevar')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Siempre busco la aventura')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Intento evitar discusiones filosóficas')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Espero mucho de mí mismo')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Llevo a cabo mis planes')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Me abrumo fácilmente de las cosas que suceden alrededor')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Pienso que soy una persona muy divertida')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'No creo que haya acciones completamente correctas o incorrectas')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Siento simpatía por aquellos que se encuentran en peores situaciones que yo
')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Suelo tomar decisiones precipitadas')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Tengo miedo de muchas cosas')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'A menudo evito el contacto con los demás
')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Soy una persona que a veces sueña despierta')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Confío en lo que dicen las personas')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Realizo mis tareas sin ningún problema')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'A veces pierdo los estribos')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Prefiero estar solo')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'No me gusta la poesía')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'
Me aprovecho de los demás')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Mi habitación es muy desordenada')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'A menudo me siento bajoneado')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Tomo el control de las cosas')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'En raras ocasiones noto mis reacciones emocionales')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Soy indiferente a los sentimientos de los demás')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Las reglas fueron hechas para romperse')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Sólo me siento cómodo en compañía de amigos')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Hago muchas cosas en mi tiempo libre')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'No me atraen situaciones en constante cambio')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'No tengo recelo en insultar a la gente')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Solo hago el trabajo justo para haberlo cumplido')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Resisto las tentaciones fácilmente')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Me gusta ser imprudente')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Me es difícil entender ideas abstractas')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Tengo altas expectativas de mí mismo')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'No hago mucho en mi tiempo libre')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'A veces siento que no soy capaz de manejar situaciones')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Amo la vida')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Tiendo a votar por los candidatos políticos conservativos')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'No me suelo implicar en los problemas de los demás')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Hago las cosas sin cautela')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Tiendo a estresarme con facilidad')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Siempre mantengo cierta distancia con las personas')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Me gusta perderme en mis pensamientos')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Desconfío de la gente')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Generalmente sé cómo hacer las cosas')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'No me molesto fácilmente')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'No me gusta mezclarme con la gente')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'No me agrada ir a museos de arte')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Sería capaz de sabotear los planes de otros')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Dejo mis pertenencias aquí y allá')
GO
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Me siento cómodo conmigo mismo')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'
Espero que alguien más lleve la batuta en un grupo')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'No comprendo a las personas que se emocionan fácilmente')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'No tengo tiempo para los demás')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'No suelo cumplir mis promesas')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'No me molestan las situaciones sociales difíciles')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Me gusta tomar las cosas con calma')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Soy una persona mayormente conservadora')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'No suelo apoyar a los otros')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Pongo poco tiempo y esfuerzo en mi trabajo')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Siempre puedo controlar mis antojos')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Creo que soy una persona activa y vigorosa')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'No me interesan las discusiones teóricas')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Me jacto de mis virtudes')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Tengo dificultad para comenzar tareas')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Me mantengo tranquilo/a bajo presión')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Siempre miro el buen lado de la vida')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Creo que deberíamos ser severos con el crimen')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Trato de no pensar en los necesitados')
INSERT [dbo].[Question] ([id_evaluation], [question]) VALUES (0, N'Actúo sin pensar')
GO
SET IDENTITY_INSERT [dbo].[Rol] ON 

INSERT [dbo].[Rol] ([id_rol], [rol]) VALUES (1, N'Super Administrador')
INSERT [dbo].[Rol] ([id_rol], [rol]) VALUES (2, N'Administrador de área')
INSERT [dbo].[Rol] ([id_rol], [rol]) VALUES (3, N'Empleado de área')
SET IDENTITY_INSERT [dbo].[Rol] OFF
GO
SET IDENTITY_INSERT [dbo].[Rol_Operation] ON 

INSERT [dbo].[Rol_Operation] ([id], [id_rol], [id_operation]) VALUES (1, 1, 1)
INSERT [dbo].[Rol_Operation] ([id], [id_rol], [id_operation]) VALUES (2, 1, 2)
INSERT [dbo].[Rol_Operation] ([id], [id_rol], [id_operation]) VALUES (3, 2, 1)
SET IDENTITY_INSERT [dbo].[Rol_Operation] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([id_us], [id_employee], [username], [password], [id_rol], [state]) VALUES (10, NULL, N'Brayan', N'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb', 1, 0)
INSERT [dbo].[User] ([id_us], [id_employee], [username], [password], [id_rol], [state]) VALUES (11, NULL, N'Duilio', N'4cf6829aa93728e8f3c97df913fb1bfa95fe5810e2933a05943f8312a98d9cf2', 2, 0)
INSERT [dbo].[User] ([id_us], [id_employee], [username], [password], [id_rol], [state]) VALUES (12, NULL, N'Sebastian', N'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb', 3, 0)
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
/****** Object:  StoredProcedure [dbo].[AllEvaluationList]    Script Date: 09/12/2022 03:52:03 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Brayan Hernández
-- Create date: 7/10/2022
-- Description:	Obtener 10 objetos de vEvaluation 0 o 1
-- =============================================
CREATE PROCEDURE [dbo].[AllEvaluationList]
	@search VARCHAR,
	@fisrt INT,
	@last INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM vEvaluation
		WHERE name LIKE '%' +  @search +  '%' OR  lastname LIKE '%' +  @search +  '%'
			ORDER BY id_evaluation
				OFFSET @fisrt ROWS
					FETCH NEXT @last ROWS ONLY
END
GO
/****** Object:  StoredProcedure [dbo].[EmployeeList]    Script Date: 09/12/2022 03:52:03 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Brayan Hernández
-- Create date: 7/10/2022
-- Description:	Obtener 10 objetos de vEmployee
-- =============================================
CREATE PROCEDURE [dbo].[EmployeeList] 
	@search VARCHAR,
	@fisrt INT,
	@last INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM vEmployee
		WHERE fullname LIKE '%' +  @search +  '%' OR  module LIKE '%' +  @search +  '%' OR position LIKE '%' +  @search +  '%'
			ORDER BY id_employee
				OFFSET @fisrt ROWS
					FETCH NEXT @last ROWS ONLY
END
GO
/****** Object:  StoredProcedure [dbo].[EvaluationList]    Script Date: 09/12/2022 03:52:03 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Brayan Hernández
-- Create date: 7/10/2022
-- Description:	Obtener 10 objetos de vEvaluation
-- =============================================
CREATE PROCEDURE [dbo].[EvaluationList]
	@search VARCHAR,
	@fisrt INT,
	@last INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM vEvaluation
		WHERE (name LIKE '%' +  @search +  '%' OR  lastname LIKE '%' +  @search +  '%') AND state = 0
			ORDER BY id_evaluation
				OFFSET @fisrt ROWS
					FETCH NEXT @last ROWS ONLY
END
GO
/****** Object:  StoredProcedure [dbo].[UserList]    Script Date: 09/12/2022 03:52:03 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Brayan Hernández
-- Create date: 7/10/2022
-- Description:	Obtener 10 objetos de User
-- =============================================
CREATE PROCEDURE [dbo].[UserList] 
	@search VARCHAR,
	@fisrt INT,
	@last INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM [dbo].[User]
		WHERE username LIKE '%' +  @search +  '%' AND state = 0
			ORDER BY id_us
				OFFSET @fisrt ROWS
					FETCH NEXT @last ROWS ONLY
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Employee"
            Begin Extent = 
               Top = 11
               Left = 249
               Bottom = 141
               Right = 441
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "Evaluation"
            Begin Extent = 
               Top = 111
               Left = 49
               Bottom = 241
               Right = 219
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Module"
            Begin Extent = 
               Top = 5
               Left = 471
               Bottom = 101
               Right = 641
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1785
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vEmployee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vEmployee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[10] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "User"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Evaluation"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 8
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vEvaluation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vEvaluation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Employee"
            Begin Extent = 
               Top = 3
               Left = 212
               Bottom = 133
               Right = 404
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "Evaluation"
            Begin Extent = 
               Top = 110
               Left = 11
               Bottom = 240
               Right = 181
            End
            DisplayFlags = 280
            TopColumn = 8
         End
         Begin Table = "Module"
            Begin Extent = 
               Top = 0
               Left = 433
               Bottom = 96
               Right = 603
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vStaffTracking'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vStaffTracking'
GO
