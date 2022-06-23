alter procedure ListarCuentaCliente(
@idTitular int)
as
begin
	SELECT C.id, C.idTitular, C.idMoneda, C.CBU_UUID, C.alias, C.numeroCuenta, C.saldo, C.descripcion, C.fechaAlta, M.nombre  
	FROM Cuenta C INNER JOIN Moneda M ON M.Id = C.idMoneda 
	WHERE C.idTitular=@idTitular
end
go

alter procedure ObtenerCuenta(
@id int)
as
begin
	SELECT C.id, C.idTitular, C.idMoneda, C.CBU_UUID, C.alias, C.numeroCuenta, C.saldo, C.descripcion, C.fechaAlta, M.nombre  
	FROM Cuenta C INNER JOIN Moneda M ON M.Id = C.idMoneda 
	WHERE C.id=@id
end
go

create procedure GuardarCuenta(
@idTitular int,
@idMoneda int,
@CBU_UUID varchar(50),
@alias varchar(50),
@numeroCuenta varchar(50),
@saldo numeric(38,10),
@descripcion varchar(50),
@fechaAlta date
)
as
begin
	insert into Cuenta(idTitular, idMoneda, CBU_UUID, alias, numeroCuenta, saldo, descripcion, fechaAlta) values(@idTitular, @idMoneda, @CBU_UUID, @alias, @numeroCuenta, @saldo, @descripcion, @fechaAlta)
end
go

create procedure EditarCuenta(
@id int,
@alias varchar(50),
@descripcion varchar(50)
)
as
begin
	update Cuenta set alias=@alias, descripcion=@descripcion where id=@id
end
go

create procedure EliminarCuenta(
@id int
)
as
begin
	delete from Cuenta where id = @id
end
go

create procedure ActualizarSaldoCuenta(
@id int,
@saldo numeric(38,10)
)
as
begin
	update Cuenta set saldo=@saldo where id=@id
end
go



GO
CREATE PROCEDURE CrearCuenta
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

create procedure ValidarCUB_UUID(
@CUB_UUID varchar(50)
)
as
begin
	select * from Cuenta where CBU_UUID = @CUB_UUID
end
go

create procedure ValidarAlias(
@alias varchar(50)
)
as
begin
	select * from Cuenta where alias = @alias
end
go








CREATE TABLE [dbo].[Movimiento]
(
	[id]           INT              IDENTITY (1, 1) NOT NULL,
    [idCuenta]    INT              NOT NULL,
    [debito]     NUMERIC (38, 10) DEFAULT ((0)) NOT NULL,
    [credito]     NUMERIC (38, 10) DEFAULT ((0)) NOT NULL,
    [saldo]        NUMERIC (38, 10) DEFAULT ((0)) NOT NULL,
    [descripcion]  VARCHAR (60)     NULL ,
    [fecha]    DATE             DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
	CONSTRAINT [FK_Cuenta_ToCuenta] FOREIGN KEY ([idCuenta]) REFERENCES [dbo].[Cuenta] ([id])
)
go

ALTER PROCEDURE Depositar
(
     @idCuenta int
    , @deposito numeric(38,10)
	,@saldo numeric(38,10)
	, @descripcion varchar(60)
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


CREATE PROCEDURE Extraer
(
     @idCuenta int
    , @extraccion numeric(38,10)
	,@saldo numeric(38,10)
	, @descripcion varchar(60)
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


create procedure ListarMovimientosCuenta(
@idCuenta int)
as
begin
	select * from Movimiento
	WHERE idCuenta=@idCuenta
end
go

create procedure ObtenerMovimiento(
@id int)
as
begin
	select * from Movimiento
	WHERE id=@id
end
go