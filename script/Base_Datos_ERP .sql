-- creacion de la basa de datos
if not exists (select * from sys.databases where name = 'Planificador_recursos_empresariales')
begin
    create database Planificador_recursos_empresariales;
end;
go

use Planificador_recursos_empresariales
go


create schema usuarios;
go

-- Módulo de usuario
-- Nombre de la tabla: roles
-- Descripcion:	se almacenan los roles y permiso de los roles que tiene el usuario
-- Llaver primaria: nombre 
if not exists (select * from sys.tables where name = 'roles' and schema_id = schema_id('usuarios'))
begin
    create table usuarios.roles (
        nombre varchar (180) not null,
		vendedor bit not null,
		primary key (nombre)
    );
end;
go

if not exists (select * from sys.tables where name = 'PermisisosMInventario' and schema_id = schema_id('usuarios'))
begin
    create table usuarios.PermisosMInventario (
        nombre varchar (180) not null,
		edicion bit  null, 
		visualizacion bit  null,
		reportes bit  null,
		primary key (nombre),
		foreign key (nombre) references usuarios.roles (nombre)

    );
end;
go

if not exists (select * from sys.tables where name = 'PermisisosMUsuarioa' and schema_id = schema_id('usuarios'))
begin
    create table usuarios.PermisosMUsuarios (
        nombre varchar (180) not null,
		edicion bit  null, 
		visualizacion bit  null,
		reportes bit  null,
		primary key (nombre),
		foreign key (nombre) references usuarios.roles (nombre)
    );
end;
go

if not exists (select * from sys.tables where name = 'PermisisosMCotizacion' and schema_id = schema_id('usuarios'))
begin
    create table usuarios.PermisosMCotizacion (
        nombre varchar (180) not null,
		edicion bit  null, 
		visualizacion bit  null,
		reportes bit  null,
		primary key (nombre),
		foreign key (nombre) references usuarios.roles (nombre)
    );
end;
go

if not exists (select * from sys.tables where name = 'PermisisosMFacturas' and schema_id = schema_id('usuarios'))
begin
    create table usuarios.PermisosMFacturas (
        nombre varchar (180) not null,
		edicion bit  null, 
		visualizacion bit  null,
		reportes bit  null,
		primary key (nombre),
		foreign key (nombre) references usuarios.roles (nombre)
    );
end;
go



if not exists (select * from sys.tables where name = 'PermisisosMCliente' and schema_id = schema_id('usuarios'))
begin
    create table usuarios.PermisosMClientes (
        nombre varchar (180) not null,
		edicion bit  null, 
		visualizacion bit  null,
		reportes bit  null,
		primary key (nombre),
		foreign key (nombre) references usuarios.roles (nombre)
    );
end;
go

if not exists (select * from sys.tables where name = 'PermisisosMReportes' and schema_id = schema_id('usuarios'))
begin
    create table usuarios.PermisosMReportes (
        nombre varchar (180) not null,
		edicion bit  null, 
		visualizacion bit  null,
		reportes bit  null,
		primary key (nombre),
		foreign key (nombre) references usuarios.roles (nombre)
    );
end;
go

if not exists (select * from sys.tables where name = 'PermisisosMCaso' and schema_id = schema_id('usuarios'))
begin
    create table usuarios.PermisosMCaso (
        nombre varchar (180) not null,
		edicion bit  null, 
		visualizacion bit  null,
		reportes bit  null,
		primary key (nombre),
		foreign key (nombre) references usuarios.roles (nombre)
    );
end;
go


-- Nombre de la tabla: departamento
-- Descripcion:	tabla donde se alamcena los departamentos de ls empresa 
-- Llaver primaria: id_departamento

if not exists (select * from sys.tables where name = 'departamento' and schema_id = schema_id('usuarios'))
begin
    create table usuarios.departamento (
        id_departamento varchar (180) not null ,
		primary key (id_departamento)
    );
end;
go

-- Nombre de la tabla: puesto
-- Descripcion: se crea puestos y se le asigna un departamento	
-- Llaver primaria: id_puesto
-- llave foranea: id_departamento
if not exists (select * from sys.tables where name = 'puesto' and schema_id = schema_id('usuarios'))
begin
    create table usuarios.puesto (
        id_puesto varchar (180) not null,
		id_departamento varchar (180) not null ,
		primary key (id_puesto),
		foreign key (id_departamento) references usuarios.departamento (id_departamento)
    );
end;
go

