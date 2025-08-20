-- 2ºMuestra los nombres de todas las películas con una clasificación por edades de 'R'.--
select title 
from film f 
where rating = 'R';

-- 3º  Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.--
select first_name,
last_name
from actor
where actor_id between 30 and 40;

-- 4º Obtén las películas cuyo idioma coincide con el idioma original.--
select title 
from film 
where language_id = original_language_id;


-- 5º Ordena las películas por duración de forma ascendente.--
select title,
length
from film 
order by 
length asc;


-- 6º Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.--
select first_name,
last_name
from actor
where last_name like'%allen%';



-- 7º Encuentra la cantidad total de películas en cada clasificación de la tabla“film” y muestra la clasificación junto con el recuento.--
select rating,
COUNT(film_id) AS total_peliculas
from film 
group by rating;


-- 8º Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.--
select title
from film
where rating = 'PG-13' or length >180;


-- 9º Encuentra la variabilidad de lo que costaría reemplazar las películas. --
select 
AVG (replacement_cost) as costo_promedio_reemplazo,
STDDEV_POP(replacement_cost) as variabilidad_reemplazo 
from 
film;


-- 10º Encuentra la mayor y menor duración de una película de nuestra BBDD.--
SELECT
  MAX(length) AS mayor_duracion,
  MIN(length) AS menor_duracion
FROM
  film;


-- 11º Encuentra lo que costó el antepenúltimo alquiler ordenado por día.--
SELECT
  p.amount
FROM
  rental AS r
JOIN
  payment AS p
  ON r.rental_id = p.rental_id
ORDER BY
  r.rental_date DESC
LIMIT 1 OFFSET 2;

-- 12º Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC- 17’ ni ‘G’ en cuanto a su clasificación.--
SELECT
  title
FROM
  film
WHERE
  rating NOT IN ('NC-17', 'G');


-- 13º Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.--
SELECT
  rating,
  AVG(length) AS promedio_duracion
FROM
  film
GROUP BY
  rating;

-- 14º Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.--
SELECT
  title
FROM
  film
WHERE
  length > 180;

-- 15º ¿Cuánto dinero ha generado en total la empresa?--
SELECT
  SUM(amount) AS total_ganancias
FROM
  payment;

-- 16º Muestra los 10 clientes con mayor valor de id.--
SELECT
  first_name,
  last_name
FROM
  customer
ORDER BY
  customer_id DESC
LIMIT 10;


-- 17º Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.
SELECT
  a.first_name,
  a.last_name
FROM
  actor AS a
JOIN
  film_actor AS fa
  ON a.actor_id = fa.actor_id
JOIN
  film AS f
  ON fa.film_id = f.film_id
WHERE
  f.title = 'Egg Igby';

