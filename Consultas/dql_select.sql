-- Consultas

use parqueNatural;


-- 100 consultas
-- clasificadas en:
--  #1. Estados Actual de parques
-- #2. inventarios de especie por areas y tipos
-- #3. Actividades del personal segun tipo, areas asignadas y sueldos
-- #4. estadisticas de proyectos de investigación: costos, especies, involucradas y equipos
-- #5. gestión de visitantes y ocupaciones de alojamiento
-- #6. consultas avanzadas (con subconsultas)



-- #1. ESTADO ACTUAL DE PARQUES


--  1. la cantidad de parques por departamento

SELECT d.nombre AS departamento,
       COUNT(dp.id_parque) AS cantidad_parques
FROM departamento d
JOIN departamento_parque_natural dp ON d.id = dp.id_departamento
GROUP BY d.id, d.nombre;



-- 2. la cantidad de parques por departamento pero tambien mostrando el id

SELECT d.id AS id_departamento,
       d.nombre AS departamento,
       COUNT(*) AS cantidad_parques
FROM departamento d
JOIN departamento_parque_natural dp ON d.id = dp.id_departamento
GROUP BY d.id, d.nombre;



-- 3. Superficie total suma total de los parques asociados a departamentos

SELECT d.nombre AS departamento,
       SUM(a.extencion_area) AS superficie_total
FROM departamento d
JOIN departamento_parque_natural dp ON d.id = dp.id_departamento
JOIN area a ON dp.id_parque = a.id_area
GROUP BY d.nombre;


-- 4 Superficie promedio declarada por parque en cada departamento:

SELECT d.nombre AS departamento,
       AVG(a.extencion_area) AS superficie_promedio
FROM departamento d
JOIN departamento_parque_natural dp ON d.id = dp.id_departamento
JOIN area a ON dp.id_parque = a.id_area
GROUP BY d.nombre;


-- 5 máxima extensión registrada por departamento

SELECT d.nombre AS departamento,
       MAX(a.extencion_area) AS mayor_superficie
FROM departamento d
JOIN departamento_parque_natural dp ON d.id = dp.id_departamento
JOIN area a ON dp.id_parque = a.id_area
GROUP BY d.nombre;




-- 6 mínima extensión registrada por departamento


SELECT d.nombre AS departamento,
       MIN(a.extencion_area) AS menor_superficie
FROM departamento d
JOIN departamento_parque_natural dp ON d.id = dp.id_departamento
JOIN area a ON dp.id_parque = a.id_area
GROUP BY d.nombre;



-- 7 devuelve un listado detallado, departamento, parque y superficie

SELECT d.nombre AS departamento,
       a.nombre AS parque,
       a.extencion_area
FROM departamento d
JOIN departamento_parque_natural dp ON d.id = dp.id_departamento
JOIN area a ON dp.id_parque = a.id_area
ORDER BY d.nombre;

-- 8  Listado de departamentos cuya superficie total declarada supera un tope , 300

SELECT d.nombre AS departamento,
       SUM(a.extencion_area) AS superficie_total
FROM departamento d
JOIN departamento_parque_natural dp ON d.id = dp.id_departamento
JOIN area a ON dp.id_parque = a.id_area
GROUP BY d.nombre
HAVING SUM(a.extencion_area) > 300;



-- 9 Listado de departamentos con superficie total menor a 500


SELECT d.nombre AS departamento,
       SUM(a.extencion_area) AS superficie_total
FROM departamento d
JOIN departamento_parque_natural dp ON d.id = dp.id_departamento
JOIN area a ON dp.id_parque = a.id_area
GROUP BY d.nombre
HAVING SUM(a.extencion_area) < 500;



-- 10 Departamento y parque con superficie individual mayor a 100

SELECT d.nombre AS departamento, a.nombre AS parque, a.extencion_area
FROM departamento d
JOIN departamento_parque_natural dp ON d.id = dp.id_departamento
JOIN area a ON dp.id_parque = a.id_area
WHERE a.extencion_area > 100;




-- 11 Departamento y superficie máxima de un parque

SELECT d.nombre AS departamento, MAX(a.extencion_area) AS mayor_superficie
FROM departamento d
JOIN departamento_parque_natural dp ON d.id = dp.id_departamento
JOIN area a ON dp.id_parque = a.id_area
GROUP BY d.nombre;







-- 12 promedio parque por departamento

SELECT (SELECT COUNT(*) FROM departamento_parque_natural)
/ (SELECT COUNT(*) FROM departamento) AS promedio_parques;






-- 13 Superficie total y cantidad de parques en departamentos
--  cuyo nombre inicia con 'A'


SELECT d.nombre AS departamento,
       COUNT(dp.id_parque) AS cantidad_parques,
       SUM(a.extencion_area) AS superficie_total
FROM departamento d
JOIN departamento_parque_natural dp ON d.id = dp.id_departamento
JOIN area a ON dp.id_parque = a.id_area
WHERE d.nombre LIKE 'A%'
GROUP BY d.nombre;



-- 14 Departamento con la mayor superficie promedio por parque:

