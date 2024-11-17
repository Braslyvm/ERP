
use Planificador_recursos_empresariales
go

-------datos del negocio
insert into facturación.Locales
       (nombre_local, cedula_juridica_local, telefono_local)
values 
       ('ERP','123456789', '98765432')

-- insertar registros en departamentos
insert into usuarios.departamento (id_departamento) 
values 
('recursos humanos'),
('ventas'),
('finanzas'),
('marketing'),
('operaciones');
go

-- insertar registros en puestos
insert into usuarios.puesto (id_puesto, id_departamento) 
values 
('gerente','recursos humanos'),
('vendedor','ventas'),
('contador','finanzas'),
('especialista','marketing'),
('supervisor ', 'operaciones');
go


------• Sectores, zonas, clientes (script con inserts).-------

INSERT INTO clientes.sector (sector_nombre)
VALUES 
('Agrícola'),
('Técnico'),
('Industrial'),
('Comercial'),
('Servicios'),
('Educativo');


INSERT INTO clientes.zona (zona_nombre)
VALUES 
('San José'),
('Alajuela'),
('Cartago'),
('Heredia'),
('Guanacaste'),
('Puntarenas'),
('Limón');

INSERT INTO clientes.cliente (cedula, nombre, Correo_Electronico, Telefono, celular, fax, zona, sector)
VALUES 
('123456789', 'Juan Pérez', 'juan.perez@mail.com', 2222-3333, 8888-9999, '2222-1111', 'San José', 'Agrícola'),
('987654321', 'María Gómez', 'maria.gomez@mail.com', 2222-4444, 8888-0000, '2222-5555', 'Alajuela', 'Técnico'),
('456123789', 'Carlos López', 'carlos.lopez@mail.com', 2222-6666, 8888-2222, '2222-7777', 'Cartago', 'Industrial'),
('321654987', 'Ana Torres', 'ana.torres@mail.com', 2222-8888, 8888-4444, '2222-9999', 'Heredia', 'Comercial'),
('654987321', 'Luis Fernández', 'luis.fernandez@mail.com', 2222-123,8888-5678, '2222-4321', 'Guanacaste', 'Servicios'),
('789654123', 'Patricia Castro', 'patricia.castro@mail.com', 2222-5678, 8888-9876, '2222-8765', 'Puntarenas', 'Educativo'),
('951753852', 'Diego Sánchez', 'diego.sanchez@mail.com', 2222-8765, 8888-6543, '2222-3456', 'Limón', 'Agrícola');
go
INSERT INTO clientes.cliente (cedula, nombre, Correo_Electronico, Telefono, celular, fax, zona, sector)
VALUES 
('753951456', 'Sofía Rojas', 'sofia.rojas@mail.com', 2222-0001, 8888-1001, '2222-2001', 'San José', 'Comercial'),
('159753468', 'José Vargas', 'jose.vargas@mail.com', 2222-0002, 8888-1002, '2222-2002', 'Alajuela', 'Industrial'),
('357951684', 'Carolina Méndez', 'carolina.mendez@mail.com', 2222-0003, 8888-1003, '2222-2003', 'Cartago', 'Técnico'),
('753159684', 'Ricardo Gutiérrez', 'ricardo.gutierrez@mail.com', 2222-0004, 8888-1004, '2222-2004', 'Heredia', 'Educativo'),
('987321654', 'Elena Ramírez', 'elena.ramirez@mail.com', 2222-0005, 8888-1005, '2222-2005', 'Guanacaste', 'Servicios'),
('654123789', 'Fernando Castro', 'fernando.castro@mail.com', 2222-0006, 8888-1006, '2222-2006', 'Puntarenas', 'Agrícola'),
('321987654', 'Gabriela Solano', 'gabriela.solano@mail.com', 2222-0007, 8888-1007, '2222-2007', 'Limón', 'Técnico'),
('147258369', 'Roberto Díaz', 'roberto.diaz@mail.com', 2222-0008, 8888-1008, '2222-2008', 'San José', 'Industrial'),
('852963741', 'Laura Pineda', 'laura.pineda@mail.com', 2222-0009, 8888-1009, '2222-2009', 'Alajuela', 'Comercial'),
('951357258', 'Mario Herrera', 'mario.herrera@mail.com', 2222-0010, 8888-1010, '2222-2010', 'Cartago', 'Servicios'),
('753486159', 'Claudia Navarro', 'claudia.navarro@mail.com', 2222-0011, 8888-1011, '2222-2011', 'Heredia', 'Educativo'),
('852741963', 'Andrés Valverde', 'andres.valverde@mail.com', 2222-0012, 8888-1012, '2222-2012', 'Guanacaste', 'Técnico'),
('951624873', 'Daniela Campos', 'daniela.campos@mail.com', 2222-0013, 8888-1013, '2222-2013', 'Puntarenas', 'Industrial'),
('741852963', 'Esteban Salas', 'esteban.salas@mail.com', 2222-0014, 8888-1014, '2222-2014', 'Limón', 'Comercial');




----------------------------------- insert de invintarios -------------------------
-- Inserciones para la tabla familia_articulos
insert into gestion_inventario.familia_articulos (id_familia, nombre, descripcion, activo) 
values
('001', 'Lacteos', 'Productos derivados de la leche', 1),
('002', 'Bebidas', 'Bebidas líquidas', 1),
('003', 'Repostería', 'Productos derivados del trigo', 1),
('004', 'Carnes Frías', 'Embutidos', 1),
('005', 'Carne', 'Alimentos derivados de los animales', 1),
('006', 'Artículos de Limpieza', 'Artículos para limpiar el hogar', 1),
('007', 'Artículos de Aseo', 'Productos de aseo personal', 1),
('008', 'Paquetes', 'Snacks', 1),
('009', 'Medicamentos', 'Productos referentes a mejorar la salud', 1);

---extras
insert into gestion_inventario.familia_articulos (id_familia, nombre, descripcion, activo) 
values
('010', 'Frutas', 'Frutas frescas y congeladas', 1),
('011', 'Verduras', 'Verduras frescas y orgánicas', 1),
('012', 'Cereales', 'Productos a base de granos', 1),
('013', 'Electrodomésticos', 'Aparatos eléctricos para el hogar', 1),
('014', 'Panadería', 'Pan, bollos y productos horneados', 1),
('015', 'Ropa', 'Vestimenta y accesorios textiles', 1),
('016', 'Calzado', 'Zapatos y artículos relacionados', 1),
('017', 'Juguetes', 'Artículos para niños y recreación', 1),
('018', 'Electrónica', 'Dispositivos electrónicos y accesorios', 1),
('019', 'Ferretería', 'Herramientas y materiales de construcción', 1),
('020', 'Bebés', 'Productos para el cuidado de bebés', 1),
('021', 'Mascotas', 'Alimentos y productos para animales', 1),
('022', 'Libros', 'Libros, revistas y material educativo', 1),
('023', 'Decoración', 'Artículos para decoración de interiores', 1)

-- Inserciones para la tabla articulos
insert into gestion_inventario.articulos (c_articulo, nombre, activo, descripcion, c_familia, peso, precio) 
values
('001', 'Leche', 1, 'Leche descremada sin lactosa', '001', 1000, 1.75),
('002', 'Yogur', 1, 'Yogur bajo en grasa', '001', 500, 2.25),
('003', 'Jugo de Naranja', 1, 'Jugo de naranja natural', '002', 1000, 1.50),
('004', 'Café Molido', 1, 'Café 100% Costaricense', '002', 500, 3.99),
('005', 'Galletas de maria', 1, 'Galletas', '003', 300, 1.99),
('006', 'Pastel de Chocolate', 1, 'Pastel de chocolate para cumpleaños', '003', 2000, 15.99),
('007', 'Jamón', 1, 'Jamón de pavo bajo en grasa', '004', 400, 4.50),
('008', 'Salchichas', 1, 'Salchichas de res', '004', 500, 3.99),
('009', 'Bistec', 1, 'Carne de res de primera', '005', 1000, 7.99),
('010', 'Pechuga de Pollo', 1, 'Pechuga de pollo sin hueso', '005', 800, 5.99),
('011', 'Detergente', 1, 'Detergente para ropa', '006', 2000, 6.99),
('012', 'Desinfectante', 1, 'Desinfectante para el hogar', '006', 1000, 3.99),
('013', 'Shampoo', 1, 'Shampoo para cabello seco', '007', 500, 4.99),
('014', 'Jabón de Manos', 1, 'Jabón líquido antibacterial', '007', 250, 2.50),
('015', 'Papas Fritas', 1, 'Paquete de papas fritas con sal', '008', 150, 1.25),
('016', 'Galletas de Chocolate', 1, 'Galletas rellenas de chocolate', '008', 200, 1.75),
('017', 'Aspirina', 1, 'Tabletas de ácido acetilsalicílico', '009', 50, 3.50),
('018', 'Jarabe para la Tos', 1, 'Jarabe expectorante', '009', 100, 4.99),
('019', 'Antibiótico Amoxicilina', 1, 'Cápsulas de 500mg de amoxicilina', '009', 100, 7.50),
('020', 'Vitamina C', 1, 'Suplemento de vitamina C', '009', 50, 2.99);
GO
---Extrar
insert into gestion_inventario.articulos (c_articulo, nombre, activo, descripcion, c_familia, peso, precio) 
values
('021', 'Manzanas', 1, 'Manzanas rojas frescas', '010', 1000, 2.99),
('022', 'Bananas', 1, 'Bananas maduras', '010', 1200, 1.50),
('023', 'Zanahorias', 1, 'Zanahorias frescas', '011', 1000, 1.75),
('024', 'Tomates', 1, 'Tomates tipo cherry', '011', 500, 2.25),
('025', 'Avena', 1, 'Avena integral', '012', 500, 2.99),
('026', 'Harina de Maíz', 1, 'Harina de maíz precocida', '012', 1000, 1.99),
('027', 'Tostadora', 1, 'Tostadora eléctrica', '013', 2000, 29.99),
('028', 'Licuadora', 1, 'Licuadora multifuncional', '013', 3000, 49.99),
('029', 'Pan Integral', 1, 'Pan integral sin azúcar', '014', 500, 2.50),
('030', 'Croissant', 1, 'Croissant relleno de chocolate', '014', 250, 1.99),
('031', 'Camiseta', 1, 'Camiseta de algodón', '015', 250, 7.99),
('032', 'Pantalones', 1, 'Pantalones de mezclilla', '015', 1000, 19.99),
('033', 'Zapatos Deportivos', 1, 'Zapatos para correr', '016', 1500, 49.99),
('034', 'Sandalias', 1, 'Sandalias casuales', '016', 500, 14.99),
('035', 'Pelota de Fútbol', 1, 'Pelota de fútbol profesional', '020', 1000, 25.99),
('036', 'Raqueta de Tenis', 1, 'Raqueta de tenis ligera', '020', 1500, 79.99),
('037', 'Aceite de Motor', 1, 'Aceite sintético para motor', '020', 1000, 12.50),
('038', 'Batería para Auto', 1, 'Batería de alto rendimiento', '020', 5000, 99.99),
('039', 'Fertilizante', 1, 'Fertilizante para césped', '019', 2000, 8.99),
('040', 'Tijeras de Jardín', 1, 'Tijeras de poda', '009', 1000, 12.99),
('041', 'Crema Facial', 1, 'Crema hidratante para la piel', '022', 200, 9.99),
('042', 'Loción Corporal', 1, 'Loción perfumada', '022', 500, 7.50);

GO
-- Inserciones para la tabla bodegas
insert into gestion_inventario.bodegas (c_bodega, nombre, ubicacion, c_toneladas, e_cubico) 
values
('B001', 'Bodega Principal', 'San José', 100, 2000),
('B002', 'Bodega 2', 'Heredia', 80, 1600),
('B003', 'Bodega 3', 'limon', 60, 1200),
('B004', 'Bodega 4', 'Alajuela', 50, 1000),
('B005', 'Bodega 5', 'limon', 40, 800);
GO
---extras 
insert into gestion_inventario.bodegas (c_bodega, nombre, ubicacion, c_toneladas, e_cubico) 
values
('B006', 'Bodega 6', 'Cartago', 70, 1400),
('B007', 'Bodega 7', 'Puntarenas', 50, 1000),
('B008', 'Bodega 8', 'Guanacaste', 60, 1200),
('B009', 'Bodega 9', 'San José', 90, 1800),
('B010', 'Bodega 10', 'Heredia', 30, 600),
('B011', 'Bodega 11', 'Alajuela', 75, 1500),
('B012', 'Bodega 12', 'Cartago', 55, 1100),
('B013', 'Bodega 13', 'Limón', 45, 900),
('B014', 'Bodega 14', 'Puntarenas', 35, 700),
('B015', 'Bodega 15', 'Guanacaste', 20, 400),
('B016', 'Bodega 16', 'San José', 110, 2200),
('B017', 'Bodega 17', 'Heredia', 65, 1300),
('B018', 'Bodega 18', 'Cartago', 85, 1700),
('B019', 'Bodega 19', 'Alajuela', 40, 800),
('B020', 'Bodega 20', 'Puntarenas', 25, 500);

