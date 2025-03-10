-- eventos


-- eventos
-- 20 eventos y breves descripciones


--  Informe semanal de visitantes y alojamientos


CREATE TABLE IF NOT EXISTS event_log (
    id INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(255),
    fecha DATETIME
);



DELIMITER $$

CREATE EVENT ev_informe_visitantes_alojamientos
ON SCHEDULE EVERY 1 WEEK STARTS '2025-03-15 00:00:00'
DO
    INSERT INTO event_log (descripcion, fecha)
    VALUES ('Informe semanal de visitantes y alojamientos generado', NOW());
$$

DELIMITER ;



-- Generar informe de costos operativos de proyectos


DELIMITER $$

CREATE EVENT ev_informe_costos_operativos
ON SCHEDULE EVERY 1 WEEK STARTS '2025-03-15 05:00:00'
DO
    INSERT INTO event_log (descripcion, fecha)
    VALUES ('Informe de costos operativos de proyectos generado', NOW());
$$

DELIMITER ;


--  Notificar alta ocupación en alojamientos

DELIMITER $$

CREATE EVENT ev_notificar_alto_ocupacion
ON SCHEDULE EVERY 1 DAY STARTS '2025-03-15 06:00:00'
DO
    INSERT INTO event_log (descripcion, fecha)
    VALUES ('Verificación de ocupación alta de alojamientos realizada', NOW());
$$

DELIMITER ;



--  Actualizar reporte de mantenimiento en personal_conservacion


DELIMITER $$

CREATE EVENT ev_reporte_mantenimiento
ON SCHEDULE EVERY 1 WEEK STARTS '2025-03-15 07:00:00'
DO
    INSERT INTO event_log (descripcion, fecha)
    VALUES ('Reporte semanal de actividades de mantenimiento actualizado', NOW());
$$

DELIMITER ;



-- Resumen semanal de actividades de personal_proyecto

DELIMITER $$

CREATE EVENT ev_resumen_personal_proyecto
ON SCHEDULE EVERY 1 WEEK STARTS '2025-03-15 08:00:00'
DO
    INSERT INTO event_log (descripcion, fecha)
    VALUES ('Resumen semanal de participación en proyectos generado', NOW());
$$

DELIMITER ;


--  Generar reporte de áreas con mayor extensión

DELIMITER $$

CREATE EVENT ev_reporte_areas_extencion
ON SCHEDULE EVERY 1 MONTH STARTS '2025-03-15 10:00:00'
DO
    INSERT INTO event_log (descripcion, fecha)
    VALUES ('Reporte mensual de áreas con mayor extensión generado', NOW());
$$

DELIMITER ;






-- Actualizar reporte de áreas en parques naturales

DELIMITER $$

CREATE EVENT ev_reporte_areas_parques
ON SCHEDULE EVERY 1 WEEK STARTS '2025-03-15 11:00:00'
DO
    INSERT INTO event_log (descripcion, fecha)
    VALUES ('Reporte semanal de áreas en parques naturales actualizado', NOW());
$$

DELIMITER ;






-- Generar listado de proyectos de investigación activos

DELIMITER $$

CREATE EVENT ev_listado_proyectos_activos
ON SCHEDULE EVERY 1 MONTH STARTS '2025-03-15 12:00:00'
DO
    INSERT INTO event_log (descripcion, fecha)
    VALUES ('Listado mensual de proyectos activos generado', NOW());
$$

DELIMITER ;





-- Actualizar informe de sueldos del personal


DELIMITER $$

CREATE EVENT ev_informe_sueldos_personal
ON SCHEDULE EVERY 1 MONTH STARTS '2025-03-15 13:00:00'
DO
    INSERT INTO event_log (descripcion, fecha)
    VALUES ('Informe mensual de sueldos del personal actualizado', NOW());
$$

DELIMITER ;




--  Resumen semanal de visitante_alojamiento

DELIMITER $$

CREATE EVENT ev_resumen_visitante_alojamiento
ON SCHEDULE EVERY 1 WEEK STARTS '2025-03-15 14:00:00'
DO
    INSERT INTO event_log (descripcion, fecha)
    VALUES ('Resumen semanal de ocupación en alojamientos registrado', NOW());
$$

DELIMITER ;



-- Actualizar inventario de vehículos en personal_vigilancia

DELIMITER $$

CREATE EVENT ev_actualizar_inventario_vehiculos
ON SCHEDULE EVERY 1 WEEK STARTS '2025-03-15 16:00:00'
DO
    INSERT INTO event_log (descripcion, fecha)
    VALUES ('Inventario de vehículos en personal_vigilancia actualizado', NOW());
$$

DELIMITER ;



-- Resumen diario de registros de entrada

DELIMITER $$

CREATE EVENT ev_resumen_registros_entrada
ON SCHEDULE EVERY 1 DAY STARTS '2025-03-15 17:00:00'
DO
    INSERT INTO event_log (descripcion, fecha)
    VALUES ('Resumen diario de registros de entrada generado', NOW());
$$

DELIMITER ;



--  Informe de personal con mayor participación en proyectos


DELIMITER $$

CREATE EVENT ev_informe_top_personal_proyectos
ON SCHEDULE EVERY 1 MONTH STARTS '2025-03-15 18:00:00'
DO
    INSERT INTO event_log (descripcion, fecha)
    VALUES ('Informe mensual de personal con mayor participación en proyectos generado', NOW());
$$

DELIMITER ;


-- opcion para que funcione

SET GLOBAL event_scheduler = ON;