
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

-- Inserciones para la tabla bodegas
insert into gestion_inventario.bodegas (c_bodega, nombre, ubicacion, c_toneladas, e_cubico) 
values
('B001', 'Bodega Principal', 'San José', 100, 2000),
('B002', 'Bodega 2', 'Heredia', 80, 1600),
('B003', 'Bodega 3', 'limon', 60, 1200),
('B004', 'Bodega 4', 'Alajuela', 50, 1000),
('B005', 'Bodega 5', 'limon', 40, 800);

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
insert into gestion_inventario.inventario (c_bodega, c_articulo, cantidad) 
values
('B001', '001', 500),
('B001', '002', 200),
('B001', '003', 100),
('B001', '004', 150),
('B002', '005', 250),
('B002', '006', 50),
('B003', '007', 300),
('B003', '008', 400),
('B004', '009', 500),
('B004', '010', 350),
('B005', '011', 200),
('B005', '012', 150),
('B001', '013', 600),
('B001', '014', 450),
('B002', '015', 700),
('B002', '016', 500),
('B003', '017', 100),
('B003', '018', 120),
('B004', '019', 80),
('B004', '020', 150);