GO
-- Inserciones para la tabla bodegas_familias
insert into gestion_inventario.bodegas_familias (c_bodega, id_familia) 
values
('B001', '001'),
('B001', '002'),
('B001', '003'),
('B002', '004'),
('B002', '005'),
('B003', '006'),
('B003', '007'),
('B004', '008'),
('B004', '009'),
('B005', '005');
GO
insert into gestion_inventario.bodegas_familias (c_bodega, id_familia) 
values
('B001', '010'),
('B001', '011'),
('B002', '012'),
('B002', '013'),
('B002', '014'),
('B003', '015'),
('B003', '016'),
('B003', '017'),
('B004', '018'),
('B004', '019'),
('B005', '020'),
('B005', '021'),
('B005', '022'),
('B006', '003'),
('B006', '008'),
('B006', '009'),
('B007', '011'),
('B007', '012'),
('B007', '018'),
('B008', '006'),
('B008', '014'),
('B009', '013'),
('B009', '019'),
('B010', '004'),
('B010', '007'),
('B010', '016'),
('B011', '002'),
('B011', '005'),
('B011', '020'),
('B012', '010'),
('B012', '017'),
('B012', '021'),
('B013', '001'),
('B013', '022'),
('B013', '023'),
('B014', '009'),
('B014', '015'),
('B014', '018'),
('B015', '003'),
('B015', '014'),
('B015', '020'),
('B016', '007'),
('B016', '011'),
('B016', '012'),
('B017', '019'),
('B017', '013'),
('B017', '005'),
('B018', '021'),
('B018', '006'),
('B018', '010'),
('B019', '002'),
('B019', '004'),
('B019', '022'),
('B020', '008'),
('B020', '017'),
('B020', '023');
GO
---------------------------crear rol y persmisos -----------------
EXEC  CrearRol 'rol' , 1
go

EXEC usuarios.InsertarPermisosInventario 'rol' , 1 , 1, 1
go

EXEC usuarios.InsertarPermisosUsuarios 'rol' , 1 , 1, 1
go


EXEC usuarios.InsertarPermisosCotizaciones 'rol' , 1 , 1, 1
go

EXEC usuarios.InsertarPermisosFacturas 'rol' , 1 , 1, 1
go

EXEC usuarios.InsertarPermisosCasos 'rol', 1, 0, 1;
go 

EXEC usuarios.InsertarPermisosReportes 'rol' , 1 , 1, 1
go

declare @mensaje nvarchar(200);
--Empleados 
exec usuarios.insertar_empleado
    @cedula = 12345678,
    @nombre = 'Juan',
    @apellido1 = 'Pérez',
    @apellido2 = 'López',
    @correo_electronico = 'juan.perez@example.com',
    @contraseña = 'ContraseñaSegura123',
    @género = 'Masculino',
    @fecha_nacimiento = '1990-05-15',
    @lugar_residencia = 'San José',
    @telefono = 88887777,
    @fecha_ingreso = '2023-01-01',
    @salario_actual = 3000,
    @puesto_actual = 'gerente',
    @departamento_actual = 'recursos humanos',
    @rol = 'rol',
    @mensaje = @mensaje output;

select @mensaje as MensajeResultado;
go
-------------- crear empleado de prueba-------------------------
DECLARE @mensaje NVARCHAR(200);

EXEC usuarios.insertar_empleado
    @cedula = 987654321,
    @nombre = 'Pedro',
    @apellido1 = 'Ramírez',
    @apellido2 = 'González',
    @correo_electronico = 'pedro.ramirez@mail.com',
    @contraseña = 'entrar',
    @género = 'Masculino',
    @fecha_nacimiento = '1990-05-10',
    @lugar_residencia = 'San José',
    @telefono = 22223333,
    @fecha_ingreso = '2023-01-15',
    @salario_actual = 1500,
    @puesto_actual = 'gerente',
    @departamento_actual = 'recursos humanos',
    @rol = 'rol',  
    @mensaje = @mensaje OUTPUT;
	print @mensaje

-- Ejemplo 1
exec usuarios.insertar_empleado
    @cedula = 87654321,
    @nombre = 'Ana',
    @apellido1 = 'García',
    @apellido2 = 'Martínez',
    @correo_electronico = 'ana.garcia@example.com',
    @contraseña = 'SeguraAna123',
    @género = 'Femenino',
    @fecha_nacimiento = '1985-07-20',
    @lugar_residencia = 'Alajuela',
    @telefono = 88996655,
    @fecha_ingreso = '2022-05-10',
    @salario_actual = 2500,
    @puesto_actual = 'vendedor',
    @departamento_actual = 'ventas',
    @rol = 'rol',
    @mensaje = @mensaje output;

select @mensaje as MensajeResultado;

-- Ejemplo 2
exec usuarios.insertar_empleado
    @cedula = 23456789,
    @nombre = 'Carlos',
    @apellido1 = 'Rojas',
    @apellido2 = 'Soto',
    @correo_electronico = 'carlos.rojas@example.com',
    @contraseña = 'CarlosSeguro123',
    @género = 'Masculino',
    @fecha_nacimiento = '1992-10-30',
    @lugar_residencia = 'Heredia',
    @telefono = 87776655,
    @fecha_ingreso = '2023-03-12',
    @salario_actual = 2800,
    @puesto_actual = 'contador',
    @departamento_actual = 'finanzas',
    @rol = 'rol',
    @mensaje = @mensaje output;

select @mensaje as MensajeResultado;

-- Ejemplo 3
exec usuarios.insertar_empleado
    @cedula = 34567890,
    @nombre = 'María',
    @apellido1 = 'Sánchez',
    @apellido2 = 'Ramírez',
    @correo_electronico = 'maria.sanchez@example.com',
    @contraseña = 'MariaFuerte123',
    @género = 'Femenino',
    @fecha_nacimiento = '1988-09-12',
    @lugar_residencia = 'Cartago',
    @telefono = 86665544,
    @fecha_ingreso = '2021-07-25',
    @salario_actual = 3200,
    @puesto_actual = 'especialista',
    @departamento_actual = 'marketing',
    @rol = 'rol',
    @mensaje = @mensaje output;

select @mensaje as MensajeResultado;

-- Ejemplo 4
exec usuarios.insertar_empleado
    @cedula = 45678901,
    @nombre = 'Luis',
    @apellido1 = 'Mora',
    @apellido2 = 'Jiménez',
    @correo_electronico = 'luis.mora@example.com',
    @contraseña = 'LuisPassword123',
    @género = 'Masculino',
    @fecha_nacimiento = '1979-03-22',
    @lugar_residencia = 'Limón',
    @telefono = 85554433,
    @fecha_ingreso = '2020-11-18',
    @salario_actual = 2700,
    @puesto_actual = 'supervisor',
    @departamento_actual = 'operaciones',
    @rol = 'rol',
    @mensaje = @mensaje output;

select @mensaje as MensajeResultado;
---
go
declare @mensaje nvarchar(200);

exec usuarios.insertar_empleado
    @cedula = 45678902,
    @nombre = 'Luisk',
    @apellido1 = 'Mora',
    @apellido2 = 'Jiménez',
    @correo_electronico = 'luis.mora@example.com',
    @contraseña = 'LuisPassword123',
    @género = 'Masculino',
    @fecha_nacimiento = '1979-03-22',
    @lugar_residencia = 'Limón',
    @telefono = 85554433,
    @fecha_ingreso = '2020-11-18',
    @salario_actual = 2700,
    @puesto_actual = 'supervisor',
    @departamento_actual = 'operaciones',
    @rol = 'rol',
    @mensaje = @mensaje output;

select @mensaje as MensajeResultado;

-- Ejemplo 5
exec usuarios.insertar_empleado
    @cedula = 56789012,
    @nombre = 'Lucía',
    @apellido1 = 'Pérez',
    @apellido2 = 'Quesada',
    @correo_electronico = 'lucia.perez@example.com',
    @contraseña = 'LuciaClave123',
    @género = 'Femenino',
    @fecha_nacimiento = '1995-01-05',
    @lugar_residencia = 'Puntarenas',
    @telefono = 84443322,
    @fecha_ingreso = '2021-08-22',
    @salario_actual = 2900,
    @puesto_actual = 'gerente',
    @departamento_actual = 'finanzas',
    @rol = 'rol',
    @mensaje = @mensaje output;

select @mensaje as MensajeResultado;
----
go
declare @mensaje nvarchar(200);
exec usuarios.insertar_empleado
    @cedula = 56789013,
    @nombre = 'Lucíano',
    @apellido1 = 'Pérez',
    @apellido2 = 'Quesada',
    @correo_electronico = 'lucia.perez@example.com',
    @contraseña = 'LuciaClave123',
    @género = 'Femenino',
    @fecha_nacimiento = '1995-01-05',
    @lugar_residencia = 'Puntarenas',
    @telefono = 84443322,
    @fecha_ingreso = '2021-08-22',
    @salario_actual = 2900,
    @puesto_actual = 'gerente',
    @departamento_actual = 'finanzas',
    @rol = 'rol',
    @mensaje = @mensaje output;

select @mensaje as MensajeResultado;


-- Ejemplo 6

exec usuarios.insertar_empleado
    @cedula = 67890123,
    @nombre = 'Mario',
    @apellido1 = 'Vargas',
    @apellido2 = 'Zúñiga',
    @correo_electronico = 'mario.vargas@example.com',
    @contraseña = 'MarioSeguro456',
    @género = 'Masculino',
    @fecha_nacimiento = '1993-11-17',
    @lugar_residencia = 'San José',
    @telefono = 83332211,
    @fecha_ingreso = '2022-02-28',
    @salario_actual = 3100,
    @puesto_actual = 'contador',
    @departamento_actual = 'finanzas',
    @rol = 'rol',
    @mensaje = @mensaje output;

select @mensaje as MensajeResultado;
---
go
declare @mensaje nvarchar(200);

exec usuarios.insertar_empleado
    @cedula = 67890124,
    @nombre = 'Mariaano',
    @apellido1 = 'Vargas',
    @apellido2 = 'Zúñiga',
    @correo_electronico = 'mario.vargas@example.com',
    @contraseña = 'MarioSeguro456',
    @género = 'Masculino',
    @fecha_nacimiento = '1993-11-17',
    @lugar_residencia = 'San José',
    @telefono = 83332211,
    @fecha_ingreso = '2022-02-28',
    @salario_actual = 3100,
    @puesto_actual = 'contador',
    @departamento_actual = 'finanzas',
    @rol = 'rol',
    @mensaje = @mensaje output;

select @mensaje as MensajeResultado;
-----
go
declare @mensaje nvarchar(200);
EXEC usuarios.insertar_empleado
    @cedula = 987654322,
    @nombre = 'bRASLY',
    @apellido1 = 'Ramírez',
    @apellido2 = 'González',
    @correo_electronico = 'bRASLY.ramirez@mail.com',
    @contraseña = 'entrar',
    @género = 'Masculino',
    @fecha_nacimiento = '1990-05-10',
    @lugar_residencia = 'San José',
    @telefono = 22223333,
    @fecha_ingreso = '2023-01-15',
    @salario_actual = 1500,
    @puesto_actual = 'gerente',
    @departamento_actual = 'recursos humanos',
    @rol = 'rol',  
    @mensaje = @mensaje OUTPUT;
	print @mensaje
go

-- Crear una tabla temporal para simular las inserciones
declare @productos table (
    c_bodega varchar(180),
    c_articulo varchar(180),
    cantidad int,
    bodega_destino varchar(180)
);

-- Insertar los datos en la tabla temporal
insert into @productos (c_bodega, c_articulo, cantidad, bodega_destino)
values
('B001', '001', 500, 'B001'),
('B001', '002', 200, 'B001'),
('B001', '003', 100, 'B001'),
('B001', '004', 150, 'B001'),
('B002', '005', 250, 'B002'),
('B002', '006', 50, 'B002'),
('B003', '007', 300, 'B003'),
('B003', '008', 400, 'B003'),
('B004', '009', 500, 'B004'),
('B004', '010', 350, 'B004'),
('B005', '011', 200, 'B005'),
('B005', '012', 150, 'B005'),
('B001', '013', 600, 'B001'),
('B001', '014', 450, 'B001'),
('B002', '015', 700, 'B002'),
('B002', '016', 500, 'B002'),
('B003', '017', 100, 'B003'),
('B003', '018', 120, 'B003'),
('B004', '019', 80, 'B004'),
('B004', '020', 150, 'B004'),
('B001', '010', 100, 'B001'),
('B001', '011', 100, 'B001'),
('B002', '012', 100, 'B002'),
('B002', '013', 100, 'B002'),
('B002', '014', 100, 'B002'),
('B003', '015', 100, 'B003'),
('B003', '016', 100, 'B003'),
('B004', '018', 100, 'B004'),
('B005', '020', 100, 'B005'),
('B005', '021', 100, 'B005'),
('B005', '022', 100, 'B005'),
('B006', '003', 100, 'B006'),
('B006', '008', 100, 'B006'),
('B006', '009', 100, 'B006'),
('B007', '011', 100, 'B007'),
('B007', '012', 100, 'B007'),
('B007', '018', 100, 'B007'),
('B008', '006', 100, 'B008'),
('B008', '014', 100, 'B008'),
('B009', '013', 100, 'B009'),
('B009', '019', 100, 'B009'),
('B010', '004', 100, 'B010'),
('B010', '007', 100, 'B010'),
('B010', '016', 100, 'B010'),
('B011', '002', 100, 'B011'),
('B011', '005', 100, 'B011'),
('B011', '020', 100, 'B011'),
('B012', '010', 100, 'B012'),
('B012', '017', 100, 'B012'),
('B012', '021', 100, 'B012'),
('B013', '001', 100, 'B013'),
('B013', '022', 100, 'B013'),
('B013', '023', 100, 'B013'),
('B014', '009', 100, 'B014'),
('B014', '015', 100, 'B014'),
('B014', '018', 100, 'B014'),
('B015', '003', 100, 'B015'),
('B015', '014', 100, 'B015'),
('B015', '020', 100, 'B015'),
('B016', '007', 100, 'B016'),
('B016', '011', 100, 'B016'),
('B016', '012', 100, 'B016'),
('B017', '019', 100, 'B017'),
('B017', '013', 100, 'B017'),
('B017', '005', 100, 'B017'),
('B018', '021', 100, 'B018'),
('B018', '006', 100, 'B018'),
('B018', '010', 100, 'B018'),
('B019', '002', 100, 'B019'),
('B019', '004', 100, 'B019'),
('B019', '022', 100, 'B019'),
('B020', '008', 100, 'B020'),
('B020', '017', 100, 'B020'),
('B020', '023', 100, 'B020');



--------------
declare @c_bodega varchar(180);
declare @c_articulo varchar(180);
declare @cantidad int;
declare @bodega_destino varchar(180);
declare @usuario int = 12345678;
declare @mensaje nvarchar(200);

