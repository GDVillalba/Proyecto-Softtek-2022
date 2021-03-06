USE [master]
GO
/****** Object:  Database [TP_Cripto_BD]    Script Date: 25/06/2022 10:09:12 ******/
CREATE DATABASE [TP_Cripto_BD]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TP_Cripto_BD', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\TP_Cripto_BD.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TP_Cripto_BD_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\TP_Cripto_BD_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [TP_Cripto_BD] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TP_Cripto_BD].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TP_Cripto_BD] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TP_Cripto_BD] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TP_Cripto_BD] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TP_Cripto_BD] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TP_Cripto_BD] SET ARITHABORT OFF 
GO
ALTER DATABASE [TP_Cripto_BD] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TP_Cripto_BD] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TP_Cripto_BD] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TP_Cripto_BD] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TP_Cripto_BD] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TP_Cripto_BD] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TP_Cripto_BD] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TP_Cripto_BD] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TP_Cripto_BD] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TP_Cripto_BD] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TP_Cripto_BD] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TP_Cripto_BD] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TP_Cripto_BD] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TP_Cripto_BD] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TP_Cripto_BD] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TP_Cripto_BD] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TP_Cripto_BD] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TP_Cripto_BD] SET RECOVERY FULL 
GO
ALTER DATABASE [TP_Cripto_BD] SET  MULTI_USER 
GO
ALTER DATABASE [TP_Cripto_BD] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TP_Cripto_BD] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TP_Cripto_BD] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TP_Cripto_BD] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TP_Cripto_BD] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'TP_Cripto_BD', N'ON'
GO
ALTER DATABASE [TP_Cripto_BD] SET QUERY_STORE = OFF
GO
USE [TP_Cripto_BD]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [TP_Cripto_BD]
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 25/06/2022 10:09:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cliente](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[usuario] [varchar](50) NOT NULL,
	[clave] [varchar](50) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[mail] [varchar](50) NULL,
	[telefono] [varchar](50) NULL,
	[fechaAlta] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cuenta]    Script Date: 25/06/2022 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cuenta](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idTitular] [int] NOT NULL,
	[idMoneda] [int] NOT NULL,
	[CBU_UUID] [varchar](50) NOT NULL,
	[alias] [varchar](50) NULL,
	[numeroCuenta] [int] NULL,
	[saldo] [numeric](38, 10) NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
	[fechaAlta] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Moneda]    Script Date: 25/06/2022 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Moneda](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[cotizacionEnUSD] [numeric](38, 10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Movimiento]    Script Date: 25/06/2022 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movimiento](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idCuenta] [int] NOT NULL,
	[debito] [numeric](38, 10) NOT NULL,
	[credito] [numeric](38, 10) NOT NULL,
	[saldo] [numeric](38, 10) NOT NULL,
	[descripcion] [varchar](50) NULL,
	[fecha] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Cliente] ON 

INSERT [dbo].[Cliente] ([id], [usuario], [clave], [nombre], [mail], [telefono], [fechaAlta]) VALUES (1, N'usuario1', N'1234', N'usuario1', N'usuario1@mail.com', N'1234-1234', CAST(N'2022-06-08' AS Date))
INSERT [dbo].[Cliente] ([id], [usuario], [clave], [nombre], [mail], [telefono], [fechaAlta]) VALUES (2, N'usuario2', N'1234', N'usuario2', N'usuario2@mail.com', N'2345-2345', CAST(N'2022-06-10' AS Date))
INSERT [dbo].[Cliente] ([id], [usuario], [clave], [nombre], [mail], [telefono], [fechaAlta]) VALUES (3, N'usuario3', N'1234', N'Cliente  3', N'usuario3@mail.com', N'1233-1233', CAST(N'2022-06-10' AS Date))
INSERT [dbo].[Cliente] ([id], [usuario], [clave], [nombre], [mail], [telefono], [fechaAlta]) VALUES (4, N'usuario4', N'1234', N'Cliente 4', N'usuario4@mail.com', N'1234-4324', CAST(N'2022-06-14' AS Date))
INSERT [dbo].[Cliente] ([id], [usuario], [clave], [nombre], [mail], [telefono], [fechaAlta]) VALUES (5, N'usuario5', N'1234', N'Cliente 5', N'usuario_5@mail.com', N'1231455', CAST(N'2022-06-14' AS Date))
SET IDENTITY_INSERT [dbo].[Cliente] OFF
SET IDENTITY_INSERT [dbo].[Cuenta] ON 

