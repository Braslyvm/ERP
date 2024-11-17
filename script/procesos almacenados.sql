
use Planificador_recursos_empresariales
go

-- ================================================
-- Nombre: CrearRol
-- Parámetros:
--   @nombre VARCHAR(180)
--   @vendedor BIT
-- Función: Crea un nuevo rol en la tabla de roles
-- ================================================
create procedure CrearRol(@nombre varchar (180) , @vendedor bit)
as 
begin	
	insert into usuarios.roles(nombre , vendedor)
	values (@nombre,@vendedor)
end 
go


-- ================================================
-- Nombre: InsertarPermisosInventario
-- Parámetros:
--   @nombre VARCHAR(180)
--   @edicion BIT
--   @visualizacion BIT
--   @reportes BIT
-- Función: Inserta permisos en el módulo de Inventario
-- ================================================
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


-- ================================================
-- Nombre: InsertarPermisosUsuarios
-- Parámetros:
--   @nombre VARCHAR(180)
--   @edicion BIT
--   @visualizacion BIT
--   @reportes BIT
-- Función: Inserta permisos en el módulo de Usuarios
-- ================================================
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

-- ================================================
-- Nombre: InsertarPermisosCotizaciones
-- Parámetros:
--   @nombre VARCHAR(180)
--   @edicion BIT
--   @visualizacion BIT
--   @reportes BIT
-- Función: Inserta permisos en el módulo de Cotizaciones
-- ================================================
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

go
-- ================================================
-- Nombre: InsertarPermisosFacturas
-- Parámetros:
--   @nombre VARCHAR(180)
--   @edicion BIT
--   @visualizacion BIT
--   @reportes BIT
-- Función: Inserta permisos en el módulo de Facturas
-- ================================================
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

-- ================================================
-- Nombre: InsertarPermisosClientes
-- Parámetros:
--   @nombre VARCHAR(180)
--   @edicion BIT
--   @visualizacion BIT
--   @reportes BIT
-- Función: Inserta permisos en el módulo de Clientes
-- ================================================
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

-- ================================================
-- Nombre: InsertarPermisosReportes
-- Parámetros:
--   @nombre VARCHAR(180)
--   @edicion BIT
--   @visualizacion BIT
--   @reportes BIT
-- Función: Inserta permisos en el módulo de Reportes
-- ================================================
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

-- ================================================
-- Nombre: InsertarPermisosCasos
-- Parámetros:
--   @nombre VARCHAR(180)
--   @edicion BIT
--   @visualizacion BIT
--   @reportes BIT
-- Función: Inserta permisos en el módulo de Casos
-- ================================================
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

-- ================================================
-- Nombre: usuarios
-- Parámetros: Ninguno
-- Retorna: Tabla con cédula y nombre de los empleados
-- ================================================
create function dbo.usuarios ()
returns table
as 
return (select cedula , nombre from  usuarios.empleados);
go 

--------------- retorna los roles ----------------------

-- ================================================
-- nombre: dbo.roles
--  Paramentros: Ninguno
--  retorna: Tabla con los nombres de los roles
-- ================================================

create function dbo.roles ()
returns table
as 
return (select nombre from  usuarios.roles);
go 


-- ================================================
-- nombre: dbo.encryptar
--  Paramentros: @contraseña nvarchar(200)
--  retorna: varbinary(max) 
-- ================================================
create function dbo.encryptar (@contraseña nvarchar(200))
returns varbinary(max)        
as
begin
    if @contraseña is null
        return null;
    return hashbytes('sha2_256', @contraseña);
end;
go

-- ================================================
-- nombre: usuarios.insertar_empleado
--  Paramentros:
--    @cedula int,
--    @nombre varchar(200),
--    @apellido1 varchar(200),
--    @apellido2 varchar(200),
--    @correo_electronico varchar(180),
--    @contraseña varchar(200),
--    @género varchar(180),
--    @fecha_nacimiento date,
--    @lugar_residencia varchar(180),
--    @telefono int,
--    @fecha_ingreso date,
--    @salario_actual int,
--    @puesto_actual varchar(180),
--    @departamento_actual varchar(180),
--    @rol varchar(180),
--    @mensaje nvarchar(200) output
--  funcion: Inserta un nuevo empleado en la tabla usuarios.empleados y devuelve un mensaje
-- ================================================
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
        set @mensaje = 'Error al insertar el empleado: ' + ERROR_MESSAGE();
    end catch
end;
go



-------------------modificar empleado -------------------------

-- ================================================
-- nombre: usuarios.actualizar_empleado
--  Paramentros:
--    @cedula int,
--    @nombre varchar(200) = null,
--    @apellido1 varchar(200) = null,
--    @apellido2 varchar(200) = null,
--    @correo_electronico varchar(180) = null,
--    @contraseña varchar(200) = null,
--    @género varchar(180) = null,
--    @fecha_nacimiento date = null,
--    @lugar_residencia varchar(180) = null,
--    @telefono int = null,
--    @fecha_ingreso date = null,
--    @salario_actual int = null,
--    @puesto_actual varchar(180) = null,
--    @departamento_actual varchar(180) = null,
--    @rol varchar(180) = null,
--    @mensaje nvarchar(200) output
--  funcion: Actualiza los datos de un empleado en la tabla usuarios.empleados y devuelve un mensaje
-- ================================================
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

-- ================================================
-- nombre: dbo.InicioValido
--  Paramentros: 
--    @Cedula int,
--    @contraseña varchar(200)
--  retorna: bit
-- ================================================
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

-- ================================================
-- nombre: roles_por_usuario
--  Paramentros: Ninguno
--  retorna: Vista con los nombres completos y roles de los empleados
-- ================================================
create view roles_por_usuario as
select 
    concat(e.nombre, ' ', e.apellido1, ' ', e.apellido2) as nombre_completo,
    e.rol
from 
    usuarios.empleados e;
go