-- Cursor para recorrer la tabla de productos
declare productos_cursor cursor for
select c_bodega, c_articulo, cantidad, bodega_destino
from @productos;

open productos_cursor;

fetch next from productos_cursor into @c_bodega, @c_articulo, @cantidad, @bodega_destino;

while @@fetch_status = 0
begin
   insert into [gestion_inventario].[inventario] (c_bodega, c_articulo, cantidad)
    values (@c_bodega, @c_articulo, 0);
   
   -- Generar una fecha aleatoria dentro de un rango específico
    declare @fecha date = dateadd(day, abs(checksum(newid()) % 365), '2023-01-01');
	
    -- Llamar al procedimiento almacenado
    exec gestion_inventario.insertar_producto_y_registrar_movimiento 
        @c_bodega = @c_bodega, 
        @c_articulo = @c_articulo, 
        @cantidad = @cantidad, 
        @n_factura = null, 
        @usuario = @usuario, 
        @bodega_origen = NULL, 
        @bodega_destino = @bodega_destino, 
        @mensaje = @mensaje output;

    -- Imprimir el mensaje de salida
    print @mensaje;

    fetch next from productos_cursor into @c_bodega, @c_articulo, @cantidad, @bodega_destino;
end;

close productos_cursor;
deallocate productos_cursor;



GO






---------------------INGRESO DE FACTURAS-----
go
declare @mensaje nvarchar(200);

exec facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 123456789, 
    @id_cotizacion = null, 
    @id_empleado = 23456789, 
    @fecha_factura = '2024-11-12', 
    @estado = 'aprobada', 
    @motivo_anulacion = null, 
    @total = null,        
    @mensaje = @mensaje output;





exec facturación.lineasfactura 
    @c_articulo = '001',
    @cantidad = 2, 
    @precio_unitario = 1, 
    @monto_total = 2, 
    @usuario = 1, 
    @mensaje = @mensaje output;


-- Producto 2: Yogur bajo en grasa (Código: '002')
exec facturación.lineasfactura 
    @c_articulo = '002',
    @cantidad = 3, 
    @precio_unitario = 2, 
    @monto_total = 6, 
    @usuario = 1, 
    @mensaje = @mensaje output;



-- Producto 3: Jugo de Naranja (Código: '003')
exec facturación.lineasfactura 
    @c_articulo = '003',
    @cantidad = 1, 
    @precio_unitario = 1, 
    @monto_total = 1, 
    @usuario = 1, 
    @mensaje = @mensaje output;





-- Factura 2
PRINT 'Factura 2: ';
go
declare @mensaje nvarchar(200);
exec facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 123456789, 
    @id_cotizacion = null, 
    @id_empleado = 12345678, 
    @fecha_factura = '2024-11-12', 
    @estado = 'aprobada', 
    @motivo_anulacion = null, 
    @total = null,        
    @mensaje = @mensaje output;



exec facturación.lineasfactura 
    @c_articulo = '004', 
    @cantidad = 2, 
    @precio_unitario = 3, 
    @monto_total = 6, 
    @usuario = 1, 
    @mensaje = @mensaje output;



exec facturación.lineasfactura 
    @c_articulo = '005', 
    @cantidad = 4, 
    @precio_unitario = 1, 
    @monto_total = 4, 
    @usuario = 1, 
    @mensaje = @mensaje output;


-- Factura 3
PRINT 'Factura 3: ';
go
declare @mensaje nvarchar(200);
exec facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 987654321, 
    @id_cotizacion = null, 
    @id_empleado = 23456789, 
    @fecha_factura = '2023-11-12',  
    @estado = 'aprobada', 
    @motivo_anulacion = null, 
    @total = null,        
    @mensaje = @mensaje output;



exec facturación.lineasfactura 
    @c_articulo = '006', 
    @cantidad = 1, 
    @precio_unitario = 15, 
    @monto_total = 15, 
    @usuario = 1, 
    @mensaje = @mensaje output;



exec facturación.lineasfactura 
    @c_articulo = '007', 
    @cantidad = 5, 
    @precio_unitario = 4, 
    @monto_total = 20, 
    @usuario = 1, 
    @mensaje = @mensaje output;




-- Factura 4
PRINT 'Factura 4: ';
go
declare @mensaje nvarchar(200);
exec facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 321654987, 
    @id_cotizacion = null, 
    @id_empleado = 12345678, 
    @fecha_factura = '2024-10-12', 
    @estado = 'aprobada', 
    @motivo_anulacion = null, 
    @total = null,        
    @mensaje = @mensaje output;


exec facturación.lineasfactura 
    @c_articulo = '010', 
    @cantidad = 3, 
    @precio_unitario = 5, 
    @monto_total = 15, 
    @usuario = 1, 
    @mensaje = @mensaje output;



exec facturación.lineasfactura 
    @c_articulo = '011', 
    @cantidad = 2, 
    @precio_unitario = 6, 
    @monto_total = 12, 
    @usuario = 1, 
    @mensaje = @mensaje output;


-- Factura 5
PRINT 'Factura 5: ';
go

declare @mensaje nvarchar(200);
exec facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 951753852, 
    @id_cotizacion = null, 
    @id_empleado = 12345678, 
    @fecha_factura = '2024-12-19', 
    @estado = 'aprobada', 
    @motivo_anulacion = null, 
    @total = null,        
    @mensaje = @mensaje output;




exec facturación.lineasfactura 
    @c_articulo = '015', 
    @cantidad = 10, 
    @precio_unitario = 1, 
    @monto_total = 10, 
    @usuario = 1, 
    @mensaje = @mensaje output;



exec facturación.lineasfactura 
    @c_articulo = '018', 
    @cantidad = 2, 
    @precio_unitario = 4, 
    @monto_total = 8, 
    @usuario = 1, 
    @mensaje = @mensaje output;

print @mensaje;

-- Factura 6
PRINT 'Factura 6: ';

go
declare @mensaje nvarchar(200);
exec facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 951753852, 
    @id_cotizacion = null, 
    @id_empleado = 12345678, 
    @fecha_factura = '2024-9-12', 
    @estado = 'aprobada', 
    @motivo_anulacion = null, 
    @total = null,        
    @mensaje = @mensaje output;



exec facturación.lineasfactura 
    @c_articulo = '017', 
    @cantidad = 3, 
    @precio_unitario = 3, 
    @monto_total = 9, 
    @usuario = 1, 
    @mensaje = @mensaje output;


exec facturación.lineasfactura 
    @c_articulo = '020', 
    @cantidad = 4, 
    @precio_unitario = 2, 
    @monto_total = 8, 
    @usuario = 1, 
    @mensaje = @mensaje output;


go
declare @mensaje nvarchar(200);
exec facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 951753852, 
    @id_cotizacion = null, 
    @id_empleado = 12345678, 
    @fecha_factura = '2024-9-12', 
    @estado = 'aprobada', 
    @motivo_anulacion = null, 
    @total = null,        
    @mensaje = @mensaje output;


exec facturación.lineasfactura 
    @c_articulo = '001', 
    @cantidad = 3, 
    @precio_unitario = 1, 
    @monto_total = 3, 
    @usuario = 1, 
    @mensaje = @mensaje output;


-- Factura 7
PRINT 'Factura 7: ';
go
declare @mensaje nvarchar(200);
exec facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 321654987, 
    @id_cotizacion = null, 
    @id_empleado = 56789012, 
    @fecha_factura = '2024-8-11', 
    @estado = 'aprobada', 
    @motivo_anulacion = null, 
    @total = null,        
    @mensaje = @mensaje output;



EXEC facturación.lineasfactura 
    @c_articulo = '001', 
    @cantidad = 5, 
    @precio_unitario = 1, 
    @monto_total = 5, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;

PRINT @mensaje;

EXEC facturación.lineasfactura 
    @c_articulo = '015', 
    @cantidad = 3, 
    @precio_unitario = 1, 
    @monto_total = 3, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;


-- Factura 8
PRINT 'Factura 8: ';
go
declare @mensaje nvarchar(200);
exec facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 654987321, 
    @id_cotizacion = null, 
    @id_empleado = 45678901, 
    @fecha_factura = '2024-8-12', 
    @estado = 'aprobada', 
    @motivo_anulacion = null, 
    @total = null,        
    @mensaje = @mensaje output;




EXEC facturación.lineasfactura 
    @c_articulo = '005', 
    @cantidad = 2, 
    @precio_unitario = 1, 
    @monto_total = 2, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;

PRINT @mensaje;

EXEC facturación.lineasfactura 
    @c_articulo = '018', 
    @cantidad = 1, 
    @precio_unitario = 4, 
    @monto_total = 4, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;

-- Factura 9
PRINT 'Factura 9: ';
go
declare @mensaje nvarchar(200);
exec facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 456123789, 
    @id_cotizacion = null, 
    @id_empleado = 67890123, 
    @fecha_factura = '2023-7-12', 
    @estado = 'aprobada', 
    @motivo_anulacion = null, 
    @total = null,        
    @mensaje = @mensaje output;



EXEC facturación.lineasfactura 
    @c_articulo = '007', 
    @cantidad = 4, 
    @precio_unitario = 4, 
    @monto_total = 16, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;


EXEC facturación.lineasfactura 
    @c_articulo = '012', 
    @cantidad = 2, 
    @precio_unitario = 3, 
    @monto_total = 6, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;



-- Factura 10
PRINT 'Factura 10: ';
go
declare @mensaje nvarchar(200);
exec facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 987654321, 
    @id_cotizacion = null, 
    @id_empleado = 87654321, 
    @fecha_factura = '2023-7-12', 
    @estado = 'aprobada', 
    @motivo_anulacion = null, 
    @total = null,        
    @mensaje = @mensaje output;



EXEC facturación.lineasfactura 
    @c_articulo = '010', 
    @cantidad = 3, 
    @precio_unitario = 5, 
    @monto_total = 15, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;


EXEC facturación.lineasfactura 
    @c_articulo = '016', 
    @cantidad = 2, 
    @precio_unitario = 1, 
    @monto_total = 2, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;


-- Factura 11
PRINT 'Factura 11: ';
go
declare @mensaje nvarchar(200);
exec facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 987654321, 
    @id_cotizacion = null, 
    @id_empleado = 87654321, 
    @fecha_factura = '2023-7-12', 
    @estado = 'aprobada', 
    @motivo_anulacion = null, 
    @total = null,        
    @mensaje = @mensaje output;



EXEC facturación.lineasfactura 
    @c_articulo = '014', 
    @cantidad = 5, 
    @precio_unitario = 2, 
    @monto_total = 10, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;



EXEC facturación.lineasfactura 
    @c_articulo = '009', 
    @cantidad = 2, 
    @precio_unitario = 7, 
    @monto_total = 14, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;


-- Factura 12
PRINT 'Factura 12: ';
go
declare @mensaje nvarchar(200);
exec facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 987654321, 
    @id_cotizacion = null, 
    @id_empleado = 87654321, 
    @fecha_factura = '2022-6-12', 
    @estado = 'aprobada', 
    @motivo_anulacion = null, 
    @total = null,        
    @mensaje = @mensaje output;



EXEC facturación.lineasfactura 
    @c_articulo = '017', 
    @cantidad = 6, 
    @precio_unitario = 3, 
    @monto_total = 18, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;


EXEC facturación.lineasfactura 
    @c_articulo = '011', 
    @cantidad = 3, 
    @precio_unitario = 6, 
    @monto_total = 18, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;



-- Factura 13

go
declare @mensaje nvarchar(200);
exec facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 321654987, 
    @id_cotizacion = null, 
    @id_empleado = 87654321, 
    @fecha_factura = '2022-7-12', 
    @estado = 'aprobada', 
    @motivo_anulacion = null, 
    @total = null,        
    @mensaje = @mensaje output;

EXEC facturación.lineasfactura 
    @c_articulo = '003', 
    @cantidad = 4, 
    @precio_unitario = 1, 
    @monto_total = 4, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;



EXEC facturación.lineasfactura 
    @c_articulo = '019', 
    @cantidad = 1, 
    @precio_unitario = 7, 
    @monto_total = 7, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;



-- Factura 14

go
declare @mensaje nvarchar(200);
exec facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 654987321, 
    @id_cotizacion = null, 
    @id_empleado = 45678901, 
    @fecha_factura = '2022-7-12', 
    @estado = 'aprobada', 
    @motivo_anulacion = null, 
    @total = null,        
    @mensaje = @mensaje output;



EXEC facturación.lineasfactura 
    @c_articulo = '004', 
    @cantidad = 2, 
    @precio_unitario = 3, 
    @monto_total = 6, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;

EXEC facturación.lineasfactura 
    @c_articulo = '018', 
    @cantidad = 2, 
    @precio_unitario = 4, 
    @monto_total = 8, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;




go
declare @mensaje nvarchar(200);
exec facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 789654123, 
    @id_cotizacion = null, 
    @id_empleado = 87654321, 
    @fecha_factura = '2023-3-12', 
    @estado = 'aprobada', 
    @motivo_anulacion = null, 
    @total = null,        
    @mensaje = @mensaje output;

EXEC facturación.lineasfactura 
    @c_articulo = '010', 
    @cantidad = 3, 
    @precio_unitario = 5, 
    @monto_total = 15, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;



EXEC facturación.lineasfactura 
    @c_articulo = '013', 
    @cantidad = 1, 
    @precio_unitario = 4, 
    @monto_total = 4, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;



-- Factura 16
go
declare @mensaje nvarchar(200);
exec facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 321654987, 
    @id_cotizacion = null, 
    @id_empleado = 23456789, 
    @fecha_factura = '2024-11-12', 
    @estado = 'aprobada', 
    @motivo_anulacion = null, 
    @total = null,        
    @mensaje = @mensaje output;

	

EXEC facturación.lineasfactura 
    @c_articulo = '007', 
    @cantidad = 4, 
    @precio_unitario = 4, 
    @monto_total = 18, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;


