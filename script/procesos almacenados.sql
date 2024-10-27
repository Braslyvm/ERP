
use Planificador_recursos_empresariales
go

--------------Crear Rol -------------------------------
create procedure CrearRol(@nombre varchar (180) , @vendedor bit)
as 
begin	
	insert into usuarios.roles(nombre , vendedor)
	values (@nombre,@vendedor)
end 
go

-- Procedimiento para insertar permisos en el módulo de Inventario
create procedure usuarios.InsertarPermisosInventario
(
    @nombre varchar (180),
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
    @nombre varchar (180),
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
    @nombre varchar (180),
    @edicion bit,
    @visualizacion bit,
    @reportes bit
)
as
begin
    insert into usuarios.PermisosMCotizacion (nombre, edicion, visualizacion, reportes)
    values (@nombre, @edicion, @visualizacion, @reportes);
end
go

-- Procedimiento para insertar permisos en el módulo de Facturas
create procedure usuarios.InsertarPermisosFacturas(
    @nombre varchar (180),
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


-- Procedimiento para insertar permisos en el módulo de Clientes
create procedure usuarios.InsertarPermisosClientes(
    @nombre varchar (180),
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
    @nombre varchar (180),
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

-- Procedimiento para insertar permisos en el módulo de Reportes
create procedure usuarios.InsertarPermisosCasos(
    @nombre varchar (180),
    @edicion bit,
    @visualizacion bit,
    @reportes bit
)
as
begin
    insert into usuarios.PermisosMCaso (nombre, edicion, visualizacion, reportes)
    values (@nombre, @edicion, @visualizacion, @reportes);
end
go

--------------- retorna los usuarios----------------------

create function dbo.usuarios ()
returns table
as 
return (select cedula , nombre from  usuarios.empleados);
go 



--------------- retorna los roles ----------------------

create function dbo.roles ()
returns table
as 
return (select nombre from  usuarios.roles);
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

create procedure usuarios.insertar_empleado
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
go

-------------------modificar empleado -------------------------
create procedure usuarios.actualizar_empleado
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
go
------------------------inicio seccion----------------------
create function dbo.InicioValido (@Cedula int, @contraseña varchar(200))
returns bit         
as
begin
    declare @resultado bit = 0; 
    if exists (
        select 1 from usuarios.empleados
        where cedula = @Cedula and contraseña = dbo.encryptar(@contraseña)
    ) 
    begin
        return 1;
    end
    return 0 ; 
end;
go


--------------------------------------rol por usuario ---------------------------------------------
create view roles_por_usuario as
select 
    concat(e.nombre, ' ', e.apellido1, ' ', e.apellido2) as nombre_completo,
    e.rol
from 
    usuarios.empleados e;
go


--------------------------------------usuariopor usuario ---------------------------------------------
create view usuarios.usuarios_por_rol as
select 
    r.nombre as nombre_rol,
    concat(e.nombre, ' ', e.apellido1, ' ', e.apellido2) as nombre_completo
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
go

--------------------------------insertar plantilla ----------------------
create procedure usuarios.insertar_plantilla
    @cedula int,
    @mes varchar(180),
    @año int,
    @fecha_pago datetime,
    @h_normales int,
    @h_extras int,
    @mensaje nvarchar(200) output
as
begin
	
    begin try
        declare @departamento varchar(180);
        declare @salario_actual int;

        select @salario_actual = salario_actual, @departamento = departamento_actual
        from usuarios.empleados
        where cedula = @cedula;
        insert into usuarios.plantilla (cedula, mes, año, fecha_pago, h_normales, salario_actual, h_extras, total_salario, departamento)
        values ( @cedula, @mes, @año, @fecha_pago, @h_normales, @salario_actual, @h_extras,usuarios.calcularsalario(@h_normales,@h_extras,@salario_actual) , @departamento);
  
        set @mensaje = 'registro de plantilla insertado exitosamente';
    end try
    begin catch
        set @mensaje = 'error al insertar en plantilla';
    end catch
end;
go


--------------------------------------plantilla por mes --------------------------------------------------
create procedure usuarios.PlanillaMes(@mes varchar(180))
as
begin
    select a.cedula, concat(e.nombre, ' ', e.apellido1, ' ', e.apellido2) as nombre_completo,departamento, 
        a.h_normales, a.h_extras, a.salario_actual, a.total_salario
    from usuarios.plantilla a
	inner join usuarios.empleados e on a.cedula = e.cedula
    where 
        mes = @mes;
end;
go

--------------------------------------plantilla por Año --------------------------------------------------

create procedure usuarios.planillaAño(@año int)
as
begin
    select a.cedula, concat(e.nombre, ' ', e.apellido1, ' ', e.apellido2) as nombre_completo,departamento, 
        a.h_normales, a.h_extras, a.salario_actual, a.total_salario
    from usuarios.plantilla a
	inner join usuarios.empleados e on a.cedula = e.cedula
    where 
        año = @año;
end;
go


--------------------------------------plantilla por departamento  --------------------------------------------------
create procedure usuarios.mostrar_planilla_por_departamento(@departamento varchar(180))
as
begin
    select a.cedula, concat(e.nombre, ' ', e.apellido1, ' ', e.apellido2) as nombre_completo,departamento, 
        a.h_normales, a.h_extras, a.salario_actual, a.total_salario
    from usuarios.plantilla a
	inner join usuarios.empleados e on a.cedula = e.cedula
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
go
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

create procedure gestion_inventario.restar_inventario
    @c_bodega varchar(180),
    @c_articulo varchar(180),
    @cantidad int
as
begin
    update gestion_inventario.inventario
    set cantidad = cantidad - @cantidad
    where c_bodega = @c_bodega and c_articulo = @c_articulo;
end;
go
-------------------------------sumar inventario ----------------------------------

create procedure gestion_inventario.suma_inventario
    @c_bodega varchar(180),
    @c_articulo varchar(180),
    @cantidad int
as
begin
    update gestion_inventario.inventario
    set cantidad = cantidad + @cantidad
    where c_bodega = @c_bodega and c_articulo = @c_articulo;
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
        EXEC gestion_inventario.suma_inventario @c_bodega_destino, @c_articulo, @cantidad ;
    end
    else if @tipo_movimiento = 'salida'
    begin
        set @aprovacion =  gestion_inventario.cantidad_disponible(@c_bodega_origen, @c_articulo, @cantidad);
		if (@aprovacion != 1)
			return 'La salida fallo'
		EXEC gestion_inventario.restar_inventario @c_bodega_origen, @c_articulo, @cantidad;
    end
    else if @tipo_movimiento = 'movimiento'
    begin
        set @aprovacion = gestion_inventario.cantidad_disponible(@c_bodega_origen, @c_articulo, @cantidad);
		if (@aprovacion != 1)
			return 'La salida fallo'
		EXEC gestion_inventario.restar_inventario @c_bodega_origen, @c_articulo, @cantidad;
        EXEC gestion_inventario.suma_inventario @c_bodega_destino, @c_articulo, @cantidad;

    end
	return 'el movimiento se realizo correctamente'
end;
go


--------------------------------Crear cotizacion----------------------------------
create procedure cotizaciones.insertar_cotizacion
    @cliente int,
    @empleado int,
    @m_cierre varchar(180),
    @probabilidad int,
    @tipo varchar(180),
    @descripcion varchar(180),
    @mensaje nvarchar(200) output
as
begin
    begin try
		declare @zona varchar(180);
        declare @sector varchar(180);

        select @zona = zona, @sector = sector
        from clientes.cliente
        where cedula = @cliente;

        insert into cotizaciones.cotizaciones (cliente, empleado, fecha_corizacion, m_cierre, probabilidad, tipo, descripción, zona, sector, estado)
        values (@cliente, @empleado, GETDATE() , @m_cierre, @probabilidad, @tipo, @descripcion, @zona, @sector, 'abierta');
        
        set @mensaje = 'Cotización insertada exitosamente.';
    end try
    begin catch
        set @mensaje = 'Error al insertar la cotización.';
    end catch
end;
go

-------------------------------------actualizar total monto------------
create procedure cotizaciones.actualizar_monto_total_cotizacion
    @id_cotizacion int
as
begin
    declare @total_monto int;
    select @total_monto = sum(monto)
    from cotizaciones.lista_articulos_cotizacion
    where id_cotizacion = @id_cotizacion;
    update cotizaciones.cotizaciones
    set monto_total = @total_monto
    where id_cotizacion = @id_cotizacion;
end;
go


-----------------------------------optener articulos de cotizacion -----------------------------
create procedure cotizaciones.sp_obtener_cotizaciones_con_articulos
as
begin
    select 
        c.id_cotizacion,
        c.cliente,
        c.empleado,
        c.fecha_corizacion,
        c.m_cierre,
        c.probabilidad,
        c.tipo,
        c.descripción,
        c.zona,
        c.sector,
        c.estado,
        c.m_denegacion,
        c.contra_quien,
        c.monto_total,
        la.c_bodega,
        la.c_producto,
        la.cantidad,
        la.monto
    from 
        cotizaciones.cotizaciones c
    left join 
        cotizaciones.lista_articulos_cotizacion la on c.id_cotizacion = la.id_cotizacion
    order by 
        c.id_cotizacion;
end;
go

--------------------------optener las tareas de cotizaciones--------------------------------
create procedure cotizaciones.sp_obtener_tareas_cotizaciones
as
begin
    select 
        t.id_tarea,
        t.id_cotizacion,
        t.descripcion,
        t.usuario,
        t.fecha_inicio,
        t.fecha_limite,
        t.estado
    from 
        cotizaciones.tareas t
    order by 
        t.id_cotizacion, t.fecha_inicio;
end;
go



--------------- retorna los Clientes----------------------

create function dbo.clientes ()
returns table
as 
return (select cedula , nombre from  clientes.cliente );
go 

--------------- retorna los cotizacio----------------------

create function dbo.cotizaciones()
returns table
as 
return (select id_cotizacion  from  cotizaciones.cotizaciones );
go 

----------------------------------actualizar------------------------------------

create procedure cotizaciones.actualizar_cotizacion
    @id_cotizacion int,
    @m_cierre varchar(180) = null,
    @probabilidad int = null,
    @tipo varchar(180) = null,
    @estado varchar(180) = null,
    @m_denegacion varchar(255) = null,
	@contra_quien varchar(255) null,
    @mensaje nvarchar(200) output
as
begin
    begin try
        update cotizaciones.cotizaciones
        set 
            m_cierre = coalesce(@m_cierre, m_cierre),
            probabilidad = coalesce(@probabilidad, probabilidad),
            tipo = coalesce(@tipo, tipo),
            estado = coalesce(@estado, estado),
            m_denegacion = coalesce(@m_denegacion, m_denegacion),
			contra_quien = coalesce(@contra_quien, contra_quien)
        where id_cotizacion = @id_cotizacion;

        set @mensaje = 'cotización actualizada.';
    end try
    begin catch
        set @mensaje = 'error al actualizar la cotización.';
    end catch
end;
go


-- Procedimiento almacenado para eliminar cotización y sus asociados
create procedure cotizaciones.eliminar_cotizacion
    @id_cotizacion int
as
begin
    set nocount on;
    delete from cotizaciones.tareas
    where id_cotizacion = @id_cotizacion;
    delete from cotizaciones.lista_articulos_cotizacion
    where id_cotizacion = @id_cotizacion;
    delete from cotizaciones.cotizaciones
    where id_cotizacion = @id_cotizacion;
end;
go



-------------Articulos-----------------------
create function dbo.Articulos ()
returns table
as 
return (select a.c_articulo as codigo , a.nombre as nombre  , b.c_bodega as bodega , cantidad
from gestion_inventario.inventario i
inner join gestion_inventario.articulos as a on  a.c_articulo = i.c_articulo
inner join gestion_inventario.bodegas as b on b.c_bodega = i.c_bodega
where cantidad > 0);
go 



--------------------------------enlistar productos de cotizacion cotizacion----------------------------------
create procedure cotizaciones.insertar_articulo_cotizacion
    @id_cotizacion int,
    @c_producto varchar(180),
    @cantidad int,
	@c_Bodega varchar(180),
    @mensaje nvarchar(200) output
as
begin
    begin try
		declare @monto int;
        select @monto = @cantidad * precio
        from gestion_inventario.articulos
        where  c_articulo = @c_producto;

        insert into cotizaciones.lista_articulos_cotizacion (id_cotizacion, c_producto, cantidad, monto,c_bodega)
        values (@id_cotizacion, @c_producto, @cantidad, @monto,@c_Bodega);
        
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


-------------------modificar tarea --------------------
create procedure cotizaciones.actualizar_tarea
    @id_tarea int,  -- Asumimos que existe un identificador único para las tareas
    @descripcion varchar(255) = null,
    @usuario int = null,
    @fecha_limite datetime = null,
    @estado varchar(180) = null,
    @mensaje nvarchar(200) output
as
begin
    begin try
        update cotizaciones.tareas
        set 
            descripcion = coalesce(@descripcion, descripcion),
            usuario = coalesce(@usuario, usuario),
            fecha_limite = coalesce(@fecha_limite, fecha_limite),
            estado = coalesce(@estado, estado)
        where id_tarea = @id_tarea;

        set @mensaje = 'Tarea actualizada.';
    end try
    begin catch
        set @mensaje = 'Error al actualizar la tarea.';
    end catch
end;
go


--------------- retorna los cotizacio----------------------

create function dbo.tarea()
returns table
as 
return (select id_tarea  from  cotizaciones.tareas );
go 


------------------------Borrar Tarea------------------------------
create procedure cotizaciones.borrartareaporid
    @id_tarea int
as
begin
     delete from cotizaciones.tareas
     where id_tarea = @id_tarea;
end;
go


-----------------------------acesso a cotizar-------------------------------------------------------
create function dbo.validar_permiso_cotizacion(
    @cedula int,
    @tipo varchar(100)
)
returns bit
as
begin
    declare @funca bit = 0;
    declare @rol varchar(180);
    select @rol = rol from usuarios.empleados where cedula = @cedula;

    if @rol is null
    begin
        return @funca; 
    end
    if @tipo = 'edicion'
    begin
        select @funca = isnull(edicion, 0)
        from usuarios.permisosmcotizacion
        where nombre = @rol;
    end
    else if @tipo = 'visualizacion'
    begin
        select @funca = isnull(visualizacion, 0)
        from usuarios.permisosmcotizacion
        where nombre = @rol;
    end
    else if @tipo = 'reportes'
    begin
        select @funca = isnull(reportes, 0)
        from usuarios.permisosmcotizacion
        where nombre = @rol;
    end
    return @funca;
end;
go

-----------------------------acesso a inventario-------------------------------------------------------
create function dbo.validar_permiso_inventario(
    @cedula int,
    @tipo varchar(100)
)
returns bit
as
begin
    declare @funca bit = 0;  
    declare @rol varchar(180);
    select @rol = rol from usuarios.empleados where cedula = @cedula;

    if @rol is null
    begin
        return @funca;
    end
    if @tipo = 'edicion'
    begin
        select @funca = isnull(edicion, 0)
        from usuarios.permisosminventario
        where nombre = @rol;
    end
    else if @tipo = 'visualizacion'
    begin
        select @funca = isnull(visualizacion, 0)
        from usuarios.permisosminventario
        where nombre = @rol;
    end
    else if @tipo = 'reportes'
    begin
        select @funca = isnull(reportes, 0)
        from usuarios.permisosminventario
        where nombre = @rol;
    end
    return @funca; 
end;
go

-----------------------------acesso a usuarios-------------------------------------------------------
create function dbo.validar_permiso_usuarios(
    @cedula int,
    @tipo varchar(100)
)
returns bit
as
begin
    declare @funca bit = 0;
    declare @rol varchar(180);
    select @rol = rol from usuarios.empleados where cedula = @cedula;

    if @rol is null
    begin
        return @funca;  
    end
    if @tipo = 'edicion'
    begin
        select @funca = isnull(edicion, 0)
        from usuarios.permisosmusuarios
        where nombre = @rol;
    end
    else if @tipo = 'visualizacion'
    begin
        select @funca = isnull(visualizacion, 0)
        from usuarios.permisosmusuarios
        where nombre = @rol;
    end
    else if @tipo = 'reportes'
    begin
        select @funca = isnull(reportes, 0)
        from usuarios.permisosmusuarios
        where nombre = @rol;
    end

    return @funca;  
end;
go


-----------------------------acesso a Facturas-------------------------------------------------------
create function dbo.validar_permiso_facturas(
    @cedula int,
    @tipo varchar(100)
)
returns bit
as
begin
    declare @funca bit = 0;  
    declare @rol varchar(180);
    select @rol = rol from usuarios.empleados where cedula = @cedula;

    if @rol is null
    begin
        return @funca; 
    end
    if @tipo = 'edicion'
    begin
        select @funca = isnull(edicion, 0)
        from usuarios.permisosmfacturas
        where nombre = @rol;
    end
    else if @tipo = 'visualizacion'
    begin
        select @funca = isnull(visualizacion, 0)
        from usuarios.permisosmfacturas
        where nombre = @rol;
    end
    else if @tipo = 'reportes'
    begin
        select @funca = isnull(reportes, 0)
        from usuarios.permisosmfacturas
        where nombre = @rol;
    end

    return @funca;  
end;
go


-----------------------------acesso a Clientes-------------------------------------------------------
create function dbo.validar_permiso_clientes(
    @cedula int,
    @tipo varchar(100)
)
returns bit
as
begin
    declare @funca bit = 0;  
    declare @rol varchar(180);
    select @rol = rol from usuarios.empleados where cedula = @cedula;

    if @rol is null
    begin
        return @funca; 
    end
    if @tipo = 'edicion'
    begin
        select @funca = isnull(edicion, 0)
        from usuarios.permisosmclientes
        where nombre = @rol;
    end
    else if @tipo = 'visualizacion'
    begin
        select @funca = isnull(visualizacion, 0)
        from usuarios.permisosmclientes
        where nombre = @rol;
    end
    else if @tipo = 'reportes'
    begin
        select @funca = isnull(reportes, 0)
        from usuarios.permisosmclientes
        where nombre = @rol;
    end

    return @funca;  
end;
go

-----------------------------acesso a Reportes-------------------------------------------------------
create function dbo.validar_permiso_reportes(
    @cedula int,
    @tipo varchar(100)
)
returns bit
as
begin
    declare @funca bit = 0;
    declare @rol varchar(180);
    select @rol = rol from usuarios.empleados where cedula = @cedula;

    if @rol is null
    begin
        return @funca; 
    end
    if @tipo = 'edicion'
    begin
        select @funca = isnull(edicion, 0)
        from usuarios.permisosmreportes
        where nombre = @rol;
    end
    else if @tipo = 'visualizacion'
    begin
        select @funca = isnull(visualizacion, 0)
        from usuarios.permisosmreportes
        where nombre = @rol;
    end
    else if @tipo = 'reportes'
    begin
        select @funca = isnull(reportes, 0)
        from usuarios.permisosmreportes
        where nombre = @rol;
    end

    return @funca;  
end;
go
-----------------------------acesso a caso-------------------------------------------------------
create function dbo.validar_permiso_caso(
    @cedula int,
    @tipo varchar(100)
)
returns bit
as
begin
    declare @funca bit = 0;  
    declare @rol varchar(180);
    select @rol = rol from usuarios.empleados where cedula = @cedula;

    if @rol is null
    begin
        return @funca;
    end
    if @tipo = 'edicion'
    begin
        select @funca = isnull(edicion, 0)
        from usuarios.permisosmcaso
        where nombre = @rol;
    end
    else if @tipo = 'visualizacion'
    begin
        select @funca = isnull(visualizacion, 0)
        from usuarios.permisosmcaso
        where nombre = @rol;
    end
    else if @tipo = 'reportes'
    begin
        select @funca = isnull(reportes, 0)
        from usuarios.permisosmcaso
        where nombre = @rol;
    end

    return @funca;  -- retornar el resultado final
end;
go

----- permiso de ventas ---------
create function dbo.validar_permiso_venta(
    @cedula int
)
returns bit
as
begin
    declare @funca bit = 0;  
    declare @rol varchar(180);
    select @rol = rol from usuarios.empleados where cedula = @cedula;
	select @funca = r.vendedor
    from usuarios.roles r
    where r.nombre = @rol;
    return @funca;  
end;
go

----------------------------------- Insertar Factura -----------------------------------
-- crear función para obtener la última factura
create function facturación.obtenerultimafactura()
returns int
as
begin
    declare @ultimafactura int;

    select @ultimafactura = max(n_factura)
    from facturación.facturas;

    return @ultimafactura;
end;
go

-- crear procedimiento para calcular el total de la factura
create procedure facturación.calculartotalfactura
    @n_factura int,
    @total decimal(10, 2) output
as
begin
    begin try
        select @total = sum(monto_total)
        from facturación.lista_articulos_facturados
        where n_factura = @n_factura;

        if @total is null
            set @total = 0;
    end try
    begin catch
        set @total = 0; 
    end catch
end;
go

-- crear procedimiento para insertar una factura
create  procedure facturación.insertar_factura
    @cedula_juridica_local int, 
    @id_cliente int, 
    @id_cotizacion int, 
    @id_empleado int,
    @fecha_factura datetime,
    @estado varchar(20), 
    @motivo_anulacion varchar(200),
    @total int = null,        
    @mensaje nvarchar(200) output
as
begin
    begin try
        -- insertar la factura
        insert into facturación.facturas(cedula_juridica_local, id_cliente, id_cotizacion, id_empleado, fecha_factura, estado, motivo_anulacion, total)
        values (@cedula_juridica_local, @id_cliente, @id_cotizacion, @id_empleado, @fecha_factura, @estado, @motivo_anulacion, @total);
        
        -- crear movimiento al insertar la factura
        declare @n_factura int = scope_identity();
        declare @tipo varchar(30) = 'salida';
        declare @usuario int = @id_empleado;

        -- nuevo movimiento
        exec gestion_inventario.insertar_movimiento @n_factura, @tipo, @usuario, @mensaje;

        set @mensaje = 'factura insertada exitosamente y movimiento registrado.';
    end try
    begin catch
        set @mensaje = 'error al insertar la factura: ' + error_message();
    end catch
end;
go

---------------------------------------
create function gestion_inventario.obtenerultimoidmovimiento()
returns int
as
begin
    declare @ultimoidmovimiento int;

    select @ultimoidmovimiento = max(id_movimiento)
    from gestion_inventario.movimientos_inventario;

    return @ultimoidmovimiento;
end;
go

-- Crear procedimiento para insertar líneas de factura
-- crear procedimiento para insertar líneas de factura
create procedure facturación.lineasfactura
    @c_articulo varchar(180),
    @cantidad int,
    @precio_unitario int,
    @monto_total int,
    @usuario int,
    @mensaje nvarchar(200) output
as
begin
    begin try
        declare @bodega varchar(180);
        declare @id_movimiento int; 
        declare @n_factura int = facturación.obtenerultimafactura();

        -- llamar a la función para obtener la bodega con cantidad suficiente
        set @bodega = gestion_inventario.abodega(@c_articulo, @cantidad);

        -- verificar si se encontró una bodega adecuada
        if @bodega = 'no hay suficiente cantidad en ninguna bodega.'
        begin
            set @mensaje = @bodega;
            return;
        end
        
        -- insertar en la lista de artículos facturados
        insert into facturación.lista_articulos_facturados(n_factura, c_articulo, cantidad, precio_unitario, monto_total)
        values (@n_factura, @c_articulo, @cantidad, @precio_unitario, @monto_total);

        -- calcular y actualizar el total de la factura
        declare @totalfactura decimal(10, 2);
        exec facturación.calculartotalfactura @n_factura, @totalfactura output;

        update facturación.facturas
        set total = @totalfactura
        where n_factura = @n_factura;
        
        -- restar la cantidad del inventario en la bodega seleccionada
        update gestion_inventario.inventario
        set cantidad = cantidad - @cantidad
        where c_articulo = @c_articulo and c_bodega = @bodega;

        -- registrar el movimiento
        exec gestion_inventario.gestionar_movimiento 'salida', @c_articulo, @bodega, null, @cantidad, @usuario;

        -- obtener el último id de movimiento
        set @id_movimiento = gestion_inventario.obtenerultimoidmovimiento();
        print 'el último id de movimiento es: ' + cast(@id_movimiento as varchar(10));

        -- insertar el detalle del movimiento directamente aquí   exec gestion_inventario.insertar_detalle_movimiento @id_movimiento, @c_articulo, @cantidad, @bodega, null, @mensaje;
        insert into gestion_inventario.detalle_movimiento (id_movimiento, c_articulo, cantidad, bodega_origen,bodega_destino)
        values (@id_movimiento, @c_articulo, @cantidad, @bodega, null); -- ajusta 'otra_columna' según tus necesidades

        -- mensaje final
        set @mensaje = 'artículo enlistado y cantidad restada del inventario, movimiento registrado.';
    end try
    begin catch
        -- manejo de errores
        set @mensaje = 'error: ' + error_message();
    end catch
end;
go


-- función para obtener la bodega con suficiente cantidad
create function gestion_inventario.abodega (
    @c_articulo varchar(180),
    @cantidad_minima int
)
returns varchar(180)
as
begin
    declare @bodega varchar(180);

    -- buscar la primera bodega con suficiente cantidad de artículo
    select top 1 @bodega = c_bodega
    from gestion_inventario.inventario
    where c_articulo = @c_articulo and cantidad >= @cantidad_minima
    order by cantidad desc;

    -- si no se encuentra, devolver mensaje
    if @bodega is null
        set @bodega = 'no hay suficiente cantidad en ninguna bodega.';

    return @bodega;
end;
go







----------------------------------- anular factura-----------------------------
CREATE PROCEDURE facturación.AnularFactura
	@n_factura int,	
    @id_empleado INT,
    @motivo_anulacion VARCHAR(200),
    @mensaje NVARCHAR(200) OUTPUT
AS
BEGIN
    BEGIN TRY
	 -- Crear movimiento al insertar la factura
        
        DECLARE @tipo VARCHAR(30) = 'entrada';
        DECLARE @usuario INT = @id_empleado;
		

        --Nuevo movimiento
        EXEC gestion_inventario.insertar_movimiento @n_factura, @tipo, @usuario,@mensaje ;
		DECLARE @id_movimiento int = SCOPE_IDENTITY();

		---mod estado y motivo
		UPDATE facturación.facturas
        SET estado = 'anulada', motivo_anulacion = @motivo_anulacion
        WHERE n_factura = @n_factura;


		DECLARE @c_articulo VARCHAR(180);
        DECLARE @cantidad INT;
        DECLARE @c_bodega VARCHAR(180);

        DECLARE producto_cursor CURSOR FOR
        SELECT lf.c_articulo, lf.cantidad, dm.bodega_origen
        FROM lista_articulos_facturados LF
        JOIN gestion_inventario.detalle_moviminto dm ON dm.c_articulo = lf.c_articulo and dm.cantidad=lf.cantidad
        WHERE lf.n_factura = @n_factura;

        OPEN producto_cursor;
        FETCH NEXT FROM producto_cursor INTO @c_articulo, @cantidad, @c_bodega;

        WHILE @@FETCH_STATUS = 0
        BEGIN
           
            EXEC gestion_inventario.suma_inventario @c_bodega, @c_articulo, @cantidad;
			EXEC gestion_inventario.insertar_detalle_movimiento @id_movimiento, @c_articulo, @cantidad, null, @c_bodega,@mensaje ;

            FETCH NEXT FROM producto_cursor INTO @c_articulo, @cantidad, @c_bodega;
        END

        CLOSE producto_cursor;
        DEALLOCATE producto_cursor;

        
        SET @mensaje = 'Factura anulada exitosamente y movimiento registrado.';
    END TRY
    BEGIN CATCH
        SET @mensaje = 'Error al anular la factura: ' + ERROR_MESSAGE();
    END CATCH
END;
GO
--------------Historiales de usuario salario----------------------------

create procedure usuarios.Hsalarios
@cedula int, 
@FechaInicio date, 
@monto int,
@mensaje NVARCHAR(200) OUTPUT
as 
begin 
	DECLARE @FechaFin DATETIME = GETDATE();
	DECLARE @NombrePuesto varchar(180);
	DECLARE @Departamento varchar(180);

begin try 
	 SET @NombrePuesto = usuarios.puestoActual(@cedula);
	  SET @Departamento = usuarios.departamentoActual(@cedula);
	 update usuarios.historico_salarios
     set fechafin = @Fechafin
     where cedula = @cedula and fechafin is null; 
	

	 insert into usuarios.historico_salarios(cedula, FechaInicio, FechaFin, NombrePuesto, Departamento,monto)
     values (@cedula, @FechaInicio, NULL,@NombrePuesto, @Departamento,@monto);
	 set @mensaje = 'Modificacion ingresada.';
end try 
begin catch 
	set @mensaje = 'Modificacion no ingresada.';
end catch 
end;
go

create function usuarios.puestoactual(@cedula int)
returns varchar(180) 
as 
begin 
    declare @puesto_actual varchar(180);
    
    select top 1 @puesto_actual = puesto_actual 
    from usuarios.empleados em 
    where em.cedula = @cedula;

    return @puesto_actual;
end; 
go
create function usuarios.departamentoactual(@cedula int)
returns varchar(180) 
as 
begin 
    declare @departamento_actual varchar(180);
    
    select top 1 @departamento_actual = departamento_actual 
    from usuarios.empleados em 
    where em.cedula = @cedula;

    return @departamento_actual;
end; 
go
-------------------------Histyorisl puesotos
create procedure usuarios.HPuestos
@cedula int, 
@FechaInicio date, 
@mensaje NVARCHAR(200) OUTPUT
as 
begin 
	DECLARE @FechaFin DATETIME = GETDATE();
	DECLARE @NombrePuesto varchar(180);
	DECLARE @Departamento varchar(180);

begin try 
	 SET @NombrePuesto = usuarios.puestoActual(@cedula);
	  SET @Departamento = usuarios.departamentoActual(@cedula);
	 update usuarios.historico_puesto
     set fechafin = @Fechafin
     where cedula = @cedula and fechafin is null; 
	

	 insert into usuarios.historico_puesto(cedula, FechaInicio, FechaFin, NombrePuesto, Departamento)
     values (@cedula, @FechaInicio, NULL,@NombrePuesto, @Departamento);
	 set @mensaje = 'Modificacion ingresada.';
end try 
begin catch 
	set @mensaje = 'Modificacion no ingresada.';
end catch 
end;
go
-------------------funciones select -----------------------
CREATE FUNCTION usuarios.ObtenerEmpleados()
RETURNS TABLE
AS
RETURN
(		
		SELECT 
        cedula,
        nombre,
        apellido1,
        apellido2,
        Correo_Electronico,
        género,
        fecha_nacimiento,
        edad,
        lugar_residencia,
        Telefono,
        fecha_ingreso,
        salario_actual,
        puesto_actual,
        departamento_actual,
        rol
    FROM usuarios.empleados
);
GO



CREATE FUNCTION usuarios.puestos()
RETURNS TABLE
AS
RETURN
(
    SELECT 
	id_puesto
	id_departamento
    FROM usuarios.puesto
);
go

CREATE FUNCTION usuarios.contraseñas()
RETURNS TABLE
AS
RETURN
(
    SELECT 
	cedula,
	Contraseña
    FROM usuarios.logeo
);
go

create function usuarios.hsalario(@fechai datetime, @fechafin datetime)
returns table
as
return
(
    select 
        cedula, 
        fechainicio, 
        fechafin,
        nombrepuesto,
        departamento,
        monto
    from usuarios.historico_salarios
    where fechainicio >= @fechai and fechafin <= @fechafin
);
go


create function gestion_inventario.productos()
returns table
as
return
(
    select 
        ga.c_articulo,
		ga.activo,

        ga.c_familia,
        ga.descripcion,
        ga.nombre,
        ga.peso,
        ga.precio,
        gi.c_bodega,
        gi.cantidad
    from 
        gestion_inventario.articulos ga
    join 
        gestion_inventario.inventario gi on gi.c_articulo = ga.c_articulo
);


go
create function clientes.ObtenerCliente()
returns table
as
return
(
    select 
     cedula,
        nombre,
        Correo_Electronico ,
        Telefono ,
        celular ,
        fax ,
		zona, 
		sector
    from  clientes.cliente
   
);
go

create function clientes.obtenerclientoporcedula (@cedula nvarchar(50))
returns table
as
return
(
    select 
        cedula,
        nombre,
        correo_electronico,
        telefono,
        celular,
        fax,
        zona,
        sector
    from clientes.cliente
    where cedula = @cedula
);
go
create function clientes.cantidades()
returns table
as
return
(
    select 
     cedula,
        nombre,
        Correo_Electronico ,
        Telefono ,
        celular ,
        fax ,
		zona, 
		sector
    from  clientes.cliente
   
);
go
create function facturación.ERP()
returns table
as
return
(
    select 
    nombre_local
      ,cedula_juridica_local
      ,telefono_local
    from  facturación.Locales
   
);
go