INSERT [dbo].[Cuenta] ([id], [idTitular], [idMoneda], [CBU_UUID], [alias], [numeroCuenta], [saldo], [descripcion], [fechaAlta]) VALUES (1, 1, 1, N'0010000000000000000001', N'cuenta.prueba.uno', 1, CAST(100.0000000000 AS Numeric(38, 10)), N'1ra cuenta en dolares', CAST(N'2022-06-08' AS Date))
INSERT [dbo].[Cuenta] ([id], [idTitular], [idMoneda], [CBU_UUID], [alias], [numeroCuenta], [saldo], [descripcion], [fechaAlta]) VALUES (3, 1, 2, N'1234500653234932185432', N'cuenta.dos', 3, CAST(0.0000000000 AS Numeric(38, 10)), N'2da cuenta', CAST(N'2022-06-08' AS Date))
INSERT [dbo].[Cuenta] ([id], [idTitular], [idMoneda], [CBU_UUID], [alias], [numeroCuenta], [saldo], [descripcion], [fechaAlta]) VALUES (5, 1, 3, N'1234512398743275610385', N'cuenta.tres', 5, CAST(0.0000000000 AS Numeric(38, 10)), N'3ra cuenta', CAST(N'2022-06-08' AS Date))
INSERT [dbo].[Cuenta] ([id], [idTitular], [idMoneda], [CBU_UUID], [alias], [numeroCuenta], [saldo], [descripcion], [fechaAlta]) VALUES (6, 2, 1, N'2341515151515', N'cuenta.dos.uno', 6, CAST(0.0000000000 AS Numeric(38, 10)), N'U2 1ra cuenta', CAST(N'2022-06-10' AS Date))
INSERT [dbo].[Cuenta] ([id], [idTitular], [idMoneda], [CBU_UUID], [alias], [numeroCuenta], [saldo], [descripcion], [fechaAlta]) VALUES (7, 3, 1, N'0000000000000000000014', NULL, 7, CAST(1250.0000000000 AS Numeric(38, 10)), N'Cuenta en dolares 1', CAST(N'2022-06-13' AS Date))
INSERT [dbo].[Cuenta] ([id], [idTitular], [idMoneda], [CBU_UUID], [alias], [numeroCuenta], [saldo], [descripcion], [fechaAlta]) VALUES (8, 4, 3, N'54747eeeeeeddadd0000000000000004', NULL, 8, CAST(0.0000000000 AS Numeric(38, 10)), N'cuenta bitcoin cliente 4', CAST(N'2022-06-14' AS Date))
INSERT [dbo].[Cuenta] ([id], [idTitular], [idMoneda], [CBU_UUID], [alias], [numeroCuenta], [saldo], [descripcion], [fechaAlta]) VALUES (9, 4, 2, N'0000000000000000000001', NULL, 9, CAST(0.0000000000 AS Numeric(38, 10)), N'test 7', CAST(N'2022-06-14' AS Date))
INSERT [dbo].[Cuenta] ([id], [idTitular], [idMoneda], [CBU_UUID], [alias], [numeroCuenta], [saldo], [descripcion], [fechaAlta]) VALUES (10, 4, 2, N'0000000000000000000002', NULL, 10, CAST(0.0000000000 AS Numeric(38, 10)), N'gfgj', CAST(N'2022-06-14' AS Date))
INSERT [dbo].[Cuenta] ([id], [idTitular], [idMoneda], [CBU_UUID], [alias], [numeroCuenta], [saldo], [descripcion], [fechaAlta]) VALUES (11, 3, 1, N'0000000000000000000003', NULL, 11, CAST(100.0000000000 AS Numeric(38, 10)), N'cuenta en dolares 2', CAST(N'2022-06-25' AS Date))
INSERT [dbo].[Cuenta] ([id], [idTitular], [idMoneda], [CBU_UUID], [alias], [numeroCuenta], [saldo], [descripcion], [fechaAlta]) VALUES (12, 5, 3, N'00000000000000000000000000000002', NULL, 12, CAST(1.0000218750 AS Numeric(38, 10)), N'cuenta bitcoin 1 cliente 5', CAST(N'2022-06-25' AS Date))
INSERT [dbo].[Cuenta] ([id], [idTitular], [idMoneda], [CBU_UUID], [alias], [numeroCuenta], [saldo], [descripcion], [fechaAlta]) VALUES (13, 5, 2, N'0000000000000000000004', NULL, 13, CAST(900.0000000000 AS Numeric(38, 10)), N'cuenta pesos 1 cliente 5', CAST(N'2022-06-25' AS Date))
SET IDENTITY_INSERT [dbo].[Cuenta] OFF
SET IDENTITY_INSERT [dbo].[Moneda] ON 

