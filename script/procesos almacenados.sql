
use Planificador_recursos_empresariales
go


-- Procedimiento para insertar permisos en el módulo de Inventario
create procedure usuarios.InsertarPermisosInventario
(
    @nombre nvarchar(50),
    @edicion bit,
    @visualizacion bit,
    @reportes bit
)
as
begin
    insert into usuarios.PermisosMInventario (nombre, edicion, visualizacion, reportes)
    values (@nombre, @edicion, @visualizacion, @reportes);
end
go

-- Procedimiento para insertar permisos en el módulo de Usuarios
create procedure usuarios.InsertarPermisosUsuarios(
    @nombre nvarchar(50),
    @edicion bit,
    @visualizacion bit,
    @reportes bit
)
as
begin
    insert into usuarios.PermisosMUsuarios (nombre, edicion, visualizacion, reportes)
    values (@nombre, @edicion, @visualizacion, @reportes);
end
go

-- Procedimiento para insertar permisos en el módulo de Cotizaciones
create procedure usuarios.InsertarPermisosCotizaciones(
    @nombre nvarchar(50),
    @edicion bit,
    @visualizacion bit,
    @reportes bit
)
as
begin
    insert into usuarios.PermisosMCotizaciones (nombre, edicion, visualizacion, reportes)
    values (@nombre, @edicion, @visualizacion, @reportes);
end
go

-- Procedimiento para insertar permisos en el módulo de Facturas
create procedure usuarios.InsertarPermisosFacturas(
    @nombre nvarchar(50),
    @edicion bit,
    @visualizacion bit,
    @reportes bit
)
as
begin
    insert into usuarios.PermisosMFacturas (nombre, edicion, visualizacion, reportes)
    values (@nombre, @edicion, @visualizacion, @reportes);
end
go

-- Procedimiento para insertar permisos en el módulo de Ventas
create procedure usuarios.InsertarPermisosVentas(
    @nombre nvarchar(50),
    @edicion bit,
    @visualizacion bit,
    @reportes bit
)
as
begin
    insert into usuarios.PermisosMVentas (nombre, edicion, visualizacion, reportes)
    values (@nombre, @edicion, @visualizacion, @reportes);
end
go

-- Procedimiento para insertar permisos en el módulo de Clientes
create procedure usuarios.InsertarPermisosClientes(
    @nombre nvarchar(50),
    @edicion bit,
    @visualizacion bit,
    @reportes bit
)
as
begin
    insert into usuarios.PermisosMClientes (nombre, edicion, visualizacion, reportes)
    values (@nombre, @edicion, @visualizacion, @reportes);
end
go

-- Procedimiento para insertar permisos en el módulo de Reportes
create procedure usuarios.InsertarPermisosReportes(
    @nombre nvarchar(50),
    @edicion bit,
    @visualizacion bit,
    @reportes bit
)
as
begin
    insert into usuarios.PermisosMReportes (nombre, edicion, visualizacion, reportes)
    values (@nombre, @edicion, @visualizacion, @reportes);
end
go




-- inserte usuarios 










create function dbo.encryptar (@contraseña nvarchar(128))
returns varbinary(max)        
as
begin
    return hashbytes('sha2_256', @contraseña);
end;




create procedure inserta(
    @nombre nvarchar(50)
)
as
begin
    insert into usa (contraseña)
    values (dbo.encryptar(@nombre));
end
go

