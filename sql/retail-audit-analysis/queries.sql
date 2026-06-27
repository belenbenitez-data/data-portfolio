--Tablas
select * from dim_pdv;
select * from dim_productos;
select * from hechos_encuestas;

--****************************************************************************************************--
--Cobertura

--pdv con productos faltantes
select distinct
pdv
from hechos_encuestas
where disponible_gondola = 'No';

--% cobertura por categoría (forma 1)
select 
    h.categoria_producto,
    sum(case
		when h.disponible_gondola = 'Si'
		then 1
		else 0
		end) as disponibles,
    sum(case
		when h.disponible_gondola = 'No'
		then 1
		else 0
		end) as no_disponibles,
	sum(case
	when h.disponible_gondola in ('Si', 'No')
	then 1
	else 0
	end) as total_productos_esperados,
    round(sum(case
		when h.disponible_gondola = 'Si'
		then 1
		else 0
		end) * 100.0 / nullif(sum(case
				when h.disponible_gondola in ('Si', 'No')
				then 1
				else 0
				end), 0),1)
     || '%' as porcentaje_disponibilidad
from hechos_encuestas h
group by h.categoria_producto;

--(forma 2)
with variables as
(
select
h.categoria_producto,
sum(case
when h.disponible_gondola = 'Si'
then 1
else 0
end) as disponibilidad,
sum(case
when h.disponible_gondola = 'No'
then 1
else 0
end) as no_disponible,
sum(case
when disponible_gondola in ('Si', 'No')
then 1
else 0
end) as total_productos
from hechos_encuestas h
group by h.categoria_producto)
select
    d.categoria_producto,
	d.disponibilidad,
	d.no_disponible,
	d.total_productos,
	round(d.disponibilidad * 100.0 / total_productos, 1) || '%' as porcentaje	
from variables d;

--% cobertura por tipo_pdv
with calculated_pdv as
(
select
split_part(h.pdv, '-', 1) as pdv_sp,
right(h.pdv,7) as cod_pdv,
sum(case
when h.disponible_gondola = 'Si'
then 1
else 0
end) as disponible,
sum(case
when h.disponible_gondola = 'No'
then 1
else 0
end) as no_disponible,
sum(case
when h.disponible_gondola in ('Si', 'No')
then 1
else 0
end) as total_productos
from hechos_encuestas h
group by h.pdv
)
select
p.tipo_pdv,
sum(c.disponible) disponible,
sum(c.no_disponible) no_disponible,
sum(c.total_productos) total_productos,
round(sum(c.disponible) * 100.0 / sum(c.total_productos),1) || '%' as porcentaje
from calculated_pdv c
inner join dim_pdv p
on c.cod_pdv = p.codigo_pdv
group by 1

--****************************************************************************************************--
--Precio

--Comparación de precios reales y reportados
select
p.codigo_producto,
h.producto,
h.categoria_producto,
h.marca,
h.linea_producto,
p.precio_unitario_real,
h.precio_unitario,
case
when precio_unitario_real != precio_unitario
then 'Desviacion'
else 'Correcto'
end as comparacion_precio
from hechos_encuestas h
full join dim_productos p
on h.producto = p.producto;

--pdv con desviaciones significativas
with desviaciones as
(
select
h.pdv,
p.precio_unitario_real,
h.precio_unitario,
case
when precio_unitario = precio_unitario_real
then 'Sin desviaciones'
when precio_unitario >= (precio_unitario_real + 5.00)
then 'Desviacion significativa'
when precio_unitario <= (precio_unitario_real - 5.00)
then 'Desviacion inferior'
else 'Desviacion leve'
end as tipo_desviacion
from hechos_encuestas h
full join dim_productos p
on h.producto = p.producto
)
select distinct
t.pdv,
t.tipo_desviacion
from desviaciones t
where t.tipo_desviacion = 'Desviacion significativa';

--****************************************************************************************************--
--Ejecución

--Fefo
select distinct
split_part(pdv, '-', 1) as pdv
from hechos_encuestas
where respeta_fefo = 'No'

--Vencidos
select distinct
split_part(pdv, '-', 1) as pdv
from hechos_encuestas
where vencidos_tienda = 'Si'

--Rack invadido
select distinct
split_part(pdv, '-', 1) as pdv
from hechos_encuestas
where rack_invadido = 'Si'

--Productos presentes en el checkout
select distinct
split_part(pdv, '-', 1) as pdv
from hechos_encuestas
where presentes_checkout = 'No'