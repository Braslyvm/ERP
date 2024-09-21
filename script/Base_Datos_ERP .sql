
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'Planificador_recorsos_empresariales')
BEGIN
    CREATE DATABASE nombre_base_de_datos;
END;

use Planificador_recorsos_empresariales
go