--------------------------------------usuariopor usuario ---------------------------------------------
-- ================================================
-- nombre: usuarios_por_rol
--  Paramentros: Ninguno
-- retorna: Vista con los roles y los nombres completos de los empleados asociados.
-- ================================================

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
-- ================================================
-- nombre: calcularsalario
--  Paramentros: 
--    @h_normales int - Horas normales trabajadas.
--    @h_extras int - Horas extras trabajadas.
--    @salario_actual int - Salario actual del empleado.
-- retorna: int - Salario total calculado con las horas extras.
-- ================================================
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
-- ================================================
-- nombre: insertar_plantilla
--  Paramentros:
--    @cedula int - Cédula del empleado.
--    @mes varchar(180) - Mes de la plantilla.
--    @año int - Año de la plantilla.
--    @fecha_pago datetime - Fecha del pago.
--    @h_normales int - Horas normales trabajadas.
--    @h_extras int - Horas extras trabajadas.
--    @mensaje nvarchar(200) output - Mensaje de salida.
-- funcion: Inserta un registro en la plantilla de pagos de un empleado.
-- ================================================
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
-- ================================================
-- nombre: PlanillaMes
--  Paramentros:
--    @mes varchar(180) - Mes de la plantilla.
-- funcion: Muestra la plantilla de empleados de un mes específico.
-- ================================================
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
-- ================================================
-- nombre: planillaAño
--  Paramentros:
--    @año int - Año de la plantilla.
-- funcion: Muestra la plantilla de empleados de un año específico.
-- ================================================

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
-- ================================================
-- nombre: mostrar_planilla_por_departamento
--  Paramentros:
--    @departamento varchar(180) - Nombre del departamento.
-- funcion: Muestra la plantilla de empleados de un departamento específico.
-- ================================================

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
-- ================================================
-- nombre: ObtenerArticulosPorBodega
--  Paramentros: Ninguno
-- retorna: Lista de artículos por bodega con su stock.
-- ================================================

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
-- ================================================
-- nombre: insertar_cliente
--  Paramentros:
--    @cedula int - Cédula del cliente.
--    @nombre varchar(180) - Nombre del cliente.
--    @correo_electronico varchar(180) - Correo del cliente.
--    @telefono int - Teléfono del cliente.
--    @celular int - Celular del cliente.
--    @fax varchar(180) - Fax del cliente.
--    @zona varchar(180) - Zona del cliente.
--    @sector varchar(180) - Sector del cliente.
--    @mensaje nvarchar(200) output - Mensaje de salida.
-- funcion: Inserta un nuevo cliente si no existe previamente.
-- ================================================
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
-- ================================================
-- nombre: cantidad_disponible
--  Paramentros:
--    @c_bodega varchar(180) - Código de bodega.
--    @c_articulo varchar(180) - Código de artículo.
--    @cantidad_solicitada int - Cantidad solicitada del artículo.
-- retorna: bit - 1 si hay suficiente cantidad, 0 si no.
-- ================================================

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
-- ================================================
-- nombre: restar_inventario
--  Paramentros:
--    @c_bodega varchar(180) - Código de bodega.
--    @c_articulo varchar(180) - Código de artículo.
--    @cantidad int - Cantidad de artículos a restar.
-- ================================================

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
-- ================================================
-- nombre: suma_inventario
-- Paramentros:
--    @c_bodega varchar(180) - Código de bodega.
--    @c_articulo varchar(180) - Código de artículo.
--    @cantidad int - Cantidad de artículos a sumar.
-- funcion:
-- ================================================
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

-- ================================================
-- nombre: getfecha_Factura
-- Paramentros:
--    @id_Factura int - ID de la factura.
-- retorna:
--    date - Fecha de la factura.
-- ================================================
create function dbo.getfecha_Factura (
	@id_Factura int
)
returns date 
as 
begin
	declare @fecha date;
	select @fecha = fecha_factura
	from facturación.facturas
	where @id_Factura = n_factura;
	return @fecha;
end;
go



-- ================================================
-- nombre: insertar_movimiento
-- Paramentros:
--    @n_factura int - Número de la factura.
--    @tipo varchar(30) - Tipo de movimiento (entrada/salida).
--    @usuario int - ID del usuario que realiza el movimiento.
--    @mensaje nvarchar(200) output - Mensaje de confirmación.
-- funcion:
-- ================================================
create procedure gestion_inventario.insertar_movimiento (
    @n_factura int,
    @tipo varchar(30),
    @usuario int,
    @mensaje nvarchar(200) output
)
as
begin
   
    insert into gestion_inventario.movimientos_inventario (n_factura, tipo, fecha, usuario)
    values (@n_factura,  @tipo,  COALESCE(dbo.getfecha_Factura(@n_factura), GETDATE()),  @usuario);

    set @mensaje = 'Movimiento creado.';
end;
go

-- ================================================
-- nombre: insertar_detalle_movimiento
-- Paramentros:
--    @id_movimiento int - ID del movimiento.
--    @c_articulo varchar(180) - Código de artículo.
--    @cantidad int - Cantidad de artículos.
--    @bodega_origen varchar(180) - Bodega de origen.
--    @bodega_destino varchar(180) - Bodega de destino.
--    @mensaje nvarchar(200) output - Mensaje de confirmación.
-- funcion:
-- ================================================
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


-- ================================================
-- nombre: gestionar_movimiento
-- Paramentros:
--    @tipo_movimiento varchar(30) - Tipo de movimiento (entrada/salida/movimiento).
--    @c_articulo varchar(180) - Código de artículo.
--    @c_bodega_origen varchar(180) - Bodega de origen.
--    @c_bodega_destino varchar(180) - Bodega de destino.
--    @cantidad int - Cantidad de artículos.
--    @usuario int - ID del usuario que realiza el movimiento.
-- retorna:
--    varchar(100) - Mensaje de éxito o error.
-- ================================================
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

-- ================================================
-- nombre: insertar_cotizacion
-- Paramentros:
--    @cliente int - ID del cliente.
--    @empleado int - ID del empleado.
--    @m_cierre varchar(180) - Monto de cierre.
--    @probabilidad int - Probabilidad de éxito.
--    @tipo varchar(180) - Tipo de cotización.
--    @descripcion varchar(180) - Descripción de la cotización.
--    @fecha date - Fecha de la cotización.
--    @mensaje nvarchar(200) output - Mensaje de confirmación.
-- funcion:
-- ================================================
create procedure cotizaciones.insertar_cotizacion
    @cliente int,
    @empleado int,
    @m_cierre varchar(180),
    @probabilidad int,
    @tipo varchar(180),
    @descripcion varchar(180),
	@fecha date,
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
        values (@cliente, @empleado, @fecha , @m_cierre, @probabilidad, @tipo, @descripcion, @zona, @sector, 'abierta');
        
        set @mensaje = 'Cotización insertada exitosamente.';
    end try
    begin catch
        set @mensaje = 'Error al insertar la cotización.';
    end catch
end;
go


-- ================================================
-- nombre: actualizar_monto_total_cotizacion
-- Paramentros:
--    @id_cotizacion int - ID de la cotización.
-- funcion:
-- ================================================
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


-- ================================================
-- nombre: sp_obtener_cotizaciones_con_articulos
-- Paramentros: ninguno
-- funcion:
-- ================================================
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


-- ================================================
-- nombre: sp_obtener_tareas_cotizaciones
-- Paramentros: ninguno
-- funcion:
-- ================================================
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

-- ================================================
-- nombre: dbo.clientes
--  Paramentros: Ninguno
-- retorna: tabla con columnas cedula y nombre de los clientes
-- ================================================
create function dbo.clientes ()
returns table
as 
return (select cedula , nombre from  clientes.cliente );
go 

