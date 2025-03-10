-- Procedimientos almacenados


-- Procedimientos almacenados
-- 20 procedimientos almacenados y una breve descripcion 


use parqueNatural;

-- insertar parque natural nuevo a la lista

-- probado
DELIMITER //
CREATE PROCEDURE InsertarParqueNatural(
    IN p_nombre VARCHAR(20),
    IN p_fecha_declaracion DATE
)
BEGIN
    INSERT INTO parque_natural (nombre, fecha_declaracion)
    VALUES (p_nombre, p_fecha_declaracion);
    SELECT 'Parque natural insertado exitosamente' AS mensaje, LAST_INSERT_ID() AS id_parque;
END //
DELIMITER ;




-- 2. Actualiza la información de un parque  y verifica que el parque exista

-- probado
DELIMITER //
CREATE PROCEDURE ActualizarParqueNatural(
    IN p_id_parque INT,
    IN p_nombre VARCHAR(20),
    IN p_fecha_declaracion DATE
)
BEGIN
    IF EXISTS (SELECT 1 FROM parque_natural WHERE id_parque = p_id_parque) THEN
        UPDATE parque_natural
        SET nombre = p_nombre, fecha_declaracion = p_fecha_declaracion
        WHERE id_parque = p_id_parque;
        SELECT 'Parque natural actualizado exitosamente' AS mensaje;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El parque no existe';
    END IF;
END //
DELIMITER ;


-- 3 Registre una nueva área con su nombre y extensión.

-- probado
DELIMITER //
CREATE PROCEDURE InsertarArea(
    IN p_nombre VARCHAR(20),
    IN p_extension_area FLOAT
)
BEGIN
    INSERT INTO area (nombre, extencion_area)
    VALUES (p_nombre, p_extension_area);
    SELECT 'Área insertada exitosamente' AS mensaje, LAST_INSERT_ID() AS id_area;
END //
DELIMITER ;


-- 4 Actualiza los datos de un área existente.



DELIMITER //
CREATE PROCEDURE ActualizarArea(
    IN p_id_area INT,
    IN p_nombre VARCHAR(20),
    IN p_extension_area FLOAT
)
BEGIN
    UPDATE area
    SET nombre = p_nombre, extencion_area = p_extension_area
    WHERE id_area = p_id_area;
    SELECT 'Área actualizada exitosamente' AS mensaje;
END //
DELIMITER ;



--  5 Registre un nuevo visitante con sus datos básicos
-- probado
DELIMITER //
CREATE PROCEDURE RegistrarVisitante(
    IN p_nombre VARCHAR(100),
    IN p_numero_cedula VARCHAR(20),
    IN p_direccion VARCHAR(100),
    IN p_profesion VARCHAR(20)
)
BEGIN
    INSERT INTO visitante (nombre, numero_cedula, direccion, profesion)
    VALUES (p_nombre, p_numero_cedula, p_direccion, p_profesion);
    SELECT 'Visitante registrado exitosamente' AS mensaje, LAST_INSERT_ID() AS id_visitante;
END //
DELIMITER ;



-- 6 Asigna un alojamiento a un visitante, verificando la capacidad disponible.
-- probado
DELIMITER //
CREATE PROCEDURE AsignarAlojamientoAVisitante(
    IN p_id_visitante INT,
    IN p_id_alojamiento INT,
    IN p_fecha DATE
)
BEGIN
    DECLARE capacidad_total INT;
    DECLARE asignaciones_existentes INT;
    DECLARE capacidad_restante INT;

    SELECT capacidad INTO capacidad_total FROM alojamiento WHERE id = p_id_alojamiento;
    SELECT COUNT(*) INTO asignaciones_existentes
    FROM visitante_alojamiento
    WHERE id_alojamiento = p_id_alojamiento AND fecha = p_fecha;
    SET capacidad_restante = capacidad_total - asignaciones_existentes;

    IF capacidad_restante > 0 THEN
        INSERT INTO visitante_alojamiento (id_visitante, id_alojamiento, fecha)
        VALUES (p_id_visitante, p_id_alojamiento, p_fecha);
        SELECT 'Alojamiento asignado exitosamente' AS mensaje, capacidad_restante - 1 AS plazas_restantes;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No hay capacidad disponible en esa fecha';
    END IF;
END //
DELIMITER ;



-- 7 Devuelve la disponibilidad de un alojamiento en una fecha específica


DELIMITER //
CREATE PROCEDURE VerificarDisponibilidadAlojamiento(
    IN p_id_alojamiento INT,
    IN p_fecha DATE
)
BEGIN
    DECLARE capacidad_total INT;
    DECLARE asignaciones INT;

    SELECT capacidad INTO capacidad_total FROM alojamiento WHERE id = p_id_alojamiento;
    SELECT COUNT(*) INTO asignaciones
    FROM visitante_alojamiento
    WHERE id_alojamiento = p_id_alojamiento AND fecha = p_fecha;

    SELECT capacidad_total - asignaciones AS plazas_disponibles;
END //
DELIMITER ;




-- 8 Muestra el historial de alojamientos de un visitante con detalles del parque


