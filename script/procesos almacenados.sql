
use Planificador_recursos_empresariales
go

--------------Crear Rol -------------------------------
create procedure CrearRol(@nombre varchar (180) )
as 
begin	
	insert into usuarios.roles(nombre)
	values (@nombre)
end 
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
create function usuarios.calcularsalario (
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
create procedure usuarios.insertar_plantilla
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
        values ( @cedula, @mes, @año, @fecha_pago, @h_normales, @salario_actual, @h_extras,usuarios.calcularsalario(h_normales,h_extras,salario_actual) , @departamento);
  
        set @mensaje = 'registro de plantilla insertado exitosamente.';
    end try
    begin catch
        set @mensaje = 'error al insertar en plantilla: ' + error_message();
    end catch
end;



--------------------------------------plantilla por mes --------------------------------------------------
create procedure usuarios.PlanillaMes(@mes varchar(180))
as
begin
    select cedula, concat(nombre, ' ', apellido1, ' ', apellido2) as nombre_completo,departamento, 
        h_normales, h_extras, salario_actual, salario_calculado
    from 
        usuarios.plantilla
    where 
        mes = @mes;
end;
go

--------------------------------------plantilla por Año --------------------------------------------------

create procedure usuarios.planillaAño(@año int)
as
begin
    select cedula, concat(nombre, ' ', apellido1, ' ', apellido2) as nombre_completo,departamento, 
        h_normales, h_extras, salario_actual, salario_calculado
    from 
        usuarios.plantilla
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
        usuarios.plantilla
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
---------------------------------Insertar cliente -------------------------
create procedure clientes.insertar_cliente (
    @cedula int,
    @nombre varchar(180),
    @correo_electronico varchar(180),
    @telefono int,
    @celular int,
    @fax varchar(180),
    @zona varchar(180),
    @sector varchar(180),
    @mensaje nvarchar(200) output
)
as
begin
    if exists (select 1 from clientes.cliente where cedula = @cedula)
    begin
        set @mensaje = 'el cliente ya existe.';
        return;
    end
    insert into clientes.cliente (cedula, nombre, correo_electronico, telefono, celular, fax, zona, sector)
    values (@cedula, @nombre, @correo_electronico, @telefono, @celular, @fax, @zona, @sector);
    set @mensaje = 'cliente insertado';
end;
go


---------------------------------Inventario--------------------------------------------


----------------------------------Validad cantidad--------------------------------------
create function gestion_inventario.cantidad_disponible (
    @c_bodega varchar(180),
    @c_articulo varchar(180),
    @cantidad_solicitada int
)
returns bit
as
begin
    declare @disponible int;
    select @disponible = cantidad
    from gestion_inventario.inventario
    where c_bodega = @c_bodega and c_articulo = @c_articulo;

	if (@disponible >= @cantidad_solicitada)
		return 1;
	return 0;
end;
go
-------------------------Restar Inventario -----------------------------

create function gestion_inventario.restar_inventario (
    @c_bodega varchar(180),
    @c_articulo varchar(180),
    @cantidad int
)
returns bit
as
begin

    if (select gestion_inventario.cantidad_disponible(@c_bodega, @c_articulo, @cantidad)) = 1
    begin
        update gestion_inventario.inventario
        set cantidad = cantidad - @cantidad
        where c_bodega = @c_bodega and c_articulo = @c_articulo;

        return 1; 
    end  
    return 0; 
end;
go

-------------------------------sumar inventario ----------------------------------

create function gestion_inventario.suma_inventario (
    @c_bodega varchar(180),
    @c_articulo varchar(180),
    @cantidad int
)
returns bit
as
begin
    declare @resultado bit;

    update gestion_inventario.inventario
    set cantidad = cantidad + @cantidad
    where c_bodega = @c_bodega and c_articulo = @c_articulo;
	return 1
end;
go



----------------------------------Crear movimiento bodega----------------------------------------

create procedure gestion_inventario.insertar_movimiento (
    @n_factura int,
    @tipo varchar(30),
    @usuario int,
    @mensaje nvarchar(200) output
)
as
begin
    insert into gestion_inventario.movimientos_inventario (n_factura, tipo, fecha, usuario)
    values (@n_factura, @tipo, getdate(), @usuario);
    set @mensaje = 'movimiento creado.';
end;
go

------------------------------------- detalle de movimiento --------------------------------------------
create procedure gestion_inventario.insertar_detalle_movimiento (
    @id_movimiento int,
    @c_articulo varchar(180),
    @cantidad int,
    @bodega_origen varchar(180),
    @bodega_destino varchar(180),
    @mensaje nvarchar(200) output
)
as
begin

    insert into gestion_inventario.detalle_movimiento (id_movimiento, c_articulo, cantidad, bodega_origen, bodega_destino)
    values (@id_movimiento, @c_articulo, @cantidad, @bodega_origen, @bodega_destino);
    set @mensaje = 'detalle de movimiento insertado.';
end;
go

-------------------------------------Realizar movimiento----------------------------------
create function gestion_inventario.gestionar_movimiento (
    @tipo_movimiento varchar(30), 
    @c_articulo varchar(180),
    @c_bodega_origen varchar(180) , 
    @c_bodega_destino varchar(180) , 
    @cantidad int,
    @usuario int
)
returns varchar(100)
as
begin
    declare @aprovacion bit;
    if @tipo_movimiento = 'entrada'
    begin
        set @aprovacion = gestion_inventario.suma_inventario(@c_bodega_destino, @c_articulo, @cantidad);
        if (@aprovacion != 1)
            return 'El ingreso falló';
    end
    else if @tipo_movimiento = 'salida'
    begin
        set @aprovacion = gestion_inventario.restar_inventario(@c_bodega_origen, @c_articulo, @cantidad);
		if (@aprovacion != 1)
			return 'La salida fallo'
    end
    else if @tipo_movimiento = 'movimiento'
    begin
        set @aprovacion = gestion_inventario.restar_inventario(@c_bodega_origen, @c_articulo, @cantidad);
		if (@aprovacion != 1)
			return 'La salida fallo'
        set @aprovacion = gestion_inventario.suma_inventario(@c_bodega_destino, @c_articulo, @cantidad);
		if (@aprovacion != 1)
			return 'El ingreso fallo'
    end
	return 'el movimiento se realizo correctamente'
end;
go













--------------------------------Crear cotizacion----------------------------------
create procedure cotizaciones.insertar_cotizacion
    @cliente int,
    @empleado int,
    @fecha_corizacion date,
    @m_cierre varchar(180),
    @probabilidad int,
    @tipo varchar(180),
    @descripcion varchar(180),
    @zona varchar(180),
    @sector varchar(180),
    @estado varchar(180),
    @m_denegacion varchar(255) = null,
    @contra_quien varchar(255),
    @monto_total int,
    @mensaje nvarchar(200) output
as
begin
    begin try
        insert into cotizaciones.cotizaciones (cliente, empleado, fecha_corizacion, m_cierre, probabilidad, tipo, descripción, zona, sector, estado, m_denegacion, contra_quien, monto_total)
        values (@cliente, @empleado, @fecha_corizacion, @m_cierre, @probabilidad, @tipo, @descripcion, @zona, @sector, @estado, @m_denegacion, @contra_quien, @monto_total);
        
        set @mensaje = 'Cotización insertada exitosamente.';
    end try
    begin catch
        set @mensaje = 'Error al insertar la cotización.';
    end catch
end;
go


--------------------------------modificar cotizacion----------------------------------
create procedure cotizaciones.actualizar_cotizacion
    @id_cotizacion int,
    @cliente int = null,
    @empleado int = null,
    @fecha_corizacion date = null,
    @m_cierre varchar(180) = null,
    @probabilidad int = null,
    @tipo varchar(180) = null,
    @descripcion varchar(180) = null,
    @zona varchar(180) = null,
    @sector varchar(180) = null,
    @estado varchar(180) = null,
    @m_denegacion varchar(255) = null,
    @contra_quien varchar(255) = null,
    @monto_total int = null,
    @mensaje nvarchar(200) output
as
begin
    begin try
        update cotizaciones.cotizaciones
        set 
            cliente = coalesce(@cliente, cliente),
            empleado = coalesce(@empleado, empleado),
            fecha_corizacion = coalesce(@fecha_corizacion, fecha_corizacion),
            m_cierre = coalesce(@m_cierre, m_cierre),
            probabilidad = coalesce(@probabilidad, probabilidad),
            tipo = coalesce(@tipo, tipo),
            descripción = coalesce(@descripcion, descripción),
            zona = coalesce(@zona, zona),
            sector = coalesce(@sector, sector),
            estado = coalesce(@estado, estado),
            m_denegacion = coalesce(@m_denegacion, m_denegacion),
            contra_quien = coalesce(@contra_quien, contra_quien),
            monto_total = coalesce(@monto_total, monto_total)
        where id_cotizacion = @id_cotizacion;
        
        set @mensaje = 'Cotización actualizada.';
    end try
    begin catch
        set @mensaje = 'Error al actualizar la cotización.';
    end catch
end;
go

--------------------------------enlistar productos de cotizacion cotizacion----------------------------------
create procedure cotizaciones.insertar_articulo_cotizacion
    @id_cotizacion int,
    @c_producto varchar(180),
    @cantidad int,
    @monto int,
    @mensaje nvarchar(200) output
as
begin
    begin try
        insert into cotizaciones.lista_articulos_cotizacion (id_cotizacion, c_producto, cantidad, monto)
        values (@id_cotizacion, @c_producto, @cantidad, @monto);
        
        set @mensaje = 'Artículo enlistado.';
    end try
    begin catch
        set @mensaje = 'Error al insertar articulo.';
    end catch
end;
go

--------------------------------crear tarea de cotizacion ----------------------------------


create procedure cotizaciones.insertar_tarea
    @id_cotizacion int,
    @descripcion varchar(255),
    @usuario int,
    @fecha_limite datetime,
    @estado varchar(180),
    @mensaje nvarchar(200) output
as
begin
    begin try
        insert into cotizaciones.tareas (id_cotizacion, descripcion, usuario, fecha_inicio, fecha_limite, estado)
        values (@id_cotizacion, @descripcion, @usuario, getdate(), @fecha_limite, @estado);
        
        set @mensaje = 'Tarea insertada.';
    end try
    begin catch
        set @mensaje = 'Error al insertar la tarea.';
    end catch
end;
go


--------------------------------------Registro factura-------------------------------------------------------

create procedure facturación.insertar_Factura
@cedula_juridica_local int, 
@id_cliente int, 
@id_cotizacion int , 
@id_empleado int ,
@fecha_factura datetime,
@estado varchar(20), 
@motivo_anulacion varchar(200),
@Total int = null,        
@mensaje nvarchar(200) output

as
begin
    begin try
        insert into facturación.facturas(cedula_juridica_local,id_cliente,id_cotizacion,id_empleado,fecha_factura,estado,motivo_anulacion,Total)
 VALUES (@cedula_juridica_local, @id_cliente, @id_cotizacion, @id_empleado, @fecha_factura, @estado, @motivo_anulacion, @Total);
        
        set @mensaje = 'Factura insertada exitosamente.';
    end try
    begin catch
        set @mensaje = 'Error al insertar la factura.';
    end catch
end;
go

--------listar articulos --------------------------------------------------------------------------------
create procedure facturación.LineasFactura
    @id_cotizacion int,
    @c_producto varchar(180),
    @cantidad int,
    @monto int,
    @mensaje nvarchar(200) output
as
begin
    begin try
        insert into cotizaciones.lista_articulos_cotizacion (id_cotizacion, c_producto, cantidad, monto)
        values (@id_cotizacion, @c_producto, @cantidad, @monto);
        
        set @mensaje = 'Artículo enlistado.';
    end try
    begin catch
        set @mensaje = 'Error al insertar articulo.';
    end catch
end;
go