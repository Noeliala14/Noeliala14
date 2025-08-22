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
