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

/****** Object:  Table [dbo].[Cuenta]    Script Date: 12/06/2022 12:54:50 ******/
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
/****** Object:  Table [dbo].[Moneda]    Script Date: 12/06/2022 12:54:50 ******/
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
SET IDENTITY_INSERT [dbo].[Cliente] ON 

INSERT [dbo].[Cliente] ([id], [usuario], [clave], [nombre], [mail], [telefono], [fechaAlta]) VALUES (1, N'usuario1', N'1234', N'usuario1', N'usuario1@mail.com', N'1234-1234', CAST(N'2022-06-08' AS Date))
INSERT [dbo].[Cliente] ([id], [usuario], [clave], [nombre], [mail], [telefono], [fechaAlta]) VALUES (2, N'usuario2', N'1234', N'usuario2', N'usuario2@mail.com', N'2345-2345', CAST(N'2022-06-10' AS Date))
INSERT [dbo].[Cliente] ([id], [usuario], [clave], [nombre], [mail], [telefono], [fechaAlta]) VALUES (3, N'usuario3', N'1234', N'Cliente  3', N'usuario_3@mail.com', N'1233-1233', CAST(N'2022-06-10' AS Date))
SET IDENTITY_INSERT [dbo].[Cliente] OFF
SET IDENTITY_INSERT [dbo].[Cuenta] ON 

INSERT [dbo].[Cuenta] ([id], [idTitular], [idMoneda], [CBU_UUID], [alias], [numeroCuenta], [saldo], [descripcion], [fechaAlta]) VALUES (1, 1, 1, N'0010000000000000000001', N'cuenta.prueba.uno', 1, CAST(0.0000000000 AS Numeric(38, 10)), N'1ra cuenta en dolares', CAST(N'2022-06-08' AS Date))
INSERT [dbo].[Cuenta] ([id], [idTitular], [idMoneda], [CBU_UUID], [alias], [numeroCuenta], [saldo], [descripcion], [fechaAlta]) VALUES (3, 1, 2, N'1234500653234932185432', N'cuenta.dos', 3, CAST(0.0000000000 AS Numeric(38, 10)), N'2da cuenta', CAST(N'2022-06-08' AS Date))
INSERT [dbo].[Cuenta] ([id], [idTitular], [idMoneda], [CBU_UUID], [alias], [numeroCuenta], [saldo], [descripcion], [fechaAlta]) VALUES (5, 1, 3, N'1234512398743275610385', N'cuenta.tres', 5, CAST(0.0000000000 AS Numeric(38, 10)), N'3ra cuenta', CAST(N'2022-06-08' AS Date))
INSERT [dbo].[Cuenta] ([id], [idTitular], [idMoneda], [CBU_UUID], [alias], [numeroCuenta], [saldo], [descripcion], [fechaAlta]) VALUES (6, 2, 1, N'2341515151515', N'cuenta.dos.uno', 6, CAST(0.0000000000 AS Numeric(38, 10)), N'U2 1ra cuenta', CAST(N'2022-06-10' AS Date))
SET IDENTITY_INSERT [dbo].[Cuenta] OFF
SET IDENTITY_INSERT [dbo].[Moneda] ON 

INSERT [dbo].[Moneda] ([id], [nombre], [cotizacionEnUSD]) VALUES (1, N'dolar', CAST(1.0000000000 AS Numeric(38, 10)))
INSERT [dbo].[Moneda] ([id], [nombre], [cotizacionEnUSD]) VALUES (2, N'pesos', CAST(208.0000000000 AS Numeric(38, 10)))
INSERT [dbo].[Moneda] ([id], [nombre], [cotizacionEnUSD]) VALUES (3, N'bitcoin', CAST(30300.0000000000 AS Numeric(38, 10)))
SET IDENTITY_INSERT [dbo].[Moneda] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Cliente__9AFF8FC6C3321C8E]    Script Date: 12/06/2022 12:54:50 ******/
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
/****** Object:  StoredProcedure [dbo].[ActualizarCotizacionMoneda]    Script Date: 12/06/2022 12:54:50 ******/
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
/****** Object:  StoredProcedure [dbo].[ActualizarSaldoCuenta]    Script Date: 12/06/2022 12:54:50 ******/
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
/****** Object:  StoredProcedure [dbo].[CrearCuenta]    Script Date: 12/06/2022 12:54:50 ******/
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
/****** Object:  StoredProcedure [dbo].[EditarCliente]    Script Date: 12/06/2022 12:54:50 ******/
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
/****** Object:  StoredProcedure [dbo].[EditarCuenta]    Script Date: 12/06/2022 12:54:50 ******/
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
/****** Object:  StoredProcedure [dbo].[EliminarCliente]    Script Date: 12/06/2022 12:54:50 ******/
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
/****** Object:  StoredProcedure [dbo].[EliminarCuenta]    Script Date: 12/06/2022 12:54:50 ******/
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
/****** Object:  StoredProcedure [dbo].[EliminarMoneda]    Script Date: 12/06/2022 12:54:50 ******/
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
/****** Object:  StoredProcedure [dbo].[GuardarCliente]    Script Date: 12/06/2022 12:54:50 ******/
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
/****** Object:  StoredProcedure [dbo].[GuardarCuenta]    Script Date: 12/06/2022 12:54:50 ******/
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
/****** Object:  StoredProcedure [dbo].[GuardarMoneda]    Script Date: 12/06/2022 12:54:50 ******/
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
/****** Object:  StoredProcedure [dbo].[ListarCliente]    Script Date: 12/06/2022 12:54:50 ******/
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
/****** Object:  StoredProcedure [dbo].[ListarCuentaCliente]    Script Date: 12/06/2022 12:54:50 ******/
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
/****** Object:  StoredProcedure [dbo].[ListarMoneda]    Script Date: 12/06/2022 12:54:50 ******/
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
/****** Object:  StoredProcedure [dbo].[ObtenerCliente]    Script Date: 12/06/2022 12:54:50 ******/
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
/****** Object:  StoredProcedure [dbo].[ObtenerCuenta]    Script Date: 12/06/2022 12:54:50 ******/
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
/****** Object:  StoredProcedure [dbo].[ObtenerMoneda]    Script Date: 12/06/2022 12:54:50 ******/
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
/****** Object:  StoredProcedure [dbo].[ValidarAlias]    Script Date: 12/06/2022 12:54:50 ******/
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
/****** Object:  StoredProcedure [dbo].[ValidarCliente]    Script Date: 12/06/2022 12:54:50 ******/
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
/****** Object:  StoredProcedure [dbo].[ValidarCUB_UUID]    Script Date: 12/06/2022 12:54:50 ******/
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