USE [ERP]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 22/11/2022 12:38:58 a. m. ******/
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
/****** Object:  Table [dbo].[Evaluation]    Script Date: 22/11/2022 12:38:58 a. m. ******/
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
/****** Object:  Table [dbo].[Module]    Script Date: 22/11/2022 12:38:58 a. m. ******/
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
/****** Object:  Table [dbo].[Operation]    Script Date: 22/11/2022 12:38:58 a. m. ******/
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
/****** Object:  Table [dbo].[Report]    Script Date: 22/11/2022 12:38:58 a. m. ******/
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
/****** Object:  Table [dbo].[Rol]    Script Date: 22/11/2022 12:38:58 a. m. ******/
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
/****** Object:  Table [dbo].[Rol_Operation]    Script Date: 22/11/2022 12:38:58 a. m. ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 22/11/2022 12:38:58 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[id_us] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[password] [nvarchar](50) NOT NULL,
	[id_rol] [int] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[id_us] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Rol] ON 

INSERT [dbo].[Rol] ([id_rol], [rol]) VALUES (1, N'Super Administrador')
INSERT [dbo].[Rol] ([id_rol], [rol]) VALUES (2, N'Administrador de área')
INSERT [dbo].[Rol] ([id_rol], [rol]) VALUES (3, N'Empleado de área')
SET IDENTITY_INSERT [dbo].[Rol] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([id_us], [username], [password], [id_rol]) VALUES (2, N'Brayan', N'a', 1)
INSERT [dbo].[User] ([id_us], [username], [password], [id_rol]) VALUES (3, N'Sebastian', N'a', 1)
INSERT [dbo].[User] ([id_us], [username], [password], [id_rol]) VALUES (4, N'Duilio', N'a', 2)
INSERT [dbo].[User] ([id_us], [username], [password], [id_rol]) VALUES (5, N'Enrique', N'a', 3)
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
