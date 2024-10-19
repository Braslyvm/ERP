
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

create function dbo.encryptar (@contraseña nvarchar(200))
returns varbinary(max)        
as
begin
    if @contraseña is null
        return null;
    return hashbytes('sha2_256', @contraseña);
end;
go

create procedure insertar_empleado
    @cedula int,
    @nombre varchar(200),
    @apellido1 varchar(200),
    @apellido2 varchar(200),
    @correo_electronico varchar(180),
    @contraseña varchar(200),
    @género varchar(180),
    @fecha_nacimiento date,
    @lugar_residencia varchar(180),
    @telefono int,
    @fecha_ingreso date,
    @salario_actual int,
    @puesto_actual varchar(180),
    @departamento_actual varchar(180),
    @rol varchar(180),
    @mensaje nvarchar(200) output
as
begin
    begin try
        insert into usuarios.empleados (cedula, nombre, apellido1, apellido2, correo_electronico, contraseña, género, fecha_nacimiento, lugar_residencia, telefono, fecha_ingreso, salario_actual, puesto_actual, departamento_actual, rol)
        values (@cedula, @nombre, @apellido1, @apellido2, @correo_electronico, dbo.encryptar(@contraseña), @género, @fecha_nacimiento, @lugar_residencia, @telefono, @fecha_ingreso, @salario_actual, @puesto_actual, @departamento_actual, @rol);
        
        set @mensaje = 'empleado insertado exitosamente.';
    end try
    begin catch
        set @mensaje = 'error al insertar el empleado';
    end catch
end;

-------------------modificar empleado -------------------------
create procedure actualizar_empleado
    @cedula int,
    @nombre varchar(200) = null,
    @apellido1 varchar(200) = null,
    @apellido2 varchar(200) = null,
    @correo_electronico varchar(180) = null,
    @contraseña varchar(200) = null,
    @género varchar(180) = null,
    @fecha_nacimiento date = null,
    @lugar_residencia varchar(180) = null,
    @telefono int = null,
    @fecha_ingreso date = null,
    @salario_actual int = null,
    @puesto_actual varchar(180) = null,
    @departamento_actual varchar(180) = null,
    @rol varchar(180) = null,
    @mensaje nvarchar(200) output
as
begin
    begin try
        update usuarios.empleados
        set 
            nombre = coalesce(@nombre, nombre),
            apellido1 = coalesce(@apellido1, apellido1),
            apellido2 = coalesce(@apellido2, apellido2),
            correo_electronico = coalesce(@correo_electronico, correo_electronico),
            contraseña = coalesce(dbo.encryptar(@contraseña), contraseña),
            género = coalesce(@género, género),
            fecha_nacimiento = coalesce(@fecha_nacimiento, fecha_nacimiento),
            lugar_residencia = coalesce(@lugar_residencia, lugar_residencia),
            telefono = coalesce(@telefono, telefono),
            fecha_ingreso = coalesce(@fecha_ingreso, fecha_ingreso),
            salario_actual = coalesce(@salario_actual, salario_actual),
            puesto_actual = coalesce(@puesto_actual, puesto_actual),
            departamento_actual = coalesce(@departamento_actual, departamento_actual),
            rol = coalesce(@rol, rol)
        where cedula = @cedula;

        set @mensaje = 'empleado actualizado exitosamente.';
    end try
    begin catch
        set @mensaje = 'error al actualizar el empleado';
    end catch
end;

------------------------inicio seccion----------------------
create function dbo.InicioValido (@Correo varchar(200), @contraseña varchar(200))
returns bit         
as
begin
    declare @resultado bit = 0; 
    if exists (
        select 1 from usuarios.empleados
        where correo_electronico = @Correo and contraseña = dbo.encryptar(@contraseña)
    ) 
    begin
        set @resultado = 1;
    end
    return @resultado; 
end;
go