--------------- retorna los cotizacio----------------------

-- ================================================
-- nombre: dbo.cotizaciones
--  Paramentros: Ninguno
-- retorna: tabla con la columna id_cotizacion
-- ================================================
create function dbo.cotizaciones()
returns table
as 
return (select id_cotizacion  from  cotizaciones.cotizaciones );
go 

----------------------------------actualizar------------------------------------

-- ================================================
-- nombre: cotizaciones.actualizar_cotizacion
--  Paramentros: 
--    @id_cotizacion int
--    @m_cierre varchar(180) = null
--    @probabilidad int = null
--    @tipo varchar(180) = null
--    @estado varchar(180) = null
--    @m_denegacion varchar(255) = null
--    @contra_quien varchar(255) null
--    @mensaje nvarchar(200) output
-- funcion: Actualiza los detalles de una cotización
-- ================================================
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

-- ================================================
-- nombre: cotizaciones.eliminar_cotizacion
--  Paramentros: 
--    @id_cotizacion int
-- funcion: Elimina la cotización y sus registros asociados
-- ================================================
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

-- ================================================
-- nombre: dbo.Articulos
--  Paramentros: Ninguno
-- retorna: tabla con columnas codigo, nombre, bodega y cantidad de artículos
-- ================================================
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

-- ================================================
-- nombre: cotizaciones.insertar_articulo_cotizacion
--  Paramentros: 
--    @id_cotizacion int
--    @c_producto varchar(180)
--    @cantidad int
--    @c_Bodega varchar(180)
--    @mensaje nvarchar(200) output
-- funcion: Inserta un artículo a la cotización especificada
-- ================================================
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

		EXEC cotizaciones.actualizar_monto_total_cotizacion @id_cotizacion
        
        set @mensaje = 'Artículo enlistado.';
    end try
    begin catch
        set @mensaje = 'Error al insertar articulo.';
    end catch
end;
go

--------------------------------crear tarea de cotizacion ----------------------------------

-- ================================================
-- nombre: cotizaciones.insertar_tarea
--  Paramentros: 
--    @id_cotizacion int
--    @descripcion varchar(255)
--    @usuario int
--    @fecha_limite date
--    @estado varchar(180)
--    @fecha_inicio date
--    @mensaje nvarchar(200) output
-- funcion: Crea una tarea asociada a una cotización
-- ================================================
create procedure cotizaciones.insertar_tarea
    @id_cotizacion int,
    @descripcion varchar(255),
    @usuario int,
    @fecha_limite date,
    @estado varchar(180),
	@fecha_inicio date,
    @mensaje nvarchar(200) output
as
begin
    begin try
        insert into cotizaciones.tareas (id_cotizacion, descripcion, usuario, fecha_inicio, fecha_limite, estado)
        values (@id_cotizacion, @descripcion, @usuario,@fecha_inicio, @fecha_limite, @estado);
        
        set @mensaje = 'Tarea insertada.';
    end try
    begin catch
        set @mensaje = 'Error al insertar la tarea.';
    end catch
end;
go

-------------------modificar tarea --------------------

-- ================================================
-- nombre: cotizaciones.actualizar_tarea
--  Paramentros: 
--    @id_tarea int
--    @descripcion varchar(255) = null
--    @usuario int = null
--    @fecha_limite datetime = null
--    @estado varchar(180) = null
--    @mensaje nvarchar(200) output
-- funcion: Actualiza los detalles de una tarea existente
-- ================================================
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

-- ================================================
-- nombre: dbo.tarea
--  Paramentros: Ninguno
-- retorna: tabla con columna id_tarea de tareas
-- ================================================
create function dbo.tarea()
returns table
as 
return (select id_tarea  from  cotizaciones.tareas );
go 

------------------------Borrar Tarea------------------------------

-- ================================================
-- nombre: cotizaciones.borrartareaporid
--  Paramentros: 
--    @id_tarea int
-- funcion: Elimina una tarea especificada por su id
-- ================================================
create procedure cotizaciones.borrartareaporid
    @id_tarea int
as
begin
     delete from cotizaciones.tareas
     where id_tarea = @id_tarea;
end;
go
-----------------------------acesso a cotizar-------------------------------------------------------
-- ================================================
-- nombre: validar_permiso_cotizacion
--  Paramentros: 
--   @cedula int
--   @tipo varchar(100)
-- retorna: bit
-- ================================================
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
-- ================================================
-- nombre: validar_permiso_inventario
--  Paramentros: 
--   @cedula int
--   @tipo varchar(100)
-- retorna: bit
-- ================================================
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
-- ================================================
-- nombre: validar_permiso_usuarios
--  Paramentros: 
--   @cedula int
--   @tipo varchar(100)
-- retorna: bit
-- ================================================
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


-- ================================================
-- nombre: validar_permiso_facturas
--  Paramentros: 
--   @cedula int
--   @tipo varchar(100)
-- retorna: bit
-- ================================================
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
-- ================================================
-- nombre: validar_permiso_clientes
--  Paramentros: 
--   @cedula int
--   @tipo varchar(100)
-- retorna: bit
-- ================================================
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
-- ================================================
-- nombre: dbo.validar_permiso_reportes
-- Parametros:
--  @cedula int
--  @tipo varchar(100)
-- retorna: bit
-- ================================================
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
-- ================================================
-- nombre: dbo.validar_permiso_caso
-- Parametros:
--  @cedula int
--  @tipo varchar(100)
-- retorna: bit
-- ================================================
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
-- ================================================
-- nombre: dbo.validar_permiso_venta
-- Parametros:
--  @cedula int
-- retorna: bit
-- ================================================
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
-- ================================================
-- nombre: facturación.obtenerultimafactura
-- Parametros: ninguno
-- retorna: int
-- ================================================
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

-- ================================================
-- nombre: facturación.calculartotalfactura
-- Parametros:
--  @n_factura int
--  @total decimal(10, 2) output
-- funcion: Calcula el total de la factura
-- ================================================
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

-- ================================================
-- nombre: facturación.insertar_factura
-- Parametros:
--  @cedula_juridica_local int
--  @id_cliente int
--  @id_cotizacion int = null
--  @id_empleado int
--  @fecha_factura date
--  @estado varchar(20)
--  @motivo_anulacion varchar(200)
--  @total int = null
--  @mensaje nvarchar(200) output
-- funcion: Inserta una nueva factura
-- ================================================
create procedure facturación.insertar_factura
    @cedula_juridica_local int, 
    @id_cliente int, 
    @id_cotizacion int = null, 
    @id_empleado int,
    @fecha_factura date,
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
-- ================================================
-- nombre: gestion_inventario.obtenerultimoidmovimiento
-- Parametros: ninguno
-- retorna: int
-- ================================================
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

