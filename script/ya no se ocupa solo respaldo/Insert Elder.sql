
use Planificador_recursos_empresariales
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

print @mensaje;



exec facturación.lineasfactura 
    @c_articulo = '001',
    @cantidad = 2, 
    @precio_unitario = 1, 
    @monto_total = 2, 
    @usuario = 1, 
    @mensaje = @mensaje output;

print @mensaje;
-- Producto 2: Yogur bajo en grasa (Código: '002')
exec facturación.lineasfactura 
    @c_articulo = '002',
    @cantidad = 3, 
    @precio_unitario = 2, 
    @monto_total = 6, 
    @usuario = 1, 
    @mensaje = @mensaje output;

print @mensaje;

-- Producto 3: Jugo de Naranja (Código: '003')
exec facturación.lineasfactura 
    @c_articulo = '003',
    @cantidad = 1, 
    @precio_unitario = 1, 
    @monto_total = 1, 
    @usuario = 1, 
    @mensaje = @mensaje output;

print @mensaje;



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

print @mensaje;

exec facturación.lineasfactura 
    @c_articulo = '004', 
    @cantidad = 2, 
    @precio_unitario = 3, 
    @monto_total = 6, 
    @usuario = 1, 
    @mensaje = @mensaje output;

print @mensaje;

exec facturación.lineasfactura 
    @c_articulo = '005', 
    @cantidad = 4, 
    @precio_unitario = 1, 
    @monto_total = 4, 
    @usuario = 1, 
    @mensaje = @mensaje output;

print @mensaje;
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

print @mensaje;

exec facturación.lineasfactura 
    @c_articulo = '006', 
    @cantidad = 1, 
    @precio_unitario = 15, 
    @monto_total = 15, 
    @usuario = 1, 
    @mensaje = @mensaje output;

print @mensaje;

exec facturación.lineasfactura 
    @c_articulo = '007', 
    @cantidad = 5, 
    @precio_unitario = 4, 
    @monto_total = 20, 
    @usuario = 1, 
    @mensaje = @mensaje output;

print @mensaje;


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

	print @mensaje;

exec facturación.lineasfactura 
    @c_articulo = '010', 
    @cantidad = 3, 
    @precio_unitario = 5, 
    @monto_total = 15, 
    @usuario = 1, 
    @mensaje = @mensaje output;

print @mensaje;

exec facturación.lineasfactura 
    @c_articulo = '011', 
    @cantidad = 2, 
    @precio_unitario = 6, 
    @monto_total = 12, 
    @usuario = 1, 
    @mensaje = @mensaje output;

print @mensaje;

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

	print @mensaje;


exec facturación.lineasfactura 
    @c_articulo = '015', 
    @cantidad = 10, 
    @precio_unitario = 1, 
    @monto_total = 10, 
    @usuario = 1, 
    @mensaje = @mensaje output;

print @mensaje;

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

	print @mensaje;

exec facturación.lineasfactura 
    @c_articulo = '017', 
    @cantidad = 3, 
    @precio_unitario = 3, 
    @monto_total = 9, 
    @usuario = 1, 
    @mensaje = @mensaje output;

print @mensaje;

exec facturación.lineasfactura 
    @c_articulo = '020', 
    @cantidad = 4, 
    @precio_unitario = 2, 
    @monto_total = 8, 
    @usuario = 1, 
    @mensaje = @mensaje output;

print @mensaje;

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

	print @mensaje;

exec facturación.lineasfactura 
    @c_articulo = '001', 
    @cantidad = 3, 
    @precio_unitario = 1, 
    @monto_total = 3, 
    @usuario = 1, 
    @mensaje = @mensaje output;

print @mensaje;







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

	print @mensaje;

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

PRINT @mensaje;

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

	print @mensaje;


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

PRINT @mensaje;

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

	print @mensaje;


EXEC facturación.lineasfactura 
    @c_articulo = '007', 
    @cantidad = 4, 
    @precio_unitario = 4, 
    @monto_total = 16, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;

PRINT @mensaje;

EXEC facturación.lineasfactura 
    @c_articulo = '012', 
    @cantidad = 2, 
    @precio_unitario = 3, 
    @monto_total = 6, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;

PRINT @mensaje;

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

	print @mensaje;

EXEC facturación.lineasfactura 
    @c_articulo = '010', 
    @cantidad = 3, 
    @precio_unitario = 5, 
    @monto_total = 15, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;