DELIMITER //
CREATE PROCEDURE ObtenerHistorialAlojamientosVisitante(
    IN p_id_visitante INT
)
BEGIN
    SELECT va.fecha, a.nombre AS alojamiento, pn.nombre AS parque
    FROM visitante_alojamiento va
    JOIN alojamiento a ON va.id_alojamiento = a.id
    JOIN parque_natural pn ON a.id_parque = pn.id_parque
    WHERE va.id_visitante = p_id_visitante
    ORDER BY va.fecha DESC;
END //
DELIMITER ;




-- 9 Asigne un personal de vigilancia a un área con un vehículo


DELIMITER //
CREATE PROCEDURE AsignarPersonalVigilancia(
    IN p_id_personal INT,
    IN p_id_area INT,
    IN p_id_vehiculo INT
)
BEGIN
    INSERT INTO personal_vigilancia (id_personal, id_area, id_vehiculo)
    VALUES (p_id_personal, p_id_area, p_id_vehiculo);
    SELECT 'Personal de vigilancia asignado exitosamente' AS mensaje;
END //
DELIMITER ;



-- 10 Asigna personal de conservación a un área con un tipo de mantenimiento


DELIMITER //
CREATE PROCEDURE AsignarPersonalConservacion(
    IN p_id_personal INT,
    IN p_id_area INT,
    IN p_tipo_mantenimiento ENUM('limpieza','mantenimiento')
)
BEGIN
    INSERT INTO personal_conservacion (id_personal, id_area, tipo_mantenimiento)
    VALUES (p_id_personal, p_id_area, p_tipo_mantenimiento);
    SELECT 'Personal de conservación asignado exitosamente' AS mensaje;
END //
DELIMITER ;




-- 11 Registre una actividad de personal en un área con un comentario


DELIMITER //
CREATE PROCEDURE RegistrarActividadPersonalEnArea(
    IN p_id_personal INT,
    IN p_id_area INT,
    IN p_comentario VARCHAR(255)
)
BEGIN
    DECLARE tipo ENUM('001','002','003','004');
    SELECT tipo_personal INTO tipo FROM personal WHERE id_personal = p_id_personal;
    
    IF tipo = '002' THEN -- Suponiendo '002' es vigilancia
        INSERT INTO personal_vigilancia (id_personal, id_area, id_vehiculo)
        VALUES (p_id_personal, p_id_area, NULL);
    ELSEIF tipo = '003' THEN -- Suponiendo '003' es conservación
        INSERT INTO personal_conservacion (id_personal, id_area, tipo_mantenimiento)
        VALUES (p_id_personal, p_id_area, 'mantenimiento');
    END IF;
    SELECT CONCAT('Actividad registrada: ', p_comentario) AS mensaje;
END //
DELIMITER ;



-- 12 Lista el personal asignado a un área con su tipo



DELIMITER //
CREATE PROCEDURE ObtenerPersonalPorArea(
    IN p_id_area INT
)
BEGIN
    SELECT p.nombre, p.tipo_personal, 'Vigilancia' AS rol
    FROM personal p
    JOIN personal_vigilancia pv ON p.id_personal = pv.id_personal
    WHERE pv.id_area = p_id_area
    UNION
    SELECT p.nombre, p.tipo_personal, 'Conservación' AS rol
    FROM personal p
    JOIN personal_conservacion pc ON p.id_personal = pc.id_personal
    WHERE pc.id_area = p_id_area;
END //
DELIMITER ;





-- 13 Registra un nuevo proyecto de investigación con su presupuesto.


DELIMITER //
CREATE PROCEDURE InsertarProyectoInvestigacion(
    IN p_nombre VARCHAR(100),
    IN p_presupuesto FLOAT,
    IN p_periodo_realizacion VARCHAR(100)
)
BEGIN
    INSERT INTO proyecto_investigacion (nombre, presupuesto, periodo_realizacion)
    VALUES (p_nombre, p_presupuesto, p_periodo_realizacion);
    SELECT 'Proyecto de investigación insertado exitosamente' AS mensaje, LAST_INSERT_ID() AS id_proyecto;
END //
DELIMITER ;




-- 14 Actualiza el presupuesto de un proyecto y registra el cambio


DELIMITER //
CREATE PROCEDURE ActualizarPresupuestoProyecto(
    IN p_id_proyecto INT,
    IN p_nuevo_presupuesto FLOAT
)
BEGIN
    DECLARE presupuesto_anterior FLOAT;
    SELECT presupuesto INTO presupuesto_anterior FROM proyecto_investigacion WHERE id_proyecto = p_id_proyecto;
    
    UPDATE proyecto_investigacion
    SET presupuesto = p_nuevo_presupuesto
    WHERE id_proyecto = p_id_proyecto;
    
    SELECT 'Presupuesto actualizado' AS mensaje, 
           presupuesto_anterior AS presupuesto_anterior, 
           p_nuevo_presupuesto AS nuevo_presupuesto;
END //
DELIMITER ;





-- 15  Asigna personal a un proyecto vinculado a una especie


