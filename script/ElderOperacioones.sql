
use Planificador_recursos_empresariales
go

/*funcion que toma las planillas por año*/
create function usuarios.planillaaños(@anoinicio int = null, @anofin int = null)
returns table
as
return
(
    select 
        year(a.fecha_pago) as año, 
        sum(a.total_salario) as total_salario
    from usuarios.plantilla a
    where 
        (@anoinicio is null or year(a.fecha_pago) >= @anoinicio) 
        and 
        (@anofin is null or year(a.fecha_pago) <= @anofin)
    group by year(a.fecha_pago)
)
GO



/*Funcion que toma planillas por departamento*/

CREATE PROCEDURE usuarios.planilla_por_departamentos
    @departamento VARCHAR(180) = NULL,
    @año_inicio INT = NULL,  -- Se puede poner un valor por defecto para evitar NULL
    @mes_inicio INT = NULL,
    @año_final INT = NULL,
    @mes_final INT = NULL
AS
BEGIN
    SELECT 
           a.departamento,
           SUM(a.total_salario) AS total_salario,
           a.año, a.mes
    FROM usuarios.plantilla a
    WHERE  (@departamento IS NULL OR a.departamento = @departamento)and  (@año_inicio IS NULL OR a.año >= @año_inicio)
        AND (@mes_inicio IS NULL OR (a.año = @año_inicio AND a.mes >= @mes_inicio))
        AND (@año_final IS NULL OR a.año <= @año_final)
        AND (@mes_final IS NULL OR (a.año = @año_final AND a.mes <= @mes_final))
    GROUP BY a.año, a.mes,a.departamento;
END;
GO

/*Planilals por mes*/
go
CREATE  FUNCTION usuarios.PlanillaMesse(
    @anio_inicio INT = NULL, 
    @mes_inicio INT = NULL, 
    @anio_fin INT = NULL, 
    @mes_fin INT = NULL
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        SUM(a.total_salario) AS total_salario,
        a.mes,
        a.año
    FROM usuarios.plantilla a
    WHERE 
        -- Filtro por el rango de fechas, si no son NULL
        (@anio_inicio IS NULL OR a.año >= @anio_inicio)
        AND (@mes_inicio IS NULL OR (a.año = @anio_inicio AND a.mes >= @mes_inicio))
        AND (@anio_fin IS NULL OR a.año <= @anio_fin)
        AND (@mes_fin IS NULL OR (a.año = @anio_fin AND a.mes <= @mes_fin))
    GROUP BY a.año, a.mes
);
go


/*Familias de productos vendidos*/

CREATE function FamiliaProductos (
    @fecha_inicio date = null,
    @fecha_fin date = null
) returns table
as
return (
SELECT 
    SUM(lf.monto_total) AS total,
    gf.nombre AS nombreFam
FROM 
    facturación.lista_articulos_facturados lf
JOIN 
    gestion_inventario.articulos ga ON lf.c_articulo = ga.c_articulo
JOIN 
    gestion_inventario.familia_articulos gf ON ga.c_familia = gf.id_familia
join facturación.facturas ff on lf.n_factura=ff.n_factura
  where 
        (@fecha_inicio is null or ff.fecha_factura >= @fecha_inicio) 
        and 
        (@fecha_fin is null or ff.fecha_factura <= @fecha_fin)
  
GROUP BY 
    gf.nombre )

go


/*ventas por sector*/
CREATE function VentaSector  (
    @fecha_inicio date = null,
    @fecha_fin date = null
) 
returns table
as return(
SELECT 
    SUM(lf.monto_total) AS total,
    cl.sector
FROM 
    facturación.lista_articulos_facturados lf
JOIN 
    facturación.facturas ff ON lf.n_factura = ff.n_factura  
	join
    clientes.cliente cl ON ff.id_cliente = cl.cedula  
	where 
        (@fecha_inicio is null or ff.fecha_factura >= @fecha_inicio) 
        and 
        (@fecha_fin is null or ff.fecha_factura <= @fecha_fin)
GROUP BY 
    cl.sector)
GO


  /*Ventas por zona*/
create function VentaZona (
    @fecha_inicio date = null,
    @fecha_fin date = null
)
returns table
as
return
(
    select 
        sum(lf.monto_total) as total,
        cl.zona
    from 
        facturación.lista_articulos_facturados lf
    join 
        facturación.facturas ff on lf.n_factura = ff.n_factura  
    join 
        clientes.cliente cl on ff.id_cliente = cl.cedula
    where 
        (@fecha_inicio is null or ff.fecha_factura >= @fecha_inicio) 
        and 
        (@fecha_fin is null or ff.fecha_factura <= @fecha_fin)
    group by 
        cl.zona
);

go


/*Ventas por departameto*/
create function Ventadepartamento (
    @fecha_inicio date = null,
    @fecha_fin date = null
)
returns table
as
return
(
    select 
        count(distinct ff.n_factura) as cantidad_ventas,
        ue.departamento_actual
    from 
        facturación.facturas ff
    join 
        usuarios.empleados ue on ff.id_empleado = ue.cedula
    where 
        (@fecha_inicio is null or ff.fecha_factura >= @fecha_inicio) 
        and 
        (@fecha_fin is null or ff.fecha_factura <= @fecha_fin)
    group by 
        ue.departamento_actual
);
go

/*Cuenta cantidad de movimientos entrada salida*/

create function gestion_inventario.cantidadmovimientos( @fecha_inicio date = null,
    @fecha_fin date = null)
