
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


