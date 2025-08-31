-- 2. Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.
SELECT title 
from film f 
where rating ='R';

-- 3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.
select first_name, last_name 
from actor 
where actor_id between 30 and 40;

-- 4. Obtén las películas cuyo idioma coincide con el idioma original.
select title 
from film 
where language_id = original_language_id;

-- 5. Ordena las películas por duración de forma ascendente.
select title,length
from film f order by length asc;


--6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.
select first_name, last_name 
from actor 
where last_name like '%ALLEN%';


--7. Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.

select rating, COUNT(title) as numero_de_peliculas 
from film 
group by rating;

--8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.
select title 
from film
where rating = 'PG-13' or length > 180;


-- 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
select MAX(replacement_cost) - MIN(replacement_cost) as variabilidad from film;


-- 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.--
select MAX(length) as duracion_maxima, MIN(length) as duracion_minina 
from film;


-- 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.

select amount 
from payment 
order by payment_date desc limit 1 offset 1;


-- 12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC- 17’ ni ‘G’ en cuanto a su clasificación.
select title 
from film f
where rating not in ('NC-17', 'G');


-- 13. Encuentra el promedio de duración de las películas para cadaclasificación de la tabla film y muestra la clasificación junto con elpromedio de duración.
select C.NAME,AVG(f.length) as duracion_promedio 
from film f
join film_category fc ON f.film_id = fc.film_id 
JOIN category c ON fc.category_id = c.category_id 
GROUP BY c.name;


-- 14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
select title
from film 
where length > 100;

-- 15. ¿Cuánto dinero ha generado en total la empresa?

select SUM(amount) as dinero_total_generado 
from payment;

--16. Muestra los 10 clientes con mayor valor de id.
select customer_id, first_name, last_name
from customer
order by customer_id desc limit 10;


--17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.
select a.first_name, a.last_name 
from actor a 
join film_actor fa 
on a.actor_id = fa.actor_id 
join film f 
on fa.film_id = f.film_id 
where f.title = 'EGG IGBY';

-- 18. Selecciona todos los nombres de las películas únicos.
select distinct title 
from film;

-- 19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.
 
select f.title
from film as f
join film_category as fc on f.film_id = fc.film_id 
join category as c on fc.category_id = c.category_id
where c.name = 'Comedy' and f.length >180;


-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.

select c.name, AVG(f.length) as promedio_duracion
from film as f
join film_category as fc on f.film_id = fc.film_id 
join category as c on fc.category_id = c.category_id 
group by c."name" 
having AVG(F.length) > 110;

-- 21. ¿Cuál es la media de duración del alquiler de las películas? 

select AVG(rental_duration) as media_duracion_alquiler
from film;

-- 22. Crea una columna con el nombre y apellidos de todos los actores y actrices.

select concat(first_name, ' ', last_name) as nombre_completo
from actor;

-- 23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.

select date(rental_date) as dia,count(rental_id) as numero_alquileres
from rental r group by dia
order by numero_alquileres desc;


-- 24. Encuentra las películas con una duración superior al promedio.

select title, length
from film
where length > (
		select AVG(length)
		from film 
);

-- 25. Averigua el número de alquileres registrados por mes.

select 
	extract(year from rental_date) as anio,
	extract(month from rental_date) as mes,
	count(rental_id) as numero_alquileres
from rental
group by anio, mes
order by anio, mes;

-- 26. Encuentra el promedio, la desviación estándar y varianza del total pagado.

select 
	AVG(amount) as promedio_pagado,
	stddev_pop(amount) as desviacion_estandar,
	var_pop(amount) as varianza
from payment;

-- 27. ¿Qué películas se alquilan por encima del precio medio?

select title, rental_rate
from film
where rental_rate > (
select AVG(amount)
from payment 
);

-- 28. Muestra el id de los actores que hayan participado en más de 40 películas.

select actor_id, count(film_id) as numero_peliculas
from film_actor 
group by actor_id 
having count(film_id) > 40;

-- 29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.

select f.title,
count(i.inventory_id) as cantidad_disponible
from film as f
left join inventory as i on f.film_id = i.film_id 
group by f.title;


