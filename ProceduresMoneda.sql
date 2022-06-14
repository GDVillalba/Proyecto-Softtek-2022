create procedure ListarMoneda
as
begin
	select * from Moneda
end
go

create procedure ObtenerMoneda(
@id int)
as
begin
	select * from Moneda where id = @id
end
go

create procedure GuardarMoneda(
@nombre varchar(50),
@cotizacionEnUSD numeric(38,10)
)
as
begin
	insert into Moneda(nombre, cotizacionEnUSD) values(@nombre, @cotizacionEnUSD)
end
go

create procedure ActualizarCotizacionMoneda(
@id int,
@cotizacionEnUSD numeric(38,10)
)
as
begin
	update Moneda set cotizacionEnUSD=@cotizacionEnUSD where id=@id
end
go

create procedure EliminarMoneda(
@id int
)
as
begin
	delete from Moneda where id = @id
end
go

create procedure ValidarMoneda(
@idMoneda int
)
as
begin
	select * from Moneda where id = @idMoneda
end
go