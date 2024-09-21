-- creacion de la basa de datos
if not exists (select * from sys.databases where name = 'Planificador_recorsos_empresariales')
begin
    create database Planificador_recorsos_empresariales;
end;

use Planificador_recorsos_empresariales
go

-- creacion de los esquemas(modulos)
 CREATE SCHEMA usuarios;

 CREATE SCHEMA gestion_inventario;
 
 CREATE SCHEMA clientes;
 
 CREATE SCHEMA ventas;

 CREATE SCHEMA cotizaciones;
 
 CREATE SCHEMA facturación ;
 
 CREATE SCHEMA registro_caso ;

-- modulo de usuario
create table usuarios.roles (
		nombre varchar (180) not null primary key
 );
create table usuarios.puesto (
		id_puesto varchar (180) not null primary key
 );
create table usuarios.departamento (
		id_departamento varchar (180) not null primary key
);
create table usuarios.empleados (
		cedula int not null primary key,
		nombre_Completo varchar (200) not null,
		Correo_Electronico varchar (180) not null,
		género varchar (180) not null check (género IN ('Masculino', 'Femenino', 'Otro')),
		fecha_nacimiento date not null,
		edad as datediff (year,fecha_nacimiento,getdate()),
		lugar_residencia varchar (180) not null,
		Telefono int not null,
		fecha_ingreso date not null,
		salario_actual int not null,
		puesto_actual varchar (180)not null,
		departamento_actual varchar (180) not null,
		rol varchar (180) not null,
		foreign key (puesto_actual) references usuarios.puesto (id_puesto),
		foreign key (departamento_actual) references usuarios.departamento (id_departamento),
 );
create table usuarios.historico_puesto (
    cedula int not null,
    FechaInicio date NOT NULL,
    FechaFin date NULL,
    NombrePuesto varchar(180) NOT NULL,
    Departamento varchar(180) NOT NULL,
	foreign key (cedula) references usuarios.empleados (cedula),
	foreign key (NombrePuesto) references usuarios.puesto (id_puesto),
	foreign key (Departamento) references usuarios.departamento (id_departamento),
);
create table usuarios.historico_salarios (
    cedula int not null,
    FechaInicio date NOT NULL,
    FechaFin date NULL,
    NombrePuesto varchar(180) NOT NULL,
    Departamento varchar(180) NOT NULL,
	monto int not null,
	foreign key (cedula) references usuarios.empleados (cedula),
	foreign key (NombrePuesto) references usuarios.puesto (id_puesto),
	foreign key (Departamento) references usuarios.departamento (id_departamento),
);

create table usuarios.plantilla (
		IdPlanilla int identity  (1,1) primary key,
		cedula int not null ,
		mes varchar (180) not null,
		año int not null,
		fecha_pago date not null,
		h_normales int not null,
		h_extras int not null,
		total_salario int not null,
		departamento varchar (180) not null,
		foreign key (cedula) references usuarios.empleados (cedula),
		foreign key (departamento) references usuarios.departamento (id_departamento),
);
 --

--modulo gestion_inventario
create table gestion_inventario.familia_articulos (
    codigo varchar(180) not null,
    nombre varchar(180) not null,
    descripcion varchar(200) not null,
	activo bit not null,
	primary key (codigo)
);

create table gestion_inventario.articulos (
    c_articulo varchar(180) not null,
    nombre varchar(180) not null,
    activo bit not null,
    descripcion varchar(255)not null,
    c_familia varchar(180) not null,
    peso int, 
    costo int,
    precio int,
	primary key (c_articulo),
    foreign key (c_familia) references gestion_inventario.familia_articulos(codigo)
);

create table gestion_inventario.bodegas (
    c_bodega varchar(180),
    nombre varchar(180) not null,
    ubicacion varchar(255) not null,
    c_toneladas int not null, 
    e_cubico int not null,
	primary key (c_bodega)
);

create table gestion_inventario.bodegas_familias (
    c_bodega varchar(180) not null,
    codigo varchar(180) not null,
    foreign key (c_bodega) references gestion_inventario.bodegas (c_bodega),
    foreign key (codigo) references gestion_inventario.familia_articulos(codigo)
);
create table gestion_inventario.inventario (
    c_bodega varchar(180) not null,
    c_articulo varchar(180) not null,
    cantidad int not null,
    foreign key (c_bodega) references gestion_inventario.bodegas(c_bodega),
    foreign key (c_articulo) references gestion_inventario.articulos (c_articulo)
);