EXEC facturación.lineasfactura 
    @c_articulo = '016', 
    @cantidad = 5, 
    @precio_unitario = 1, 
    @monto_total = 5, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;


-- Factura 17
go
declare @mensaje nvarchar(200);
exec facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 123456789, 
    @id_cotizacion = null, 
    @id_empleado = 87654321, 
    @fecha_factura = '2024-5-12', 
    @estado = 'aprobada', 
    @motivo_anulacion = null, 
    @total = null,        
    @mensaje = @mensaje output;


EXEC facturación.lineasfactura 
    @c_articulo = '015', 
    @cantidad = 10, 
    @precio_unitario = 1, 
    @monto_total = 10, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;


EXEC facturación.lineasfactura 
    @c_articulo = '002', 
    @cantidad = 3, 
    @precio_unitario = 2, 
    @monto_total = 6, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;


-- Factura 18

go
declare @mensaje nvarchar(200);
exec facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 789654123, 
    @id_cotizacion = null, 
    @id_empleado = 87654321, 
    @fecha_factura = '2023-5-12', 
    @estado = 'aprobada', 
    @motivo_anulacion = null, 
    @total = null,        
    @mensaje = @mensaje output;

	
EXEC facturación.lineasfactura 
    @c_articulo = '006', 
    @cantidad = 1, 
    @precio_unitario = 15, 
    @monto_total = 15, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;



EXEC facturación.lineasfactura 
    @c_articulo = '018', 
    @cantidad = 4, 
    @precio_unitario = 4, 
    @monto_total = 18, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;



-- Factura 19
go
declare @mensaje nvarchar(200);
exec facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 456123789, 
    @id_cotizacion = null, 
    @id_empleado = 23456789, 
    @fecha_factura = '2023-5-12', 
    @estado = 'aprobada', 
    @motivo_anulacion = null, 
    @total = null,        
    @mensaje = @mensaje output;

	
EXEC facturación.lineasfactura 
    @c_articulo = '003', 
    @cantidad = 8, 
    @precio_unitario = 1, 
    @monto_total = 8, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;



EXEC facturación.lineasfactura 
    @c_articulo = '001', 
    @cantidad = 5, 
    @precio_unitario = 1, 
    @monto_total = 5, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;



----

GO
DECLARE @mensaje NVARCHAR(200);
EXEC facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 456123789, 
    @id_cotizacion = NULL, 
    @id_empleado = 23456789, 
    @fecha_factura = '2023-05-12', 
    @estado = 'aprobada', 
    @motivo_anulacion = NULL, 
    @total = NULL,        
    @mensaje = @mensaje OUTPUT;


EXEC facturación.lineasfactura 
    @c_articulo = '003', 
    @cantidad = 8, 
    @precio_unitario = 1, 
    @monto_total = 8, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;

PRINT @mensaje;


GO
DECLARE @mensaje NVARCHAR(200);
EXEC facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 654123789, 
    @id_cotizacion = NULL, 
    @id_empleado = 23456789, 
    @fecha_factura = '2023-06-20', 
    @estado = 'aprobada', 
    @motivo_anulacion = NULL, 
    @total = NULL,        
    @mensaje = @mensaje OUTPUT;


EXEC facturación.lineasfactura 
    @c_articulo = '007', 
    @cantidad = 5, 
    @precio_unitario = 4, 
    @monto_total = 20, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;


GO
DECLARE @mensaje NVARCHAR(200);
EXEC facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 321987654, 
    @id_cotizacion = NULL, 
    @id_empleado = 23456789, 
    @fecha_factura = '2023-07-10', 
    @estado = 'aprobada', 
    @motivo_anulacion = NULL, 
    @total = NULL,        
    @mensaje = @mensaje OUTPUT;



EXEC facturación.lineasfactura 
    @c_articulo = '010', 
    @cantidad = 10, 
    @precio_unitario = 2, 
    @monto_total = 20, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;


GO
DECLARE @mensaje NVARCHAR(200);
EXEC facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 753159684, 
    @id_cotizacion = NULL, 
    @id_empleado = 23456789, 
    @fecha_factura = '2023-08-15', 
    @estado = 'aprobada', 
    @motivo_anulacion = NULL, 
    @total = NULL,        
    @mensaje = @mensaje OUTPUT;



EXEC facturación.lineasfactura 
    @c_articulo = '011', 
    @cantidad = 3, 
    @precio_unitario = 6, 
    @monto_total = 18, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;


GO
DECLARE @mensaje NVARCHAR(200);
EXEC facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 987654321, 
    @id_cotizacion = NULL, 
    @id_empleado = 23456789, 
    @fecha_factura = '2023-09-01', 
    @estado = 'aprobada', 
    @motivo_anulacion = NULL, 
    @total = NULL,        
    @mensaje = @mensaje OUTPUT;



EXEC facturación.lineasfactura 
    @c_articulo = '020', 
    @cantidad = 6, 
    @precio_unitario = 7, 
    @monto_total = 42, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;




GO
DECLARE @mensaje NVARCHAR(200);
EXEC facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 654123789, 
    @id_cotizacion = NULL, 
    @id_empleado = 23456789, 
    @fecha_factura = '2023-11-01', 
    @estado = 'aprobada', 
    @motivo_anulacion = NULL, 
    @total = NULL,        
    @mensaje = @mensaje OUTPUT;



EXEC facturación.lineasfactura 
    @c_articulo = '012', 
    @cantidad = 5, 
    @precio_unitario = 1, 
    @monto_total = 5, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;



GO
DECLARE @mensaje NVARCHAR(200);
EXEC facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 321654987, 
    @id_cotizacion = NULL, 
    @id_empleado = 23456789, 
    @fecha_factura = '2023-11-10', 
    @estado = 'aprobada', 
    @motivo_anulacion = NULL, 
    @total = NULL,        
    @mensaje = @mensaje OUTPUT;



EXEC facturación.lineasfactura 
    @c_articulo = '016', 
    @cantidad = 3, 
    @precio_unitario = 1, 
    @monto_total = 3, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;



GO
DECLARE @mensaje NVARCHAR(200);
EXEC facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 753951456, 
    @id_cotizacion = NULL, 
    @id_empleado = 23456789, 
    @fecha_factura = '2023-12-01', 
    @estado = 'aprobada', 
    @motivo_anulacion = NULL, 
    @total = NULL,        
    @mensaje = @mensaje OUTPUT;



EXEC facturación.lineasfactura 
    @c_articulo = '018', 
    @cantidad = 6, 
    @precio_unitario = 4, 
    @monto_total = 24, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;


GO
DECLARE @mensaje NVARCHAR(200);
EXEC facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 753159684, 
    @id_cotizacion = NULL, 
    @id_empleado = 23456789, 
    @fecha_factura = '2023-12-15', 
    @estado = 'aprobada', 
    @motivo_anulacion = NULL, 
    @total = NULL,        
    @mensaje = @mensaje OUTPUT;

EXEC facturación.lineasfactura 
    @c_articulo = '022', 
    @cantidad = 2, 
    @precio_unitario = 7, 
    @monto_total = 14, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;


GO
DECLARE @mensaje NVARCHAR(200);
EXEC facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 654123789, 
    @id_cotizacion = NULL, 
    @id_empleado = 23456789, 
    @fecha_factura = '2023-12-01', 
    @estado = 'aprobada', 
    @motivo_anulacion = NULL, 
    @total = NULL,        
    @mensaje = @mensaje OUTPUT;



EXEC facturación.lineasfactura 
    @c_articulo = '018', 
    @cantidad = 6, 
    @precio_unitario = 4, 
    @monto_total = 24, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;



PRINT 'Factura 28: '; 
GO
DECLARE @mensaje NVARCHAR(200);
EXEC facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 753159684, 
    @id_cotizacion = NULL, 
    @id_empleado = 23456789, 
    @fecha_factura = '2023-12-15', 
    @estado = 'aprobada', 
    @motivo_anulacion = NULL, 
    @total = NULL,        
    @mensaje = @mensaje OUTPUT;



EXEC facturación.lineasfactura 
    @c_articulo = '022', 
    @cantidad = 2, 
    @precio_unitario = 7, 
    @monto_total = 14, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;



GO
DECLARE @mensaje NVARCHAR(200);
EXEC facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 987654321, 
    @id_cotizacion = NULL, 
    @id_empleado = 23456789, 
    @fecha_factura = '2024-01-01', 
    @estado = 'aprobada', 
    @motivo_anulacion = NULL, 
    @total = NULL,        
    @mensaje = @mensaje OUTPUT;



EXEC facturación.lineasfactura 
    @c_articulo = '020', 
    @cantidad = 3, 
    @precio_unitario = 12, 
    @monto_total = 36, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;


PRINT 'Factura 30: '; 
GO
DECLARE @mensaje NVARCHAR(200);
EXEC facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 123456789, 
    @id_cotizacion = NULL, 
    @id_empleado = 23456789, 
    @fecha_factura = '2024-02-10', 
    @estado = 'aprobada', 
    @motivo_anulacion = NULL, 
    @total = NULL,        
    @mensaje = @mensaje OUTPUT;



EXEC facturación.lineasfactura 
    @c_articulo = '021', 
    @cantidad = 4, 
    @precio_unitario = 2, 
    @monto_total = 8, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;

PRINT @mensaje;


GO
DECLARE @mensaje NVARCHAR(200);
EXEC facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 654987321, 
    @id_cotizacion = NULL, 
    @id_empleado = 23456789, 
    @fecha_factura = '2024-03-05', 
    @estado = 'aprobada', 
    @motivo_anulacion = NULL, 
    @total = NULL,        
    @mensaje = @mensaje OUTPUT;



EXEC facturación.lineasfactura 
    @c_articulo = '015', 
    @cantidad = 10, 
    @precio_unitario = 7, 
    @monto_total = 70, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;


GO
DECLARE @mensaje NVARCHAR(200);
EXEC facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 123456789, 
    @id_cotizacion = NULL, 
    @id_empleado = 23456789, 
    @fecha_factura = '2024-04-15', 
    @estado = 'aprobada', 
    @motivo_anulacion = NULL, 
    @total = NULL,        
    @mensaje = @mensaje OUTPUT;



EXEC facturación.lineasfactura 
    @c_articulo = '017', 
    @cantidad = 7, 
    @precio_unitario = 3, 
    @monto_total = 21, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;


GO
DECLARE @mensaje NVARCHAR(200);
EXEC facturación.insertar_factura 
    @cedula_juridica_local = 123456789, 
    @id_cliente = 321654987, 
    @id_cotizacion = NULL, 
    @id_empleado = 23456789, 
    @fecha_factura = '2024-05-20', 
    @estado = 'aprobada', 
    @motivo_anulacion = NULL, 
    @total = NULL,        
    @mensaje = @mensaje OUTPUT;


EXEC facturación.lineasfactura 
    @c_articulo = '014', 
    @cantidad = 3, 
    @precio_unitario = 5, 
    @monto_total = 15, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;

PRINT @mensaje;

----------------Inserts de planillas 
go
declare @mensaje nvarchar(200);
exec usuarios.insertar_plantilla 
    @cedula = 12345678,
    @mes = 'Enero',
    @año = 2024,
    @fecha_pago  = '2024-1-12',
    @h_normales = 160,
    @h_extras = 10,
    @mensaje = @mensaje output;

go
declare @mensaje nvarchar(200);
exec usuarios.insertar_plantilla 
    @cedula = 34567890,
    @mes = 'Enero',
    @año = 2024,
    @fecha_pago  = '2024-1-12',
    @h_normales = 160,
    @h_extras = 10,
    @mensaje = @mensaje output;


-- Ejemplo de ejecución del procedimiento con cédulas proporcionadas

-- Cedula: 12345678
go
declare @mensaje nvarchar(200);
exec usuarios.insertar_plantilla 
    @cedula = 12345678,
    @mes = 'Junio',
    @año = 2022,
    @fecha_pago  = '2022-06-12',
    @h_normales = 160,
    @h_extras = 10,
    @mensaje = @mensaje output;


-- Cedula: 23456789
go
declare @mensaje nvarchar(200);
exec usuarios.insertar_plantilla 
    @cedula = 23456789,
    @mes = 'Marzo',
    @año = 2023,
    @fecha_pago  = '2023-03-12',
    @h_normales = 160,
    @h_extras = 15,
    @mensaje = @mensaje output;
print @mensaje;
go
declare @mensaje nvarchar(200);

-- Cedula: 34567890
exec usuarios.insertar_plantilla 
    @cedula = 56789012,
    @mes = 'Marzo',
    @año = 2023,
     @fecha_pago  = '2023-03-12',
    @h_normales = 160,
    @h_extras = 12,
    @mensaje = @mensaje output;


-- Cedula: 45678901
exec usuarios.insertar_plantilla 
    @cedula = 45678901,
    @mes = 'Abril',
    @año = 2023,
    @fecha_pago  = '2023-04-12',
    @h_normales = 160,
    @h_extras = 8,
    @mensaje = @mensaje output;

-- Cedula: 56789012
exec usuarios.insertar_plantilla 
    @cedula = 56789012,
    @mes = 'Mayo',
    @año = 2023,
    @fecha_pago  = '2023-05-12',
    @h_normales = 160,
    @h_extras = 20,
    @mensaje = @mensaje output;

-- Cedula: 67890123
exec usuarios.insertar_plantilla 
    @cedula = 67890123,
    @mes = 'Junio',
    @año = 2023,
    @fecha_pago  = '2023-06-12',
    @h_normales = 160,
    @h_extras = 5,
    @mensaje = @mensaje output;


-- Cedula: 87654321
exec usuarios.insertar_plantilla 
    @cedula = 87654321,
    @mes = 'Julio',
    @año = 2023,
     @fecha_pago  = '2023-07-12',
    @h_normales = 160,
    @h_extras = 18,
    @mensaje = @mensaje output;