DELIMITER //
CREATE PROCEDURE AsignarPersonalAProyectoConEspecie(
    IN p_id_personal INT,
    IN p_id_proyecto INT,
    IN p_id_especie INT
)
BEGIN
    INSERT INTO personal_proyecto (id_personal, id_proyecto, id_especie)
    VALUES (p_id_personal, p_id_proyecto, p_id_especie);
    SELECT 'Personal asignado al proyecto exitosamente' AS mensaje;
END //
DELIMITER ;




-- 16 Lista los proyectos en los que participa un miembro del personal

DELIMITER //
CREATE PROCEDURE ObtenerProyectosPorPersonal(
    IN p_id_personal INT
)
BEGIN
    SELECT pi.nombre AS proyecto, pi.presupuesto, e.denominacion_vulgar AS especie
    FROM personal_proyecto pp
    JOIN proyecto_investigacion pi ON pp.id_proyecto = pi.id_proyecto
    JOIN especie e ON pp.id_especie = e.id
    WHERE pp.id_personal = p_id_personal;
END //
DELIMITER ;



-- 17 Calcula el costo total de proyectos asociados a un parque (vía especies y áreas)

DELIMITER //
CREATE PROCEDURE CalcularCostoTotalProyectosPorParque(
    IN p_id_parque INT
)
BEGIN
    SELECT SUM(pi.presupuesto) AS costo_total
    FROM proyecto_investigacion pi
    JOIN personal_proyecto pp ON pi.id_proyecto = pp.id_proyecto
    JOIN area_especie ae ON pp.id_especie = ae.id_especie
    JOIN area_parque_natural apn ON ae.id_area = apn.id_area
    WHERE apn.id_parque = p_id_parque;
END //
DELIMITER ;


-- 18 Registre la entrada de un visitante y le asigna un alojamiento automáticamente.


DELIMITER //
CREATE PROCEDURE RegistrarEntradaYAsignarAlojamiento(
    IN p_id_personal INT,
    IN p_id_visitante INT,
    IN p_id_entrada INT,
    IN p_id_alojamiento INT,
    IN p_fecha DATE
)
BEGIN
    DECLARE capacidad_restante INT;
    

    INSERT INTO registro_entrada (id_personal, id_visitante, id_entrada, fecha)
    VALUES (p_id_personal, p_id_visitante, p_id_entrada, NOW());
    

    SELECT capacidad - COUNT(*) INTO capacidad_restante
    FROM alojamiento a
    LEFT JOIN visitante_alojamiento va ON a.id = va.id_alojamiento AND va.fecha = p_fecha
    WHERE a.id = p_id_alojamiento;
    
    IF capacidad_restante > 0 THEN
        INSERT INTO visitante_alojamiento (id_visitante, id_alojamiento, fecha)
        VALUES (p_id_visitante, p_id_alojamiento, p_fecha);
        SELECT 'Entrada registrada y alojamiento asignado' AS mensaje;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No hay capacidad en el alojamiento';
    END IF;
END //
DELIMITER ;




-- 19 genera un informe detallado acerca de las especies presentes



DELIMITER //
CREATE PROCEDURE GenerarReporteEspeciesPorParque(
    IN p_id_parque INT
)
BEGIN
    
    IF NOT EXISTS (SELECT 1 FROM parque_natural WHERE id_parque = p_id_parque) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El parque especificado no existe';
    END IF;

    SELECT 
        pn.nombre AS nombre_parque,
        a.nombre AS nombre_area,
        e.denominacion_vulgar AS nombre_especie,
        e.tipo_especie AS tipo,
        ae.numero_individuos_area AS individuos,
        SUM(ae.numero_individuos_area) OVER (PARTITION BY e.tipo_especie) AS total_por_tipo
    FROM parque_natural pn
    JOIN area_parque_natural apn ON pn.id_parque = apn.id_parque
    JOIN area a ON apn.id_area = a.id_area
    JOIN area_especie ae ON a.id_area = ae.id_area
    JOIN especie e ON ae.id_especie = e.id
    WHERE pn.id_parque = p_id_parque
    ORDER BY e.tipo_especie, a.nombre;

    
    SELECT 
        e.tipo_especie AS tipo,
        COUNT(DISTINCT e.id) AS cantidad_especies,
        SUM(ae.numero_individuos_area) AS total_individuos
    FROM parque_natural pn
    JOIN area_parque_natural apn ON pn.id_parque = apn.id_parque
    JOIN area_especie ae ON apn.id_area = ae.id_area
    JOIN especie e ON ae.id_especie = e.id
    WHERE pn.id_parque = p_id_parque
    GROUP BY e.tipo_especie;
END //
DELIMITER ;



-- 20 registrar vehiculo nuevo 

DELIMITER //
CREATE PROCEDURE RegistrarVehiculoSimple(
    IN p_tipo VARCHAR(20),
    IN p_marca VARCHAR(20)
)
BEGIN
    INSERT INTO vehiculo (tipo, marca)
    VALUES (p_tipo, p_marca);
    SELECT 'Vehículo registrado' AS mensaje;
END //
DELIMITER ;