SELECT d.nombre AS departamento,
       AVG(a.extencion_area) AS promedio_superficie
FROM departamento d
JOIN departamento_parque_natural dp ON d.id = dp.id_departamento
JOIN area a ON dp.id_parque = a.id_area
GROUP BY d.nombre
ORDER BY promedio_superficie DESC
LIMIT 1;



-- 15 Departamento con la menor superficie promedio por parque:

SELECT d.nombre AS departamento,
       AVG(a.extencion_area) AS promedio_superficie
FROM departamento d
JOIN departamento_parque_natural dp ON d.id = dp.id_departamento
JOIN area a ON dp.id_parque = a.id_area
GROUP BY d.nombre
ORDER BY promedio_superficie ASC
LIMIT 1;


-- 16 Detalle de cada parque con su departamento y la extensión redondeada a 2 decimales:

SELECT d.nombre AS departamento,
       a.nombre AS parque,
       ROUND(a.extencion_area, 2) AS extencion_redondeada
FROM departamento d
JOIN departamento_parque_natural dp ON d.id = dp.id_departamento
JOIN area a ON dp.id_parque = a.id_area;



-- 17 Conteo de departamentos que tienen al menos 1 parque:

SELECT COUNT(DISTINCT d.id) AS departamentos_con_parques
FROM departamento d
JOIN departamento_parque_natural dp ON d.id = dp.id_departamento;



-- 18 Promedio de extensión total por departamento

SELECT AVG(superficie_total) AS promedio_extension
FROM (
  SELECT SUM(a.extencion_area) AS superficie_total
  FROM departamento d
  JOIN departamento_parque_natural dp ON d.id = dp.id_departamento
  JOIN area a ON dp.id_parque = a.id_area
  GROUP BY d.id
) AS subconsulta;


-- 19 Departamentos con extensión total entre 200 y 800

SELECT d.nombre AS departamento,
       SUM(a.extencion_area) AS superficie_total
FROM departamento d
JOIN departamento_parque_natural dp ON d.id = dp.id_departamento
JOIN area a ON dp.id_parque = a.id_area
GROUP BY d.nombre
HAVING SUM(a.extencion_area) BETWEEN 200 AND 800;


-- 20 Listado de departamentos sin parques (usando LEFT JOIN)

 SELECT d.nombre AS departamento
FROM departamento d
LEFT JOIN departamento_parque_natural dp ON d.id = dp.id_departamento
WHERE dp.id_departamento IS NULL;






-- 21 Listado de parques y su departamento, ordenados por extensión ascendente


SELECT d.nombre AS departamento,
       a.nombre AS parque,
       a.extencion_area
FROM departamento d
JOIN departamento_parque_natural dp ON d.id = dp.id_departamento
JOIN area a ON dp.id_parque = a.id_area
ORDER BY a.extencion_area ASC;




-- 22 Cantidad de parques agrupados por rango de extensión


SELECT CASE 
         WHEN a.extencion_area BETWEEN 0 AND 50 THEN '0-50'
         WHEN a.extencion_area BETWEEN 51 AND 100 THEN '51-100'
         WHEN a.extencion_area BETWEEN 101 AND 150 THEN '101-150'
         ELSE '150+'
       END AS rango,
       COUNT(*) AS cantidad_parques
FROM area a
GROUP BY rango;



-- 23 Total de extensión por parque individualmente sin agrupar por departamento


SELECT a.nombre AS parque, a.extencion_area
FROM area a;




-- 24 Departamento con mayor número de parques cuyo nombre contiene la letra 'a'

SELECT d.nombre AS departamento,
       COUNT(dp.id_parque) AS cantidad_parques
FROM departamento d
JOIN departamento_parque_natural dp ON d.id = dp.id_departamento
JOIN area a ON dp.id_parque = a.id_area
WHERE a.nombre LIKE '%a%'
GROUP BY d.nombre
ORDER BY cantidad_parques DESC
LIMIT 1;




-- 25 Número de departamentos que tienen parques con extensión superior a 75


SELECT COUNT(DISTINCT d.id) AS departamentos
FROM departamento d
JOIN departamento_parque_natural dp ON d.id = dp.id_departamento
JOIN area a ON dp.id_parque = a.id_area
WHERE a.extencion_area > 75;


-- 26 detalle completo


SELECT d.nombre AS departamento,
       a.nombre AS parque,
       a.extencion_area
FROM departamento d
JOIN departamento_parque_natural dp ON d.id = dp.id_departamento
JOIN area a ON dp.id_parque = a.id_area
ORDER BY d.nombre, a.nombre;



-- 27 Listado de departamentos con parques cuyo nombre empieza por 'P' en la 
-- tabla area


SELECT DISTINCT d.nombre AS departamento
FROM departamento d
JOIN departamento_parque_natural dp ON d.id = dp.id_departamento
JOIN area a ON dp.id_parque = a.id_area
WHERE a.nombre LIKE 'P%';



-- 28 Suma de extensiones de parques por departamento, redondeada a enteros

