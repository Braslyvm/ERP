use Planificador_recursos_empresariales
go

-----------------------------retorna el top 15 tareas -----------------------------------------
create function cotizaciones.top15_tareas(
@fecha_inicio date = null,
    @fecha_fin date = null
)
returns table
as
return
(
    select top 15 
        id_tarea,
        ct.id_cotizacion,
        descripcion,
        usuario,
        fecha_inicio,
        fecha_limite,
        ct.estado
    from cotizaciones.tareas ct
	join cotizaciones.cotizaciones on ct.id_cotizacion=ct.id_cotizacion
    where ct.estado = 'completada' or ct.estado = 'en progreso' and 
	  (@fecha_inicio is null or ct.fecha_inicio >= @fecha_inicio) 
        and 
        (@fecha_fin is null or ct.fecha_inicio <= @fecha_fin)


    order by 
        fecha_inicio asc
);
go
-----------------------------------Top 10 de clientes con mayores ventas-------------------------------
create function dbo.top_clientes(
 @fecha_inicio date = null,
    @fecha_fin date = null

)
returns table
as
return
(
    select top 10 
        c.nombre as nombre_cliente,
        sum(f.total) as monto
    from facturación.facturas f
    inner join  clientes.cliente c on f.id_cliente = c.cedula

    where f.estado = 'aprobada' and 
	(@fecha_inicio is null or f.fecha_factura >= @fecha_inicio) 
        and 
        (@fecha_fin is null or f.fecha_factura <= @fecha_fin)
    group by  c.nombre
    order by  monto desc
);
go

-----------------------------------Cantidad de clientes por zona y monto ventas por zona------------------------
create  function dbo.clientes_zona(
@fecha_inicio date = null,
    @fecha_fin date = null
)
returns table
as
return
(
    select c.zona, count(distinct c.cedula) as cantidad_clientes, sum(f.total) as monto_total_ventas
    from  clientes.cliente c
    left join  facturación.facturas f on c.cedula = f.id_cliente
    where  f.estado = 'aprobada'and 
	 (@fecha_inicio is null or f.fecha_factura >= @fecha_inicio) 
        and 
        (@fecha_fin is null or f.fecha_factura <= @fecha_fin)
    group by  c.zona
);
go

---------------------------------------Casos por cotizacion y facturas 

create function dbo.casos_cotizacion_factura(
 @fecha_inicio date = null,
    @fecha_fin date = null
)
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
    where c.id_factura IS NULL and
        (@fecha_inicio is null or c.fecha_creacion >= @fecha_inicio) 
        and 
        (@fecha_fin is null or c.fecha_creacion <= @fecha_fin)
    group by  year(c.fecha_creacion), month(c.fecha_creacion)
    
    union all
    
    select year(c.fecha_creacion) as año,
        month(c.fecha_creacion) as mes,
        'factura' as tipo,
        count(c.id_caso) as cantidad_casos
    from registro_caso.casos c
    where c.id_cotizacion  IS NULL and 
	  (@fecha_inicio is null or c.fecha_creacion >= @fecha_inicio) 
        and 
        (@fecha_fin is null or c.fecha_creacion <= @fecha_fin)
    group by year(c.fecha_creacion), month(c.fecha_creacion)
);


-- Función para obtener el top de bodegas con más artículos transados
create function dbo.top_transados()
returns table
as
return
(
	select top 10
		b.c_bodega,
		b.nombre as nombre_bodega,
		sum(case when mi.tipo = 'entrada' then dm.cantidad else 0 end) - 
		sum(case when mi.tipo = 'salida' then dm.cantidad else 0 end) as total_transacciones
	from gestion_inventario.detalle_movimiento as dm
	join gestion_inventario.movimientos_inventario as mi on dm.id_movimiento = mi.id_movimiento
	join gestion_inventario.bodegas as b on b.c_bodega = dm.bodega_origen or b.c_bodega = dm.bodega_destino
	group by b.c_bodega, b.nombre
	order by total_transacciones desc
);

create function gestion_inventario.total_movimientos (
    @tipo_movimiento varchar(30), 
    @fecha_inicio date = null,     
    @fecha_final date = null       
)
returns table
as
return
(
    select 
        b.c_bodega,
        b.nombre as nombre_bodega,
        sum(case when mi.tipo = @tipo_movimiento then 1 else 0 end) as cantidad_movimientos
    from  gestion_inventario.detalle_movimiento as dm
    join  gestion_inventario.movimientos_inventario as mi on dm.id_movimiento = mi.id_movimiento
    join   gestion_inventario.bodegas as b on b.c_bodega = dm.bodega_origen or b.c_bodega = dm.bodega_destino
    where  (mi.tipo = @tipo_movimiento) 
        and (@fecha_inicio is null or mi.fecha >= @fecha_inicio)
        and (@fecha_final is null or mi.fecha <= @fecha_final)

    group by 
        b.c_bodega, b.nombre
);