returns table
as
return
(
    select 
        c.bodega_origen as bodega,
       'salida' as tipo,
        count( c.id_movimiento) as cantidad_casos
    from 
        gestion_inventario.detalle_movimiento c
		join gestion_inventario.movimientos_inventario gi on c.id_movimiento=gi.id_movimiento
    where c.bodega_destino is null and 
	(@fecha_inicio is null or gi.fecha >= @fecha_inicio) 
        and 
        (@fecha_fin is null or gi.fecha  <= @fecha_fin)
    group by c.bodega_origen
    union all

    select 
        c.bodega_destino as bodega,
       'Entrada' as tipo,
        count( c.id_movimiento) as cantidad_casos
    from 
        gestion_inventario.detalle_movimiento c
	join gestion_inventario.movimientos_inventario gi on c.id_movimiento=gi.id_movimiento
    where c.bodega_origen is null
    group by c.bodega_destino

);
go


/*	top10 articulos cotizados*/
create function top10 (
    @fecha_inicio date = null,
    @fecha_fin date = null
)
returns table 
as return (
select top 10 
    count(cl.c_producto) as cantidad,
    ga.nombre,
    ga.descripcion,
    ga.c_articulo
from [cotizaciones].[lista_articulos_cotizacion] cl
join gestion_inventario.articulos ga on cl.c_producto = ga.c_articulo
join cotizaciones.cotizaciones cc on cl.id_cotizacion = cc.id_cotizacion
where 
(@fecha_inicio is null or cc.fecha_corizacion >= @fecha_inicio) 
        and 
        (@fecha_fin is null or cc.fecha_corizacion  <= @fecha_fin)
group by ga.nombre, ga.descripcion, ga.c_articulo
order by cantidad desc)
go 



/*Cotizaciones y ventas por departamento*/
create  function CotizacionesyVentas (
    @fecha_inicio date = null,
    @fecha_fin date = null
)
returns table 
as 
return(
	
select 
    coalesce(cotizaciones.departamento_actual, ventas.departamento_actual) as departamento_actual,
    cotizaciones.cantidadCotizacion,
    ventas.cantidadVentas
from 
    (
        select 
            count(distinct cc.id_cotizacion) as cantidadCotizacion,
            ue.departamento_actual,cc.fecha_corizacion
        from 
            cotizaciones.cotizaciones cc
        join 
            usuarios.empleados ue on cc.empleado = ue.cedula
			 where 
        (@fecha_inicio is null or cc.fecha_corizacion >= @fecha_inicio) 
        and 
        (@fecha_fin is null or cc.fecha_corizacion <= @fecha_fin)
        group by 
            ue.departamento_actual,cc.fecha_corizacion
    ) as cotizaciones
full outer join 
    (
        select 
            count(distinct ff.n_factura) as cantidadVentas,
            ue.departamento_actual,ff.fecha_factura
        from 
            facturación.facturas ff
        join 
            usuarios.empleados ue on ff.id_empleado = ue.cedula
		 where 
        (@fecha_inicio is null or ff.fecha_factura >= @fecha_inicio) 
        and 
        (@fecha_fin is null or ff.fecha_factura <= @fecha_fin)
        group by 
            ue.departamento_actual,ff.fecha_factura
    ) as ventas 

on 
    cotizaciones.departamento_actual = ventas.departamento_actual)



/* ventas y cotizaciones cuenta*/
create  function ventasycotizaciones  (
    @fecha_inicio date = null,
    @fecha_fin date = null
)
returns table 
as 
return (
select 
    coalesce(cotizaciones.departamento_actual, ventas.departamento_actual) as departamento_actual,
    cotizaciones.cantidadCotizacion,
    ventas.cantidadVentas
from 
    (
        select 
            count(distinct cc.id_cotizacion) as cantidadCotizacion,
            ue.departamento_actual,cc.fecha_corizacion
        from 
            cotizaciones.cotizaciones cc
        join 
            usuarios.empleados ue on cc.empleado = ue.cedula
			where 
        (@fecha_inicio is null or cc.fecha_corizacion >= @fecha_inicio) 
        and 
        (@fecha_fin is null or cc.fecha_corizacion <= @fecha_fin)
        group by 
            ue.departamento_actual,cc.fecha_corizacion

    ) as cotizaciones
full outer join 
    (
        select 
            count(distinct ff.n_factura) as cantidadVentas,
            ue.departamento_actual,ff.fecha_factura
        from 
            facturación.facturas ff
        join 
            usuarios.empleados ue on ff.id_empleado = ue.cedula
			where 
        (@fecha_inicio is null or ff.fecha_factura >= @fecha_inicio) 
        and 
        (@fecha_fin is null or ff.fecha_factura <= @fecha_fin)

        group by 
            ue.departamento_actual,ff.fecha_factura
    ) as ventas 
on 
    cotizaciones.departamento_actual = ventas.departamento_actual)

go

/*ventas y cotizaciones por mes y año*/

create view ventasycotizaciones as 


select 
    coalesce(cotizaciones.anio, ventas.anio) as anio,
    coalesce(cotizaciones.mes, ventas.mes) as mes,
    cotizaciones.cantidadcotizacion,
    ventas.cantidadventas
from 
    (
        select 
            count(distinct cc.id_cotizacion) as cantidadcotizacion,
            year(cc.fecha_corizacion) as anio,
            month(cc.fecha_corizacion) as mes
        from 
            cotizaciones.cotizaciones cc
        group by 
            year(cc.fecha_corizacion),
            month(cc.fecha_corizacion)
    ) as cotizaciones
full outer join 
    (
        select 
            count(distinct ff.n_factura) as cantidadventas,
            year(ff.fecha_factura) as anio,
            month(ff.fecha_factura) as mes
        from 
            facturación.facturas ff
        group by 
            year(ff.fecha_factura),
            month(ff.fecha_factura)
    ) as ventas 
on 
    cotizaciones.anio = ventas.anio
    and cotizaciones.mes = ventas.mes;