SELECT d.nombre AS departamento,
       ROUND(SUM(a.extencion_area)) AS superficie_total_redondeada
FROM departamento d
JOIN departamento_parque_natural dp ON d.id = dp.id_departamento
JOIN area a ON dp.id_parque = a.id_area
GROUP BY d.nombre;


-- 29 Promedio de extensión de parques a nivel global

SELECT AVG(a.extencion_area) AS promedio_global
FROM area a;


-- 30 Departamento y el porcentaje de la superficie total global que posee

-- (sub-consultas)

SELECT d.nombre AS departamento,
       (SUM(a.extencion_area) / (SELECT SUM(extencion_area) FROM area) * 100) AS porcentaje_global
FROM departamento d
JOIN departamento_parque_natural dp ON d.id = dp.id_departamento
JOIN area a ON dp.id_parque = a.id_area
GROUP BY d.nombre;


-- 31 Departamento y cantidad de parques, filtrando solo aquellos
-- con parque de extensión mayor a 50

SELECT d.nombre AS departamento,
       COUNT(dp.id_parque) AS cantidad_parques
FROM departamento d
JOIN departamento_parque_natural dp ON d.id = dp.id_departamento
JOIN area a ON dp.id_parque = a.id_area
WHERE a.extencion_area > 50
GROUP BY d.nombre;




-- 32 Listado de departamentos y la lista de nombres de parques asociados


SELECT d.nombre AS departamento,
       GROUP_CONCAT(a.nombre SEPARATOR ', ') AS parques
FROM departamento d
JOIN departamento_parque_natural dp ON d.id = dp.id_departamento
JOIN area a ON dp.id_parque = a.id_area
GROUP BY d.nombre;





-- 33 Detalle de parques con extensión mayor al promedio global, junto con su departamento

SELECT d.nombre AS departamento,
       a.nombre AS parque,
       a.extencion_area
FROM departamento d
JOIN departamento_parque_natural dp ON d.id = dp.id_departamento
JOIN area a ON dp.id_parque = a.id_area
WHERE a.extencion_area > (SELECT AVG(extencion_area) FROM area);




-- 34 Departamento y cantidad de parques, usando ORDER BY cantidad de parques
-- con orden desedente


SELECT d.nombre AS departamento,
       COUNT(dp.id_parque) AS cantidad_parques
FROM departamento d
JOIN departamento_parque_natural dp ON d.id = dp.id_departamento
GROUP BY d.nombre
ORDER BY cantidad_parques DESC;



-- 35 Cantidad de departamentos que tienen una superficie total declarada mayor
--  a la superficie promedio de todos los departamentos:



-- (Consultas Avanzadas)

SELECT COUNT(*) AS departamentos_superiores
FROM (
  SELECT d.id, SUM(a.extencion_area) AS superficie_total
  FROM departamento d
  JOIN departamento_parque_natural dp ON d.id = dp.id_departamento
  JOIN area a ON dp.id_parque = a.id_area
  GROUP BY d.id
  HAVING SUM(a.extencion_area) > (SELECT AVG(sub.extencion_area_total)
                                  FROM (SELECT SUM(a.extencion_area) AS extencion_area_total
                                        FROM departamento d
                                        JOIN departamento_parque_natural dp ON d.id = dp.id_departamento
                                        JOIN area a ON dp.id_parque = a.id_area
                                        GROUP BY d.id) AS sub)
) AS departamentos_resultado;





-- #2. inventarios de especie por areas y tipos


-- 36  Total de individuos por área suma de todas las especies en cada área

SELECT a.nombre AS Area, SUM(ae.numero_individuos_area) AS Total_Individuos
FROM area a
JOIN area_especie ae ON a.id_area = ae.id_area
GROUP BY a.id_area, a.nombre;


-- 37 Total de individuos global por tipo de especie

SELECT e.tipo_especie, SUM(ae.numero_individuos_area) AS Total_Individuos
FROM especie e
JOIN area_especie ae ON e.id = ae.id_especie
GROUP BY e.tipo_especie;


-- 38 Promedio de individuos por área para cada tipo de especie

SELECT e.tipo_especie, a.nombre AS Area, AVG(ae.numero_individuos_area) AS Promedio_Individuos
FROM area a
JOIN area_especie ae ON a.id_area = ae.id_area
JOIN especie e ON ae.id_especie = e.id
GROUP BY e.tipo_especie, a.id_area, a.nombre;



-- 39 Detalle de inventario por área cantidad total de especies registradas y suma de individuos

SELECT a.nombre AS Area, COUNT(DISTINCT ae.id_especie) AS Cantidad_Especies, SUM(ae.numero_individuos_area) AS Total_Individuos
FROM area a
JOIN area_especie ae ON a.id_area = ae.id_area
GROUP BY a.id_area, a.nombre;




-- 40 Listado de registros de inventario ordenados por número de individuos desendente

SELECT a.nombre AS Area, e.denominacion_vulgar AS Especie, ae.numero_individuos_area
FROM area_especie ae
JOIN area a ON ae.id_area = a.id_area
JOIN especie e ON ae.id_especie = e.id
ORDER BY ae.numero_individuos_area DESC;