-- Nombre de la tabla: empleados
-- Descripcion: regostra la informaciocion de los empleados de la empresa	
-- Llaver primaria: cedula
-- llave foranea: rol,departamento_actual,puesto_actual
if not exists (select * from sys.tables where name = 'empleados' and schema_id = schema_id('usuarios'))
begin
    create table usuarios.empleados (
        cedula int not null,
        nombre varchar (200) not null,
		apellido1 varchar (200) not null,
		apellido2 varchar (200) not null,
        Correo_Electronico varchar (180) not null,
		contraseña varbinary(max) not null,
        género varchar (180) not null check (género IN ('Masculino', 'Femenino', 'Otro')),
        fecha_nacimiento date not null,
        edad as datediff(year, fecha_nacimiento, getdate()),
        lugar_residencia varchar (180) not null,
        Telefono int not null,
        fecha_ingreso date not null,
        salario_actual int not null,
        puesto_actual varchar (180) not null,
        departamento_actual varchar (180) not null,
        rol varchar (180) null,
        primary key (cedula),
        foreign key (rol) references usuarios.roles (nombre),
        foreign key (puesto_actual) references usuarios.puesto (id_puesto),
        foreign key (departamento_actual) references usuarios.departamento (id_departamento)
    );
end;
go

-- Nombre de la tabla:logeo
-- Descripcion:	sistema de logeo que permite ingresar al usuario al sistema 
-- llave foranea: cedula
if not exists (select * from sys.tables where name = 'logeo' and schema_id = schema_id('usuarios'))
begin
    create table usuarios.logeo (
        cedula int not null,
		Contraseña varchar (180) not null,
        foreign key (cedula) references usuarios.empleados (cedula),
    );
end;
go

-- Nombre de la tabla: historico_puesto
-- Descripcion:	alamcena el historia de los puestos del usuario 
-- llave foranea: cedula, NombrePuesto, Departamento
if not exists (select * from sys.tables where name='historico_puesto' and schema_id = schema_id('usuarios'))
begin
	create table usuarios.historico_puesto (
	id INT IDENTITY(1,1) ,
		cedula int not null,
		FechaInicio date NOT NULL,
		FechaFin date  NULL,
		NombrePuesto varchar(180) NOT NULL,
		Departamento varchar(180) NOT NULL,
		primary key (cedula,FechaInicio,id),
		foreign key (cedula) references usuarios.empleados (cedula),
		foreign key (NombrePuesto) references usuarios.puesto (id_puesto),
		foreign key (Departamento) references usuarios.departamento (id_departamento)
	);
end;
go

-- Nombre de la tabla: historico_salarios
-- Descripcion:	almacena el historial de salario de los empleados
-- llave foranea: cedula, NombrePuesto, Departamento
if not exists (select * from sys.tables where name='historico_salarios' and schema_id = schema_id('usuarios'))
begin
	create table usuarios.historico_salarios (

		 id INT IDENTITY(1,1) ,
		cedula int not null,
		FechaInicio date NOT NULL,
		FechaFin date NULL ,
		NombrePuesto varchar(180) NOT NULL,
		Departamento varchar(180) NOT NULL,
		monto int not null,
		primary key (cedula,FechaInicio,id),
		foreign key (cedula) references usuarios.empleados (cedula),
		foreign key (NombrePuesto) references usuarios.puesto (id_puesto),
		foreign key (Departamento) references usuarios.departamento (id_departamento)
	);
end;
go

-- Nombre de la tabla: plantilla
-- Descripcion:	genera reportes de pago de plantilla donde se gusrda el monto que se pago a cada uno de los empleados en el mes
-- Llaver primaria: IdPlanilla
-- llave foranea: cedula departamento
if not exists (select * from sys.tables where name='plantilla' and schema_id = schema_id('usuarios'))
begin
	create table usuarios.plantilla (
		cedula int not null,
		mes varchar (180) not null,
		año int not null,
		fecha_pago datetime not null,
		salario_actual int not null,
		h_normales int not null,
		h_extras int null,
		total_salario int not null,
		departamento varchar (180) not null,
		primary key (cedula,mes,año),
		foreign key (cedula) references usuarios.empleados (cedula),
		foreign key (departamento) references usuarios.departamento (id_departamento)
	);
end;
go
 --

-- modulo gestion_inventario

create schema gestion_inventario;
go
-- Nombre de la tabla: familia_articulos
-- Descripcion: crea y gurada las familias de los productos 
-- Llaver primaria: id_familia

-- Verificar y crear la tabla familia_articulos si no existe
if not exists (select * from sys.tables where name='familia_articulos' and schema_id = schema_id('gestion_inventario'))
begin
    create table gestion_inventario.familia_articulos (
        id_familia varchar(180) not null,
        nombre varchar(180) not null,
        descripcion varchar(200) not null,
        activo bit not null,
        primary key (id_familia)
    );