-- Cedula: 987654321
exec usuarios.insertar_plantilla 
    @cedula = 987654321,
    @mes = 'Agosto',
    @año = 2023,
     @fecha_pago  = '2023-08-12',
    @h_normales = 160,
    @h_extras = 22,
    @mensaje = @mensaje output;



go

-- Cedula: 12345678 - Enero 2022
declare @mensaje nvarchar(200);
exec usuarios.insertar_plantilla 
    @cedula = 12345678,
    @mes = 'Febrero',
    @año = 2024,
    @fecha_pago  = '2024-02-12',
    @h_normales = 160,
    @h_extras = 5,
    @mensaje = @mensaje output;


-- Cedula: 23456789 - Febrero 2022
exec usuarios.insertar_plantilla 
    @cedula = 23456789,
    @mes = 'Febrero',
    @año = 2024,
     @fecha_pago  = '2024-02-12',
    @h_normales = 150,
    @h_extras = 10,
    @mensaje = @mensaje output;


-- Cedula: 34567890 - Marzo 2022
exec usuarios.insertar_plantilla 
    @cedula = 34567890,
    @mes = 'Marzo',
    @año = 2024,
    @fecha_pago  = '2024-03-12',
    @h_normales = 160,
    @h_extras = 15,
    @mensaje = @mensaje output;


-- Cedula: 45678901 - Abril 2023
exec usuarios.insertar_plantilla 
    @cedula = 45678901,
    @mes = 'Mayo',
    @año = 2023,
    @fecha_pago  = '2023-05-12',
    @h_normales = 160,
    @h_extras = 20,
    @mensaje = @mensaje output;


-- Cedula: 56789012 - Mayo 2023
exec usuarios.insertar_plantilla 
    @cedula = 56789012,
    @mes = 'Mayo',
    @año = 2023,
     @fecha_pago  = '2023-05-12',
    @h_normales = 155,
    @h_extras = 12,
    @mensaje = @mensaje output;


-- Cedula: 67890123 - Junio 2023
exec usuarios.insertar_plantilla 
    @cedula = 67890123,
    @mes = 'Junio',
    @año = 2023,
    @fecha_pago  = '2023-06-12',
    @h_normales = 160,
    @h_extras = 18,
    @mensaje = @mensaje output;


-- Cedula: 87654321 - Julio 2024
exec usuarios.insertar_plantilla 
    @cedula = 87654321,
    @mes = 'Julio',
    @año = 2024,
      @fecha_pago  = '2024-07-12',
    @h_normales = 160,
    @h_extras = 10,
    @mensaje = @mensaje output;


-- Cedula: 987654321 - Agosto 2024
exec usuarios.insertar_plantilla 
    @cedula = 987654321,
    @mes = 'Agosto',
    @año = 2024,
      @fecha_pago  = '2024-05-12',
    @h_normales = 160,
    @h_extras = 25,
    @mensaje = @mensaje output;


-- Cedula: 12345678 - Septiembre 2024
exec usuarios.insertar_plantilla 
    @cedula = 12345678,
    @mes = 'Septiembre',
    @año = 2024,
  @fecha_pago  = '2024-09-12',
    @h_normales = 150,
    @h_extras = 8,
    @mensaje = @mensaje output;


-- Cedula: 23456789 - Octubre 2024
exec usuarios.insertar_plantilla 
    @cedula = 23456789,
    @mes = 'Octubre',
    @año = 2024,
     @fecha_pago  = '2024-10-12',
    @h_normales = 160,
    @h_extras = 10,
    @mensaje = @mensaje output;

go 
---EXTRAS
-- Declaración de la variable para el mensaje
declare @mensaje nvarchar(200);

exec usuarios.insertar_plantilla 
    @cedula = 12345678,
    @mes = 'Enero',
    @año = 2024,
    @fecha_pago = '2024-01-12',
    @h_normales = 160,
    @h_extras = 10,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 12345678,
    @mes = 'Febrero',
    @año = 2024,
    @fecha_pago = '2024-02-12',
    @h_normales = 160,
    @h_extras = 12,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 12345678,
    @mes = 'Marzo',
    @año = 2024,
    @fecha_pago = '2024-03-12',
    @h_normales = 160,
    @h_extras = 14,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 12345678,
    @mes = 'Abril',
    @año = 2024,
    @fecha_pago = '2024-04-12',
    @h_normales = 160,
    @h_extras = 15,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 12345678,
    @mes = 'Mayo',
    @año = 2024,
    @fecha_pago = '2024-05-12',
    @h_normales = 160,
    @h_extras = 20,
    @mensaje = @mensaje output;

-- Ingresar planillas para la cédula 23456789 en varias fechas
exec usuarios.insertar_plantilla 
    @cedula = 23456789,
    @mes = 'Enero',
    @año = 2024,
    @fecha_pago = '2024-01-12',
    @h_normales = 160,
    @h_extras = 10,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 23456789,
    @mes = 'Febrero',
    @año = 2024,
    @fecha_pago = '2024-02-12',
    @h_normales = 160,
    @h_extras = 11,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 23456789,
    @mes = 'Marzo',
    @año = 2024,
    @fecha_pago = '2024-03-12',
    @h_normales = 160,
    @h_extras = 12,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 23456789,
    @mes = 'Abril',
    @año = 2024,
    @fecha_pago = '2024-04-12',
    @h_normales = 160,
    @h_extras = 14,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 23456789,
    @mes = 'Mayo',
    @año = 2024,
    @fecha_pago = '2024-05-12',
    @h_normales = 160,
    @h_extras = 16,
    @mensaje = @mensaje output;


-- Ingresar planillas para la cédula 34567890 en varias fechas
exec usuarios.insertar_plantilla 
    @cedula = 34567890,
    @mes = 'Enero',
    @año = 2024,
    @fecha_pago = '2024-01-12',
    @h_normales = 160,
    @h_extras = 15,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 34567890,
    @mes = 'Febrero',
    @año = 2024,
    @fecha_pago = '2024-02-12',
    @h_normales = 160,
    @h_extras = 18,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 34567890,
    @mes = 'Marzo',
    @año = 2024,
    @fecha_pago = '2024-03-12',
    @h_normales = 160,
    @h_extras = 20,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 34567890,
    @mes = 'Abril',
    @año = 2024,
    @fecha_pago = '2024-04-12',
    @h_normales = 160,
    @h_extras = 25,
    @mensaje = @mensaje output;

exec usuarios.insertar_plantilla 
    @cedula = 34567890,
    @mes = 'Mayo',
    @año = 2024,
    @fecha_pago = '2024-05-12',
    @h_normales = 160,
    @h_extras = 30,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 45678901,
    @mes = 'Enero',
    @año = 2024,
    @fecha_pago = '2024-01-12',
    @h_normales = 160,
    @h_extras = 12,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 45678901,
    @mes = 'Febrero',
    @año = 2024,
    @fecha_pago = '2024-02-12',
    @h_normales = 160,
    @h_extras = 14,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 45678901,
    @mes = 'Marzo',
    @año = 2024,
    @fecha_pago = '2024-03-12',
    @h_normales = 160,
    @h_extras = 16,
    @mensaje = @mensaje output;

exec usuarios.insertar_plantilla 
    @cedula = 45678901,
    @mes = 'Abril',
    @año = 2024,
    @fecha_pago = '2024-04-12',
    @h_normales = 160,
    @h_extras = 18,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 45678901,
    @mes = 'Mayo',
    @año = 2024,
    @fecha_pago = '2024-05-12',
    @h_normales = 160,
    @h_extras = 20,
    @mensaje = @mensaje output;
print @mensaje;

-- Ingresar planillas para la cédula 56789012 en varias fechas
exec usuarios.insertar_plantilla 
    @cedula = 56789012,
    @mes = 'Enero',
    @año = 2024,
    @fecha_pago = '2024-01-12',
    @h_normales = 160,
    @h_extras = 15,
    @mensaje = @mensaje output;

exec usuarios.insertar_plantilla 
    @cedula = 56789012,
    @mes = 'Febrero',
    @año = 2024,
    @fecha_pago = '2024-02-12',
    @h_normales = 160,
    @h_extras = 17,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 56789012,
    @mes = 'Marzo',
    @año = 2024,
    @fecha_pago = '2024-03-12',
    @h_normales = 160,
    @h_extras = 19,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 56789012,
    @mes = 'Abril',
    @año = 2024,
    @fecha_pago = '2024-04-12',
    @h_normales = 160,
    @h_extras = 22,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 56789012,
    @mes = 'Mayo',
    @año = 2024,
    @fecha_pago = '2024-05-12',
    @h_normales = 160,
    @h_extras = 25,
    @mensaje = @mensaje output;


-- Ingresar planillas para la cédula 67890123 en varias fechas
exec usuarios.insertar_plantilla 
    @cedula = 67890123,
    @mes = 'Enero',
    @año = 2024,
    @fecha_pago = '2024-01-12',
    @h_normales = 160,
    @h_extras = 10,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 67890123,
    @mes = 'Febrero',
    @año = 2024,
    @fecha_pago = '2024-02-12',
    @h_normales = 160,
    @h_extras = 12,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 67890123,
    @mes = 'Marzo',
    @año = 2024,
    @fecha_pago = '2024-03-12',
    @h_normales = 160,
    @h_extras = 13,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 67890123,
    @mes = 'Abril',
    @año = 2024,
    @fecha_pago = '2024-04-12',
    @h_normales = 160,
    @h_extras = 14,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 67890123,
    @mes = 'Mayo',
    @año = 2024,
    @fecha_pago = '2024-05-12',
    @h_normales = 160,
    @h_extras = 18,
    @mensaje = @mensaje output;


-- Ingresar planillas para la cédula 78901234 en varias fechas
exec usuarios.insertar_plantilla 
    @cedula = 78901234,
    @mes = 'Enero',
    @año = 2024,
    @fecha_pago = '2024-01-12',
    @h_normales = 160,
    @h_extras = 11,
    @mensaje = @mensaje output;

GO
-- Declaración de la variable para el mensaje
declare @mensaje nvarchar(200);

-- Ingresar planillas para la cédula 45678901 en varias fechas (año 2023 y 2022)
exec usuarios.insertar_plantilla 
    @cedula = 45678901,
    @mes = 'Enero',
    @año = 2023,
    @fecha_pago = '2023-01-12',
    @h_normales = 160,
    @h_extras = 12,
    @mensaje = @mensaje output;

exec usuarios.insertar_plantilla 
    @cedula = 45678901,
    @mes = 'Febrero',
    @año = 2023,
    @fecha_pago = '2023-02-12',
    @h_normales = 160,
    @h_extras = 14,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 45678901,
    @mes = 'Marzo',
    @año = 2023,
    @fecha_pago = '2023-03-12',
    @h_normales = 160,
    @h_extras = 16,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 45678901,
    @mes = 'Abril',
    @año = 2023,
    @fecha_pago = '2023-04-12',
    @h_normales = 160,
    @h_extras = 18,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 45678901,
    @mes = 'Mayo',
    @año = 2023,
    @fecha_pago = '2023-05-12',
    @h_normales = 160,
    @h_extras = 20,
    @mensaje = @mensaje output;


-- Ingresar planillas para la cédula 56789012 en varias fechas (año 2023 y 2022)
exec usuarios.insertar_plantilla 
    @cedula = 56789012,
    @mes = 'Enero',
    @año = 2023,
    @fecha_pago = '2023-01-12',
    @h_normales = 160,
    @h_extras = 15,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 56789012,
    @mes = 'Febrero',
    @año = 2023,
    @fecha_pago = '2023-02-12',
    @h_normales = 160,
    @h_extras = 17,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 56789012,
    @mes = 'Marzo',
    @año = 2023,
    @fecha_pago = '2023-03-12',
    @h_normales = 160,
    @h_extras = 19,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 56789012,
    @mes = 'Abril',
    @año = 2023,
    @fecha_pago = '2023-04-12',
    @h_normales = 160,
    @h_extras = 22,
    @mensaje = @mensaje output;

exec usuarios.insertar_plantilla 
    @cedula = 56789012,
    @mes = 'Mayo',
    @año = 2023,
    @fecha_pago = '2023-05-12',
    @h_normales = 160,
    @h_extras = 25,
    @mensaje = @mensaje output;


-- Ingresar planillas para la cédula 67890123 en varias fechas (año 2023 y 2022)
exec usuarios.insertar_plantilla 
    @cedula = 67890123,
    @mes = 'Enero',
    @año = 2023,
    @fecha_pago = '2023-01-12',
    @h_normales = 160,
    @h_extras = 10,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 67890123,
    @mes = 'Febrero',
    @año = 2023,
    @fecha_pago = '2023-02-12',
    @h_normales = 160,
    @h_extras = 12,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 67890123,
    @mes = 'Marzo',
    @año = 2023,
    @fecha_pago = '2023-03-12',
    @h_normales = 160,
    @h_extras = 13,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 67890123,
    @mes = 'Abril',
    @año = 2023,
    @fecha_pago = '2023-04-12',
    @h_normales = 160,
    @h_extras = 14,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 67890123,
    @mes = 'Mayo',
    @año = 2023,
    @fecha_pago = '2023-05-12',
    @h_normales = 160,
    @h_extras = 18,
    @mensaje = @mensaje output;


-- Ingresar planillas para la cédula 78901234 en varias fechas (año 2023 y 2022)
exec usuarios.insertar_plantilla 
    @cedula = 78901234,
    @mes = 'Enero',
    @año = 2023,
    @fecha_pago = '2023-01-12',
    @h_normales = 160,
    @h_extras = 11,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 78901234,
    @mes = 'Febrero',
    @año = 2023,
    @fecha_pago = '2023-02-12',
    @h_normales = 160,
    @h_extras = 13,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 78901234,
    @mes = 'Marzo',
    @año = 2023,
    @fecha_pago = '2023-03-12',
    @h_normales = 160,
    @h_extras = 15,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 78901234,
    @mes = 'Abril',
    @año = 2023,
    @fecha_pago = '2023-04-12',
    @h_normales = 160,
    @h_extras = 17,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 78901234,
    @mes = 'Mayo',
    @año = 2023,
    @fecha_pago = '2023-05-12',
    @h_normales = 160,
    @h_extras = 20,
    @mensaje = @mensaje output;

