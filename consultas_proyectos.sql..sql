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

