/*Agregar una película a la tabla movies.*/

INSERT INTO movies (id, title, rating, awards, release_date, length) VALUES 
(22, "The whale", 9.3, 5, "2022-06-01 00:00:00", 90);

SELECT * FROM genres;

/*Agregar un género a la tabla genres.*/

INSERT INTO genres VALUES 
(13, NOW(), NULL, "Thriller", 13, 1);

/*Asociar a la película del punto 1. genre el género creado en el punto 2.*/

UPDATE movies SET genre_id = 13 WHERE id = 22;

/*Modificar la tabla actors para que al menos un actor tenga como favorita la película agregada en el punto 1.*/

UPDATE actors SET favorite_movie_id = 22 WHERE id = 3;
SELECT * FROM actors;

/*Crear una tabla temporal copia de la tabla movies.*/
CREATE TEMPORARY TABLE movies_copy AS 
(
SELECT *
FROM movies
);

SELECT * FROM movies_copy;

/*Eliminar de esa tabla temporal todas las películas que hayan ganado menos de 5 awards.*/

DELETE FROM movies_copy
WHERE awards < 5;

/*SET SQL_SAFE_UPDATES = 0;*/

/*Obtener la lista de todos los géneros que tengan al menos una película.*/

SELECT g.name
FROM movies m
INNER JOIN genres g
ON m.genre_id = g.id
GROUP BY m.genre_id
HAVING COUNT(m.genre_id) >= 1;

/*Obtener la lista de actores cuya película favorita haya ganado más de 3 awards.*/

SELECT a.first_name, a.last_name
FROM actor_movie am
INNER JOIN movies m
ON am.movie_id = m.id
INNER join actors a
ON am.actor_id = a.id
WHERE awards > 3;

/*Crear un índice sobre el nombre en la tabla movies.*/

EXPLAIN SELECT title FROM movies WHERE title = "Titanic";
SHOW INDEXES FROM movies;

CREATE INDEX title_index ON movies(title);