-- ================================================
-- nombre: facturación.lineasfactura
-- Parametros:
--  @c_articulo varchar(180)
--  @cantidad int
--  @precio_unitario int
--  @monto_total int
--  @usuario int
--  @mensaje nvarchar(200) output
-- funcion: Inserta una línea de factura y actualiza el inventario
-- ================================================
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
        declare @n_factura int;
		       declare @aprovacion int;

        -- Obtener el último número de factura
        select @n_factura = max(n_factura) from facturación.facturas;

        -- Llamar a la función para verificar la bodega con cantidad suficiente
        set @bodega = gestion_inventario.abodega(@c_articulo, @cantidad);

        if @bodega = 'no hay suficiente cantidad en ninguna bodega.'
        begin
            set @mensaje = @bodega;
            return;
        end

        -- Insertar en la lista de artículos facturados
        insert into facturación.lista_articulos_facturados(n_factura, c_articulo, cantidad, precio_unitario, monto_total)
        values (@n_factura, @c_articulo, @cantidad, @precio_unitario, @monto_total);

        -- Calcular y actualizar el total de la factura
        declare @totalfactura decimal(10, 2);
        exec facturación.calculartotalfactura @n_factura, @totalfactura output;

        update facturación.facturas
        set total = @totalfactura
        where n_factura = @n_factura;

        -- Restar la cantidad del inventario en la bodega seleccionada
        update gestion_inventario.inventario
        set cantidad = cantidad - @cantidad
        where c_articulo = @c_articulo and c_bodega = @bodega;

        -- Registrar el movimiento
        set @aprovacion =  gestion_inventario.cantidad_disponible(@bodega, @c_articulo, @cantidad);
		if (@aprovacion != 1)
			return 'La salida fallo'
		--EXEC gestion_inventario.restar_inventario @bodega, @c_articulo, @cantidad;

        -- Obtener el último ID de movimiento
        set @id_movimiento = gestion_inventario.obtenerultimoidmovimiento();

        -- Insertar el detalle del movimiento
        insert into gestion_inventario.detalle_movimiento (id_movimiento, c_articulo, cantidad, bodega_origen, bodega_destino)
        values (@id_movimiento, @c_articulo, @cantidad, @bodega, null);

        -- Mensaje final
        set @mensaje = 'Artículo enlistado y cantidad restada del inventario, movimiento registrado.';
    end try
    begin catch
        -- Manejo de errores
        set @mensaje = 'Error: ' + error_message();
    end catch
end;
go

-- ================================================
-- nombre: gestion_inventario.abodega
-- Paramentros:
--   @c_articulo varchar(180),
--   @cantidad_minima int
-- retorna:
--   varchar(180)
-- ================================================
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



-- ================================================
-- nombre: facturación.AnularFactura
-- Paramentros:
--   @n_factura int,	
--   @id_empleado INT,
--   @motivo_anulacion VARCHAR(200),
--   @mensaje NVARCHAR(200) OUTPUT
-- funcion:
--   Anula una factura y registra los movimientos correspondientes.
-- ================================================
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


-- ================================================
-- nombre: usuarios.Hsalarios
-- Paramentros:
--   @cedula int, 
--   @FechaInicio date, 
--   @monto int,
--   @mensaje NVARCHAR(200) OUTPUT
-- funcion:
--   Registra un cambio en el salario de un empleado en su historial.
-- ================================================
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


-- ================================================
-- nombre: usuarios.puestoactual
-- Paramentros:
--   @cedula int
-- retorna:
--   varchar(180)
-- ================================================
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


-- ================================================
-- nombre: usuarios.departamentoactual
-- Paramentros:
--   @cedula int
-- retorna:
--   varchar(180)
-- ================================================
---Retorna el departamento actual de un empleado
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


-- ================================================
-- nombre: usuarios.HPuestos
-- Paramentros:
--   @cedula int, 
--   @FechaInicio date, 
--   @mensaje NVARCHAR(200) OUTPUT
-- funcion:
--   Registra un cambio en el puesto de un empleado en su historial.
-- ================================================
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


-- ================================================
-- nombre: usuarios.ObtenerEmpleados
-- Paramentros:
--   ninguno
-- retorna:
--   Tabla con la información de los empleados.
-- ================================================
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


-- ================================================
-- nombre: usuarios.puestos
-- Paramentros:
--   ninguno
-- retorna:
--   Tabla con la información de los puestos.
-- ================================================
--- retorna todos los puestos
CREATE FUNCTION usuarios.puestos()
RETURNS TABLE
AS
RETURN
(
    SELECT 
	id_puesto,
	id_departamento
    FROM usuarios.puesto
);
go


-- ================================================
-- nombre: usuarios.contraseñas
-- Paramentros:
--   ninguno
-- retorna:
--   Tabla con la información de las contraseñas.
-- ================================================
--- retorna las contraseñas
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


-- ================================================
-- nombre: usuarios.hsalario
-- Paramentros:
--   @fechai datetime, 
--   @fechafin datetime
-- retorna:
--   Tabla con la información de los historiales de salario.
-- ================================================
--- retorna los historiales de salario
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
-- ================================================
-- nombre: gestion_inventario.productos
--  Paramentros: Ninguno
-- retorna: Devuelve una tabla con los artículos y su inventario correspondiente.
-- ================================================
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

---retorna todos los clientes
go
-- ================================================
-- nombre: clientes.ObtenerCliente
--  Paramentros: Ninguno
-- retorna: Devuelve una tabla con la información de todos los clientes.
-- ================================================
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
-- ================================================
-- nombre: clientes.obtenerclientoporcedula
--  Paramentros: 
--      @cedula nvarchar(50): Cédula del cliente.
-- retorna: Devuelve una tabla con la información del cliente especificado por cédula.
-- ================================================
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

-- ================================================
-- nombre: clientes.cantidades
--  Paramentros: Ninguno
-- retorna: Devuelve una tabla con las cantidades de los clientes.
-- ================================================
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
-- ================================================
-- nombre: facturación.ERP
--  Paramentros: Ninguno
-- retorna: Devuelve una tabla con la información del local.
-- ================================================
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

