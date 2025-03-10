-- triggers


-- TRIGGERS
-- 20 triggers y breves descripciones



-- Registrar inserciones en el inventario de especies por área


-- tabla

CREATE TABLE log_inventario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    accion VARCHAR(20) NOT NULL,
    id_area INT,
    id_especie INT,
    cantidad INT,
    fecha DATETIME NOT NULL
);


--  Registrar inserciones en el inventario de especies por área

DELIMITER //
CREATE TRIGGER after_insert_area_especie
AFTER INSERT ON area_especie
FOR EACH ROW
BEGIN
    INSERT INTO log_inventario (accion, id_area, id_especie, cantidad, fecha) 
    VALUES ('INSERT', NEW.id_area, NEW.id_especie, NEW.numero_individuos_area, NOW());
END; //
DELIMITER ;



-- : Registrar eliminaciones en el inventario de especies por área
DELIMITER //
CREATE TRIGGER after_delete_area_especie
AFTER DELETE ON area_especie
FOR EACH ROW
BEGIN
    INSERT INTO log_inventario (accion, id_area, id_especie, cantidad, fecha) 
    VALUES ('DELETE', OLD.id_area, OLD.id_especie, OLD.numero_individuos_area, NOW());
END; //
DELIMITER ;




--  Registrar actualizaciones en el inventario de especies por área

DELIMITER //
CREATE TRIGGER after_update_area_especie
AFTER UPDATE ON area_especie
FOR EACH ROW
BEGIN
    INSERT INTO log_inventario (accion, id_area, id_especie, cantidad, fecha) 
    VALUES ('UPDATE', NEW.id_area, NEW.id_especie, NEW.numero_individuos_area, NOW());
END; //
DELIMITER ;



-- Registrar aumentos salariales en el personal

DELIMITER //
CREATE TRIGGER after_update_sueldo
AFTER UPDATE ON personal
FOR EACH ROW
BEGIN
    IF NEW.sueldo > OLD.sueldo THEN
        INSERT INTO log_salarial (id_personal, sueldo_anterior, nuevo_sueldo, fecha)
        VALUES (NEW.id_personal, OLD.sueldo, NEW.sueldo, NOW());
    END IF;
END; //
DELIMITER ;



-- Registrar reducciones salariales en el personal


DELIMITER //
CREATE TRIGGER after_update_sueldo_decrease
AFTER UPDATE ON personal
FOR EACH ROW
BEGIN
    IF NEW.sueldo < OLD.sueldo THEN
        INSERT INTO log_salarial (id_personal, sueldo_anterior, nuevo_sueldo, fecha)
        VALUES (NEW.id_personal, OLD.sueldo, NEW.sueldo, NOW());
    END IF;
END; //
DELIMITER ;




--  Registrar nuevos empleados

DELIMITER //
CREATE TRIGGER after_insert_personal
AFTER INSERT ON personal
FOR EACH ROW
BEGIN
    INSERT INTO log_salarial (id_personal, sueldo_anterior, nuevo_sueldo, fecha)
    VALUES (NEW.id_personal, 0, NEW.sueldo, NOW());
END; //
DELIMITER ;



-- Registrar eliminación de empleados


DELIMITER //
CREATE TRIGGER after_delete_personal
AFTER DELETE ON personal
FOR EACH ROW
BEGIN
    INSERT INTO log_salarial (id_personal, sueldo_anterior, nuevo_sueldo, fecha)
    VALUES (OLD.id_personal, OLD.sueldo, 0, NOW());
END; //
DELIMITER ;


-- Registrar cambios en el personal de vigilancia


DELIMITER //
CREATE TRIGGER after_update_vigilancia
AFTER UPDATE ON personal_vigilancia
FOR EACH ROW
BEGIN
    INSERT INTO log_vigilancia (id_personal, id_area, id_vehiculo, fecha)
    VALUES (NEW.id_personal, NEW.id_area, NEW.id_vehiculo, NOW());
END; //
DELIMITER ;



--  Registrar nuevos proyectos de investigación


DELIMITER //
CREATE TRIGGER after_insert_proyecto
AFTER INSERT ON proyecto_investigacion
FOR EACH ROW
BEGIN
    INSERT INTO log_proyectos (accion, id_proyecto, presupuesto, fecha)
    VALUES ('INSERT', NEW.id_proyecto, NEW.presupuesto, NOW());
END; //
DELIMITER ;



-- Registrar cambios en proyectos de investigación

DELIMITER //
CREATE TRIGGER after_update_proyecto
AFTER UPDATE ON proyecto_investigacion
FOR EACH ROW
BEGIN
    INSERT INTO log_proyectos (accion, id_proyecto, presupuesto, fecha)
    VALUES ('UPDATE', NEW.id_proyecto, NEW.presupuesto, NOW());
END; //
DELIMITER ;



-- creando tabla_log_conservacion

CREATE TABLE log_conservacion (
    id INT PRIMARY KEY AUTO_INCREMENT,
    accion VARCHAR(20) NOT NULL,
    id_personal INT NOT NULL,
    id_area INT NOT NULL,
    tipo_mantenimiento VARCHAR(20) NOT NULL,
    fecha DATETIME NOT NULL
);






--  Registrar inserciones en el personal de conservación

DELIMITER //
CREATE TRIGGER after_insert_personal_conservacion
AFTER INSERT ON personal_conservacion
FOR EACH ROW
BEGIN
    INSERT INTO log_conservacion (accion, id_personal, id_area, tipo_mantenimiento, fecha)
    VALUES ('INSERT', NEW.id_personal, NEW.id_area, NEW.tipo_mantenimiento, NOW());
END; //
DELIMITER ;



-- creando tabla registro

CREATE TABLE log_registro_entrada (
    id INT PRIMARY KEY AUTO_INCREMENT,
    accion VARCHAR(20) NOT NULL,
    id_personal INT NOT NULL,
    id_visitante INT NOT NULL,
    id_entrada INT NOT NULL,
    fecha DATETIME NOT NULL
);



-- Registrar inserciones en el registro de entrada


DELIMITER //
CREATE TRIGGER after_insert_registro_entrada
AFTER INSERT ON registro_entrada
FOR EACH ROW
BEGIN
    INSERT INTO log_registro_entrada (accion, id_personal, id_visitante, id_entrada, fecha)
    VALUES ('INSERT', NEW.id_personal, NEW.id_visitante, NEW.id_entrada, NOW());
END; //
DELIMITER ;