PRINT @mensaje;

EXEC facturación.lineasfactura 
    @c_articulo = '016', 
    @cantidad = 2, 
    @precio_unitario = 1, 
    @monto_total = 2, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;

PRINT @mensaje;







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

	print @mensaje;

EXEC facturación.lineasfactura 
    @c_articulo = '014', 
    @cantidad = 5, 
    @precio_unitario = 2, 
    @monto_total = 10, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;

PRINT @mensaje;

EXEC facturación.lineasfactura 
    @c_articulo = '009', 
    @cantidad = 2, 
    @precio_unitario = 7, 
    @monto_total = 14, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;

PRINT @mensaje;

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

	print @mensaje;


EXEC facturación.lineasfactura 
    @c_articulo = '017', 
    @cantidad = 6, 
    @precio_unitario = 3, 
    @monto_total = 18, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;

PRINT @mensaje;

EXEC facturación.lineasfactura 
    @c_articulo = '011', 
    @cantidad = 3, 
    @precio_unitario = 6, 
    @monto_total = 18, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;

PRINT @mensaje;

-- Factura 13
PRINT 'Factura 13: ';
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

	print @mensaje;
EXEC facturación.lineasfactura 
    @c_articulo = '003', 
    @cantidad = 4, 
    @precio_unitario = 1, 
    @monto_total = 4, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;

PRINT @mensaje;

EXEC facturación.lineasfactura 
    @c_articulo = '019', 
    @cantidad = 1, 
    @precio_unitario = 7, 
    @monto_total = 7, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;

PRINT @mensaje;

-- Factura 14
PRINT 'Factura 14: ';
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

	print @mensaje;

EXEC facturación.lineasfactura 
    @c_articulo = '004', 
    @cantidad = 2, 
    @precio_unitario = 3, 
    @monto_total = 6, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;

PRINT @mensaje;

EXEC facturación.lineasfactura 
    @c_articulo = '018', 
    @cantidad = 2, 
    @precio_unitario = 4, 
    @monto_total = 8, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;

PRINT @mensaje;


-- Factura 15
PRINT 'Factura 15: ';
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

	print @mensaje;
EXEC facturación.lineasfactura 
    @c_articulo = '010', 
    @cantidad = 3, 
    @precio_unitario = 5, 
    @monto_total = 15, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;

PRINT @mensaje;

EXEC facturación.lineasfactura 
    @c_articulo = '013', 
    @cantidad = 1, 
    @precio_unitario = 4, 
    @monto_total = 4, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;

PRINT @mensaje;

-- Factura 16
PRINT 'Factura 16: ';
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

	print @mensaje;

EXEC facturación.lineasfactura 
    @c_articulo = '007', 
    @cantidad = 4, 
    @precio_unitario = 4, 
    @monto_total = 18, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;

PRINT @mensaje;

EXEC facturación.lineasfactura 
    @c_articulo = '016', 
    @cantidad = 5, 
    @precio_unitario = 1, 
    @monto_total = 5, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;

PRINT @mensaje;

-- Factura 17
PRINT 'Factura 17: ';
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

	print @mensaje;

EXEC facturación.lineasfactura 
    @c_articulo = '015', 
    @cantidad = 10, 
    @precio_unitario = 1, 
    @monto_total = 10, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;

PRINT @mensaje;

EXEC facturación.lineasfactura 
    @c_articulo = '002', 
    @cantidad = 3, 
    @precio_unitario = 2, 
    @monto_total = 6, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;

PRINT @mensaje;

-- Factura 18
PRINT 'Factura 18: ';
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

	print @mensaje;
EXEC facturación.lineasfactura 
    @c_articulo = '006', 
    @cantidad = 1, 
    @precio_unitario = 15, 
    @monto_total = 15, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;

PRINT @mensaje;

EXEC facturación.lineasfactura 
    @c_articulo = '018', 
    @cantidad = 4, 
    @precio_unitario = 4, 
    @monto_total = 18, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;

PRINT @mensaje;

-- Factura 19
PRINT 'Factura 19: ';
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

	print @mensaje;
EXEC facturación.lineasfactura 
    @c_articulo = '003', 
    @cantidad = 8, 
    @precio_unitario = 1, 
    @monto_total = 8, 
    @usuario = 1, 
    @mensaje = @mensaje OUTPUT;