INSERT [dbo].[Moneda] ([id], [nombre], [cotizacionEnUSD]) VALUES (1, N'dolar', CAST(1.0000000000 AS Numeric(38, 10)))
INSERT [dbo].[Moneda] ([id], [nombre], [cotizacionEnUSD]) VALUES (2, N'peso', CAST(224.0000000000 AS Numeric(38, 10)))
INSERT [dbo].[Moneda] ([id], [nombre], [cotizacionEnUSD]) VALUES (3, N'bitcoin', CAST(0.0000490000 AS Numeric(38, 10)))
SET IDENTITY_INSERT [dbo].[Moneda] OFF
SET IDENTITY_INSERT [dbo].[Movimiento] ON 

INSERT [dbo].[Movimiento] ([id], [idCuenta], [debito], [credito], [saldo], [descripcion], [fecha]) VALUES (1, 7, CAST(0.0000000000 AS Numeric(38, 10)), CAST(1000.0000000000 AS Numeric(38, 10)), CAST(1000.0000000000 AS Numeric(38, 10)), N'Deposito 1000.00', CAST(N'2022-06-23' AS Date))
INSERT [dbo].[Movimiento] ([id], [idCuenta], [debito], [credito], [saldo], [descripcion], [fecha]) VALUES (2, 7, CAST(100.0000000000 AS Numeric(38, 10)), CAST(0.0000000000 AS Numeric(38, 10)), CAST(900.0000000000 AS Numeric(38, 10)), N'Extraccion 100.00', CAST(N'2022-06-23' AS Date))
INSERT [dbo].[Movimiento] ([id], [idCuenta], [debito], [credito], [saldo], [descripcion], [fecha]) VALUES (3, 7, CAST(0.0000000000 AS Numeric(38, 10)), CAST(100.0000000000 AS Numeric(38, 10)), CAST(1000.0000000000 AS Numeric(38, 10)), N'Deposito 100.00', CAST(N'2022-06-23' AS Date))
INSERT [dbo].[Movimiento] ([id], [idCuenta], [debito], [credito], [saldo], [descripcion], [fecha]) VALUES (4, 7, CAST(100.0000000000 AS Numeric(38, 10)), CAST(0.0000000000 AS Numeric(38, 10)), CAST(900.0000000000 AS Numeric(38, 10)), N'Extraccion 100.00', CAST(N'2022-06-23' AS Date))
INSERT [dbo].[Movimiento] ([id], [idCuenta], [debito], [credito], [saldo], [descripcion], [fecha]) VALUES (5, 7, CAST(0.0000000000 AS Numeric(38, 10)), CAST(100.0000000000 AS Numeric(38, 10)), CAST(1000.0000000000 AS Numeric(38, 10)), N'Deposito 100.00', CAST(N'2022-06-23' AS Date))
INSERT [dbo].[Movimiento] ([id], [idCuenta], [debito], [credito], [saldo], [descripcion], [fecha]) VALUES (6, 7, CAST(0.0000000000 AS Numeric(38, 10)), CAST(100.0000000000 AS Numeric(38, 10)), CAST(1100.0000000000 AS Numeric(38, 10)), N'Deposito 100,00 .', CAST(N'2022-06-23' AS Date))
INSERT [dbo].[Movimiento] ([id], [idCuenta], [debito], [credito], [saldo], [descripcion], [fecha]) VALUES (7, 7, CAST(0.0000000000 AS Numeric(38, 10)), CAST(100.0000000000 AS Numeric(38, 10)), CAST(1200.0000000000 AS Numeric(38, 10)), N'Deposito 100,00 .', CAST(N'2022-06-23' AS Date))
INSERT [dbo].[Movimiento] ([id], [idCuenta], [debito], [credito], [saldo], [descripcion], [fecha]) VALUES (8, 7, CAST(0.0000000000 AS Numeric(38, 10)), CAST(150.0000000000 AS Numeric(38, 10)), CAST(1350.0000000000 AS Numeric(38, 10)), N'Deposito 150,00 .', CAST(N'2022-06-23' AS Date))
INSERT [dbo].[Movimiento] ([id], [idCuenta], [debito], [credito], [saldo], [descripcion], [fecha]) VALUES (9, 1, CAST(0.0000000000 AS Numeric(38, 10)), CAST(100.0000000000 AS Numeric(38, 10)), CAST(100.0000000000 AS Numeric(38, 10)), N'Deposito 100,00 .', CAST(N'2022-06-23' AS Date))
INSERT [dbo].[Movimiento] ([id], [idCuenta], [debito], [credito], [saldo], [descripcion], [fecha]) VALUES (10, 7, CAST(100.0000000000 AS Numeric(38, 10)), CAST(0.0000000000 AS Numeric(38, 10)), CAST(1250.0000000000 AS Numeric(38, 10)), N'Transferencia a cuenta cuenta en dolares 2', CAST(N'2022-06-25' AS Date))
INSERT [dbo].[Movimiento] ([id], [idCuenta], [debito], [credito], [saldo], [descripcion], [fecha]) VALUES (11, 11, CAST(0.0000000000 AS Numeric(38, 10)), CAST(100.0000000000 AS Numeric(38, 10)), CAST(100.0000000000 AS Numeric(38, 10)), N'Transferencia de cuenta Cuenta en dolares 1', CAST(N'2022-06-25' AS Date))
INSERT [dbo].[Movimiento] ([id], [idCuenta], [debito], [credito], [saldo], [descripcion], [fecha]) VALUES (12, 12, CAST(0.0000000000 AS Numeric(38, 10)), CAST(1.0000000000 AS Numeric(38, 10)), CAST(1.0000000000 AS Numeric(38, 10)), N'Deposito 1,00 .', CAST(N'2022-06-25' AS Date))
INSERT [dbo].[Movimiento] ([id], [idCuenta], [debito], [credito], [saldo], [descripcion], [fecha]) VALUES (13, 13, CAST(0.0000000000 AS Numeric(38, 10)), CAST(1000.0000000000 AS Numeric(38, 10)), CAST(1000.0000000000 AS Numeric(38, 10)), N'Deposito 1000,00 .', CAST(N'2022-06-25' AS Date))
INSERT [dbo].[Movimiento] ([id], [idCuenta], [debito], [credito], [saldo], [descripcion], [fecha]) VALUES (14, 13, CAST(100.0000000000 AS Numeric(38, 10)), CAST(0.0000000000 AS Numeric(38, 10)), CAST(900.0000000000 AS Numeric(38, 10)), N'Transferencia a cuenta cuenta bitcoin 1 cliente 5', CAST(N'2022-06-25' AS Date))
INSERT [dbo].[Movimiento] ([id], [idCuenta], [debito], [credito], [saldo], [descripcion], [fecha]) VALUES (15, 12, CAST(0.0000000000 AS Numeric(38, 10)), CAST(0.0000218750 AS Numeric(38, 10)), CAST(1.0000218750 AS Numeric(38, 10)), N'Transferencia de cuenta cuenta pesos 1 cliente 5', CAST(N'2022-06-25' AS Date))
SET IDENTITY_INSERT [dbo].[Movimiento] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Cliente__9AFF8FC6C3321C8E]    Script Date: 25/06/2022 10:09:13 ******/
ALTER TABLE [dbo].[Cliente] ADD UNIQUE NONCLUSTERED 
(
	[usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT (getdate()) FOR [fechaAlta]
GO
ALTER TABLE [dbo].[Cuenta] ADD  DEFAULT ((0)) FOR [saldo]
GO
ALTER TABLE [dbo].[Cuenta] ADD  DEFAULT (getdate()) FOR [fechaAlta]
GO
ALTER TABLE [dbo].[Movimiento] ADD  DEFAULT ((0)) FOR [debito]
GO
ALTER TABLE [dbo].[Movimiento] ADD  DEFAULT ((0)) FOR [credito]
GO
ALTER TABLE [dbo].[Movimiento] ADD  DEFAULT ((0)) FOR [saldo]
GO
ALTER TABLE [dbo].[Movimiento] ADD  DEFAULT (getdate()) FOR [fecha]
GO
ALTER TABLE [dbo].[Cuenta]  WITH CHECK ADD  CONSTRAINT [FK_Cuenta_ToCliente] FOREIGN KEY([idTitular])
REFERENCES [dbo].[Cliente] ([id])
GO
ALTER TABLE [dbo].[Cuenta] CHECK CONSTRAINT [FK_Cuenta_ToCliente]
GO
ALTER TABLE [dbo].[Cuenta]  WITH CHECK ADD  CONSTRAINT [FK_Cuenta_ToMoneda] FOREIGN KEY([idMoneda])
REFERENCES [dbo].[Moneda] ([id])
GO
ALTER TABLE [dbo].[Cuenta] CHECK CONSTRAINT [FK_Cuenta_ToMoneda]
GO
ALTER TABLE [dbo].[Movimiento]  WITH CHECK ADD  CONSTRAINT [FK_Cuenta_ToCuenta] FOREIGN KEY([idCuenta])
REFERENCES [dbo].[Cuenta] ([id])
GO
ALTER TABLE [dbo].[Movimiento] CHECK CONSTRAINT [FK_Cuenta_ToCuenta]
GO
/****** Object:  StoredProcedure [dbo].[ActualizarCotizacionMoneda]    Script Date: 25/06/2022 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[ActualizarCotizacionMoneda](
@id int,
@cotizacionEnUSD numeric(38,10)
)
as
begin
	update Moneda set cotizacionEnUSD=@cotizacionEnUSD where id=@id
end
GO
/****** Object:  StoredProcedure [dbo].[ActualizarSaldoCuenta]    Script Date: 25/06/2022 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[ActualizarSaldoCuenta](
@id int,
@saldo numeric(38,10)
)
as
begin
	update Cuenta set saldo=@saldo where id=@id
end
GO
/****** Object:  StoredProcedure [dbo].[CrearCuenta]    Script Date: 25/06/2022 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CrearCuenta]
(
     @idTitular int
    , @idMoneda int
    , @CBU_UUID varchar(50)
	, @descripcion varchar(50)
)
AS
BEGIN
    BEGIN TRANSACTION;
    SAVE TRANSACTION MySavePoint;

    BEGIN TRY
        INSERT INTO Cuenta
            (
            idTitular
            ,idMoneda
            ,CBU_UUID
            ,descripcion
            )
        VALUES (
            @idTitular
            , @idMoneda
            , @CBU_UUID
            , @descripcion
            );
		
		UPDATE Cuenta 
        SET numeroCuenta = id 
        WHERE (CBU_UUID = @CBU_UUID);

        COMMIT TRANSACTION 
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION MySavePoint; -- rollback to MySavePoint
        END
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[Depositar]    Script Date: 25/06/2022 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Depositar]
(
     @idCuenta int
    , @deposito numeric(38,10)
	,@saldo numeric(38,10)
	, @descripcion varchar(50)
)
AS
BEGIN
    BEGIN TRANSACTION;
    SAVE TRANSACTION MySavePoint;

    BEGIN TRY
        update Cuenta set saldo=@saldo  where id=@idCuenta

		INSERT INTO Movimiento
            (
            idCuenta
            ,credito
            ,saldo
            ,descripcion
            )
        VALUES (
            @idCuenta
            , @deposito
            , @saldo
            , @descripcion
            );

        COMMIT TRANSACTION 
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION MySavePoint; -- rollback to MySavePoint
        END
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[EditarCliente]    Script Date: 25/06/2022 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[EditarCliente](
@id int,
@clave varchar(50),
@nombre varchar(50),
@mail varchar(50),
@telefono varchar(50)
)
as
begin
	update Cliente set clave=@clave, nombre=@nombre, mail=@mail, telefono=@telefono where id=@id
end
GO
/****** Object:  StoredProcedure [dbo].[EditarCuenta]    Script Date: 25/06/2022 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[EditarCuenta](
@id int,
@alias varchar(50),
@descripcion varchar(50)
)
as
begin
	update Cuenta set alias=@alias, descripcion=@descripcion where id=@id
end
GO
/****** Object:  StoredProcedure [dbo].[EliminarCliente]    Script Date: 25/06/2022 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[EliminarCliente](
@id int
)
as
begin
	delete from Cliente where id = @id
end
GO
/****** Object:  StoredProcedure [dbo].[EliminarCuenta]    Script Date: 25/06/2022 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[EliminarCuenta](
@id int
)
as
begin
	delete from Cuenta where id = @id
end
GO
/****** Object:  StoredProcedure [dbo].[EliminarMoneda]    Script Date: 25/06/2022 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[EliminarMoneda](
@id int
)
as
begin
	delete from Moneda where id = @id
end
GO
/****** Object:  StoredProcedure [dbo].[Extraer]    Script Date: 25/06/2022 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Extraer]
(
     @idCuenta int
    , @extraccion numeric(38,10)
	,@saldo numeric(38,10)
	, @descripcion varchar(50)
)
AS
BEGIN
    BEGIN TRANSACTION;
    SAVE TRANSACTION MySavePoint;

    BEGIN TRY
        update Cuenta set saldo=@saldo  where id=@idCuenta

		INSERT INTO Movimiento
            (
            idCuenta
            ,debito
            ,saldo
            ,descripcion
            )
        VALUES (
            @idCuenta
            , @extraccion
            , @saldo
            , @descripcion
            );

        COMMIT TRANSACTION 
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION MySavePoint; -- rollback to MySavePoint
        END
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[GuardarCliente]    Script Date: 25/06/2022 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GuardarCliente](
@usuario varchar(50),
@clave varchar(50),
@nombre varchar(50),
@mail varchar(50),
@telefono varchar(50)
)
as
begin
	insert into Cliente(usuario, clave, nombre, mail, telefono) values(@usuario, @clave, @nombre, @mail, @telefono)
end
GO
/****** Object:  StoredProcedure [dbo].[GuardarCuenta]    Script Date: 25/06/2022 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GuardarCuenta](
@idTitular int,
@idMoneda int,
@CBU_UUID varchar(50),
@alias varchar(50),
@numeroCuenta varchar(50),
@saldo numeric(38,10),
@descripcion varchar(50)
)
as
begin
	insert into Cuenta(idTitular, idMoneda, CBU_UUID, alias, numeroCuenta, saldo, descripcion) values(@idTitular, @idMoneda, @CBU_UUID, @alias, @numeroCuenta, @saldo, @descripcion)
end
GO
/****** Object:  StoredProcedure [dbo].[GuardarMoneda]    Script Date: 25/06/2022 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[GuardarMoneda](
@nombre varchar(50),
@cotizacionEnUSD numeric(38,10)
)
as
begin
	insert into Moneda(nombre, cotizacionEnUSD) values(@nombre, @cotizacionEnUSD)
end
GO
/****** Object:  StoredProcedure [dbo].[ListarCliente]    Script Date: 25/06/2022 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ListarCliente]
as
begin
	select * from Cliente
end
GO
/****** Object:  StoredProcedure [dbo].[ListarCuentaCliente]    Script Date: 25/06/2022 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[ListarCuentaCliente](
@idTitular int)
as
begin
	SELECT C.id, C.idTitular, C.idMoneda, C.CBU_UUID, C.alias, C.numeroCuenta, C.saldo, C.descripcion, C.fechaAlta, M.nombre  
	FROM Cuenta C INNER JOIN Moneda M ON M.Id = C.idMoneda 
	WHERE C.idTitular=@idTitular
end
GO
/****** Object:  StoredProcedure [dbo].[ListarMoneda]    Script Date: 25/06/2022 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ListarMoneda]
as
begin
	select * from Moneda
end
GO
/****** Object:  StoredProcedure [dbo].[ListarMovimientosCuenta]    Script Date: 25/06/2022 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ListarMovimientosCuenta](
@idCuenta int)
as
begin
	select * from Movimiento
	WHERE idCuenta=@idCuenta
end
GO
/****** Object:  StoredProcedure [dbo].[ObtenerCliente]    Script Date: 25/06/2022 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[ObtenerCliente](
@id int)
as
begin
	select * from Cliente where id = @id
end
GO
/****** Object:  StoredProcedure [dbo].[ObtenerCuenta]    Script Date: 25/06/2022 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[ObtenerCuenta](
@id int)
as
begin
	SELECT C.id, C.idTitular, C.idMoneda, C.CBU_UUID, C.alias, C.numeroCuenta, C.saldo, C.descripcion, C.fechaAlta, M.nombre  
	FROM Cuenta C INNER JOIN Moneda M ON M.Id = C.idMoneda 
	WHERE C.id=@id
end
GO
/****** Object:  StoredProcedure [dbo].[ObtenerMoneda]    Script Date: 25/06/2022 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[ObtenerMoneda](
@id int)
as
begin
	select * from Moneda where id = @id
end
GO
/****** Object:  StoredProcedure [dbo].[ObtenerMovimiento]    Script Date: 25/06/2022 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[ObtenerMovimiento](
@id int)
as
begin
	select * from Movimiento
	WHERE id=@id
end
GO
/****** Object:  StoredProcedure [dbo].[TransferenciaPropia]    Script Date: 25/06/2022 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TransferenciaPropia]
(
     @idCuentaOrigen int
    , @montoOrigen numeric(38,10)
	,@saldoOrigen numeric(38,10)
	, @descripcionOrigen varchar(60)
	,@idCuentaDestino int
    , @montoDestino numeric(38,10)
	,@saldoDestino numeric(38,10)
	, @descripcionDestino varchar(60)
)
AS
BEGIN
    BEGIN TRANSACTION;
    SAVE TRANSACTION MySavePoint;

    BEGIN TRY
        update Cuenta set saldo=@saldoOrigen  where id=@idCuentaOrigen

		INSERT INTO Movimiento
            (
            idCuenta
            ,debito
            ,saldo
            ,descripcion
            )
        VALUES (
            @idCuentaOrigen
            , @montoOrigen
            , @saldoOrigen
            , @descripcionOrigen
            );

		update Cuenta set saldo=@saldoDestino  where id=@idCuentaDestino

		INSERT INTO Movimiento
            (
            idCuenta
            ,credito
            ,saldo
            ,descripcion
            )
        VALUES (
            @idCuentaDestino
            , @montoDestino
            , @saldoDestino
            , @descripcionDestino
            );

        COMMIT TRANSACTION 
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION MySavePoint; -- rollback to MySavePoint
        END
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[ValidarAlias]    Script Date: 25/06/2022 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[ValidarAlias](
@alias varchar(50)
)
as
begin
	select * from Cuenta where alias = @alias
end
GO
/****** Object:  StoredProcedure [dbo].[ValidarCliente]    Script Date: 25/06/2022 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ValidarCliente](
@usuario varchar(50),
@clave varchar(50)
)
as
begin
	select * from Cliente where usuario = @usuario and clave = @clave
end
GO
/****** Object:  StoredProcedure [dbo].[ValidarCUB_UUID]    Script Date: 25/06/2022 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ValidarCUB_UUID](
@CUB_UUID varchar(50)
)
as
begin
	select * from Cuenta where CBU_UUID = @CUB_UUID
end
GO
/****** Object:  StoredProcedure [dbo].[ValidarMoneda]    Script Date: 25/06/2022 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ValidarMoneda](
@idMoneda int
)
as
begin
	select * from Moneda where id = @idMoneda
end
GO
USE [master]
GO
ALTER DATABASE [TP_Cripto_BD] SET  READ_WRITE 
GO