end;
go

-- Nombre de la tabla:articulos
-- Descripcion:	almacena la informacion de los articulos de la tienda
-- Llaver primaria: c_articulo
-- llave foranea: c_familia
-- Verificar y crear la tabla articulos si no existe
if not exists (select * from sys.tables where name='articulos' and schema_id = schema_id('gestion_inventario'))
begin
    create table gestion_inventario.articulos (
        c_articulo varchar(180) not null,
        nombre varchar(180) not null,
        activo bit not null,
        descripcion varchar(255) not null,
        c_familia varchar(180) not null,
        peso int not null,
        precio int not null,
        primary key (c_articulo),
        foreign key (c_familia) references gestion_inventario.familia_articulos(id_familia)
    );
end;
go

-- Nombre de la tabla: bodegas
-- Descripcion: lugares espesificos en donde se almacenan los productos por tipo de familia 
-- Llaver primaria: c_bodega
-- Verificar y crear la tabla bodegas si no existe
if not exists (select * from sys.tables where name='bodegas' and schema_id = schema_id('gestion_inventario'))
begin
    create table gestion_inventario.bodegas (
        c_bodega varchar(180),
        nombre varchar(180) not null,
        ubicacion varchar(255) not null,
        c_toneladas int not null,
        e_cubico int not null,
        primary key (c_bodega)
    );
end;
go
-- Nombre de la tabla: bodegas_familias
-- Descripcion:	lista de familias de producto que se encuentran en una bodega
-- Llaver primaria: c_bodega,id_familia
-- llave foranea: c_bodega,id_familia
-- Verificar y crear la tabla bodegas_familias si no existe
if not exists (select * from sys.tables where name='bodegas_familias' and schema_id = schema_id('gestion_inventario'))
begin
    create table gestion_inventario.bodegas_familias (
        c_bodega varchar(180) not null,
        id_familia varchar(180) not null,
		primary key (c_bodega,id_familia),
        foreign key (c_bodega) references gestion_inventario.bodegas(c_bodega),
        foreign key (id_familia) references gestion_inventario.familia_articulos(id_familia)
    );
end;
go

-- Nombre de la tabla: inventario
-- Descripcion:	muestra la cantidad de productos de un articulo y en que bodega se localiza
-- Llaver primaria: c_bodega,c_articulo
-- llave foranea: c_bodega,c_articulo
-- Verificar y crear la tabla inventario si no existe
if not exists (select * from sys.tables where name='inventario' and schema_id = schema_id('gestion_inventario'))
begin
    create table gestion_inventario.inventario (
        c_bodega varchar(180) not null,
        c_articulo varchar(180) not null,
        cantidad int not null,
		primary key (c_bodega,c_articulo), 
        foreign key (c_bodega) references gestion_inventario.bodegas(c_bodega),
        foreign key (c_articulo) references gestion_inventario.articulos(c_articulo)
    );
end;
go

--
-- Modulo de clientes
create schema clientes;
go

-- Nombre de la tabla: sector
-- Descripcion:	sectores de trabajo del cliente 
-- Llaver primaria: sector_nombre


if not exists (select * from sys.tables where name='sector' and schema_id = schema_id('clientes'))
begin
    create table clientes.sector (
		sector_nombre varchar (180) not null, 
        primary key (sector_nombre)
    );
end;
go

-- Nombre de la tabla:zona
-- Descripcion:	zona de ubicacion del cliente 
-- Llaver primaria: zona_nombre

if not exists (select * from sys.tables where name='zona' and schema_id = schema_id('clientes'))
begin
    create table clientes.zona (
		zona_nombre varchar (180) not null, 
        primary key (zona_nombre)
    );
end;
go

-- Nombre de la tabla:cliente
-- Descripcion:	guerda los clientes que a teniado la tienda 
-- Llaver primaria: cedula
-- llave foranea: sector, zona

if not exists (select * from sys.tables where name='cliente' and schema_id = schema_id('clientes'))
begin
    create table clientes.cliente (
    cedula int not null,
    nombre varchar (180) not null,
    Correo_Electronico varchar (180) not null,
    Telefono int not null,
    celular int not null,
    fax varchar (180) not null,
	zona varchar (180) not null, 
	sector varchar (180) not null, 
        primary key (cedula),
		foreign key (sector) references clientes.sector(sector_nombre),
		foreign key (zona) references clientes.zona(zona_nombre),
    );
end;
go



-- Modulo de cotizaciones

create schema cotizaciones;
go

