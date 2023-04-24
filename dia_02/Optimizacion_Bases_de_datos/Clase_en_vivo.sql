/*1 - Con la base de datos “movies”, se propone crear una tabla temporal llamada “TWD” y guardar en la misma los episodios de 
todas las temporadas de “The Walking Dead”.*/

CREATE TEMPORARY TABLE TWD AS 
(
SELECT e.title, e.rating, e.release_date, sn.number
FROM series s
INNER JOIN seasons sn
ON s.id = sn.serie_id
INNER JOIN episodes e
ON sn.id = e.season_id
WHERE s.id = 3
);

/*2 - Realizar una consulta a la tabla temporal para ver los episodios de la primera temporada.*/

SELECT * FROM TWD WHERE number = 1;

/* En la base de datos “movies”, seleccionar una tabla donde crear un índice y luego chequear la creación del mismo. */
/* Analizar por qué crearía un índice en la tabla indicada y con qué criterio se elige/n el/los campos.*/

CREATE INDEX movies_rating ON movies(rating);
SHOW INDEXES FROM movies;

