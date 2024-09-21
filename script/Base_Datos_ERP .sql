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
--



 -- modulo de cliente
 create table clientes.cliente (
		cedula int not null primary key,
		nombre varchar (180) not null,
		Correo_Electronico varchar (180) not null,
		Telefono int not null,
		celular int not null,
		fax varchar (180)not null,
		Zon varchar (180)not null,
		sector varchar (180) not null
 );
 --

 --modulo ventas
--
--modulo cotizaciones
--
--modulo facturación
--
--modulo registro_caso
--