-- 30. Obtener los actores y el número de películas en las que ha actuado.

select a.first_name, a.last_name, count(fa.film_id) as numero_peliculas
from actor as a
join film_actor as fa on a.actor_id = fa.actor_id 
group by a.actor_id;

-- 31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.

select f.title, a.first_name, a.last_name
from film as f
left join film_actor as fa on f.film_id = fa.film_id 
left join actor as a on fa.actor_id = a.actor_id;

-- 32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.

select a.first_name, a.last_name, f.title 
from actor as a
left join film_actor as fa on a.actor_id = fa.actor_id 
left join film as f on fa.film_id = f.film_id;

-- 33. Obtener todas las películas que tenemos y todos los registros de alquiler.

select f.title, r.rental_date
from film as f
full outer join inventory as i on f.film_id = i.film_id 
full outer join rental as r on i.inventory_id = r.inventory_id;

-- 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.

select c.first_name, c.last_name, sum(p.amount) as total_gastado
from customer as c
join payment as p on c.customer_id = p.customer_id 
group by c.customer_id order by total_gastado desc
limit 5;

-- 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.
 
select *
from ACTOR
where FIRST_NAME = 'JOHNNY';

--36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.

select first_name as nombre, last_name as apellido
from actor;

-- 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.

select 
	min(actor_id) as id_mas_bajo,
	max(actor_id)as id_mas_alto
from actor;

-- 38. Cuenta cuántos actores hay en la tabla “actor”.

select count(*) as total_actores
from actor;

--39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.

select *
from actor 
order by last_name asc;

--40. Selecciona las primeras 5 películas de la tabla “film”.

select *
from film
limit 5;

--41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?

select first_name,
count(first_name) as numero_veces
from actor a 
group by first_name 
order by numero_veces desc
limit 1;

-- 42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.

select 
r.rental_id, c.first_name, c.last_name
from rental as r
join customer as c on r.customer_id = c.customer_id;

-- 43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.

select 
c.first_name,c.last_name,r.rental_date
from customer as c
left join rental as r on c.customer_id = r.customer_id;

--44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.

select f.title,
c.name as category_name
from film as f
cross join category as c;

--No,como ya vimos en los videos tutoriales sobre consultas con JOIN ,un CROS JOIn no es útil ,ya que te da todas las combinaciones posibles
--la cual no nos puede ser util para el analisis.
--Resumidamente demasiada informacion no revelante a la pregunta principal.

--45. Encuentra los actores que han participado en películas de la categoría 'Action'.

select distinct 
	a.first_name,
	a.last_name
from actor as a
join film_actor as fa on a.actor_id = fa.actor_id 
join film_category as fc on fa.film_id = fc.film_id 
join category as c on fc.category_id = c.category_id 
where c.name = 'Action';

--46. Encuentra todos los actores que no han participado en películas.

select 
a.first_name,
a.last_name
from actor as a
left join film_actor as fa
on a.actor_id = fa.actor_id where fa.film_id  is null;

--47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.

select 
a.first_name,
a.last_name,
count(fa.film_id) as numero_peliculas
from actor as a
join film_actor as fa
on a.actor_id = fa.actor_id 
group by a.actor_id;

--48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado.

create view actor_num_peliculas as
select
a.first_name,
a.last_name,
count(fa.film_id) as numero_peliculas
from actor as a
join film_actor as fa
on a.actor_id = fa.actor_id
group by 
a.actor_id;

-- 49. Calcula el número total de alquileres realizados por cada cliente.

select 
c.first_name,
c.last_name,
count(r.rental_id) as total_alquileres
from customer as c
join rental as r
on c.customer_id = r.customer_id 
group by
c.customer_id;

-- 50. Calcula la duración total de las películas en la categoría 'Action'.

select 
sum(f.length) as duracion_total_action
from film as f
join film_category as fc
on f.film_id = fc.film_id 
join category as c
on fc.category_id = c.category_id 
where c.name = 'Action';

--51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.

create temporary table cliente_rentas_temporal as 
select
c.first_name,
c.last_name,
count(r.rental_id) as total_alquileres
from customer as c
join rental as r
on c.customer_id = r.customer_id
group by 
c.customer_id;