-- ================================================
-- nombre: gestion_inventario.insertar_producto_y_registrar_movimiento
--  Paramentros: 
--      @c_bodega varchar(180): Código de la bodega.
--      @c_articulo varchar(180): Código del artículo.
--      @cantidad int: Cantidad del artículo.
--      @n_factura int: Número de factura.
--      @usuario int: Identificador del usuario.
--      @bodega_origen varchar(180): (Opcional) Código de la bodega de origen.
--      @bodega_destino varchar(180): Código de la bodega de destino.
--      @mensaje nvarchar(200) output: Mensaje de salida.
-- funcion: Registra un producto en el inventario y el movimiento correspondiente en el sistema.
-- ================================================
create procedure gestion_inventario.insertar_producto_y_registrar_movimiento (
   @c_bodega VARCHAR(180),
    @c_articulo VARCHAR(180),
    @cantidad INT,
    @n_factura INT = NULL,
    @usuario INT,
    @bodega_origen VARCHAR(180) = NULL,
    @bodega_destino VARCHAR(180),
    @mensaje NVARCHAR(200) OUTPUT
)
as
begin
    begin try
        -- Paso 1: Actualizar la cantidad en la tabla inventario
        exec gestion_inventario.suma_inventario @c_bodega = @c_bodega, @c_articulo = @c_articulo, @cantidad = @cantidad;
        
        -- Paso 2: Insertar el movimiento en movimientos_inventario
        exec gestion_inventario.insertar_movimiento 
            @n_factura = @n_factura, 
            @tipo = 'entrada', 
            @usuario = @usuario, 
            @mensaje = @mensaje output;

        -- Paso 3: Obtener el último id_movimiento insertado
        declare @id_movimiento int;
        set @id_movimiento = gestion_inventario.obtenerultimoidmovimiento();

        -- Paso 4: Insertar el detalle del movimiento
        exec gestion_inventario.insertar_detalle_movimiento 
            @id_movimiento = @id_movimiento, 
            @c_articulo = @c_articulo, 
            @cantidad = @cantidad, 
            @bodega_origen = @bodega_origen, 
            @bodega_destino = @bodega_destino, 
            @mensaje = @mensaje output;

        -- Mensaje de éxito
        set @mensaje = 'Producto insertado y movimiento registrado correctamente.';
    end try
    begin catch
        -- Manejo de errores
        set @mensaje = 'Error al insertar el producto o registrar el movimiento: ' + ERROR_MESSAGE();
    end catch
end;
go
-- ================================================
-- nombre: insertar_caso
--  Paramentros: 
--      @id_empleado int,
--      @id_cotizacion int = null,
--      @id_factura int = null,
--      @nombre_cuenta varchar(180),
--      @nombre_contacto varchar(180),
--      @asunto varchar(180),
--      @direccion varchar(180),
--      @descripcion_caso varchar(1000),
--      @estado varchar(180),
--      @tipo_caso varchar(180),
--      @prioridad varchar(180),
--      @fecha date
-- funcion: Inserta un caso en la tabla registro_caso.casos
-- ================================================
create procedure registro_caso.insertar_caso
    @id_empleado int,
    @id_cotizacion int = null,
    @id_factura int = null,
    @nombre_cuenta varchar(180),
    @nombre_contacto varchar(180),
    @asunto varchar(180),
    @direccion varchar(180),
    @descripcion_caso varchar(1000),
    @estado varchar(180),
    @tipo_caso varchar(180),
    @prioridad varchar(180),
    @fecha date
as
begin
    insert into registro_caso.casos (id_empleado, id_cotizacion, id_factura, nombre_cuenta, nombre_contacto, asunto, direccion, descripcion, estado, tipo_caso, prioridad, fecha_creacion)
    values (@id_empleado, @id_cotizacion, @id_factura, @nombre_cuenta, @nombre_contacto, @asunto, @direccion, @descripcion_caso, @estado, @tipo_caso, @prioridad, @fecha);
end;
go


-- ================================================
-- nombre: insertar_tarea_caso
--  Paramentros: 
--      @id_caso int,
--      @id_empleado int,
--      @descripcion_tarea nvarchar(1000),
--      @fecha date
-- funcion: Inserta una tarea para un caso en la tabla registro_caso.tarea_casos
-- ================================================
create procedure registro_caso.insertar_tarea_caso
    @id_caso int,
    @id_empleado int,
    @descripcion_tarea nvarchar(1000),
    @fecha date
as
begin
    insert into registro_caso.tarea_casos (id_caso, id_empleado, fecha, descripcion) 
    values (@id_caso, @id_empleado, @fecha, @descripcion_tarea);
end;
go


-- ================================================
-- nombre: planillaaños
--  Paramentros: 
--      @anoinicio int = null, 
--      @anofin int = null
-- retorna: Retorna un conjunto de datos con el total de salario por año.
-- ================================================
create function usuarios.planillaaños(@anoinicio int = null, @anofin int = null)
returns table
as
return
(
    select 
        year(a.fecha_pago) as año, 
        sum(a.total_salario) as total_salario
    from usuarios.plantilla a
    where 
        (@anoinicio is null or year(a.fecha_pago) >= @anoinicio) 
        and 
        (@anofin is null or year(a.fecha_pago) <= @anofin)
    group by year(a.fecha_pago)
)
GO


-- ================================================
-- nombre: planilla_por_departamentos
--  Paramentros: 
--      @departamento VARCHAR(180) = NULL,
--      @año_inicio INT = NULL,
--      @mes_inicio INT = NULL,
--      @año_final INT = NULL,
--      @mes_final INT = NULL
-- retorna: Retorna un conjunto de datos con el total de salario por departamento y periodo.
-- ================================================
CREATE FUNCTION usuarios.planilla_por_departamentos (
    @departamento VARCHAR(180) = NULL,
    @año_inicio INT = NULL,
    @mes_inicio INT = NULL,
    @año_final INT = NULL,
    @mes_final INT = NULL
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
           a.departamento,
           SUM(a.total_salario) AS total_salario,
           a.año, a.mes
    FROM usuarios.plantilla a
    WHERE  (@departamento IS NULL OR a.departamento = @departamento)
        AND (@año_inicio IS NULL OR a.año >= @año_inicio)
        AND (@mes_inicio IS NULL OR (a.año = @año_inicio AND a.mes >= @mes_inicio))
        AND (@año_final IS NULL OR a.año <= @año_final)
        AND (@mes_final IS NULL OR (a.año = @año_final AND a.mes <= @mes_final))
    GROUP BY a.año, a.mes, a.departamento
);
go


-- ================================================
-- nombre: obtenerfecha
--  Paramentros: 
--       @año int
--       @mes  varchar(180)
-- retorna: Retorna una fecha dependiendo del año y mes
-- ================================================
create function obtenerfecha(
    @año int,
    @mes  varchar(180)
)
returns date
as
begin
    declare @fecha date;
    declare @mesnumero int;
    set @mesnumero = case 
                        when lower(@mes) = 'enero' then 1
                        when lower(@mes) = 'febrero' then 2
                        when lower(@mes) = 'marzo' then 3
                        when lower(@mes) = 'abril' then 4
                        when lower(@mes) = 'mayo' then 5
                        when lower(@mes) = 'junio' then 6
                        when lower(@mes) = 'julio' then 7
                        when lower(@mes) = 'agosto' then 8
                        when lower(@mes) = 'septiembre' then 9
                        when lower(@mes) = 'octubre' then 10
                        when lower(@mes) = 'noviembre' then 11
                        when lower(@mes) = 'diciembre' then 12
                        else null
                    end;
    if @mesnumero is null
    begin
        return null;
    end
    set @fecha = datefromparts(@año, @mesnumero, 1);
    return @fecha;