-- 41 Área con el mayor número de individuos total en el área



SELECT a.nombre AS Area, SUM(ae.numero_individuos_area) AS Total_Individuos
FROM area a
JOIN area_especie ae ON a.id_area = ae.id_area
GROUP BY a.id_area, a.nombre
ORDER BY Total_Individuos DESC
LIMIT 1;



-- 42 Área con el menor número de individuos (total en el área)

SELECT a.nombre AS Area, SUM(ae.numero_individuos_area) AS Total_Individuos
FROM area a
JOIN area_especie ae ON a.id_area = ae.id_area
GROUP BY a.id_area, a.nombre
ORDER BY Total_Individuos ASC
LIMIT 1;




-- 43 Top 5 áreas con mayor cantidad de individuos:


SELECT a.nombre AS Area, SUM(ae.numero_individuos_area) AS Total_Individuos
FROM area a
JOIN area_especie ae ON a.id_area = ae.id_area
GROUP BY a.id_area, a.nombre
ORDER BY Total_Individuos DESC
LIMIT 5;



-- 44 Inventario detallado por área (cada especie y su cantidad)


SELECT a.nombre AS Area, e.denominacion_cientifica AS Especie, ae.numero_individuos_area
FROM area a
JOIN area_especie ae ON a.id_area = ae.id_area
JOIN especie e ON ae.id_especie = e.id
ORDER BY a.nombre, e.denominacion_cientifica;





-- 45 Inventario agrupado por tipo de especie y área

SELECT a.nombre AS Area, e.tipo_especie, SUM(ae.numero_individuos_area) AS Total_Individuos
FROM area a
JOIN area_especie ae ON a.id_area = ae.id_area
JOIN especie e ON ae.id_especie = e.id
GROUP BY a.nombre, e.tipo_especie;




-- 46 Áreas con al menos 50 individuos en total

SELECT a.nombre AS Area, SUM(ae.numero_individuos_area) AS Total_Individuos
FROM area a
JOIN area_especie ae ON a.id_area = ae.id_area
GROUP BY a.id_area, a.nombre
HAVING Total_Individuos >= 50;




-- 47 Áreas con menos de 20 individuos en total

SELECT a.nombre AS Area, SUM(ae.numero_individuos_area) AS Total_Individuos
FROM area a
JOIN area_especie ae ON a.id_area = ae.id_area
GROUP BY a.id_area, a.nombre
HAVING Total_Individuos < 20;



-- 48 Extensión total de área agrupada por tipo de especie (suma de extensión de áreas que tienen al menos una especie de cada tipo)

SELECT e.tipo_especie, SUM(a.extencion_area) AS Suma_Extencion
FROM area a
JOIN area_especie ae ON a.id_area = ae.id_area
JOIN especie e ON ae.id_especie = e.id
GROUP BY e.tipo_especie;


-- 49 Listado de áreas sin registros en el inventario áreas sin correspondencia en area_especie

SELECT a.nombre AS Area, a.extencion_area
FROM area a
LEFT JOIN area_especie ae ON a.id_area = ae.id_area
WHERE ae.id_area IS NULL;



-- 50 Número de áreas en las que aparece cada especie

SELECT e.denominacion_vulgar AS Especie, COUNT(DISTINCT ae.id_area) AS Areas_Presentes
FROM especie e
JOIN area_especie ae ON e.id = ae.id_especie
GROUP BY e.id, e.denominacion_vulgar;





-- 51 Total de individuos por especie en todas las áreas


SELECT e.denominacion_vulgar AS Especie, SUM(ae.numero_individuos_area) AS Total_Individuos
FROM especie e
JOIN area_especie ae ON e.id = ae.id_especie
GROUP BY e.id, e.denominacion_vulgar;





-- 52 Listado de especies con menos de 10 individuos en total


SELECT e.denominacion_vulgar AS Especie, SUM(ae.numero_individuos_area) AS Total_Individuos
FROM especie e
JOIN area_especie ae ON e.id = ae.id_especie
GROUP BY e.id, e.denominacion_vulgar
HAVING Total_Individuos < 10;





-- 53 Listado de especies con más de 100 individuos en total



SELECT e.denominacion_vulgar AS Especie, SUM(ae.numero_individuos_area) AS Total_Individuos
FROM especie e
JOIN area_especie ae ON e.id = ae.id_especie
GROUP BY e.id, e.denominacion_vulgar
HAVING Total_Individuos > 100;




-- 54 Especies con el mayor número de individuos en cada área


SELECT a.nombre AS Area, e.denominacion_vulgar AS Especie, ae.numero_individuos_area
FROM area a
JOIN area_especie ae ON a.id_area = ae.id_area
JOIN especie e ON ae.id_especie = e.id
WHERE (a.id_area, ae.numero_individuos_area) IN (
  SELECT id_area, MAX(numero_individuos_area)
  FROM area_especie
  GROUP BY id_area
)
ORDER BY a.nombre;





-- 55 Áreas con un promedio de individuos por especie mayor a 20


