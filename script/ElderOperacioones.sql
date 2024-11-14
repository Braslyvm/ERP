
use Planificador_recursos_empresariales
go

/*funcion que toma las planillas por a�o*/
create function usuarios.planillaa�os(@anoinicio int = null, @anofin int = null)
returns table
as
return
(
    select 
        year(a.fecha_pago) as a�o, 
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
    @a�o_inicio INT = NULL,  -- Se puede poner un valor por defecto para evitar NULL
    @mes_inicio INT = NULL,
    @a�o_final INT = NULL,
    @mes_final INT = NULL
AS
BEGIN
    SELECT 
           a.departamento,
           SUM(a.total_salario) AS total_salario,
           a.a�o, a.mes
    FROM usuarios.plantilla a
    WHERE  (@departamento IS NULL OR a.departamento = @departamento)and  (@a�o_inicio IS NULL OR a.a�o >= @a�o_inicio)
        AND (@mes_inicio IS NULL OR (a.a�o = @a�o_inicio AND a.mes >= @mes_inicio))
        AND (@a�o_final IS NULL OR a.a�o <= @a�o_final)
        AND (@mes_final IS NULL OR (a.a�o = @a�o_final AND a.mes <= @mes_final))
    GROUP BY a.a�o, a.mes,a.departamento;
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
        a.a�o
    FROM usuarios.plantilla a
    WHERE 
        -- Filtro por el rango de fechas, si no son NULL
        (@anio_inicio IS NULL OR a.a�o >= @anio_inicio)
        AND (@mes_inicio IS NULL OR (a.a�o = @anio_inicio AND a.mes >= @mes_inicio))
        AND (@anio_fin IS NULL OR a.a�o <= @anio_fin)
        AND (@mes_fin IS NULL OR (a.a�o = @anio_fin AND a.mes <= @mes_fin))
    GROUP BY a.a�o, a.mes
);
go


/*Familias de productos vendidos*/

CREATE VIEW FamiliaProductos AS
SELECT 
    SUM(lf.monto_total) AS total,
    gf.nombre AS nombreFam
FROM 
    facturaci�n.lista_articulos_facturados lf
JOIN 
    gestion_inventario.articulos ga ON lf.c_articulo = ga.c_articulo
JOIN 
    gestion_inventario.familia_articulos gf ON ga.c_familia = gf.id_familia
GROUP BY 
    gf.nombre;

go


CREATE VIEW VentaSector AS
SELECT 
    SUM(lf.monto_total) AS total,
    cl.sector
FROM 
    facturaci�n.lista_articulos_facturados lf
JOIN 
    facturaci�n.facturas ff ON lf.n_factura = ff.n_factura  -- Relaci�n entre lista_articulos_facturados y facturas
JOIN 
    clientes.cliente cl ON ff.id_cliente = cl.cedula          -- Relaci�n entre facturas y cliente
GROUP BY 
    cl.sector;

SELECT * FROM VentaSector;