end;
go

-- ================================================
-- nombre: PlanillaMesse
--  Paramentros: 
--          @año_inicio int = null, 
--          @mes_inicio varchar(180) = null, 
--          @año_fin int = null, 
--           @mes_fin varchar(180) = null
-- retorna: Retorna el total de salario por mes en el periodo especificado.
-- ================================================
create function usuarios.PlanillaMesse(
    @año_inicio int = null, 
    @mes_inicio varchar(180) = null, 
    @año_fin int = null, 
    @mes_fin varchar(180) = null
)
returns table
as
return
(
    select 
        sum(a.total_salario) as total_salario,
        a.mes,
        a.año
    from usuarios.plantilla a
    where 
        ((@año_inicio is null and @mes_inicio is null)  or (dbo.obtenerfecha(a.año, a.mes) >= dbo.obtenerfecha(@año_inicio, @mes_inicio)) )
        and 
        ((@año_fin is null and @mes_fin is null)  or  (dbo.obtenerfecha(a.año, a.mes) <= dbo.obtenerfecha(@año_fin, @mes_fin)))
    group by a.año, a.mes
);
go



-- ================================================
-- nombre: Departamentos
-- retorna: Retorna los departamentos 
-- ================================================

create function usuarios.Departamentos()
returns table
as
return
(
    select id_departamento
    from usuarios.departamento
);
go

-- ================================================
-- nombre: FamiliaProductos
--  Paramentros: 
--      @fecha_inicio date = null,
--      @fecha_fin date = null
-- retorna: Retorna el total de ventas por familia de productos en el periodo especificado.
-- ================================================
CREATE function FamiliaProductos (
    @fecha_inicio date = null,
    @fecha_fin date = null
) returns table
as
return (
SELECT 
    SUM(lf.monto_total) AS total,
    gf.nombre AS nombreFam
FROM 
    facturación.lista_articulos_facturados lf
JOIN 
    gestion_inventario.articulos ga ON lf.c_articulo = ga.c_articulo
JOIN 
    gestion_inventario.familia_articulos gf ON ga.c_familia = gf.id_familia
join facturación.facturas ff on lf.n_factura=ff.n_factura
  where 
        (@fecha_inicio is null or ff.fecha_factura >= @fecha_inicio) 
        and 
        (@fecha_fin is null or ff.fecha_factura <= @fecha_fin)
  
GROUP BY 
    gf.nombre )

go


-- ================================================
-- nombre: VentaSector
--  Paramentros: 
--      @fecha_inicio date = null,
--      @fecha_fin date = null
-- retorna: Retorna el total de ventas por sector en el periodo especificado.
-- ================================================
CREATE function VentaSector  (
    @fecha_inicio date = null,
    @fecha_fin date = null
) 
returns table
as return(
SELECT 
    SUM(lf.monto_total) AS total,
    cl.sector
FROM 
    facturación.lista_articulos_facturados lf
JOIN 
    facturación.facturas ff ON lf.n_factura = ff.n_factura  
	join
    clientes.cliente cl ON ff.id_cliente = cl.cedula  
	where 
        (@fecha_inicio is null or ff.fecha_factura >= @fecha_inicio) 
        and 
        (@fecha_fin is null or ff.fecha_factura <= @fecha_fin)
GROUP BY 
    cl.sector)
GO


-- ================================================
-- nombre: VentaZona
--  Paramentros: 
--      @fecha_inicio date = null,
--      @fecha_fin date = null
-- retorna: Retorna el total de ventas por zona en el periodo especificado.
-- ================================================
create function VentaZona (
    @fecha_inicio date = null,
    @fecha_fin date = null
)
returns table
as
return
(
    select 
        sum(lf.monto_total) as total,
        cl.zona
    from 
        facturación.lista_articulos_facturados lf
    join 
        facturación.facturas ff on lf.n_factura = ff.n_factura  
    join 
        clientes.cliente cl on ff.id_cliente = cl.cedula
    where 
        (@fecha_inicio is null or ff.fecha_factura >= @fecha_inicio) 
        and 
        (@fecha_fin is null or ff.fecha_factura <= @fecha_fin)
    group by 
        cl.zona
);

go


/*Ventas por departamento*/
-- ================================================
-- nombre: Ventadepartamento
--  Paramentros: 
--   @fecha_inicio date = null
--   @fecha_fin date = null
-- retorna: tabla con cantidad de ventas por departamento
-- ================================================
create function Ventadepartamento (
    @fecha_inicio date = null,
    @fecha_fin date = null
)
returns table
as
return
(
    select 
        count(distinct ff.n_factura) as cantidad_ventas,
        ue.departamento_actual
    from 
        facturación.facturas ff
    join 
        usuarios.empleados ue on ff.id_empleado = ue.cedula
    where 
        (@fecha_inicio is null or ff.fecha_factura >= @fecha_inicio) 
        and 
        (@fecha_fin is null or ff.fecha_factura <= @fecha_fin)
    group by 
        ue.departamento_actual
);
go
/*Cuenta cantidad de movimientos entrada salida*/
-- ================================================
-- nombre: cantidadmovimientos
--  Paramentros: 
--   @fecha_inicio DATE = NULL
--   @fecha_fin DATE = NULL
-- retorna: tabla con cantidad de movimientos de entrada y salida por bodega
-- ================================================

CREATE FUNCTION gestion_inventario.cantidadmovimientos( 
    @fecha_inicio DATE = NULL,
    @fecha_fin DATE = NULL
)
RETURNS TABLE
AS
RETURN
(
    -- Consulta para movimientos de salida
    SELECT 
        c.bodega_origen AS bodega,
        'salida' AS tipo,
        COUNT(c.id_movimiento) AS cantidad_casos
    FROM 
        gestion_inventario.detalle_movimiento c
    JOIN 
        gestion_inventario.movimientos_inventario gi 
        ON c.id_movimiento = gi.id_movimiento
    WHERE 
        c.bodega_destino IS NULL 
        AND (@fecha_inicio IS NULL OR gi.fecha >= @fecha_inicio) 
        AND (@fecha_fin IS NULL OR gi.fecha <= @fecha_fin)

    GROUP BY 
        c.bodega_origen
    
    UNION ALL

    -- Consulta para movimientos de entrada
    SELECT 
        c.bodega_destino AS bodega,
        'entrada' AS tipo,
        COUNT(c.id_movimiento) AS cantidad_casos
    FROM 
        gestion_inventario.detalle_movimiento c
    JOIN 
        gestion_inventario.movimientos_inventario gi 
        ON c.id_movimiento = gi.id_movimiento
    WHERE 
        c.bodega_origen IS NULL
        AND (@fecha_inicio IS NULL OR gi.fecha >= @fecha_inicio) 
        AND (@fecha_fin IS NULL OR gi.fecha <= @fecha_fin)
    GROUP BY 
        c.bodega_destino
)
GO

