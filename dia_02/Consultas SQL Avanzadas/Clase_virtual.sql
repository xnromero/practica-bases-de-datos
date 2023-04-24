/*CLASE VIRTUAL*/
/* 1 - Mostrar el título y el nombre del género de todas las series.*/

SELECT s.title, g.name
FROM series s
INNER JOIN genres g
ON s.genre_id = g.id;

/* 2 - Mostrar el título de los episodios, el nombre y apellido de los actores que trabajan en cada uno de ellos.*/

SELECT e.title, a.first_name, a.last_name
FROM actor_episode ae
INNER JOIN actors a
ON ae.actor_id = a.id
INNER JOIN episodes e
ON ae.episode_id = e.id;

/* 3 - Mostrar el título de todas las series y el total de temporadas que tiene cada una de ellas.*/

SELECT s.title, count(sn.id)
FROM series s
INNER JOIN seasons sn
ON s.id = sn.serie_id
GROUP BY s.id;

/* 4 - Mostrar el nombre de todos los géneros y la cantidad total de películas por cada uno, siempre que sea mayor o igual a 3.*/

SELECT g.name, count(m.id)
FROM movies m
INNER JOIN genres g
ON m.genre_id = g.id
GROUP BY g.name
HAVING count(m.id) >= 3;

/* 5 - Mostrar sólo el nombre y apellido de los actores que trabajan en todas las películas de la guerra de las galaxias y que estos no se repitan.*/

SELECT DISTINCT a.first_name, a.last_name
FROM actor_movie am
INNER JOIN actors a
ON am.actor_id = a.id
INNER JOIN movies m
ON am.movie_id = m.id
WHERE LOWER(m.title) like '%guerra de las galaxias%' ;
