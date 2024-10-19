
use Planificador_recursos_empresariales
go


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