/*top10 articulos cotizados*/
-- ================================================
-- nombre: top10
--  Paramentros: 
--   @fecha_inicio date = null
--   @fecha_fin date = null
-- retorna: tabla con los 10 artículos más cotizados
-- ================================================
/*	top10 articulos cotizados*/
create function top10 (
    @fecha_inicio date = null,
    @fecha_fin date = null
)
returns table 
as return (
select top 10 
    count(cl.c_producto) as cantidad,
    ga.nombre,
    ga.descripcion,
    ga.c_articulo
from [cotizaciones].[lista_articulos_cotizacion] cl
join gestion_inventario.articulos ga on cl.c_producto = ga.c_articulo
join cotizaciones.cotizaciones cc on cl.id_cotizacion = cc.id_cotizacion
where 
(@fecha_inicio is null or cc.fecha_corizacion >= @fecha_inicio) 
        and 
        (@fecha_fin is null or cc.fecha_corizacion  <= @fecha_fin)
group by ga.nombre, ga.descripcion, ga.c_articulo
order by cantidad desc)
go 

/*Cotizaciones y ventas por departamento*/
-- ================================================
-- nombre: CotizacionesyVentas
--  Paramentros: 
--   @fecha_inicio date = null
--   @fecha_fin date = null
-- retorna: tabla con cotizaciones y ventas por departamento
-- ================================================
create function CotizacionesyVentas (
    @fecha_inicio date = null,
    @fecha_fin date = null
)
returns table 
as 
return(
	
select 
    coalesce(cotizaciones.departamento_actual, ventas.departamento_actual) as departamento_actual,
    cotizaciones.cantidadCotizacion,
    ventas.cantidadVentas
from 
    (
        select 
            count(distinct cc.id_cotizacion) as cantidadCotizacion,
            ue.departamento_actual,cc.fecha_corizacion
        from 
            cotizaciones.cotizaciones cc
        join 
            usuarios.empleados ue on cc.empleado = ue.cedula
			 where 
        (@fecha_inicio is null or cc.fecha_corizacion >= @fecha_inicio) 
        and 
        (@fecha_fin is null or cc.fecha_corizacion <= @fecha_fin)
        group by 
            ue.departamento_actual,cc.fecha_corizacion
    ) as cotizaciones
full outer join 
    (
        select 
            count(distinct ff.n_factura) as cantidadVentas,
            ue.departamento_actual,ff.fecha_factura
        from 
            facturación.facturas ff
        join 
            usuarios.empleados ue on ff.id_empleado = ue.cedula
		 where 
        (@fecha_inicio is null or ff.fecha_factura >= @fecha_inicio) 
        and 
        (@fecha_fin is null or ff.fecha_factura <= @fecha_fin)
        group by 
            ue.departamento_actual,ff.fecha_factura
    ) as ventas 

on 
    cotizaciones.departamento_actual = ventas.departamento_actual)

	go

/*ventas y cotizaciones cuenta*/
-- ================================================
-- nombre: ventasycotizacionesdepa
--  Paramentros: 
--   @fecha_inicio date = null
--   @fecha_fin date = null
-- retorna: tabla con cotizaciones y ventas por departamento
-- ================================================
create function ventasycotizacionesdepa  (
    @fecha_inicio date = null,
    @fecha_fin date = null
)
returns table 
as 
return (
select 
    coalesce(cotizaciones.departamento_actual, ventas.departamento_actual) as departamento_actual,
    cotizaciones.cantidadCotizacion,
    ventas.cantidadVentas
from 
    (
        select 
            count(distinct cc.id_cotizacion) as cantidadCotizacion,
            ue.departamento_actual
        from 
            cotizaciones.cotizaciones cc
        join 
            usuarios.empleados ue on cc.empleado = ue.cedula
			where 
        (@fecha_inicio is null or cc.fecha_corizacion >= @fecha_inicio) 
        and 
        (@fecha_fin is null or cc.fecha_corizacion <= @fecha_fin)
        group by 
            ue.departamento_actual

    ) as cotizaciones
full outer join 
    (
        select 
            count(distinct ff.n_factura) as cantidadVentas,
            ue.departamento_actual
        from 
            facturación.facturas ff
        join 
            usuarios.empleados ue on ff.id_empleado = ue.cedula
			where 
        (@fecha_inicio is null or ff.fecha_factura >= @fecha_inicio) 
        and 
        (@fecha_fin is null or ff.fecha_factura <= @fecha_fin)

        group by 
            ue.departamento_actual
    ) as ventas 
on 
    cotizaciones.departamento_actual = ventas.departamento_actual)

go

/* ventas y cotizaciones por mes y año */
-- ================================================
-- nombre: ventasycotizacionesmeas
-- Paramentros: Ninguno
-- retorna: Vista con las cotizaciones y ventas por mes y año
-- ================================================
create function dbo.ventasycotizacionesmeasZ
(
    @fecha_inicio date = null,
    @fecha_fin date = null
)
returns table
as
return
(
    select 
        coalesce(cotizaciones.anio, ventas.anio) as anio,
        coalesce(cotizaciones.mes, ventas.mes) as mes,
        cotizaciones.cantidadcotizacion,
        ventas.cantidadventas
    from 
        (
            select 
                count(distinct cc.id_cotizacion) as cantidadcotizacion,
                year(cc.fecha_corizacion) as anio,
                month(cc.fecha_corizacion) as mes
            from 
                cotizaciones.cotizaciones cc
            where 
                (@fecha_inicio is null or cc.fecha_corizacion >= @fecha_inicio)
                and (@fecha_fin is null or cc.fecha_corizacion <= @fecha_fin)
            group by 
                year(cc.fecha_corizacion),
                month(cc.fecha_corizacion)
        ) as cotizaciones
    full outer join 
        (
            select 
                count(distinct ff.n_factura) as cantidadventas,
                year(ff.fecha_factura) as anio,
                month(ff.fecha_factura) as mes
            from 
                facturación.facturas ff
            where 
                (@fecha_inicio is null or ff.fecha_factura >= @fecha_inicio)
                and (@fecha_fin is null or ff.fecha_factura <= @fecha_fin)
            group by 
                year(ff.fecha_factura),
                month(ff.fecha_factura)
        ) as ventas 
    on 
        cotizaciones.anio = ventas.anio
        and cotizaciones.mes = ventas.mes
);
go