SELECT a.nombre AS Area, AVG(ae.numero_individuos_area) AS Promedio_Individuos
FROM area a
JOIN area_especie ae ON a.id_area = ae.id_area
GROUP BY a.id_area, a.nombre
HAVING Promedio_Individuos > 20;



-- 56 Número de especies distintas presentes en cada área


SELECT a.nombre AS Area, COUNT(DISTINCT ae.id_especie) AS Cantidad_Especies
FROM area a
JOIN area_especie ae ON a.id_area = ae.id_area
GROUP BY a.id_area, a.nombre;


-- 57 Promedio de individuos por especie en cada área

SELECT a.nombre AS Area, AVG(ae.numero_individuos_area) AS Promedio_Individuos
FROM area a
JOIN area_especie ae ON a.id_area = ae.id_area
GROUP BY a.id_area, a.nombre;



-- 58 Resumen de inventario por área extensión y total de individuos

SELECT a.nombre AS Area, a.extencion_area, SUM(ae.numero_individuos_area) AS Total_Individuos
FROM area a
JOIN area_especie ae ON a.id_area = ae.id_area
GROUP BY a.id_area, a.nombre, a.extencion_area;



-- 59 Razón de individuos por unidad de extensión para cada área


SELECT a.nombre AS Area, 
       SUM(ae.numero_individuos_area) / a.extencion_area AS Ratio_Individuos_Extencion
FROM area a
JOIN area_especie ae ON a.id_area = ae.id_area
GROUP BY a.id_area, a.nombre, a.extencion_area;



-- 60 Inventario por área con detalle del tipo de especie


SELECT a.nombre AS Area, e.denominacion_vulgar AS Especie, e.tipo_especie, ae.numero_individuos_area
FROM area a
JOIN area_especie ae ON a.id_area = ae.id_area
JOIN especie e ON ae.id_especie = e.id
ORDER BY a.nombre, e.tipo_especie;





-- 61  Inventario agrupado por área y tipo de especie

SELECT a.nombre AS Area, e.tipo_especie, SUM(ae.numero_individuos_area) AS Total_Individuos
FROM area a
JOIN area_especie ae ON a.id_area = ae.id_area
JOIN especie e ON ae.id_especie = e.id
GROUP BY a.nombre, e.tipo_especie;




-- 62 Inventario de especies de tipo 'animal' por área

SELECT a.nombre AS Area, SUM(ae.numero_individuos_area) AS Total_Animales
FROM area a
JOIN area_especie ae ON a.id_area = ae.id_area
JOIN especie e ON ae.id_especie = e.id
WHERE e.tipo_especie = 'animal'
GROUP BY a.id_area, a.nombre;



-- 63 Inventario de especies de tipo 'vegetal' por área


SELECT a.nombre AS Area, SUM(ae.numero_individuos_area) AS Total_Vegetales
FROM area a
JOIN area_especie ae ON a.id_area = ae.id_area
JOIN especie e ON ae.id_especie = e.id
WHERE e.tipo_especie = 'vegetal'
GROUP BY a.id_area, a.nombre;




-- 64 Inventario de especies de tipo 'mineral' por área

SELECT a.nombre AS Area, SUM(ae.numero_individuos_area) AS Total_Minerales
FROM area a
JOIN area_especie ae ON a.id_area = ae.id_area
JOIN especie e ON ae.id_especie = e.id
WHERE e.tipo_especie = 'mineral'
GROUP BY a.id_area, a.nombre;



-- 65 Áreas donde el total de individuos supera 100


SELECT a.nombre AS Area, SUM(ae.numero_individuos_area) AS Total_Individuos
FROM area a
JOIN area_especie ae ON a.id_area = ae.id_area
GROUP BY a.id_area, a.nombre
HAVING Total_Individuos > 100;



-- 66 Áreas donde el total de individuos es menor a 30

SELECT a.nombre AS Area, SUM(ae.numero_individuos_area) AS Total_Individuos
FROM area a
JOIN area_especie ae ON a.id_area = ae.id_area
GROUP BY a.id_area, a.nombre
HAVING Total_Individuos < 30;


-- 67 Número de áreas en las que aparece cada especie (solo aquellas que aparecen en más de 3 áreas)

SELECT e.denominacion_vulgar AS Especie, COUNT(DISTINCT ae.id_area) AS Areas_Presentes
FROM especie e
JOIN area_especie ae ON e.id = ae.id_especie
GROUP BY e.id, e.denominacion_vulgar
HAVING Areas_Presentes > 3;



-- 68 Listado de especies que aparecen exactamente en un área

SELECT e.denominacion_vulgar AS Especie, COUNT(DISTINCT ae.id_area) AS Areas_Presentes
FROM especie e
JOIN area_especie ae ON e.id = ae.id_especie
GROUP BY e.id, e.denominacion_vulgar
HAVING Areas_Presentes = 1;


-- 69  Especie con mayor número de individuos en cada área (por área, la especie con mayor inventario)