-- Nombre de la tabla: cotizaciones
-- Descripcion:	cotizaciones de una lista de productos que quiere el cliente 
-- Llaver primaria: id_cotizacion
-- llave foranea: cliente, empleado ,sector, zona
if not exists (select * from sys.tables where name='cotizaciones' and schema_id = schema_id('cotizaciones'))
begin
    create table cotizaciones.cotizaciones (
        id_cotizacion int identity(1,1),
        cliente int not null,
		empleado int not null,
        fecha_corizacion date not null,
        m_cierre varchar (180) not null,
        probabilidad int not null,
        tipo varchar (180) not null check (tipo in ('Cotización de Venta','Cotización de Servicio')),
        descripción varchar (180) not null,
        zona varchar (180) not null,
        sector varchar (180) not null,
        estado varchar (180) not null check (estado in ('abierta','aprobada','denegada')),
        m_denegacion varchar(255) null,
        contra_quien varchar(255) null,
        monto_total int null,
        primary key (id_cotizacion),
        foreign key (cliente) references clientes.cliente (cedula),
		foreign key (empleado) references usuarios.empleados(cedula),
		foreign key (sector) references clientes.sector(sector_nombre),
		foreign key (zona) references clientes.zona(zona_nombre),
    );
end;
go
-- Nombre de la tabla: lista_articulos_cotizacion
-- Descripcion:	lista de los qrticulos que cotizo el cliente 
-- Llaver primaria: id_lista
-- llave foranea: id_cotizacion, c_producto
if not exists (select * from sys.tables where name='lista_articulos_cotizacion' and schema_id = schema_id('cotizaciones'))
begin
    create table cotizaciones.lista_articulos_cotizacion (
		id_lista int identity(1,1),
        id_cotizacion int not null,
		c_bodega varchar(180) not null,
        c_producto varchar(180) not null,
        cantidad int not null,
        monto int not null,
		primary key (id_lista),
		foreign key (c_bodega) references gestion_inventario.bodegas(c_bodega),
        foreign key (id_cotizacion) references cotizaciones.cotizaciones(id_cotizacion),
        foreign key (c_producto) references gestion_inventario.articulos(c_articulo)
    );
end;
go
-- Nombre de la tabla:tareas
-- Descripcion:	es la lista de cotizaciones que se le asigna a un empleado
-- Llaver primaria: id_tarea
-- llave foranea: id_cotizacion,usuario
if not exists (select * from sys.tables where name='tareas' and schema_id = schema_id('cotizaciones'))
begin
    create table cotizaciones.tareas (
        id_tarea int identity(1,1) ,
        id_cotizacion int not null,
        descripcion varchar(255) not null,
        usuario int not null,
        fecha_inicio datetime not null default getdate(),
        fecha_limite datetime not null,
        estado varchar (180) not null check (estado in ('pendiente','en progreso','completada')),
		primary key (id_tarea),
        foreign key (id_cotizacion) references cotizaciones.cotizaciones(id_cotizacion),
        foreign key (usuario) references usuarios.empleados(cedula)
    );
end;
go

-- Modulo de facturación

create schema facturación;
go

if not exists (select * from sys.tables where name='Locales' and schema_id = schema_id('facturación'))
 create table facturación.Locales (
		nombre_local varchar(100) not null,
        cedula_juridica_local int not null primary key,
        telefono_local int not null);

-- Nombre de la tabla: facturas
-- Descripcion:	es el comprobante de compra que se le da al cliente 
-- Llaver primaria: n_factura
-- llave foranea: id_cliente, id_empleado, id_cotizacion
if not exists (select * from sys.tables where name='facturas' and schema_id = schema_id('facturación'))
begin
    create table facturación.facturas (
        n_factura int identity(1,1),
		cedula_juridica_local int not null,
        id_cliente int not null,
        id_cotizacion int  null, 
        id_empleado int not null, 
        fecha_factura datetime not null default getdate(),
        estado varchar(20) not null check (estado in ('creada','anulada','aprobada')), 
		motivo_anulacion varchar(200) null,
		Total int null,
        primary key (n_factura),
        foreign key (id_cliente) references clientes.cliente (cedula),
		 foreign key (cedula_juridica_local) references facturación.Locales(cedula_juridica_local),
        foreign key (id_empleado) references usuarios.empleados(cedula),
        foreign key (id_cotizacion) references cotizaciones.cotizaciones(id_cotizacion)
    );
end;
go

-- Nombre de la tabla: lista_articulos_facturados
-- Descripcion:	son las listas de articulos que se le asignan a la factura 
-- Llaver primaria: n_lista
-- llave foranea: n_factura, c_articulo