-- tabla de movimientos de inventario
create table gestion_inventario.movimientos_inventario (
    id_movimiento int identity(1,1) primary key,
    tipo varchar(30) not null check (tipo in ('entrada','salida','movimiento')),
    fecha datetime not null default getdate(),
    usuario int not null, 
    bodega_origen varchar(180) not null, 
    bodega_destino varchar(180) not null, 
	foreign key (usuario) references usuarios.empleados(cedula),
    foreign key (bodega_origen) references gestion_inventario.bodegas(c_bodega),
    foreign key (bodega_destino) references gestion_inventario.bodegas(c_bodega)
);

-- tabla para los detalles de los movimientos de inventario
create table gestion_inventario.detalle_moviminto (
    id_detalle int identity(1,1) primary key,
    id_movimiento int not null,
    c_articulo varchar(180) not null,
    cantidad int not null,
    foreign key (id_movimiento) references gestion_inventario.movimientos_inventario(id_movimiento),
    foreign key (c_articulo) references gestion_inventario.articulos(c_articulo)
);
--
-- modulo de cliente
create table clientes.cliente (
		cedula int not null,
		nombre varchar (180) not null,
		Correo_Electronico varchar (180) not null,
		Telefono int not null,
		celular int not null,
		fax varchar (180)not null, 
		primary key (cedula)
 );
 --

--modulo cotizaciones
create table cotizaciones.cotizaciones (
	id_cotizacion int identity(1,1),
	cliente int not null,
	fecha_corizacion date not null,
	m_cierre varchar (180) not null,
	probabilidad int not null,
	orden_compra varchar (180) not null,
	tipo varchar (180) not null,
	descripción varchar (180) not null,
	zona varchar (180) not null,
	sector varchar (180) not null,
	estado varchar (180) not null check (estado in ('abierta','aprobada','denegada')),
	m_denegacion varchar(255),
    contra_quien nvarchar(255),
    monto_total int,
	primary key (id_cotizacion),
	foreign key (cliente) references  clientes.cliente (cedula)
);

create table cotizaciones.lista_articulos_cotizacion (
    id_cotizacion int not null,
    c_producto varchar(180) not null,
    cantidad int not null,
    monto int not null,
    foreign key (id_cotizacion) references cotizaciones.cotizaciones(id_cotizacion),
    foreign key (c_producto) references gestion_inventario.articulos(c_articulo)
);
create table cotizaciones.tareas (
    id_tarea int identity(1,1) primary key,
    id_cotizacion int not null,
    descripcion varchar(255) not null,
    usuario int not null,
    fecha_inicio datetime not null default getdate(),
    fecha_limite datetime,
    estado varchar (180) not null check (estado in ('pendiente','en progreso','completada')),
    foreign key (id_cotizacion) references cotizaciones.cotizaciones(id_cotizacion),
	foreign key (usuario) references usuarios.empleados(cedula)
);
--

--modulo facturación
create table facturación.facturas (
    n_factura int identity(1,1),
    nombre_local varchar(100) not null,
    cedula_juridica_local int not null,
    telefono_local int not null ,
    id_cliente int not null,
    id_cotizacion int not null, 
    id_empleado int not null, 
    fecha_factura datetime not null default getdate(),
    estado varchar(20) not null check (estado in ('creada','anulada')), 
	primary key (n_factura),
	foreign key (id_cliente) references clientes.cliente (cedula),
	foreign key (id_empleado) references usuarios.empleados(cedula),
    foreign key (id_cotizacion) references cotizaciones.cotizaciones(id_cotizacion)
);
create table facturación.facturas_articulos (
    n_factura int not null,
    c_articulo varchar(180) not null,
    cantidad int not null,
    precio_unitario int not null,
    monto_total int not null,
    foreign key (n_factura) references facturación.facturas(n_factura),
    foreign key (c_articulo) references gestion_inventario.articulos(c_articulo)
);
--
--modulo registro_caso
--