SELECT a.nombre AS Area, e.denominacion_vulgar AS Especie, ae.numero_individuos_area
FROM area a
JOIN area_especie ae ON a.id_area = ae.id_area
JOIN especie e ON ae.id_especie = e.id
WHERE (a.id_area, ae.numero_individuos_area) IN (
  SELECT id_area, MAX(numero_individuos_area)
  FROM area_especie
  GROUP BY id_area
);



-- 70 Resumen por área: cantidad de especies, total de individuos y promedio por especie

SELECT a.nombre AS Area,
       COUNT(DISTINCT ae.id_especie) AS Cantidad_Especies,
       SUM(ae.numero_individuos_area) AS Total_Individuos,
       AVG(ae.numero_individuos_area) AS Promedio_Individuos
FROM area a
JOIN area_especie ae ON a.id_area = ae.id_area
GROUP BY a.id_area, a.nombre;




-- 71  Detalle de inventario para áreas con extensión mayor a 100

SELECT a.nombre AS Area, a.extencion_area, e.denominacion_vulgar AS Especie, ae.numero_individuos_area
FROM area a
JOIN area_especie ae ON a.id_area = ae.id_area
JOIN especie e ON ae.id_especie = e.id
WHERE a.extencion_area > 100
ORDER BY a.nombre;




-- 72 Inventario detallado: áreas y especies, ordenados por nombre del área y de la especie:

SELECT a.nombre AS Area, e.denominacion_vulgar AS Especie, ae.numero_individuos_area
FROM area a
JOIN area_especie ae ON a.id_area = ae.id_area
JOIN especie e ON ae.id_especie = e.id
ORDER BY a.nombre, e.denominacion_vulgar;



-- 73 Total global de individuos por cada tipo de especie:

SELECT e.tipo_especie, SUM(ae.numero_individuos_area) AS Total_Individuos
FROM especie e
JOIN area_especie ae ON e.id = ae.id_especie
GROUP BY e.tipo_especie;



-- 74  Inventario detallado para áreas, mostrando solo aquellos registros con más de 10 individuos

SELECT a.nombre AS Area, e.denominacion_vulgar AS Especie, ae.numero_individuos_area
FROM area a
JOIN area_especie ae ON a.id_area = ae.id_area
JOIN especie e ON ae.id_especie = e.id
WHERE ae.numero_individuos_area > 10;




-- #3. Actividades del personal segun tipo, areas asignadas y sueldos



-- 75 Listado general del personal con sus áreas asignadas y sueldo
-- Muestra el nombre, tipo de personal, sueldo y el nombre
--  del área asignada de personal_vigilancia y área 


SELECT p.id_personal, p.nombre, p.tipo_personal, p.sueldo, a.nombre AS Area
FROM personal p
JOIN personal_vigilancia pv ON p.id_personal = pv.id_personal
JOIN area a ON pv.id_area = a.id_area
ORDER BY p.tipo_personal, p.nombre;





-- 76 Sueldo total y promedio por tipo de personal
-- Agrupa por tipo y muestra la suma total y el sueldo promedio.


SELECT tipo_personal,
       SUM(sueldo) AS Sueldo_Total,
       AVG(sueldo) AS Sueldo_Promedio
FROM personal
GROUP BY tipo_personal;


-- 77 Número de personal asignado a cada área, por tipo de personal
-- Cuenta cuántos empleados (por tipo) están asignados en cada área

SELECT a.nombre AS Area, p.tipo_personal, COUNT(*) AS Cantidad_Personal
FROM personal p
JOIN personal_vigilancia pv ON p.id_personal = pv.id_personal
JOIN area a ON pv.id_area = a.id_area
GROUP BY a.nombre, p.tipo_personal;


-- 78 Promedio de sueldo de personal asignado en cada área
-- Se muestra el nombre del área y el sueldo promedio de los empleados asignados a esa área

SELECT a.nombre AS Area, AVG(p.sueldo) AS Sueldo_Promedio
FROM area a
JOIN personal_vigilancia pv ON a.id_area = pv.id_area
JOIN personal p ON pv.id_personal = p.id_personal
GROUP BY a.id_area, a.nombre;




-- 79 Listado del personal con información de su vehículo y área asignada
-- Une personal , personal_vigilancia , vehiculo y area para mostrar detalles completos


SELECT p.nombre AS Personal, p.tipo_personal, p.sueldo,
       a.nombre AS Area, v.tipo AS Tipo_Vehiculo, v.marca AS Marca_Vehiculo
FROM personal p
JOIN personal_vigilancia pv ON p.id_personal = pv.id_personal
JOIN area a ON pv.id_area = a.id_area
JOIN vehiculo v ON pv.id_vehiculo = v.id
ORDER BY p.nombre;



-- 80 Personal asignado a proyectos de investigación
-- Muestra el nombre del personal, su sueldo y el nombre del proyecto usando personal_proyecto y proyecto_investigacion 

SELECT p.nombre AS Personal, p.sueldo, pi.nombre AS Proyecto, pi.presupuesto
FROM personal p
JOIN personal_proyecto pp ON p.id_personal = pp.id_personal
JOIN proyecto_investigacion pi ON pp.id_proyecto = pi.id_proyecto
ORDER BY p.nombre;