--------------------------------------rol por usuario ---------------------------------------------
create view roles_por_usuario as
select 
    concat(e.nombre, ' ', e.apellido_1, ' ', e.apellido_2) as nombre_completo,
    e.rol
from 
    usuarios.empleados e;
go


--------------------------------------usuariopor usuario ---------------------------------------------
create view usuarios.usuarios_por_rol as
select 
    r.nombre as nombre_rol,
    concat(e.nombre, ' ', e.apellido_1, ' ', e.apellido_2) as nombre_completo
from 
    usuarios.roles r
left join 
    usuarios.empleados e on e.rol = r.nombre;
go



--------------------------------------calcular salario -------------------------------------
create function calcularsalario (
    @h_normales int,
    @h_extras int,
    @salario_actual int
)
returns int
as
begin
    declare @horas_por_mes int = 200;
    declare @total int;
    declare @extras int;
    declare @pago_por_hora int;
    declare @pago_extra int;

    set @total = @salario_actual;
    if (@h_normales + @h_extras > @horas_por_mes)
    begin
        set @extras = (@h_normales + @h_extras) - @horas_por_mes;
        set @pago_por_hora = @salario_actual / @horas_por_mes;
        set @pago_extra = @extras * @pago_por_hora * 1.5;
        set @total = @total + @pago_extra;
    end
    return @total;
end;


--------------------------------insertar plantilla ----------------------
create procedure insertar_plantilla
    @cedula int,
    @mes varchar(180),
    @año int,
    @fecha_pago date,
    @h_normales int,
    @salario_actual int,
    @h_extras int,
    @departamento varchar(180),
    @mensaje nvarchar(200) output
as
begin
    begin try
        insert into usuarios.plantilla (cedula, mes, año, fecha_pago, h_normales, salario_actual, h_extras, total_salario, departamento)
        values ( @cedula, @mes, @año, @fecha_pago, @h_normales, @salario_actual, @h_extras,calcularsalario(h_normales,h_extras,salario_actual) , @departamento);
  
        set @mensaje = 'registro de plantilla insertado exitosamente.';
    end try
    begin catch
        set @mensaje = 'error al insertar en plantilla: ' + error_message();
    end catch
end;



--------------------------------------plantilla por mes --------------------------------------------------
create procedure PlanillaMes(@mes varchar(180))
as
begin
    select cedula, concat(nombre, ' ', apellido1, ' ', apellido2) as nombre_completo,departamento, 
        h_normales, h_extras, salario_actual, salario_calculado
    from 
        usuarios.vista_empleados_planilla
    where 
        mes = @mes;
end;
go

--------------------------------------plantilla por Año --------------------------------------------------

create procedure planillaAño(@año int)
as
begin
    select cedula, concat(nombre, ' ', apellido1, ' ', apellido2) as nombre_completo,departamento, 
        h_normales, h_extras, salario_actual, salario_calculado
    from 
        usuarios.vista_empleados_planilla
    where 
        año = @año;
end;
go


--------------------------------------plantilla por departamento  --------------------------------------------------
create procedure usuarios.mostrar_planilla_por_departamento(@departamento varchar(180))
as
begin
    select cedula, concat(nombre, ' ', apellido1, ' ', apellido2) as nombre_completo,departamento, 
        h_normales, h_extras, salario_actual, salario_calculado
    from 
        usuarios.vista_empleados_planilla
    where 
        departamento = @departamento;
end;
go



--------------------------------ver articulos por bodega----------------------------------

CREATE PROCEDURE gestion_inventario.ObtenerArticulosPorBodega

AS
BEGIN
    SELECT 
        a.c_articulo AS ID_Articulo,
        a.nombre AS Nombre_Articulo,
        b.nombre AS Nombre_Bodega,
        i.cantidad AS Stock
    FROM 
        inventario i
    INNER JOIN 
        articulos a ON i.c_articulo = a.c_articulo
    INNER JOIN 
        bodegas b ON i.c_bodega = b.c_bodega
END;

--------------------------------Crear cotizacion----------------------------------