--52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces.

create temporary table peliculas_alquiladas as 
select
	f.title,
	count(r.rental_id) as numero_alquileres
from film as f
join inventory as i
	on f.film_id = i.film_id
join rental as r
	on i.inventory_id = r.inventory_id
group by
f.film_id
having
count(r.rental_id) <= 10;

--53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena
--los resultados alfabéticamente por título de película.
select f.title 
from film as f
join inventory as i
on f.film_id = i.film_id 
join rental as r
on i.inventory_id = r.inventory_id 
join customer as c
on r.customer_id = c.customer_id 
where c.first_name = 'TAMMY' and c.last_name = 'SANDERS' and r.return_date is null 
order by
f.title asc;


--54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados
--alfabéticamente por apellido.
select distinct
  a.first_name,
  a.last_name
from actor as a
join film_actor as fa
  on a.actor_id = fa.actor_id
join film_category as fc
  on fa.film_id = fc.film_id
join category as c
  on fc.category_id = c.category_id
where
  c.name = 'Sci-Fi'
order by
  a.last_name asc;


--55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaper’ se alquilara por primera vez. Ordena los resultados
--alfabéticamente por apellido.
select distinct a.first_name,
a.last_name
from actor as a
join film_actor as fa
on a.actor_id = fa.actor_id 
join film as f
on fa.film_id = f.film_id 
join inventory as i
on f.film_id = i.film_id 
join rental as r
on i.inventory_id = r.inventory_id 
where 
r.rental_date > (
select min(r2.rental_date)
from rental as r2
join inventory as i2
on r2.inventory_id = i2.inventory_id 
join film as f2
on i2.film_id = f2.film_id
where f2.title = 'SPARTACUS CHEAPER'
)
order by a.last_name asc;

--56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.
select 
a.first_name,a.last_name
from actor as a
where
a.actor_id not in (
select fa.actor_id
from film_actor as fa
join film_category as fc
on fa.film_id = fc.film_id 
join category as c
on fc.category_id = c.category_id 
where
c.name = 'Music'
);


--57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
select title 
from film
where rental_duration > 8;


--58. Encuentra el título de todas las películas que son de la misma categoría
--que ‘Animation’.

select 
c.name AS categoria,
count(f.film_id) as numero_peliculas
from category as c
join film_category as fc
on c.category_id = fc.category_id
join film as f
on fc.film_id = f.film_id 
group by categoria
order by numero_peliculas desc;



--59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’. Ordena los resultados
--alfabéticamente por título de película.

select title
from film
where length = (
select length 
from film 
where 
title = 'DANCING FEVER'
) and title <> 'DANCING FEVER'
order by 
title asc;




-- 60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.
select 
c.first_name,c.last_name
from customer as c
join rental as r
on c.customer_id = r.customer_id 
join inventory as i
on r.inventory_id = i.inventory_id 
group by
c.customer_id 
having count (distinct i.film_id) >= 7
order by c.last_name asc;


--61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
select c.name as categoria,
count (r.rental_id) as total_alquileres
from category as c
join film_category as fc
on c.category_id = fc.category_id
join film as f
on fc.film_id = f.film_id 
join inventory as i
on f.film_id = i.film_id 
join rental as r
on i.inventory_id = r.inventory_id 
group by categoria;


-- 62. Encuentra el número de películas por categoría estrenadas en 2006.

select c.name as categoria,
count(f.film_id) as numero_peliculas
from category as c
join film_category as fc
on c.category_id = fc.category_id
join film as f
on fc.film_id = f.film_id 
where 
f.release_year = 2006
group by categoria;


--63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.

select 
s.first_name as nombre_empleado,
s.last_name as apellido_empleado,
st.store_id as tienda_id
from staff as s
cross join store as st;


--64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
select c.customer_id,c.first_name,c.last_name,
count(r.rental_id) as cantidad_alquileres
from customer as c
join rental as r
on c.customer_id = r.customer_id 
group by c.customer_id 
order by cantidad_alquileres desc;