-- 81 Personal sin asignación de vigilancia (sin área asignada en personal_vigilancia)
-- Lista el personal que no tiene registros en la tabla de vigilancia.


SELECT p.id_personal, p.nombre, p.tipo_personal, p.sueldo
FROM personal p
LEFT JOIN personal_vigilancia pv ON p.id_personal = pv.id_personal
WHERE pv.id_personal IS NULL;




-- 82 top 5 personal con mayor sueldo y su área asignada
-- Muestra los cinco empleados mejores remunerados junto con el área en la que trabajan si están asignados

SELECT p.nombre AS Personal, p.sueldo, a.nombre AS Area
FROM personal p
LEFT JOIN personal_vigilancia pv ON p.id_personal = pv.id_personal
LEFT JOIN area a ON pv.id_area = a.id_area
ORDER BY p.sueldo DESC
LIMIT 5;




-- 83 Sueldo promedio del personal por cada área según asignación en personal_vigilancia

SELECT a.nombre AS Area, AVG(p.sueldo) AS Sueldo_Promedio
FROM area a
JOIN personal_vigilancia pv ON a.id_area = pv.id_area
JOIN personal p ON pv.id_personal = p.id_personal
GROUP BY a.nombre;


-- 84 Personal de tipo '001' y sus áreas asignadas, ordenadas por sueldo descendente


SELECT p.nombre AS Personal, p.sueldo, a.nombre AS Area
FROM personal p
JOIN personal_vigilancia pv ON p.id_personal = pv.id_personal
JOIN area a ON pv.id_area = a.id_area
WHERE p.tipo_personal = '001'
ORDER BY p.sueldo DESC;



-- 85 Cantidad de proyectos asignados a cada personal y su sueldo
-- Utilizando personal_proyecto , se cuenta el número de proyectos asignados a cada empleado.


SELECT p.nombre AS Personal, p.sueldo, COUNT(pp.id_proyecto) AS Cantidad_Proyectos
FROM personal p
JOIN personal_proyecto pp ON p.id_personal = pp.id_personal
GROUP BY p.id_personal, p.nombre, p.sueldo;



-- 86 Resumen por tipo de personal: cantidad de empleados, sueldo total y sueldo promedio


SELECT p.tipo_personal,
       COUNT(*) AS Cantidad_Empleados,
       SUM(p.sueldo) AS Sueldo_Total,
       AVG(p.sueldo) AS Sueldo_Promedio
FROM personal p
GROUP BY p.tipo_personal;



-- 87 Comparación de sueldo de personal y presupuesto de proyectos asignados
-- Muestra el personal, su sueldo y la suma de presupuestos de los proyectos en los que participan

SELECT p.nombre AS Personal, p.sueldo, SUM(pi.presupuesto) AS Total_Presupuesto
FROM personal p
JOIN personal_proyecto pp ON p.id_personal = pp.id_personal
JOIN proyecto_investigacion pi ON pp.id_proyecto = pi.id_proyecto
GROUP BY p.id_personal, p.nombre, p.sueldo;




-- 88 Listado del personal y el tipo de vehículo que usan en vigilancia, agrupados por área


SELECT a.nombre AS Area, p.nombre AS Personal, v.tipo AS Tipo_Vehiculo, v.marca AS Marca_Vehiculo
FROM personal p
JOIN personal_vigilancia pv ON p.id_personal = pv.id_personal
JOIN area a ON pv.id_area = a.id_area
JOIN vehiculo v ON pv.id_vehiculo = v.id
ORDER BY a.nombre, p.nombre;



-- 89  Resumen general: por cada tipo de personal, cantidad de empleados, suma y promedio de sueldos, y número total de áreas asignadas
-- Se utiliza una subconsulta para contar áreas asignadas.


SELECT p.tipo_personal,
       COUNT(*) AS Cantidad_Empleados,
       SUM(p.sueldo) AS Sueldo_Total,
       AVG(p.sueldo) AS Sueldo_Promedio,
       (SELECT COUNT(DISTINCT pv.id_area)
        FROM personal_vigilancia pv
        WHERE pv.id_personal IN (SELECT id_personal FROM personal WHERE tipo_personal = p.tipo_personal)
       ) AS Total_Areas_Asignadas
FROM personal p
GROUP BY p.tipo_personal;

--  gestión de visitantes y ocupaciones de alojamiento y subconsultas


-- 90 Visitantes sin ocupación en alojamiento en los últimos 30 días
-- Esta consulta lista los visitantes que no han ocupado ningún alojamiento en los últimos 30 días


SELECT v.id, v.nombre
FROM visitante v
WHERE v.id NOT IN (
  SELECT DISTINCT va.id_visitante
  FROM visitante_alojamiento va
  WHERE va.fecha >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
);



-- 91  Porcentaje de ocupación por alojamiento
-- Calcula, para cada alojamiento, el porcentaje de ocupación respecto a su capacidad,
--  usando una subconsulta para contar las ocupaciones.