-----------------------------retorna el top 15 tareas -----------------------------------------
-- ================================================
-- nombre: cotizaciones.top15_tareas
-- Paramentros: 
--    @fecha_inicio date = null
--    @fecha_fin date = null
-- retorna: Tabla con las 15 tareas más recientes completadas o en progreso
-- ================================================
create function cotizaciones.top15_tareas(
@fecha_inicio date = null,
    @fecha_fin date = null
)
returns table
as
return
(
    select top 15
        id_tarea,
        ct.id_cotizacion,
        descripcion,
        usuario,
        fecha_inicio,
        fecha_limite,
        ct.estado
    from cotizaciones.tareas ct
	join cotizaciones.cotizaciones on ct.id_cotizacion=ct.id_cotizacion
    where ct.estado = 'completada' or ct.estado = 'en progreso' and 
	  (@fecha_inicio is null or ct.fecha_inicio >= @fecha_inicio) 
        and 
        (@fecha_fin is null or ct.fecha_inicio <= @fecha_fin)


    order by 
        fecha_inicio asc
);
go

-----------------------------------Top 10 de clientes con mayores ventas-------------------------------
-- ================================================
-- nombre: dbo.top_clientes
-- Paramentros: 
--    @fecha_inicio date = null
--    @fecha_fin date = null
-- retorna: Tabla con los 10 clientes con mayores ventas
-- ================================================
create function dbo.top_clientes(
 @fecha_inicio date = null,
    @fecha_fin date = null

)
returns table
as
return
(
    select top 10 
        c.nombre as nombre_cliente,
        sum(f.total) as monto
    from facturación.facturas f
    inner join  clientes.cliente c on f.id_cliente = c.cedula

    where f.estado = 'aprobada' and 
	(@fecha_inicio is null or f.fecha_factura >= @fecha_inicio) 
        and 
        (@fecha_fin is null or f.fecha_factura <= @fecha_fin)
    group by  c.nombre
    order by  monto desc
);
go

-----------------------------------Cantidad de clientes por zona y monto ventas por zona------------------------
-- ================================================
-- nombre: dbo.clientes_zona
-- Paramentros: 
--    @fecha_inicio date = null
--    @fecha_fin date = null
-- retorna: Tabla con la cantidad de clientes por zona y el monto total de ventas por zona
-- ================================================
create  function dbo.clientes_zona(
@fecha_inicio date = null,
    @fecha_fin date = null
)
returns table
as
return
(
    select c.zona, count(distinct c.cedula) as cantidad_clientes, sum(f.total) as monto_total_ventas
    from  clientes.cliente c
    left join  facturación.facturas f on c.cedula = f.id_cliente
    where  f.estado = 'aprobada'and 
	 (@fecha_inicio is null or f.fecha_factura >= @fecha_inicio) 
        and 
        (@fecha_fin is null or f.fecha_factura <= @fecha_fin)
    group by  c.zona
);
go

---------------------------------------Casos por cotizacion y facturas 
-- ================================================
-- nombre: dbo.casos_cotizacion_factura
-- Paramentros: 
--    @fecha_inicio date = null
--    @fecha_fin date = null
-- retorna: Tabla con casos relacionados a cotizaciones y facturas, agrupados por mes y año
-- ================================================
create function dbo.casos_cotizacion_factura(
 @fecha_inicio date = null,
    @fecha_fin date = null
)
returns table
as
return
(
    select year(c.fecha_creacion) as año,
        month(c.fecha_creacion) as mes,
        'cotizacion' as tipo,
        count(c.id_caso) as cantidad_casos
    from 
        registro_caso.casos c
    where c.id_factura IS NULL and
        (@fecha_inicio is null or c.fecha_creacion >= @fecha_inicio) 
        and 
        (@fecha_fin is null or c.fecha_creacion <= @fecha_fin)
    group by  year(c.fecha_creacion), month(c.fecha_creacion)
    
    union all
    
    select year(c.fecha_creacion) as año,
        month(c.fecha_creacion) as mes,
        'factura' as tipo,
        count(c.id_caso) as cantidad_casos
    from registro_caso.casos c
    where c.id_cotizacion  IS NULL and 
	  (@fecha_inicio is null or c.fecha_creacion >= @fecha_inicio) 
        and 
        (@fecha_fin is null or c.fecha_creacion <= @fecha_fin)
    group by year(c.fecha_creacion), month(c.fecha_creacion)
);
GO

-- Función para obtener el top de bodegas con más artículos transados
-- ================================================
-- nombre: dbo.top_transados
-- Paramentros: 
--    @fecha_inicio date = null
--    @fecha_fin date = null
-- retorna: Tabla con las bodegas con más artículos transados por tipo de movimiento (entrada/salida)
-- ================================================
create function dbo.top_transados(
	@fecha_inicio date = null,
	@fecha_fin date = null
)
returns table
as
return
(
	select top 10
		b.c_bodega,
		b.nombre as nombre_bodega,
		sum(case when mi.tipo = 'entrada' then dm.cantidad else 0 end) as Entrada,
		sum(case when mi.tipo = 'salida' then dm.cantidad else 0 end) as Salida,
		sum(case when mi.tipo = 'entrada' then dm.cantidad else 0 end) + 
		sum(case when mi.tipo = 'salida' then dm.cantidad else 0 end) as total_transacciones
	from gestion_inventario.detalle_movimiento as dm
	join gestion_inventario.movimientos_inventario as mi on dm.id_movimiento = mi.id_movimiento
	join gestion_inventario.bodegas as b on b.c_bodega = dm.bodega_origen or b.c_bodega = dm.bodega_destino
	where 
		(@fecha_inicio is null or @fecha_fin is null or mi.fecha between @fecha_inicio and @fecha_fin)
	group by b.c_bodega, b.nombre
	order by total_transacciones desc
);
go


-- ================================================
-- nombre: gestion_inventario.total_movimientos
-- Paramentros: 
--    @tipo_movimiento varchar(30)
--    @fecha_inicio date = null
--    @fecha_final date = null
-- retorna: Tabla con la cantidad de movimientos por bodega, según tipo de movimiento (entrada/salida)
-- ================================================
create function gestion_inventario.total_movimientos (
    @tipo_movimiento varchar(30), 
    @fecha_inicio date = null,     
    @fecha_final date = null       
)
returns table
as
return
(
    select 
        b.c_bodega,
        b.nombre as nombre_bodega,
        sum(case when mi.tipo = @tipo_movimiento then 1 else 0 end) as cantidad_movimientos
    from  gestion_inventario.detalle_movimiento as dm
    join  gestion_inventario.movimientos_inventario as mi on dm.id_movimiento = mi.id_movimiento
    join   gestion_inventario.bodegas as b on b.c_bodega = dm.bodega_origen or b.c_bodega = dm.bodega_destino
    where  (mi.tipo = @tipo_movimiento) 
        and (@fecha_inicio is null or mi.fecha >= @fecha_inicio)
        and (@fecha_final is null or mi.fecha <= @fecha_final)

    group by 
        b.c_bodega, b.nombre
);


