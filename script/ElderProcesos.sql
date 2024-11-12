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
declare @mensaje nvarchar(200);

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


---pLANILLAS 

declare @mensaje nvarchar(200);

-- Ejemplo de plantilla 1
exec usuarios.insertar_plantilla2
    @cedula = 12345678,
    @mes = 'Enero',
    @año = 2024,
    @h_normales = 160,
    @h_extras = 10,
    @mensaje = @mensaje output;
select @mensaje as MensajeResultado;
declare @mensaje nvarchar(200);

-- Plantillas para el empleado 12345678
exec usuarios.insertar_plantilla2
    @cedula = 12345678,
    @mes = 'Enero',
    @año = 2024,
    @h_normales = 160,
    @h_extras = 10,
    @mensaje = @mensaje output;
select @mensaje as MensajeResultado;

exec usuarios.insertar_plantilla2
    @cedula = 12345678,
    @mes = 'Febrero',
    @año = 2024,
    @h_normales = 155,
    @h_extras = 12,
    @mensaje = @mensaje output;
select @mensaje as MensajeResultado;

exec usuarios.insertar_plantilla2
    @cedula = 12345678,
    @mes = 'Marzo',
    @año = 2024,
    @h_normales = 162,
    @h_extras = 8,
    @mensaje = @mensaje output;
select @mensaje as MensajeResultado;

-- Plantillas para el empleado 87654321
exec usuarios.insertar_plantilla2
    @cedula = 87654321,
    @mes = 'Enero',
    @año = 2024,
    @h_normales = 150,
    @h_extras = 5,
    @mensaje = @mensaje output;
select @mensaje as MensajeResultado;

exec usuarios.insertar_plantilla2
    @cedula = 87654321,
    @mes = 'Febrero',
    @año = 2024,
    @h_normales = 160,
    @h_extras = 15,
    @mensaje = @mensaje output;
select @mensaje as MensajeResultado;

exec usuarios.insertar_plantilla2
    @cedula = 87654321,
    @mes = 'Marzo',
    @año = 2024,
    @h_normales = 155,
    @h_extras = 10,
    @mensaje = @mensaje output;
select @mensaje as MensajeResultado;

-- Plantillas para el empleado 23456789
exec usuarios.insertar_plantilla2
    @cedula = 23456789,
    @mes = 'Enero',
    @año = 2024,
    @h_normales = 165,
    @h_extras = 9,
    @mensaje = @mensaje output;
select @mensaje as MensajeResultado;

exec usuarios.insertar_plantilla2
    @cedula = 23456789,
    @mes = 'Febrero',
    @año = 2024,
    @h_normales = 170,
    @h_extras = 6,
    @mensaje = @mensaje output;
select @mensaje as MensajeResultado;

exec usuarios.insertar_plantilla2
    @cedula = 23456789,
    @mes = 'Marzo',
    @año = 2024,
    @h_normales = 160,
    @h_extras = 8,
    @mensaje = @mensaje output;
select @mensaje as MensajeResultado;

-- Plantillas para el empleado 34567890
exec usuarios.insertar_plantilla2
    @cedula = 34567890,
    @mes = 'Enero',
    @año = 2024,
    @h_normales = 158,
    @h_extras = 14,
    @mensaje = @mensaje output;
select @mensaje as MensajeResultado;

exec usuarios.insertar_plantilla2
    @cedula = 34567890,
    @mes = 'Febrero',
    @año = 2024,
    @h_normales = 160,
    @h_extras = 7,
    @mensaje = @mensaje output;
select @mensaje as MensajeResultado;

exec usuarios.insertar_plantilla2
    @cedula = 34567890,
    @mes = 'Marzo',
    @año = 2024,
    @h_normales = 155,
    @h_extras = 12,
    @mensaje = @mensaje output;
select @mensaje as MensajeResultado;

-- Plantillas para el empleado 45678901
exec usuarios.insertar_plantilla2
    @cedula = 45678901,
    @mes = 'Enero',
    @año = 2024,
    @h_normales = 160,
    @h_extras = 10,
    @mensaje = @mensaje output;
select @mensaje as MensajeResultado;

exec usuarios.insertar_plantilla2
    @cedula = 45678901,
    @mes = 'Febrero',
    @año = 2024,
    @h_normales = 165,
    @h_extras = 11,
    @mensaje = @mensaje output;
select @mensaje as MensajeResultado;

exec usuarios.insertar_plantilla2
    @cedula = 45678901,
    @mes = 'Marzo',
    @año = 2024,
    @h_normales = 160,
    @h_extras = 5,
    @mensaje = @mensaje output;
select @mensaje as MensajeResultado;
