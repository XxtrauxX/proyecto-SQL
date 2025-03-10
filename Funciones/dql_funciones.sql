-- funciones


-- funciones
-- 20 funciones y breve descricion




-- 1. Superficie total de parques por departamento

DELIMITER $$

CREATE FUNCTION fn_superficie_total_departamento(depId INT) 
RETURNS FLOAT 
DETERMINISTIC
BEGIN
  DECLARE total FLOAT;
  SELECT SUM(a.extencion_area) INTO total
  FROM area a
  JOIN area_parque_natural apn ON a.id_area = apn.id_area
  JOIN parque_natural pn ON apn.id_parque = pn.id_parque
  JOIN departamento_parque_natural dpn ON pn.id_parque = dpn.id_parque
  WHERE dpn.id_departamento = depId;
  RETURN IFNULL(total, 0);
END$$

DELIMITER ;


SELECT fn_superficie_total_departamento(1);



-- 2 Inventario de especies en un área para un tipo específico

DELIMITER $$

CREATE FUNCTION fn_inventario_especies_area(areaId INT, especieType VARCHAR(20)) 
RETURNS INT 
DETERMINISTIC
BEGIN
  DECLARE total INT;
  SELECT SUM(ae.numero_individuos_area) INTO total
  FROM area_especie ae
  JOIN especie e ON ae.id_especie = e.id
  WHERE ae.id_area = areaId AND e.tipo_especie = especieType;
  RETURN IFNULL(total, 0);
END$$

DELIMITER ;


SELECT fn_inventario_especies_area(10, 'animal');


-- 3 Cálculo de costos operativos de un proyecto

DELIMITER $$

CREATE FUNCTION fn_costo_operativo_proyecto(projId INT) 
RETURNS FLOAT 
DETERMINISTIC
BEGIN
  DECLARE pres FLOAT;
  DECLARE costo FLOAT;
  SELECT presupuesto INTO pres 
  FROM proyecto_investigacion 
  WHERE id_proyecto = projId;
  SET costo = pres * 0.15;
  RETURN IFNULL(costo, 0);
END$$

DELIMITER ;

SELECT  fn_costo_operativo_proyecto(1);






-- 4 Sueldo promedio del personal para un tipo dado


DELIMITER $$

CREATE FUNCTION fn_promedio_sueldo_personal_tipo(tipo VARCHAR(10))
RETURNS FLOAT 
DETERMINISTIC
BEGIN
  DECLARE avgSueldo FLOAT;
  SELECT AVG(sueldo) INTO avgSueldo 
  FROM personal 
  WHERE tipo_personal = tipo;
  RETURN IFNULL(avgSueldo, 0);
END$$

DELIMITER ;

SELECT fn_promedio_sueldo_personal_tipo('001');




-- 5 Total de vehículos asignados en vigilancia sin ningun duplicado

DELIMITER $$

CREATE FUNCTION fn_total_vehiculos_personal() 
RETURNS INT 
DETERMINISTIC
BEGIN
  DECLARE total INT;
  SELECT COUNT(DISTINCT id_vehiculo) INTO total 
  FROM personal_vigilancia;
  RETURN IFNULL(total, 0);
END$$

DELIMITER ;


SELECT fn_total_vehiculos_personal();



-- 6 Cantidad de proyectos en los que participa un personal

DELIMITER $$

CREATE FUNCTION fn_cantidad_proyectos_personal(personalId INT)
RETURNS INT 
DETERMINISTIC
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total 
  FROM personal_proyecto 
  WHERE id_personal = personalId;
  RETURN IFNULL(total, 0);
END$$

DELIMITER ;



SELECT fn_cantidad_proyectos_personal(1);







-- 7  Presupuesto total de todos los proyectos de investigación

DELIMITER $$

CREATE FUNCTION fn_total_presupuesto_proyectos() 
RETURNS FLOAT 
DETERMINISTIC
BEGIN
  DECLARE total FLOAT;
  SELECT SUM(presupuesto) INTO total 
  FROM proyecto_investigacion;
  RETURN IFNULL(total, 0);
END$$

DELIMITER ;

SELECT fn_total_presupuesto_proyectos();


-- 8  Cantidad total de visitantes registrados


DELIMITER $$

CREATE FUNCTION fn_cantidad_visitantes() 
RETURNS INT 
DETERMINISTIC
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total 
  FROM visitante;
  RETURN total;
END$$

DELIMITER ;

SELECT fn_cantidad_visitantes();


-- 9 Total de ocupaciones de un alojamiento

DELIMITER $$

CREATE FUNCTION fn_total_ocupacion_alojamiento(alojamientoId INT)
RETURNS INT 
DETERMINISTIC
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total 
  FROM visitante_alojamiento 
  WHERE id_alojamiento = alojamientoId;
  RETURN IFNULL(total, 0);
END$$

DELIMITER ;

SELECT fn_total_ocupacion_alojamiento(1);


-- 10 Promedio global de ocupación en alojamientos

DELIMITER $$

CREATE FUNCTION fn_promedio_ocupacion_alojamiento() 
RETURNS FLOAT 
DETERMINISTIC
BEGIN
  DECLARE avgOcc FLOAT;
  SELECT AVG(cnt) INTO avgOcc
  FROM (
    SELECT COUNT(*) AS cnt 
    FROM visitante_alojamiento 
    GROUP BY id_alojamiento
  ) AS t;
  RETURN IFNULL(avgOcc, 0);