PRINT @mensaje;

EXEC facturación.lineasfactura 
    @c_articulo = '001', 
    @cantidad = 5, 
    @precio_unitario = 1, 
    @monto_total = 5, 
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
print @mensaje;
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
print @mensaje;

-- Ejemplo de ejecución del procedimiento con cédulas proporcionadas

-- Cedula: 12345678
go
declare @mensaje nvarchar(200);
exec usuarios.insertar_plantilla 
    @cedula = 12345678,
    @mes = 'Junio',
    @año = 2022,
    @fecha_pago  = '2022-6-12',
    @h_normales = 160,
    @h_extras = 10,
    @mensaje = @mensaje output;
print @mensaje;

-- Cedula: 23456789
go
declare @mensaje nvarchar(200);
exec usuarios.insertar_plantilla 
    @cedula = 23456789,
    @mes = 'Marzo',
    @año = 2023,
    @fecha_pago  = '2023-3-12',
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
     @fecha_pago  = '2023-3-12',
    @h_normales = 160,
    @h_extras = 12,
    @mensaje = @mensaje output;
print @mensaje;

-- Cedula: 45678901
exec usuarios.insertar_plantilla 
    @cedula = 45678901,
    @mes = 'Abril',
    @año = 2023,
    @fecha_pago  = '2023-4-12',
    @h_normales = 160,
    @h_extras = 8,
    @mensaje = @mensaje output;
print @mensaje;

-- Cedula: 56789012
exec usuarios.insertar_plantilla 
    @cedula = 56789012,
    @mes = 'Mayo',
    @año = 2023,
    @fecha_pago  = '2023-5-12',
    @h_normales = 160,
    @h_extras = 20,
    @mensaje = @mensaje output;
print @mensaje;

-- Cedula: 67890123
exec usuarios.insertar_plantilla 
    @cedula = 67890123,
    @mes = 'Junio',
    @año = 2023,
    @fecha_pago  = '2023-6-12',
    @h_normales = 160,
    @h_extras = 5,
    @mensaje = @mensaje output;
print @mensaje;

-- Cedula: 87654321
exec usuarios.insertar_plantilla 
    @cedula = 87654321,
    @mes = 'Julio',
    @año = 2023,
     @fecha_pago  = '2023-7-12',
    @h_normales = 160,
    @h_extras = 18,
    @mensaje = @mensaje output;
print @mensaje;

-- Cedula: 987654321
exec usuarios.insertar_plantilla 
    @cedula = 987654321,
    @mes = 'Agosto',
    @año = 2023,
     @fecha_pago  = '2023-8-12',
    @h_normales = 160,
    @h_extras = 22,
    @mensaje = @mensaje output;
print @mensaje;


go

-- Cedula: 12345678 - Enero 2022
declare @mensaje nvarchar(200);
exec usuarios.insertar_plantilla 
    @cedula = 12345678,
    @mes = 'Febrero',
    @año = 2024,
    @fecha_pago  = '2024-2-12',
    @h_normales = 160,
    @h_extras = 5,
    @mensaje = @mensaje output;
print @mensaje;

-- Cedula: 23456789 - Febrero 2022
exec usuarios.insertar_plantilla 
    @cedula = 23456789,
    @mes = 'Febrero',
    @año = 2024,
     @fecha_pago  = '2024-2-12',
    @h_normales = 150,
    @h_extras = 10,
    @mensaje = @mensaje output;
print @mensaje;

-- Cedula: 34567890 - Marzo 2022
exec usuarios.insertar_plantilla 
    @cedula = 34567890,
    @mes = 'Marzo',
    @año = 2024,
    @fecha_pago  = '2024-3-12',
    @h_normales = 160,
    @h_extras = 15,
    @mensaje = @mensaje output;
print @mensaje;

-- Cedula: 45678901 - Abril 2023
exec usuarios.insertar_plantilla 
    @cedula = 45678901,
    @mes = 'Mayo',
    @año = 2023,
    @fecha_pago  = '2023-5-12',
    @h_normales = 160,
    @h_extras = 20,
    @mensaje = @mensaje output;
print @mensaje;

-- Cedula: 56789012 - Mayo 2023
exec usuarios.insertar_plantilla 
    @cedula = 56789012,
    @mes = 'Mayo',
    @año = 2023,
     @fecha_pago  = '2023-5-12',
    @h_normales = 155,
    @h_extras = 12,
    @mensaje = @mensaje output;
