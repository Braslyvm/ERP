
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
        c.nombre as nombre_cliente,
        sum(f.total) as monto
    from facturación.facturas f
    inner join  clientes.cliente c on f.id_cliente = c.cedula
    where f.estado = 'aprobada' 
    group by  c.nombre
    order by  monto desc
);
go
-----------------------------------Cantidad de clientes por zona y monto ventas por zona------------------------
create function dbo.clientes_zona()
returns table
as
return
(
    select c.zona, count(distinct c.cedula) as cantidad_clientes, sum(f.total) as monto_total_ventas
    from  clientes.cliente c
    left join  facturación.facturas f on c.cedula = f.id_cliente
    where  f.estado = 'aprobada'
    group by  c.zona
);
go

---------------------------------------Casos por cotizacion y facturas 

create function dbo.casos_cotizacion_factura()
returns table
as
return
(
    select year(c.fecha_creacion) as año,
        month(c.fecha_creacion) as mes,
        'cotizacion' as tipo,
        count(c.id_caso) as cantidad_casos
    from 
        registro_caso.casos c
    where c.id_cotizacion = id_factura
    group by  year(c.fecha_creacion), month(c.fecha_creacion)
    
    union all
    
    select year(c.fecha_creacion) as año,
        month(c.fecha_creacion) as mes,
        'factura' as tipo,
        count(c.id_caso) as cantidad_casos
    from registro_caso.casos c
    where c.id_cotizacion = null
    group by year(c.fecha_creacion), month(c.fecha_creacion)
);