END$$

DELIMITER ;


SELECT fn_promedio_ocupacion_alojamiento();



-- 11  Inventario total de especies en un área

DELIMITER $$

CREATE FUNCTION fn_inventario_especies_area_total(areaId INT)
RETURNS INT 
DETERMINISTIC
BEGIN
  DECLARE total INT;
  SELECT SUM(numero_individuos_area) INTO total 
  FROM area_especie 
  WHERE id_area = areaId;
  RETURN IFNULL(total, 0);
END$$

DELIMITER ;

SELECT fn_inventario_especies_area_total(5);



-- 12  Extensión total de un parque natural

DELIMITER $$

CREATE FUNCTION fn_total_extencion_area_parque(parqueId INT)
RETURNS FLOAT 
DETERMINISTIC
BEGIN
  DECLARE total FLOAT;
  SELECT SUM(a.extencion_area) INTO total
  FROM area a
  JOIN area_parque_natural apn ON a.id_area = apn.id_area
  WHERE apn.id_parque = parqueId;
  RETURN IFNULL(total, 0);
END$$

DELIMITER ;


SELECT fn_total_extencion_area_parque(1);




-- 13 Número de áreas asociadas a un parque natural

DELIMITER $$

CREATE FUNCTION fn_numero_areas_por_parque(parqueId INT)
RETURNS INT 
DETERMINISTIC
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total 
  FROM area_parque_natural 
  WHERE id_parque = parqueId;
  RETURN IFNULL(total, 0);
END$$

DELIMITER ;

SELECT fn_numero_areas_por_parque(1);


-- 14  Inventario global de especies en todas las áreas


DELIMITER $$

CREATE FUNCTION fn_total_inventario_especies() 
RETURNS INT 
DETERMINISTIC
BEGIN
  DECLARE total INT;
  SELECT SUM(numero_individuos_area) INTO total 
  FROM area_especie;
  RETURN IFNULL(total, 0);
END$$

DELIMITER ;

SELECT fn_total_inventario_especies();


-- 15 Inventario total para un tipo de especie en todas las áreas

DELIMITER $$

CREATE FUNCTION fn_inventario_por_tipo(tipo VARCHAR(20))
RETURNS INT 
DETERMINISTIC
BEGIN
  DECLARE total INT;
  SELECT SUM(ae.numero_individuos_area) INTO total
  FROM area_especie ae
  JOIN especie e ON ae.id_especie = e.id
  WHERE e.tipo_especie = tipo;
  RETURN IFNULL(total, 0);
END$$

DELIMITER ;

SELECT fn_inventario_por_tipo('vegetal');



-- 16 Total de registros en conservación_personal


DELIMITER $$

CREATE FUNCTION fn_personal_conservacion_count() 
RETURNS INT 
DETERMINISTIC
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total FROM personal_conservacion;
  RETURN total;
END$$

DELIMITER ;

SELECT  fn_personal_conservacion_count();


-- 17 Costo operativo total del personal

DELIMITER $$

CREATE FUNCTION fn_total_costo_operativo_personal() 
RETURNS FLOAT 
DETERMINISTIC
BEGIN
  DECLARE total FLOAT;
  SELECT SUM(sueldo) INTO total FROM personal;
  RETURN IFNULL(total, 0);
END$$

DELIMITER ;

SELECT  fn_total_costo_operativo_personal();




-- 18 Ratio sueldo/proyectos para un personal

DELIMITER $$

CREATE FUNCTION fn_ratio_sueldo_inventario(personalId INT) 
RETURNS FLOAT 
DETERMINISTIC
BEGIN
  DECLARE sueldo FLOAT;
  DECLARE numProyectos INT;
  SELECT sueldo INTO sueldo FROM personal WHERE id_personal = personalId;
  SELECT COUNT(*) INTO numProyectos FROM personal_proyecto WHERE id_personal = personalId;
  IF numProyectos = 0 THEN
    RETURN NULL;
  ELSE
    RETURN sueldo / numProyectos;
  END IF;
END$$

DELIMITER ;


SELECT fn_ratio_sueldo_inventario(1);



-- 19 Promedio de presupuesto de proyectos de investigación


DELIMITER $$

CREATE FUNCTION fn_promedio_presupuesto_proyectos() 
RETURNS FLOAT 
DETERMINISTIC
BEGIN
  DECLARE avgPresupuesto FLOAT;
  SELECT AVG(presupuesto) INTO avgPresupuesto FROM proyecto_investigacion;
  RETURN IFNULL(avgPresupuesto, 0);
END$$

DELIMITER ;


SELECT fn_promedio_presupuesto_proyectos();



-- 20 Costos operativos totales de proyectos




DELIMITER $$

CREATE FUNCTION fn_total_costos_operativos_proyectos() 
RETURNS FLOAT 
DETERMINISTIC
BEGIN
  DECLARE totalCost FLOAT;
  SELECT SUM(presupuesto * 0.15) INTO totalCost FROM proyecto_investigacion;
  RETURN IFNULL(totalCost, 0);
END$$

DELIMITER ;


SELECT fn_total_costos_operativos_proyectos();


