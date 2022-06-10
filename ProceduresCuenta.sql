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