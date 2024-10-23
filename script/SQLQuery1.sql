

use Planificador_recursos_empresariales
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
    @rol = 'rol',  -- el rol que solicitaste
    @mensaje = @mensaje OUTPUT;
	
	
	



EXEC  CrearRol 'rol' , 1
go

EXEC usuarios.InsertarPermisosInventario 'rol' , 1 , 1, 1
go

EXEC usuarios.InsertarPermisosUsuarios 'rol' , 1 , 1, 1


EXEC usuarios.InsertarPermisosCotizaciones 'rol' , 1 , 1, 1
go

EXEC usuarios.InsertarPermisosFacturas 'rol' , 1 , 1, 1
go

EXEC usuarios.InsertarPermisosVentas 'rol' , 1, 1, 1
go

EXEC usuarios.InsertarPermisosClientes 'rol' , 1, 1, 1
go

EXEC usuarios.InsertarPermisosReportes 'rol' , 1 , 1, 1
go

SELECT dbo.InicioValido(123456789, 'feo1') as ver 



SELECT * FROM usuarios.roles

SELECT * FROM usuarios.PermisosMInventario

EXEC usuarios.InsertarPermisosCasos 'werg', 1, 0, 1;