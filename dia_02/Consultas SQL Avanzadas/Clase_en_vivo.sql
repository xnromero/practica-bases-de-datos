/* CLASE EN VIVO - PRÁCTICA RESUELTA EN CLASE */

INSERT INTO departamento VALUES
("D-000-1", "Software","Los Tigres"),
("D-000-2", "Sistemas", "Guadalupe"),
("D-000-3", "Contabilidad", "La Roca"),
("D-000-4", "Ventas", "Plata");

SELECT * FROM departamento;

INSERT INTO empleado VALUES 
/*("E-0001", "César", "Piñero", "Vendedor", "2018-12-05" ,80000, 15000, "D-000-4");*/
("E-0002", "Yosep", "Kowaleski", "Analista", "2015-07-14", 140000, 0, "D-000-2"),
("E-0003","Mariela", "Barrios", "Director", "2014-06-05", 185000, 0, "D-000-3"),
("E-0004", "Jonathan", "Aguilera", "Vendedor", "2015-06-03", 85000, 10000,"D-000-4"),
("E-0005", "Daniel", "Brezezicki", "Vendedor", "2018-03-03", 83000, 10000, "D-000-4"),
("E-0006", "Mito", "Barchuk", "Presidente", "2014-06-05", 190000, 0, "D-000-3"),
("E-0007", "Emilio", "Galarza", "Desarrollador", "2014-08-02", 60000, 0, "D-000-1");

SELECT * FROM empleado;

/*1 - Seleccionar el nombre, el puesto y la localidad de los departamentos donde trabajan los vendedores.*/

SELECT e.nombre, e.puesto, d.localidad
FROM empleado e
INNER JOIN departamento d 
ON e.depto_nro = d.depto_nro
WHERE e.puesto = "Vendedor";

/*2 - Visualizar los departamentos con más de cinco empleados.*/

SELECT *
FROM departamento d
WHERE (SELECT count(*) FROM empleado e WHERE e.depto_nro = d.depto_nro) >= 2;

SELECT d.*, count(*) as cantidad
FROM empleado e
INNER JOIN departamento d
ON e.depto_nro = d.depto_nro
GROUP BY e.depto_nro
HAVING cantidad >= 2;

/*3 - Mostrar el nombre, salario y nombre del departamento de los empleados que tengan el mismo puesto que ‘Mito Barchuk’.*/

SELECT e.nombre, e.salario, d.nombre_depto
FROM empleado e
INNER JOIN departamento d
ON e.depto_nro = d.depto_nro
WHERE e.puesto = (
				SELECT puesto
				FROM empleado
                WHERE apellido = "Barchuk");
                
/*4 - Mostrar los datos de los empleados que trabajan en el departamento de contabilidad, ordenados por nombre.*/

SELECT e.*
FROM empleado e
WHERE e.depto_nro = (
					SELECT depto_nro
                    FROM departamento
                    WHERE nombre_depto = "contabilidad")
ORDER BY e.nombre;

/*5 - Mostrar el nombre del empleado que tiene el salario más bajo.*/

SELECT e.nombre
FROM empleado e
WHERE e.salario = (
				SELECT MIN(e2.salario)
                FROM empleado e2
                );

/*6 - Mostrar los datos del empleado que tiene el salario más alto en el departamento de ‘Ventas’.*/

SELECT e.*
FROM empleado e
INNER JOIN departamento d
ON e.depto_nro = d.depto_nro
WHERE d.nombre_depto = "Ventas"
AND e.salario = (
				SELECT MAX(e2.salario)
                FROM empleado e2
                WHERE e2.depto_nro = d.depto_nro
);