-- Año 2022 para la cédula 45678901
exec usuarios.insertar_plantilla 
    @cedula = 45678901,
    @mes = 'Enero',
    @año = 2022,
    @fecha_pago = '2022-01-12',
    @h_normales = 160,
    @h_extras = 12,
    @mensaje = @mensaje output;


exec usuarios.insertar_plantilla 
    @cedula = 45678901,
    @mes = 'Febrero',
    @año = 2022,
    @fecha_pago = '2022-02-12',
    @h_normales = 160,
    @h_extras = 14,
    @mensaje = @mensaje output;


-- Ingresar planillas para la cédula 56789012 (año 2022)
exec usuarios.insertar_plantilla 
    @cedula = 56789012,
    @mes = 'Enero',
    @año = 2022,
    @fecha_pago = '2022-01-12',
    @h_normales = 160,
    @h_extras = 15,
    @mensaje = @mensaje output;


-- Ingresar planillas para la cédula 67890123 (año 2022)
exec usuarios.insertar_plantilla 
    @cedula = 67890123,
    @mes = 'Enero',
    @año = 2022,
    @fecha_pago = '2022-01-12',
    @h_normales = 160,
    @h_extras = 10,
    @mensaje = @mensaje output;

-- Ingresar planillas para la cédula 78901234 (año 2022)
exec usuarios.insertar_plantilla 
    @cedula = 78901234,
    @mes = 'Enero',
    @año = 2022,
    @fecha_pago = '2022-01-12',
    @h_normales = 160,
    @h_extras = 11,
    @mensaje = @mensaje output;

GO
declare @mensaje nvarchar(200); 
exec gestion_inventario.insertar_producto_y_registrar_movimiento @c_bodega = 'B001', @c_articulo = '001', @cantidad = 100, @n_factura = NULL, @usuario = 987654321, @bodega_origen = NULL, @bodega_destino = 'B001', @mensaje = @mensaje output; print @mensaje;
exec gestion_inventario.insertar_producto_y_registrar_movimiento @c_bodega = 'B002', @c_articulo = '002', @cantidad = 150, @n_factura = NULL, @usuario = 34567890, @bodega_origen = NULL, @bodega_destino = 'B002', @mensaje = @mensaje output; print @mensaje;
exec gestion_inventario.insertar_producto_y_registrar_movimiento @c_bodega = 'B003', @c_articulo = '003', @cantidad = 200, @n_factura = NULL, @usuario = 45678901, @bodega_origen = NULL, @bodega_destino = 'B003', @mensaje = @mensaje output; print @mensaje;
exec gestion_inventario.insertar_producto_y_registrar_movimiento @c_bodega = 'B004', @c_articulo = '004', @cantidad = 250, @n_factura = NULL, @usuario = 56789012, @bodega_origen = NULL, @bodega_destino = 'B004', @mensaje = @mensaje output; print @mensaje;
exec gestion_inventario.insertar_producto_y_registrar_movimiento @c_bodega = 'B005', @c_articulo = '005', @cantidad = 300, @n_factura = NULL, @usuario = 67890123, @bodega_origen = NULL, @bodega_destino = 'B005', @mensaje = @mensaje output; print @mensaje;
exec gestion_inventario.insertar_producto_y_registrar_movimiento @c_bodega = 'B001', @c_articulo = '006', @cantidad = 50, @n_factura = NULL, @usuario = 67890123, @bodega_origen = NULL, @bodega_destino = 'B001', @mensaje = @mensaje output; print @mensaje;
exec gestion_inventario.insertar_producto_y_registrar_movimiento @c_bodega = 'B002', @c_articulo = '007', @cantidad = 80, @n_factura = NULL, @usuario = 87654321, @bodega_origen = NULL, @bodega_destino = 'B002', @mensaje = @mensaje output; print @mensaje;
exec gestion_inventario.insertar_producto_y_registrar_movimiento @c_bodega = 'B003', @c_articulo = '008', @cantidad = 120, @n_factura = NULL, @usuario = 987654321, @bodega_origen = NULL, @bodega_destino = 'B003', @mensaje = @mensaje output; print @mensaje;





--------------------------insertar cotizaciones----------------------------
exec cotizaciones.insertar_cotizacion 951753852, 12345678, 'Noviembre', 80, 'Cotización de Venta', 'Compra de productos electrónicos', '2022-08-09', @mensaje;
exec cotizaciones.insertar_cotizacion 123456789, 45678901, 'Diciembre', 75, 'Cotización de Servicio', 'Servicios para el hogar', '2022-07-11', @mensaje;
exec cotizaciones.insertar_cotizacion 987654321, 12345678, 'Abril', 90, 'Cotización de Venta', 'Artículos para la cocina', '2022-02-09', @mensaje;
exec cotizaciones.insertar_cotizacion 123456789, 67890123, 'Mayo', 85, 'Cotización de Servicio', 'Catering para evento', '2022-02-09', @mensaje;
exec cotizaciones.insertar_cotizacion 654987321, 12345678, 'Junio', 70, 'Cotización de Servicio', 'Alquiler para fiesta', '2023-02-09', @mensaje;
exec cotizaciones.insertar_cotizacion 987654321, 23456789, 'Julio', 95, 'Cotización de Venta', 'Productos de oficina', '2023-07-11', @mensaje;
exec cotizaciones.insertar_cotizacion 123456789, 23456789, 'Agosto', 80, 'Cotización de Venta', 'Compra de herramientas', '2023-08-02', @mensaje;
exec cotizaciones.insertar_cotizacion 321654987, 45678901, 'Septiembre', 90, 'Cotización de Venta', 'Productos para el hogar', '2023-09-15', @mensaje;
exec cotizaciones.insertar_cotizacion 789654123, 23456789, 'Octubre', 85, 'Cotización de Venta', 'Accesorios para el hogar', '2023-10-10', @mensaje;
exec cotizaciones.insertar_cotizacion 321654987, 45678901, 'Julio', 60, 'Cotización de Servicio', 'Servicio de transporte para evento', '2023-07-20', @mensaje;
exec cotizaciones.insertar_cotizacion 123456789, 23456789, 'Noviembre', 92, 'Cotización de Venta', 'Suministros de oficina', '2023-11-05', @mensaje;
exec cotizaciones.insertar_cotizacion 951753852, 12345678, 'Noviembre', 75, 'Cotización de Servicio', 'Instalación de sistemas de seguridad', '2023-11-07', @mensaje;
exec cotizaciones.insertar_cotizacion 321654987, 23456789, 'Noviembre', 88, 'Cotización de Venta', 'Mobiliario de oficina', '2023-11-12', @mensaje;
exec cotizaciones.insertar_cotizacion 654987321, 23456789, 'Octubre', 80, 'Cotización de Servicio', 'Asesoría empresarial', '2023-10-15', @mensaje;
exec cotizaciones.insertar_cotizacion 123456789, 67890123, 'Noviembre', 77, 'Cotización de Venta', 'Suministros de limpieza para empresa', '2023-11-17', @mensaje;
exec cotizaciones.insertar_cotizacion 951753852, 67890123, 'Noviembre', 68, 'Cotización de Servicio', 'Servicios de mantenimiento de equipos', '2023-11-20', @mensaje;
exec cotizaciones.insertar_cotizacion 123456789, 12345678, 'Octubre', 85, 'Cotización de Venta', 'Compra de productos tecnológicos', '2024-10-22', @mensaje;
exec cotizaciones.insertar_cotizacion 987654321, 87654321, 'Julio', 82, 'Cotización de Servicio', 'Servicios de reparación de electrodomésticos', '2024-07-25', @mensaje;
exec cotizaciones.insertar_cotizacion 987654321, 87654321, 'Diciembre', 91, 'Cotización de Venta', 'Venta de productos electrónicos', '2024-12-05', @mensaje;
exec cotizaciones.insertar_cotizacion 789654123, 12345678, 'Noviembre', 70, 'Cotización de Servicio', 'Alquiler de equipos para evento', '2024-11-22', @mensaje;
---
exec cotizaciones.insertar_cotizacion 951753852, 12345678, 'Noviembre', 80, 'Cotización de Venta', 'Compra de productos electrónicos', '2022-08-09', @mensaje;
exec cotizaciones.insertar_cotizacion 123456789, 45678901, 'Diciembre', 75, 'Cotización de Servicio', 'Servicios para el hogar', '2022-07-11', @mensaje;
exec cotizaciones.insertar_cotizacion 987654321, 12345678, 'Abril', 90, 'Cotización de Venta', 'Artículos para la cocina', '2022-02-09', @mensaje;
exec cotizaciones.insertar_cotizacion 123456789, 67890123, 'Mayo', 85, 'Cotización de Servicio', 'Catering para evento', '2022-02-09', @mensaje;
exec cotizaciones.insertar_cotizacion 654987321, 12345678, 'Junio', 70, 'Cotización de Servicio', 'Alquiler para fiesta', '2023-02-09', @mensaje;
exec cotizaciones.insertar_cotizacion 987654321, 23456789, 'Julio', 95, 'Cotización de Venta', 'Productos de oficina', '2023-07-11', @mensaje;
exec cotizaciones.insertar_cotizacion 123456789, 23456789, 'Agosto', 80, 'Cotización de Venta', 'Compra de herramientas', '2023-08-02', @mensaje;
exec cotizaciones.insertar_cotizacion 321654987, 45678901, 'Septiembre', 90, 'Cotización de Venta', 'Productos para el hogar', '2023-09-15', @mensaje;
exec cotizaciones.insertar_cotizacion 789654123, 23456789, 'Octubre', 85, 'Cotización de Venta', 'Accesorios para el hogar', '2023-10-10', @mensaje;
exec cotizaciones.insertar_cotizacion 321654987, 45678901, 'Julio', 60, 'Cotización de Servicio', 'Servicio de transporte para evento', '2023-07-20', @mensaje;
exec cotizaciones.insertar_cotizacion 123456789, 23456789, 'Noviembre', 92, 'Cotización de Venta', 'Suministros de oficina', '2023-11-05', @mensaje;
exec cotizaciones.insertar_cotizacion 951753852, 12345678, 'Noviembre', 75, 'Cotización de Servicio', 'Instalación de sistemas de seguridad', '2023-11-07', @mensaje;
exec cotizaciones.insertar_cotizacion 321654987, 23456789, 'Noviembre', 88, 'Cotización de Venta', 'Mobiliario de oficina', '2023-11-12', @mensaje;
exec cotizaciones.insertar_cotizacion 654987321, 23456789, 'Octubre', 80, 'Cotización de Servicio', 'Asesoría empresarial', '2023-10-15', @mensaje;
exec cotizaciones.insertar_cotizacion 123456789, 67890123, 'Noviembre', 77, 'Cotización de Venta', 'Suministros de limpieza para empresa', '2023-11-17', @mensaje;
exec cotizaciones.insertar_cotizacion 951753852, 67890123, 'Noviembre', 68, 'Cotización de Servicio', 'Servicios de mantenimiento de equipos', '2023-11-20', @mensaje;
exec cotizaciones.insertar_cotizacion 123456789, 12345678, 'Octubre', 85, 'Cotización de Venta', 'Compra de productos tecnológicos', '2024-10-22', @mensaje;
exec cotizaciones.insertar_cotizacion 987654321, 87654321, 'Julio', 82, 'Cotización de Servicio', 'Servicios de reparación de electrodomésticos', '2024-07-25', @mensaje;
exec cotizaciones.insertar_cotizacion 987654321, 87654321, 'Diciembre', 91, 'Cotización de Venta', 'Venta de productos electrónicos', '2024-12-05', @mensaje;
exec cotizaciones.insertar_cotizacion 789654123, 12345678, 'Noviembre', 70, 'Cotización de Servicio', 'Alquiler de equipos para evento', '2024-11-22', @mensaje;

