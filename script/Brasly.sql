

-----------------------------retorna el top 15 tareas -----------------------------------------
create function cotizaciones.top15_tareas()
returns table
as
return
(
    select top 15 
        id_tarea,
        id_cotizacion,
        descripcion,
        usuario,
        fecha_inicio,
        fecha_limite,
        estado
    from cotizaciones.tareas
    where estado = 'completada' or estado = 'en progreso'
    order by 
        fecha_inicio asc
);
go


-----------------------------------Top 10 de clientes con mayores ventas-------------------------------
create function dbo.top_clientes()
returns table
as
return
(
    select top 10 
        c.nombre as cliente,
        sum(v.monto) as monto_total_ventas
    from clientes.cliente c
    inner join ventas v on c.clienteid = v.clienteid
    group by c.nombre
    order by monto_total_ventas desc
);
go

-----------------------------------Cantidad de clientes por zona y monto ventas por zona------------------------
create function cantidad_clientes_y_ventas_por_zona()
returns table
as
return
(
    select c.zona as zona,
        count(distinct c.clienteid) as cantidad_clientes,
        sum(v.monto) as monto_total_ventas
    from clientes c
    left join ventas v on c.clienteid = v.clienteid
    group by c.zona
    order by monto_total_ventas desc
);
go

use Planificador_recursos_empresariales
go
--------------------------insertar cotizaciones----------------------------


declare @mensaje nvarchar(200);
exec cotizaciones.insertar_cotizacion 951753852, 12345678, 'Noviembre', 80, 'Cotización de Venta', 'Compra de productos electrónicos', @mensaje;
exec cotizaciones.insertar_cotizacion 123456789, 45678901, 'Diciembre', 75, 'Cotización de Servicio', 'Servicios para el hogar', @mensaje;
exec cotizaciones.insertar_cotizacion 987654321, 12345678, 'Abril', 90, 'Cotización de Venta', 'Artículos para la cocina', @mensaje;
exec cotizaciones.insertar_cotizacion 123456789, 67890123, 'Mayo', 85, 'Cotización de Servicio', 'Catering para evento', @mensaje;
exec cotizaciones.insertar_cotizacion 654987321, 12345678, 'Junio', 70, 'Cotización de Servicio', 'Alquiler para fiesta', @mensaje;
exec cotizaciones.insertar_cotizacion 987654321, 23456789, 'Julio', 95, 'Cotización de Venta', 'Productos de oficina', @mensaje;
exec cotizaciones.insertar_cotizacion 123456789, 23456789, 'Agosto', 80, 'Cotización de Venta', 'Compra de herramientas', @mensaje;
exec cotizaciones.insertar_cotizacion 321654987, 45678901, 'Septiembre', 90, 'Cotización de Venta', 'Productos para el hogar', @mensaje;
exec cotizaciones.insertar_cotizacion 789654123, 23456789, 'Octubre', 85, 'Cotización de Venta', 'Accesorios para el hogar', @mensaje;
exec cotizaciones.insertar_cotizacion 321654987, 45678901, 'Julio', 60, 'Cotización de Servicio', 'Servicio de transporte para evento', @mensaje;
exec cotizaciones.insertar_cotizacion 123456789, 23456789, 'Noviembre', 92, 'Cotización de Venta', 'Suministros de oficina', @mensaje;
exec cotizaciones.insertar_cotizacion 951753852, 12345678, 'Noviembre', 75, 'Cotización de Servicio', 'Instalación de sistemas de seguridad', @mensaje;
exec cotizaciones.insertar_cotizacion 321654987, 23456789, 'Noviembre', 88, 'Cotización de Venta', 'Mobiliario de oficina', @mensaje;
exec cotizaciones.insertar_cotizacion 654987321, 23456789, 'Octubre', 80, 'Cotización de Servicio', 'Asesoría empresarial', @mensaje;
exec cotizaciones.insertar_cotizacion 123456789, 67890123, 'Noviembre', 77, 'Cotización de Venta', 'Suministros de limpieza para empresa', @mensaje;
exec cotizaciones.insertar_cotizacion 951753852, 67890123, 'Noviembre', 68, 'Cotización de Servicio', 'Servicios de mantenimiento de equipos', @mensaje;
exec cotizaciones.insertar_cotizacion 123456789, 12345678, 'Octubre', 85, 'Cotización de Venta', 'Compra de productos tecnológicos', @mensaje;
exec cotizaciones.insertar_cotizacion 987654321, 87654321, 'Julio', 82, 'Cotización de Servicio', 'Servicios de reparación de electrodomésticos', @mensaje;
exec cotizaciones.insertar_cotizacion 987654321, 87654321, 'Diciembre', 91, 'Cotización de Venta', 'Venta de productos electrónicos', @mensaje;
exec cotizaciones.insertar_cotizacion 789654123, 12345678, 'Noviembre', 70, 'Cotización de Servicio', 'Alquiler de equipos para evento', @mensaje;


