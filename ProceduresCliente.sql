create procedure ListarCliente
as
begin
	select * from Cliente
end
go

create procedure ObtenerCliente(
@id int)
as
begin
	select * from Cliente where id = @id
end
go

create procedure ValidarCliente(
@usuario varchar(50),
@clave varchar(50)
)
as
begin
	select * from Cliente where usuario = @usuario and clave = @clave
end
go

create procedure GuardarCliente(
@usuario varchar(50),
@clave varchar(50),
@nombre varchar(50),
@mail varchar(50),
@telefono varchar(50),
@fechaAlta date
)
as
begin
	insert into Cliente(usuario, clave, nombre, mail, telefono, fechaAlta) values(@usuario, @clave, @nombre, @mail, @telefono, @fechaAlta)
end
go

create procedure EditarCliente(
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
go

create procedure EliminarCliente(
@id int
)
as
begin
	delete from Cliente where id = @id
end
go