-----------
exec cotizaciones.insertar_tarea 1, 'Revisar productos', 12345678, '2024-11-30', 'pendiente', '2022-08-09', @mensaje;
exec cotizaciones.insertar_tarea 2, 'Presupuesto mantenimiento', 23456789, '2024-11-25', 'en progreso', '2022-07-15', @mensaje;
exec cotizaciones.insertar_tarea 3, 'Buscar proveedores cocina', 34567890, '2024-12-01', 'pendiente', '2023-03-20', @mensaje;
exec cotizaciones.insertar_tarea 4, 'Propuesta catering evento', 45678901, '2024-11-28', 'en progreso', '2023-04-10', @mensaje;
exec cotizaciones.insertar_tarea 5, 'Actualizar cotización fiesta', 56789012, '2024-12-05', 'pendiente', '2023-05-01', @mensaje;
exec cotizaciones.insertar_tarea 6, 'Investigar productos oficina', 67890123, '2024-11-30', 'en progreso', '2023-06-18', @mensaje;
exec cotizaciones.insertar_tarea 7, 'Revisar herramientas', 87654321, '2024-11-27', 'pendiente', '2023-07-12', @mensaje;
exec cotizaciones.insertar_tarea 8, 'Proveedores hogar', 987654321, '2024-12-03', 'en progreso', '2023-08-10', @mensaje;
exec cotizaciones.insertar_tarea 9, 'Cotización accesorios oficina', 12345678, '2024-11-29', 'pendiente', '2023-09-05', @mensaje;
exec cotizaciones.insertar_tarea 10, 'Gestionar transporte', 23456789, '2024-11-25', 'en progreso', '2023-10-08', @mensaje;
exec cotizaciones.insertar_tarea 11, 'Propuesta suministros oficina', 34567890, '2024-11-30', 'pendiente', '2023-11-01', @mensaje;
exec cotizaciones.insertar_tarea 12, 'Revisar cotización seguridad', 45678901, '2024-12-02', 'en progreso', '2023-12-15', @mensaje;
exec cotizaciones.insertar_tarea 13, 'Propuesta mobiliario oficina', 56789012, '2024-12-04', 'pendiente', '2024-01-20', @mensaje;
exec cotizaciones.insertar_tarea 14, 'Asesoría empresarial', 67890123, '2024-11-30', 'en progreso', '2024-02-10', @mensaje;
exec cotizaciones.insertar_tarea 15, 'Actualizar cotización limpieza', 87654321, '2024-12-01', 'pendiente', '2024-03-05', @mensaje;
exec cotizaciones.insertar_tarea 16, 'Coordinar mantenimiento', 987654321, '2024-11-29', 'en progreso', '2024-04-15', @mensaje;
exec cotizaciones.insertar_tarea 17, 'Revisar cotización tecnología', 12345678, '2024-12-06', 'pendiente', '2024-05-20', @mensaje;
exec cotizaciones.insertar_tarea 18, 'Propuesta reparación electrodomésticos', 23456789, '2024-11-28', 'en progreso', '2024-06-01', @mensaje;
exec cotizaciones.insertar_tarea 19, 'Revisar cotización electrónica', 34567890, '2024-12-02', 'pendiente', '2024-07-10', @mensaje;
exec cotizaciones.insertar_tarea 20, 'Generar cotización alquiler', 45678901, '2024-11-30', 'en progreso', '2024-08-25', @mensaje;
---
exec cotizaciones.insertar_tarea 21, 'Revisar productos', 12345678, '2023-11-30', 'pendiente', '2022-08-09', @mensaje;
exec cotizaciones.insertar_tarea 22, 'Presupuesto mantenimiento', 23456789, '2023-11-25', 'en progreso', '2022-07-15', @mensaje;
exec cotizaciones.insertar_tarea 23, 'Buscar proveedores cocina', 34567890, '2023-12-01', 'pendiente', '2023-03-20', @mensaje;
exec cotizaciones.insertar_tarea 24, 'Propuesta catering evento', 45678901, '2023-11-28', 'en progreso', '2023-04-10', @mensaje;
exec cotizaciones.insertar_tarea 25, 'Actualizar cotización fiesta', 56789012, '2023-12-05', 'pendiente', '2023-05-01', @mensaje;
exec cotizaciones.insertar_tarea 26, 'Investigar productos oficina', 67890123, '2023-11-30', 'en progreso', '2023-06-18', @mensaje;
exec cotizaciones.insertar_tarea 27, 'Revisar herramientas', 87654321, '2023-11-27', 'pendiente', '2023-07-12', @mensaje;
exec cotizaciones.insertar_tarea 28, 'Proveedores hogar', 987654321, '2023-12-03', 'en progreso', '2023-08-10', @mensaje;
exec cotizaciones.insertar_tarea 29, 'Cotización accesorios oficina', 12345678, '2023-11-29', 'pendiente', '2023-09-05', @mensaje;
exec cotizaciones.insertar_tarea 31, 'Gestionar transporte', 23456789, '2023-11-25', 'en progreso', '2023-10-08', @mensaje;
exec cotizaciones.insertar_tarea 30, 'Propuesta suministros oficina', 34567890, '2023-11-30', 'pendiente', '2023-11-01', @mensaje;
exec cotizaciones.insertar_tarea 32, 'Revisar cotización seguridad', 45678901, '2023-12-02', 'en progreso', '2023-12-15', @mensaje;
exec cotizaciones.insertar_tarea 33, 'Propuesta mobiliario oficina', 56789012, '2023-12-04', 'pendiente', '2024-01-20', @mensaje;
exec cotizaciones.insertar_tarea 34, 'Asesoría empresarial', 67890123, '2023-11-30', 'en progreso', '2024-02-10', @mensaje;
exec cotizaciones.insertar_tarea 35, 'Actualizar cotización limpieza', 87654321, '2023-12-01', 'pendiente', '2024-03-05', @mensaje;
exec cotizaciones.insertar_tarea 36, 'Coordinar mantenimiento', 987654321, '2023-11-29', 'en progreso', '2024-04-15', @mensaje;
exec cotizaciones.insertar_tarea 37, 'Revisar cotización tecnología', 12345678, '2023-12-06', 'pendiente', '2024-05-20', @mensaje;
exec cotizaciones.insertar_tarea 38, 'Propuesta reparación electrodomésticos', 23456789, '2023-11-28', 'en progreso', '2024-06-01', @mensaje;
exec cotizaciones.insertar_tarea 39, 'Revisar cotización electrónica', 34567890, '2023-12-02', 'pendiente', '2024-07-10', @mensaje;
exec cotizaciones.insertar_tarea 40, 'Generar cotización alquiler', 45678901, '2023-11-30', 'en progreso', '2024-08-25', @mensaje;


----------------------------insertar productos cotizacion -------------------

-- Cotización 1
EXEC cotizaciones.insertar_articulo_cotizacion 1, '001', 5, 'B001', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 1, '003', 2, 'B001', @mensaje;

-- Cotización 2
EXEC cotizaciones.insertar_articulo_cotizacion 2, '002', 3, 'B001', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 2, '004', 4, 'B001', @mensaje;

-- Cotización 3
EXEC cotizaciones.insertar_articulo_cotizacion 3, '005', 6, 'B002', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 3, '007', 8, 'B003', @mensaje;

-- Cotización 4
EXEC cotizaciones.insertar_articulo_cotizacion 4, '006', 1, 'B002', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 4, '008', 4, 'B003', @mensaje;

-- Cotización 5
EXEC cotizaciones.insertar_articulo_cotizacion 5, '009', 10, 'B004', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 5, '010', 5, 'B004', @mensaje;

-- Cotización 6
EXEC cotizaciones.insertar_articulo_cotizacion 6, '011', 12, 'B005', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 6, '013', 3, 'B001', @mensaje;

-- Cotización 7
EXEC cotizaciones.insertar_articulo_cotizacion 7, '014', 4, 'B001', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 7, '015', 7, 'B002', @mensaje;

-- Cotización 8
EXEC cotizaciones.insertar_articulo_cotizacion 8, '016', 5, 'B002', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 8, '017', 8, 'B003', @mensaje;

-- Cotización 9
EXEC cotizaciones.insertar_articulo_cotizacion 9, '018', 6, 'B003', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 9, '019', 3, 'B004', @mensaje;

-- Cotización 10
EXEC cotizaciones.insertar_articulo_cotizacion 10, '020', 4, 'B004', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 10, '002', 2, 'B001', @mensaje;

-- Cotización 11
EXEC cotizaciones.insertar_articulo_cotizacion 11, '003', 5, 'B001', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 11, '005', 8, 'B002', @mensaje;

-- Cotización 12
EXEC cotizaciones.insertar_articulo_cotizacion 12, '006', 7, 'B002', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 12, '007', 6, 'B003', @mensaje;

-- Cotización 13
EXEC cotizaciones.insertar_articulo_cotizacion 13, '008', 4, 'B003', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 13, '009', 10, 'B004', @mensaje;

-- Cotización 14
EXEC cotizaciones.insertar_articulo_cotizacion 14, '010', 5, 'B004', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 14, '011', 12, 'B005', @mensaje;

-- Cotización 15
EXEC cotizaciones.insertar_articulo_cotizacion 15, '012', 3, 'B005', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 15, '013', 6, 'B001', @mensaje;

-- Cotización 16
EXEC cotizaciones.insertar_articulo_cotizacion 16, '014', 4, 'B001', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 16, '015', 5, 'B002', @mensaje;

-- Cotización 17
EXEC cotizaciones.insertar_articulo_cotizacion 17, '016', 7, 'B002', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 17, '017', 4, 'B003', @mensaje;

-- Cotización 18
EXEC cotizaciones.insertar_articulo_cotizacion 18, '018', 3, 'B003', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 18, '019', 10, 'B004', @mensaje;

-- Cotización 19
EXEC cotizaciones.insertar_articulo_cotizacion 19, '020', 2, 'B004', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 19, '002', 8, 'B001', @mensaje;

-- Cotización 20
EXEC cotizaciones.insertar_articulo_cotizacion 20, '003', 6, 'B001', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 20, '004', 4, 'B001', @mensaje;
-- Cotización 21
EXEC cotizaciones.insertar_articulo_cotizacion 21, '001', 5, 'B001', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 21, '003', 2, 'B001', @mensaje;

-- Cotización 22
EXEC cotizaciones.insertar_articulo_cotizacion 22, '002', 3, 'B001', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 22, '004', 4, 'B001', @mensaje;

-- Cotización 23
EXEC cotizaciones.insertar_articulo_cotizacion 23, '005', 6, 'B002', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 23, '007', 8, 'B003', @mensaje;

-- Cotización 24
EXEC cotizaciones.insertar_articulo_cotizacion 24, '006', 1, 'B002', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 24, '008', 4, 'B003', @mensaje;

-- Cotización 25
EXEC cotizaciones.insertar_articulo_cotizacion 25, '009', 10, 'B004', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 25, '010', 5, 'B004', @mensaje;

-- Cotización 26
EXEC cotizaciones.insertar_articulo_cotizacion 26, '011', 12, 'B005', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 26, '013', 3, 'B001', @mensaje;

-- Cotización 27
EXEC cotizaciones.insertar_articulo_cotizacion 27, '014', 4, 'B001', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 27, '015', 7, 'B002', @mensaje;

-- Cotización 28
EXEC cotizaciones.insertar_articulo_cotizacion 28, '016', 5, 'B002', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 28, '017', 8, 'B003', @mensaje;

-- Cotización 29
EXEC cotizaciones.insertar_articulo_cotizacion 29, '018', 6, 'B003', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 29, '019', 3, 'B004', @mensaje;

-- Cotización 30
EXEC cotizaciones.insertar_articulo_cotizacion 30, '020', 4, 'B004', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 30, '002', 2, 'B001', @mensaje;

-- Cotización 31
EXEC cotizaciones.insertar_articulo_cotizacion 31, '003', 5, 'B001', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 31, '005', 8, 'B002', @mensaje;

-- Cotización 32
EXEC cotizaciones.insertar_articulo_cotizacion 32, '006', 7, 'B002', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 32, '007', 6, 'B003', @mensaje;

-- Cotización 33
EXEC cotizaciones.insertar_articulo_cotizacion 33, '008', 4, 'B003', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 33, '009', 10, 'B004', @mensaje;

-- Cotización 34
EXEC cotizaciones.insertar_articulo_cotizacion 34, '010', 5, 'B004', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 34, '011', 12, 'B005', @mensaje;

-- Cotización 35
EXEC cotizaciones.insertar_articulo_cotizacion 35, '012', 3, 'B005', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 35, '013', 6, 'B001', @mensaje;

-- Cotización 36
EXEC cotizaciones.insertar_articulo_cotizacion 36, '014', 4, 'B001', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 36, '015', 5, 'B002', @mensaje;

-- Cotización 37
EXEC cotizaciones.insertar_articulo_cotizacion 37, '016', 7, 'B002', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 37, '017', 4, 'B003', @mensaje;

-- Cotización 38
EXEC cotizaciones.insertar_articulo_cotizacion 38, '018', 3, 'B003', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 38, '019', 10, 'B004', @mensaje;

-- Cotización 39
EXEC cotizaciones.insertar_articulo_cotizacion 39, '020', 2, 'B004', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 39, '002', 8, 'B001', @mensaje;

-- Cotización 40
EXEC cotizaciones.insertar_articulo_cotizacion 40, '003', 6, 'B001', @mensaje;
EXEC cotizaciones.insertar_articulo_cotizacion 40, '004', 4, 'B001', @mensaje;


------------------------inserts de casos de cotizaciones--------------------------------------------------
exec registro_caso.insertar_caso 12345678, 1, null, 'cotizacion 1', 'cliente 1', 'asunto 1', 'direccion 1', 'cliente interesado en obtener más detalles', 'abierto', 'tipo caso 1', 'alta', '2020-03-15';
exec registro_caso.insertar_caso 23456789, 2, null, 'cotizacion 2', 'cliente 2', 'asunto 2', 'direccion 2', 'cliente tiene preguntas sobre la cotización', 'abierto', 'tipo caso 2', 'alta', '2021-06-22';
exec registro_caso.insertar_caso 12345678, 3, null, 'cotizacion 3', 'cliente 3', 'asunto 3', 'direccion 3', 'cliente requiere más información sobre el servicio', 'abierto', 'tipo caso 3', 'media', '2022-01-14';
exec registro_caso.insertar_caso 34567890, 4, null, 'cotizacion 4', 'cliente 4', 'asunto 4', 'direccion 4', 'solicitud de información adicional sobre el producto', 'abierto', 'tipo caso 4', 'baja', '2021-09-05';
exec registro_caso.insertar_caso 45678901, 5, null, 'cotizacion 5', 'cliente 5', 'asunto 5', 'direccion 5', 'cliente tiene dudas sobre el precio', 'abierto', 'tipo caso 5', 'baja', '2023-03-18';
exec registro_caso.insertar_caso 56789012, 6, null, 'cotizacion 6', 'cliente 6', 'asunto 6', 'direccion 6', 'cliente consulta tiempos de entrega', 'abierto', 'tipo caso 6', 'media', '2022-11-29';
exec registro_caso.insertar_caso 67890123, 7, null, 'cotizacion 7', 'cliente 7', 'asunto 7', 'direccion 7', 'cliente revisando los detalles del contrato', 'abierto', 'tipo caso 7', 'alta', '2020-07-08';
exec registro_caso.insertar_caso 12345678, 8, null, 'cotizacion 8', 'cliente 8', 'asunto 8', 'direccion 8', 'cliente necesita reprogramar la entrega', 'abierto', 'tipo caso 8', 'alta', '2023-05-17';
exec registro_caso.insertar_caso 87654321, 9, null, 'cotizacion 9', 'cliente 9', 'asunto 9', 'direccion 9', 'cliente tiene preguntas sobre la cotización', 'abierto', 'tipo caso 9', 'baja', '2021-02-03';
exec registro_caso.insertar_caso 45678901, 10, null, 'cotizacion 10', 'cliente 10', 'asunto 10', 'direccion 10', 'cliente solicita cambios en los términos', 'abierto', 'tipo caso 10', 'baja', '2020-12-12';

