

use Planificador_recursos_empresariales
go

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

DECLARE @mensaje NVARCHAR(200);

EXEC usuarios.insertar_empleado
    @cedula = 123456789,
    @nombre = 'Pedro',
    @apellido1 = 'Ramírez',
    @apellido2 = 'González',
    @correo_electronico = 'pedro.ramirez@mail.com',
    @contraseña = 'feo1',
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
	
	
	





SELECT dbo.InicioValido(123456789, 'feo1') as ver 



SELECT * FROM usuarios.empleados

SELECT * FROM usuarios.PermisosMInventario

EXEC usuarios.InsertarPermisosCasos 'werg', 1, 0, 1;


SELECT * FROM cotizaciones.cotizaciones

SELECT * FROM cotizaciones.lista_articulos_cotizacion

SELECT * FROM cotizaciones.tareas