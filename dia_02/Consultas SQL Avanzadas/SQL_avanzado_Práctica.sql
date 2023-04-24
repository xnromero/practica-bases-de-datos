-- DDL

CREATE DATABASE IF NOT EXISTS biblioteca_db;
USE biblioteca_db;

CREATE TABLE IF NOT EXISTS libro (
	id_libro VARCHAR(15) NOT NULL,
    titulo VARCHAR(45) NOT NULL,
    editorial VARCHAR(45) NOT NULL,
    area VARCHAR(45) NOT NULL,
    PRIMARY KEY (`id_libro`)
);

CREATE TABLE IF NOT EXISTS autor (
	id_autor VARCHAR(15) NOT NULL,
    nombre VARCHAR(45) NOT NULL,
    nacionalidad VARCHAR(45) NOT NULL,
    PRIMARY KEY (`id_autor`)
);

CREATE TABLE IF NOT EXISTS estudiante (
	id_lector VARCHAR(15) NOT NULL,
    nombre VARCHAR(45) NOT NULL,
    apellido VARCHAR(45) NOT NULL,
    direccion VARCHAR(45) NOT NULL,
	carrera VARCHAR(45) NOT NULL,
	edad INT,
    PRIMARY KEY (`id_lector`)
);

CREATE TABLE IF NOT EXISTS libro_autor (
	id_libro_autor INT AUTO_INCREMENT,
    id_libro VARCHAR(15) NOT NULL,
    id_autor VARCHAR(15) NOT NULL,
	PRIMARY KEY (`id_libro_autor`),
	CONSTRAINT `fk_libro_autor_id_libro` FOREIGN KEY (`id_libro`) REFERENCES `libro` (`id_libro`),
    CONSTRAINT `fk_libro_autor_id_autor` FOREIGN KEY (`id_autor`) REFERENCES `autor` (`id_autor`)
);

CREATE TABLE IF NOT EXISTS prestamo (
	id_prestamo INT AUTO_INCREMENT,
	id_lector VARCHAR(15) NOT NULL,
    id_libro VARCHAR(15) NOT NULL,
    fecha_prestamo DATE NOT NULL,
    fecha_devolucion DATE NOT NULL,
    devuelto BOOLEAN,
	PRIMARY KEY (`id_prestamo`),
	CONSTRAINT `fk_prestamo_id_lector` FOREIGN KEY (`id_lector`) REFERENCES `estudiante` (`id_lector`),
	CONSTRAINT `fk_prestamos_id_libro` FOREIGN KEY (`id_libro`) REFERENCES `libro` (`id_libro`)
);

SHOW TABLES;

-- DML

INSERT INTO libro VALUES
("L-001", "El Universo: Guía de viaje", "GeoPlaneta", "Divulgación científica"),
("L-002", "La era de la información", "Alianza", "Internet"),
("L-003", "Harry Potter y la piedra filosofal", "Salamandra", "Fantasía"),
("L-004", "Harry Potter y la cámara secreta", "Salamandra", "Fantasía"),
("L-005", "Desarrollo de bases de datos", "Ra-Ma", "Bases de datos");

INSERT INTO autor VALUES
("A-001", "Oliver Berry", "Británica"),
("A-002", "Mark A. Garlick", "Británica"),
("A-003", "Mark Mackenzie", "Británica"),
("A-004", "Valerie Stimac", "Británica"),
("A-005", "Manuel Castells", "Española"),
("A-006", "J.K. Rowling", "Británica"),
("A-007", "Dolores Cuadra Fernandez", "Española");

INSERT INTO estudiante VALUES
("E-001", "Manuel", "Rodriguez", "Calle Falsa 123", "Literatura", 18),
("E-002", "Mariana", "Gómes", "Calle Falsa 123", "Informática", 19),
("E-003", "Pablo", "Perez", "Calle Falsa 123", "Informática", 25),
("E-004", "Filipo", "Galli", "Calle Falsa 123", "Astonomía", 18);

INSERT INTO libro_autor VALUES
(1, "L-001", "A-001"),
(2, "L-001", "A-002"),
(3, "L-001", "A-003"),
(4, "L-001", "A-004"),
(5, "L-002", "A-005"),
(6, "L-003", "A-006"),
(7, "L-004", "A-006"),
(8, "L-005", "A-007");

INSERT INTO prestamo VALUES
(1, "E-001", "L-003", "2021-04-05", "2021-04-12", false),
(2, "E-002", "L-002", "2021-07-09", "2021-07-16", true),
(3, "E-003", "L-005", "2021-07-09", "2021-07-16", false),
(4, "E-004", "L-001", "2021-05-05", "2021-05-12", true);


-- 1 - Listar los datos de los autores.

SELECT * FROM autor;

-- 2 - Listar nombre y edad de los estudiantes

SELECT nombre, edad FROM estudiante;

-- 3 - ¿Qué estudiantes pertenecen a la carrera informática?

SELECT * FROM estudiante WHERE carrera = "Informática";

-- 4 - ¿Qué autores son de nacionalidad francesa o italiana?

SELECT * FROM autor WHERE nacionalidad = "Española";

-- 5 - ¿Qué libros no son del área de internet?

SELECT * FROM libro WHERE area <> 'Internet';

-- 6 - Listar los libros de la editorial Salamandra.

SELECT * FROM libro WHERE editorial = "Salamandra";

-- 7 - Listar los datos de los estudiantes cuya edad es mayor al promedio.

SELECT * 
FROM estudiante
WHERE edad > (SELECT AVG(edad) FROM estudiante) ;

-- 8 - Listar los nombres de los estudiantes cuyo apellido comience con la letra G.

SELECT * FROM estudiante WHERE apellido LIKE 'G%';

-- 9 - Listar los autores del libro “El Universo: Guía de viaje”. (Se debe listar solamente los nombres).

SELECT a.nombre
FROM libro_autor la
INNER JOIN libro l
ON la.id_libro = l.id_libro
INNER JOIN autor a
ON la.id_autor = a.id_autor
WHERE l.titulo = "El Universo: Guía de viaje";

-- 10 - ¿Qué libros se prestaron al lector “Filippo Galli”?

SELECT l.titulo
FROM prestamo p
INNER JOIN estudiante e
ON p.id_lector = e.id_lector
INNER JOIN libro l
ON p.id_libro = l.id_libro
WHERE e.nombre = "Filipo" AND e.apellido = "Galli";

-- 11 - Listar el nombre del estudiante de menor edad.

SELECT e.nombre
FROM estudiante e
WHERE e.edad = (SELECT MIN(edad) FROM estudiante);

-- 12 - Listar nombres de los estudiantes a los que se prestaron libros de Base de Datos.

SELECT e.nombre, e.apellido
FROM prestamo p
INNER JOIN estudiante e
ON p.id_lector = e.id_lector
INNER JOIN libro l
ON p.id_libro = l.id_libro
WHERE l.area = "Bases de datos";

-- 13 - Listar los libros que pertenecen a la autora J.K. Rowling.

SELECT l.*
FROM libro_autor la
INNER JOIN libro l
ON la.id_libro = l.id_libro
INNER JOIN autor a
ON la.id_autor = a.id_autor
WHERE a.nombre = "J.K. Rowling";

-- 14 - Listar títulos de los libros que debían devolverse el 16/07/2021.

SELECT l.titulo
FROM prestamo p
INNER JOIN libro l
ON p.id_libro = l.id_libro
WHERE fecha_devolucion = DATE("2021-07-16")