exec registro_caso.insertar_caso 56789012, 11, null, 'cotizacion 11', 'cliente 11', 'asunto 11', 'direccion 11', 'cliente interesado en detalles del producto', 'abierto', 'tipo caso 11', 'media', '2023-06-21';
exec registro_caso.insertar_caso 67890123, 12, null, 'cotizacion 12', 'cliente 12', 'asunto 12', 'direccion 12', 'cliente solicita revisión de opciones', 'abierto', 'tipo caso 12', 'alta', '2023-09-30';
exec registro_caso.insertar_caso 12345678, 13, null, 'cotizacion 13', 'cliente 13', 'asunto 13', 'direccion 13', 'cliente requiere comparativa con otra cotización', 'abierto', 'tipo caso 13', 'baja', '2024-01-10';
exec registro_caso.insertar_caso 23456789, 14, null, 'cotizacion 14', 'cliente 14', 'asunto 14', 'direccion 14', 'cliente está esperando mejor precio', 'abierto', 'tipo caso 14', 'alta', '2024-03-20';
exec registro_caso.insertar_caso 34567890, 15, null, 'cotizacion 15', 'cliente 15', 'asunto 15', 'direccion 15', 'cliente consulta condiciones de pago', 'abierto', 'tipo caso 15', 'media', '2024-04-05';
exec registro_caso.insertar_caso 45678901, 16, null, 'cotizacion 16', 'cliente 16', 'asunto 16', 'direccion 16', 'cliente solicita entrega inmediata', 'abierto', 'tipo caso 16', 'baja', '2024-02-18';
exec registro_caso.insertar_caso 56789012, 17, null, 'cotizacion 17', 'cliente 17', 'asunto 17', 'direccion 17', 'cliente quiere modificar el alcance de la cotización', 'abierto', 'tipo caso 17', 'alta', '2024-01-30';
exec registro_caso.insertar_caso 67890123, 18, null, 'cotizacion 18', 'cliente 18', 'asunto 18', 'direccion 18', 'cliente tiene dudas sobre las condiciones de entrega', 'abierto', 'tipo caso 18', 'baja', '2024-03-10';
exec registro_caso.insertar_caso 12345678, 19, null, 'cotizacion 19', 'cliente 19', 'asunto 19', 'direccion 19', 'cliente solicita cambios en los términos de la oferta', 'abierto', 'tipo caso 19', 'alta', '2024-04-25';
exec registro_caso.insertar_caso 23456789, 20, null, 'cotizacion 20', 'cliente 20', 'asunto 20', 'direccion 20', 'cliente solicita nuevas opciones de financiamiento', 'abierto', 'tipo caso 20', 'media', '2024-05-14';

------------------------inserts de casos de facturas--------------------------------------------------
exec registro_caso.insertar_caso 12345678, null, 1, 'factura 1', 'cliente 1', 'asunto factura 1', 'direccion factura 1', 'cliente solicita información adicional sobre la factura', 'abierto', 'tipo caso factura', 'alta', '2019-04-25';
exec registro_caso.insertar_caso 23456789, null, 2, 'factura 2', 'cliente 2', 'asunto factura 2', 'direccion factura 2', 'cliente tiene dudas sobre los cargos', 'abierto', 'tipo caso factura', 'alta', '2020-08-16';
exec registro_caso.insertar_caso 34567890, null, 3, 'factura 3', 'cliente 3', 'asunto factura 3', 'direccion factura 3', 'cliente quiere discutir el método de pago', 'abierto', 'tipo caso factura', 'media', '2022-10-10';
exec registro_caso.insertar_caso 12345678, null, 5, 'factura 5', 'cliente 4', 'asunto factura 4', 'direccion factura 4', 'cliente requiere una aclaración de la fecha de vencimiento', 'abierto', 'tipo caso factura', 'baja', '2023-09-14';
exec registro_caso.insertar_caso 45678901, null, 4, 'factura 4', 'cliente 5', 'asunto factura 5', 'direccion factura 5', 'cliente consulta descuentos aplicados', 'abierto', 'tipo caso factura', 'baja', '2023-09-14';
exec registro_caso.insertar_caso 56789012, null, 7, 'factura 7', 'cliente 6', 'asunto factura 6', 'direccion factura 6', 'cliente solicita una copia de la factura', 'abierto', 'tipo caso factura', 'media', '2022-06-11';
exec registro_caso.insertar_caso 67890123, null, 6, 'factura 6', 'cliente 7', 'asunto factura 7', 'direccion factura 7', 'cliente tiene preguntas sobre el monto total', 'abierto', 'tipo caso factura', 'alta', '2021-12-20';
exec registro_caso.insertar_caso 12345678, null, 8, 'factura 8', 'cliente 8', 'asunto factura 8', 'direccion factura 8', 'cliente necesita corregir los datos de la factura', 'abierto', 'tipo caso factura', 'alta', '2020-05-28';
exec registro_caso.insertar_caso 87654321, null, 9, 'factura 9', 'cliente 9', 'asunto factura 9', 'direccion factura 9', 'cliente requiere una reimpresión de la factura', 'abierto', 'tipo caso factura', 'baja', '2019-11-09';
exec registro_caso.insertar_caso 45678901, null, 10, 'factura 10', 'cliente 10', 'asunto factura 10', 'direccion factura 10', 'cliente tiene dudas sobre los impuestos aplicados', 'abierto', 'tipo caso factura', 'baja', '2023-07-22';

exec registro_caso.insertar_caso 56789012, null, 11, 'factura 11', 'cliente 11', 'asunto factura 11', 'direccion factura 11', 'cliente desea una revisión del monto', 'abierto', 'tipo caso factura', 'media', '2023-07-19';
exec registro_caso.insertar_caso 67890123, null, 12, 'factura 12', 'cliente 12', 'asunto factura 12', 'direccion factura 12', 'cliente consulta un crédito para la factura', 'abierto', 'tipo caso factura', 'alta', '2023-11-05';
exec registro_caso.insertar_caso 12345678, null, 13, 'factura 13', 'cliente 13', 'asunto factura 13', 'direccion factura 13', 'cliente solicita la corrección de los detalles', 'abierto', 'tipo caso factura', 'baja', '2023-12-17';
exec registro_caso.insertar_caso 23456789, null, 14, 'factura 14', 'cliente 14', 'asunto factura 14', 'direccion factura 14', 'cliente pregunta por el desglose de la factura', 'abierto', 'tipo caso factura', 'alta', '2023-10-30';
exec registro_caso.insertar_caso 34567890, null, 15, 'factura 15', 'cliente 15', 'asunto factura 15', 'direccion factura 15', 'cliente solicita detalles sobre el monto de impuestos', 'abierto', 'tipo caso factura', 'media', '2024-01-05';
exec registro_caso.insertar_caso 45678901, null, 16, 'factura 16', 'cliente 16', 'asunto factura 16', 'direccion factura 16', 'cliente está revisando los términos', 'abierto', 'tipo caso factura', 'baja', '2024-02-23';
exec registro_caso.insertar_caso 56789012, null, 17, 'factura 17', 'cliente 17', 'asunto factura 17', 'direccion factura 17', 'cliente requiere más información sobre la factura', 'abierto', 'tipo caso factura', 'alta', '2024-03-15';
exec registro_caso.insertar_caso 67890123, null, 18, 'factura 18', 'cliente 18', 'asunto factura 18', 'direccion factura 18', 'cliente consulta opciones de pago', 'abierto', 'tipo caso factura', 'baja', '2024-01-25';
exec registro_caso.insertar_caso 12345678, null, 19, 'factura 19', 'cliente 19', 'asunto factura 19', 'direccion factura 19', 'cliente quiere recibir un desglose más detallado', 'abierto', 'tipo caso factura', 'alta', '2024-03-03';
exec registro_caso.insertar_caso 23456789, null, 20, 'factura 20', 'cliente 20', 'asunto factura 20', 'direccion factura 20', 'cliente requiere un cambio en la fecha de vencimiento', 'abierto', 'tipo caso factura', 'media', '2024-02-05';

-- Tareas para los casos de cotización------------------------------------------
exec registro_caso.insertar_tarea_caso 1, 12345678, 'Revisión de los detalles de la cotización para el cliente 1', '2023-01-05';
exec registro_caso.insertar_tarea_caso 2, 23456789, 'Respuesta a las dudas sobre la cotización del cliente 2', '2023-02-15';
exec registro_caso.insertar_tarea_caso 3, 34567890, 'Proporcionar más información sobre los servicios solicitados por el cliente 3', '2023-03-10';
exec registro_caso.insertar_tarea_caso 4, 45678901, 'Brindar información adicional sobre el producto para el cliente 4', '2023-04-18';
exec registro_caso.insertar_tarea_caso 5, 56789012, 'Explicar el precio de la cotización al cliente 5', '2023-05-12';
exec registro_caso.insertar_tarea_caso 6, 67890123, 'Responde consulta sobre tiempos de entrega para el cliente 6', '2023-06-20';
exec registro_caso.insertar_tarea_caso 7, 87654321, 'Revisar contrato con el cliente 7 en relación con la cotización', '2023-07-25';
exec registro_caso.insertar_tarea_caso 8, 12345678, 'Reprogramar la entrega de la cotización para el cliente 8', '2023-08-15';
exec registro_caso.insertar_tarea_caso 9, 23456789, 'Aclarar dudas adicionales sobre la cotización para el cliente 9', '2023-09-05';
exec registro_caso.insertar_tarea_caso 10, 34567890, 'Ajustar los términos de la cotización con el cliente 10', '2023-10-22';

exec registro_caso.insertar_tarea_caso 11, 45678901, 'Actualizar detalles del producto para el cliente 11', '2023-11-07';
exec registro_caso.insertar_tarea_caso 12, 56789012, 'Confirmar los términos de la cotización para el cliente 12', '2023-12-01';
exec registro_caso.insertar_tarea_caso 13, 67890123, 'Explicar el plan de pago al cliente 13', '2024-01-15';
exec registro_caso.insertar_tarea_caso 14, 87654321, 'Revisar presupuesto de cotización con el cliente 14', '2024-02-08';
exec registro_caso.insertar_tarea_caso 15, 12345678, 'Enviar detalles de la cotización por correo al cliente 15', '2024-03-03';
exec registro_caso.insertar_tarea_caso 16, 23456789, 'Revisar opciones adicionales para el cliente 16', '2024-04-18';
exec registro_caso.insertar_tarea_caso 17, 34567890, 'Confirmar cambios en la cotización con el cliente 17', '2024-05-02';
exec registro_caso.insertar_tarea_caso 18, 45678901, 'Confirmar fecha de entrega con el cliente 18', '2024-06-15';
exec registro_caso.insertar_tarea_caso 19, 56789012, 'Aclarar condiciones de pago con el cliente 19', '2024-07-01';
exec registro_caso.insertar_tarea_caso 20, 67890123, 'Confirmar detalles finales con el cliente 20', '2024-08-10';

-- Tareas para los casos de facturas--------------------------------------------------
exec registro_caso.insertar_tarea_caso 21, 23456789, 'Resolver dudas sobre los cargos en la factura del cliente 2', '2023-02-20';
exec registro_caso.insertar_tarea_caso 22, 34567890, 'Discutir el método de pago de la factura con el cliente 3', '2023-03-25';
exec registro_caso.insertar_tarea_caso 23, 45678901, 'Aclarar la fecha de vencimiento de la factura con el cliente 4', '2023-04-14';
exec registro_caso.insertar_tarea_caso 24, 56789012, 'Revisar los descuentos aplicados en la factura del cliente 5', '2023-05-30';
exec registro_caso.insertar_tarea_caso 25, 67890123, 'Proporcionar una copia de la factura al cliente 6', '2023-06-08';
exec registro_caso.insertar_tarea_caso 26, 87654321, 'Responder preguntas sobre el monto total de la factura del cliente 7', '2023-07-15';
exec registro_caso.insertar_tarea_caso 27, 12345678, 'Corregir los datos de la factura para el cliente 8', '2023-08-23';
exec registro_caso.insertar_tarea_caso 28, 23456789, 'Reimprimir la factura solicitada por el cliente 9', '2023-09-10';
exec registro_caso.insertar_tarea_caso 29, 34567890, 'Aclarar las dudas sobre los impuestos aplicados en la factura del cliente 10', '2023-10-28';
exec registro_caso.insertar_tarea_caso 30, 45678901, 'Confirmar el pago de la factura del cliente 11', '2023-11-15';
exec registro_caso.insertar_tarea_caso 31, 56789012, 'Verificar el estatus de la factura pendiente del cliente 12', '2023-12-01';
exec registro_caso.insertar_tarea_caso 32, 67890123, 'Aclarar cargos adicionales en la factura con el cliente 13', '2024-01-10';
exec registro_caso.insertar_tarea_caso 33, 87654321, 'Verificar si la factura ha sido procesada correctamente con el cliente 14', '2024-02-18';
exec registro_caso.insertar_tarea_caso 34, 12345678, 'Actualizar los datos de la factura para el cliente 15', '2024-03-03';
exec registro_caso.insertar_tarea_caso 35, 23456789, 'Enviar un resumen de los cargos de la factura al cliente 16', '2024-04-10';
exec registro_caso.insertar_tarea_caso 36, 34567890, 'Confirmar las condiciones de pago de la factura con el cliente 17', '2024-05-02';
exec registro_caso.insertar_tarea_caso 37, 45678901, 'Revisar la factura por cargos erróneos con el cliente 18', '2024-06-15';
exec registro_caso.insertar_tarea_caso 38, 56789012, 'Aclarar el importe final de la factura con el cliente 19', '2024-07-01';
exec registro_caso.insertar_tarea_caso 39, 67890123, 'Confirmar que todos los pagos han sido aplicados correctamente en la factura del cliente 20', '2024-08-12';
exec registro_caso.insertar_tarea_caso 40, 87654321, 'Verificar la validez de la factura con el cliente 21', '2024-09-25';