if not exists (select * from sys.tables where name='lista_articulos_facturados' and schema_id = schema_id('facturación'))
begin
    create table facturación.lista_articulos_facturados (
		n_lista int identity(1,1),
        n_factura int not null,
        c_articulo varchar(180) not null,
        cantidad int not null,
        precio_unitario int not null,
        monto_total int not null,
		primary key (n_lista),
        foreign key (n_factura) references facturación.facturas(n_factura),
        foreign key (c_articulo) references gestion_inventario.articulos(c_articulo)
    );
end;
go

-- Nombre de la tabla:movimientos_inventario
-- Descripcion:	historial de movimientos que se hace en el inventario como restar mercansia o aumentar mercancia
-- Llaver primaria: id_movimiento
-- llave foranea: usuario, bodega_origen , bodega_destino
-- Verificar y crear la tabla movimientos_inventario si no existe
if not exists (select * from sys.tables where name='movimientos_inventario' and schema_id = schema_id('gestion_inventario'))
begin
    create table gestion_inventario.movimientos_inventario (
        id_movimiento int identity(1,1) ,
		n_factura int null,
        tipo varchar(30) not null check (tipo in ('entrada','salida','movimiento')),
        fecha datetime not null default getdate(),
        usuario int not null, 
		primary key (id_movimiento),
        foreign key (usuario) references usuarios.empleados(cedula),
		foreign key (n_factura) references facturación.facturas(n_factura)

    );
end;
go

-- Nombre de la tabla:
-- Descripcion:	detalles espesificos de los movimientos del inventario
-- Llaver primaria: id_detalle
-- llave foranea: id_movimiento , id_movimiento
-- Verificar y crear la tabla detalle_movimiento si no existe
if not exists (select * from sys.tables where name='detalle_movimiento' and schema_id = schema_id('gestion_inventario'))
begin
    create table gestion_inventario.detalle_movimiento (
        id_detalle int identity(1,1) primary key,
        id_movimiento int not null,
        c_articulo varchar(180) not null,
        cantidad int not null,
		bodega_origen varchar(180) null, 
        bodega_destino varchar(180) null, 
        foreign key (id_movimiento) references gestion_inventario.movimientos_inventario(id_movimiento),
        foreign key (c_articulo) references gestion_inventario.articulos(c_articulo),
		foreign key (bodega_origen) references gestion_inventario.bodegas(c_bodega),
        foreign key (bodega_destino) references gestion_inventario.bodegas(c_bodega)
    );
end;
go



create schema registro_caso;
go

-- Modulo de registro de casos

-- Nombre de la tabla: registro_caso
-- Descripcion:	son los caso que se le asocian a una facturacion o a una cotizacion 
-- Llaver primaria: id_caso
-- llave foranea: id_empleado, id_cotizacion, id_factura
if not exists (select * from sys.tables where name='casos' and schema_id = schema_id('registro_caso'))
begin
    create table registro_caso.casos (
        id_caso int identity(1,1),
        id_empleado int null, 
        id_cotizacion int null, 
        id_factura int not null, 
        nombre_cuenta varchar(180) not null,
        nombre_contacto varchar(180) not null,
        asunto varchar(180) not null,
        direccion varchar(180),
        descripcion varchar(1000),
        estado varchar(180) not null check (estado in ('abierto','en progreso','cerrado')), 
        tipo_caso varchar(180) not null,
        prioridad varchar(180) not null check (prioridad in ('alta','media','baja')),
        fecha_creacion datetime not null default getdate(),
        primary key (id_caso),
        foreign key (id_empleado) references usuarios.empleados(cedula),
        foreign key (id_cotizacion) references cotizaciones.cotizaciones(id_cotizacion),
        foreign key (id_factura) references facturación.facturas(n_factura)
    );
end;
go

-- Nombre de la tabla: tarea_casos
-- Descripcion:	son las tarea asociaadas a los casos que registran quin reliaza la tarea 
-- Llaver primaria: id_tarea
-- llave foranea: id_empleado, id_caso
if not exists (select * from sys.tables where name='tarea_casos' and schema_id = schema_id('registro_caso'))
begin
    create table registro_caso.tarea_casos (
        id_tarea int identity(1,1),
        id_caso int not null,
        id_empleado int not null,
        fecha datetime not null default getdate(),
        descripcion nvarchar(1000) not null, 
        primary key (id_tarea),
        foreign key (id_empleado) references usuarios.empleados(cedula),
        foreign key (id_caso) references registro_caso.casos(id_caso)
    );
end;
go