SELECT a.id, a.nombre,
       ( (SELECT COUNT(*) FROM visitante_alojamiento va WHERE va.id_alojamiento = a.id) / a.capacidad * 100 ) AS porcentaje_ocupacion
FROM alojamiento a;



-- 92 Alojamientos con ocupación completa
-- Lista los alojamientos donde la cantidad de registros en visitante_alojamiento es mayor o igual a la capacidad.


SELECT a.id, a.nombre
FROM alojamiento a
WHERE (SELECT COUNT(*) FROM visitante_alojamiento va WHERE va.id_alojamiento = a.id) >= a.capacidad;



-- 93 Visitantes que han ocupado alojamientos más de 3 veces
-- Muestra los visitantes que han ocupado un alojamiento en más de 3 ocasiones
--  (usando una subconsulta en la cláusula WHERE).

-- ningun visitante a ocupado un alojamiento 3 veces

SELECT v.id, v.nombre
FROM visitante v
WHERE (SELECT COUNT(*) FROM visitante_alojamiento va WHERE va.id_visitante = v.id) > 3;



-- 94  Ocupación actual vs. promedio global por alojamiento
-- Muestra, para cada alojamiento, la cantidad de ocupaciones (visitantes) y, mediante una subconsulta, el promedio global de ocupación entre todos los alojamientos.



SELECT a.id, a.nombre,
       (SELECT COUNT(*) FROM visitante_alojamiento va WHERE va.id_alojamiento = a.id) AS ocupacion,
       (SELECT AVG(occ) FROM (
           SELECT COUNT(*) AS occ
           FROM visitante_alojamiento
           GROUP BY id_alojamiento
       ) AS temp) AS promedio_ocupacion
FROM alojamiento a;




-- 95 Visitantes que registraron entrada y ocuparon alojamiento
-- Devuelve los visitantes que aparecen tanto en registro_entrada como en visitante_alojamiento .


SELECT v.id, v.nombre
FROM visitante v
WHERE v.id IN (SELECT id_visitante FROM registro_entrada)
  AND v.id IN (SELECT id_visitante FROM visitante_alojamiento);
 
 
 
 -- 96 Última entrada registrada para cada visitante
-- Para cada visitante, se obtiene la fecha de su última entrada en registro_entrada mediante una subconsulta.

SELECT v.id, v.nombre,
       (SELECT MAX(re.fecha) FROM registro_entrada re WHERE re.id_visitante = v.id) AS ultima_entrada
FROM visitante v;



-- 97  Personal atendiendo visitantes: número de visitantes y promedio de ocupación en alojamientos asociados
-- Esta consulta muestra, para cada miembro del personal que ha atendido visitantes (según registro_entrada ),
-- la cantidad de visitantes atendidos y, mediante una subconsulta anidada, el promedio de ocupación (por alojamiento)
--  de los visitantes que atendieron


SELECT p.id_personal, p.nombre,
       (SELECT COUNT(*) FROM registro_entrada re WHERE re.id_personal = p.id_personal) AS visitantes_atendidos,
       (
         SELECT AVG(occ)
         FROM (
           SELECT COUNT(*) AS occ
           FROM visitante_alojamiento va
           WHERE va.id_visitante IN (
             SELECT re2.id_visitante FROM registro_entrada re2 WHERE re2.id_personal = p.id_personal
           )
           GROUP BY va.id_alojamiento
         ) AS sub
       ) AS promedio_ocupacion_alojamiento
FROM personal p
WHERE p.id_personal IN (SELECT DISTINCT id_personal FROM registro_entrada);



-- 98 Lista de alojamientos con ocupación inferior al promedio global
-- Esta consulta muestra los alojamientos cuya cantidad de ocupaciones
--  es inferior al promedio global de ocupación
--  (calculado a partir de la tabla visitante_alojamiento ).

SELECT a.id, a.nombre,
       (SELECT COUNT(*) FROM visitante_alojamiento va WHERE va.id_alojamiento = a.id) AS ocupacion
FROM alojamiento a
WHERE (SELECT COUNT(*) FROM visitante_alojamiento va WHERE va.id_alojamiento = a.id)
      < (
         SELECT AVG(cnt)
         FROM (
           SELECT COUNT(*) AS cnt
           FROM visitante_alojamiento
           GROUP BY id_alojamiento
         ) AS sub
      );

     
     

-- 99 Ranking de visitantes según frecuencia de ocupación de alojamientos
-- Esta consulta lista a los visitantes ordevisitante_alojamiento 
     
     
     SELECT v.id, v.nombre,
       (SELECT COUNT(*) FROM visitante_alojamiento va WHERE va.id_visitante = v.id) AS veces_ocupado
FROM visitante v
ORDER BY veces_ocupado DESC;



-- 100 Última visita registrada en cada alojamiento
-- Para cada alojamiento, se obtiene la fecha de la última
--  ocupación registrada en visitante_alojamiento 


SELECT a.id, a.nombre,
       (SELECT MAX(va.fecha) FROM visitante_alojamiento va WHERE va.id_alojamiento = a.id) AS ultima_visita
FROM alojamiento a;
