exec cotizaciones.insertar_tarea 1, 'Revisar productos', 12345678, '2024-11-30', 'pendiente', @mensaje;
exec cotizaciones.insertar_tarea 2, 'Presupuesto mantenimiento', 23456789, '2024-11-25', 'en progreso', @mensaje;
exec cotizaciones.insertar_tarea 3, 'Buscar proveedores cocina', 34567890, '2024-12-01', 'pendiente', @mensaje;
exec cotizaciones.insertar_tarea 4, 'Propuesta catering evento', 45678901, '2024-11-28', 'en progreso', @mensaje;
exec cotizaciones.insertar_tarea 5, 'Actualizar cotización fiesta', 56789012, '2024-12-05', 'pendiente', @mensaje;
exec cotizaciones.insertar_tarea 6, 'Investigar productos oficina', 67890123, '2024-11-30', 'en progreso', @mensaje;
exec cotizaciones.insertar_tarea 7, 'Revisar herramientas', 87654321, '2024-11-27', 'pendiente', @mensaje;
exec cotizaciones.insertar_tarea 8, 'Proveedores hogar', 987654321, '2024-12-03', 'en progreso', @mensaje;
exec cotizaciones.insertar_tarea 9, 'Cotización accesorios oficina', 12345678, '2024-11-29', 'pendiente', @mensaje;
exec cotizaciones.insertar_tarea 10, 'Gestionar transporte', 23456789, '2024-11-25', 'en progreso', @mensaje;
exec cotizaciones.insertar_tarea 11, 'Propuesta suministros oficina', 34567890, '2024-11-30', 'pendiente', @mensaje;
exec cotizaciones.insertar_tarea 12, 'Revisar cotización seguridad', 45678901, '2024-12-02', 'en progreso', @mensaje;
exec cotizaciones.insertar_tarea 13, 'Propuesta mobiliario oficina', 56789012, '2024-12-04', 'pendiente', @mensaje;
exec cotizaciones.insertar_tarea 14, 'Asesoría empresarial', 67890123, '2024-11-30', 'en progreso', @mensaje;
exec cotizaciones.insertar_tarea 15, 'Actualizar cotización limpieza', 87654321, '2024-12-01', 'pendiente', @mensaje;
exec cotizaciones.insertar_tarea 16, 'Coordinar mantenimiento', 987654321, '2024-11-29', 'en progreso', @mensaje;
exec cotizaciones.insertar_tarea 17, 'Revisar cotización tecnología', 12345678, '2024-12-06', 'pendiente', @mensaje;
exec cotizaciones.insertar_tarea 18, 'Propuesta reparación electrodomésticos', 23456789, '2024-11-28', 'en progreso', @mensaje;
exec cotizaciones.insertar_tarea 19, 'Revisar cotización electrónica', 34567890, '2024-12-02', 'pendiente', @mensaje;
exec cotizaciones.insertar_tarea 20, 'Generar cotización alquiler', 45678901, '2024-11-30', 'en progreso', @mensaje;

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