print @mensaje;

-- Cedula: 67890123 - Junio 2023
exec usuarios.insertar_plantilla 
    @cedula = 67890123,
    @mes = 'Junio',
    @año = 2023,
    @fecha_pago  = '2023-6-12',
    @h_normales = 160,
    @h_extras = 18,
    @mensaje = @mensaje output;
print @mensaje;

-- Cedula: 87654321 - Julio 2024
exec usuarios.insertar_plantilla 
    @cedula = 87654321,
    @mes = 'Julio',
    @año = 2024,
      @fecha_pago  = '2024-7-12',
    @h_normales = 160,
    @h_extras = 10,
    @mensaje = @mensaje output;
print @mensaje;

-- Cedula: 987654321 - Agosto 2024
exec usuarios.insertar_plantilla 
    @cedula = 987654321,
    @mes = 'Agosto',
    @año = 2024,
      @fecha_pago  = '2024-5-12',
    @h_normales = 160,
    @h_extras = 25,
    @mensaje = @mensaje output;
print @mensaje;

-- Cedula: 12345678 - Septiembre 2024
exec usuarios.insertar_plantilla 
    @cedula = 12345678,
    @mes = 'Septiembre',
    @año = 2024,
  @fecha_pago  = '2024-9-12',
    @h_normales = 150,
    @h_extras = 8,
    @mensaje = @mensaje output;
print @mensaje;

-- Cedula: 23456789 - Octubre 2024
exec usuarios.insertar_plantilla 
    @cedula = 23456789,
    @mes = 'Octubre',
    @año = 2024,
     @fecha_pago  = '2024-10-12',
    @h_normales = 160,
    @h_extras = 10,
    @mensaje = @mensaje output;
print @mensaje;


go 

declare @mensaje nvarchar(200); 
exec gestion_inventario.insertar_producto_y_registrar_movimiento @c_bodega = 'B001', @c_articulo = '001', @cantidad = 100, @n_factura = NULL, @usuario = 987654321, @bodega_origen = NULL, @bodega_destino = 'B001', @mensaje = @mensaje output; print @mensaje;
exec gestion_inventario.insertar_producto_y_registrar_movimiento @c_bodega = 'B002', @c_articulo = '002', @cantidad = 150, @n_factura = NULL, @usuario = 34567890, @bodega_origen = NULL, @bodega_destino = 'B002', @mensaje = @mensaje output; print @mensaje;
 exec gestion_inventario.insertar_producto_y_registrar_movimiento @c_bodega = 'B003', @c_articulo = '003', @cantidad = 200, @n_factura = NULL, @usuario = 45678901, @bodega_origen = NULL, @bodega_destino = 'B003', @mensaje = @mensaje output; print @mensaje;
 exec gestion_inventario.insertar_producto_y_registrar_movimiento @c_bodega = 'B004', @c_articulo = '004', @cantidad = 250, @n_factura = NULL, @usuario = 56789012, @bodega_origen = NULL, @bodega_destino = 'B004', @mensaje = @mensaje output; print @mensaje;
 exec gestion_inventario.insertar_producto_y_registrar_movimiento @c_bodega = 'B005', @c_articulo = '005', @cantidad = 300, @n_factura = NULL, @usuario = 67890123, @bodega_origen = NULL, @bodega_destino = 'B005', @mensaje = @mensaje output; print @mensaje;
 exec gestion_inventario.insertar_producto_y_registrar_movimiento @c_bodega = 'B001', @c_articulo = '006', @cantidad = 50, @n_factura = NULL, @usuario = 67890123, @bodega_origen = NULL, @bodega_destino = 'B001', @mensaje = @mensaje output; print @mensaje;
 exec gestion_inventario.insertar_producto_y_registrar_movimiento @c_bodega = 'B002', @c_articulo = '007', @cantidad = 80, @n_factura = NULL, @usuario = 87654321, @bodega_origen = NULL, @bodega_destino = 'B002', @mensaje = @mensaje output; print @mensaje;
 exec gestion_inventario.insertar_producto_y_registrar_movimiento @c_bodega = 'B003', @c_articulo = '008', @cantidad = 120, @n_factura = NULL, @usuario = 987654321, @bodega_origen = NULL, @bodega_destino = 'B003', @mensaje = @mensaje output; print @mensaje;
