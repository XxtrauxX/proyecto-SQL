-- creacion de roles

-- rol de administrador

CREATE ROLE 'admin';

GRANT ALL PRIVILEGES ON parqueNatural.* TO 'admin_user';

CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'trainer123';
GRANT 'admin' TO 'admin_user'@'localhost';

SELECT user, host FROM mysql.user;
SHOW GRANTS FOR 'admin_user'@'localhost';


-- rol Gestor de Parques



CREATE USER 'Gestor_parques'@'localhost' IDENTIFIED BY 'elmejorgestor123';


GRANT SELECT, INSERT, UPDATE, DELETE ON parqueNatural.parque_natural  TO 'Gestor_parques'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON parqueNatural.area TO 'Gestor_parques'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON parqueNatural.especie TO 'Gestor_parques'@'localhost';


FLUSH PRIVILEGES;




-- rol investigador



CREATE USER 'investigador'@'localhost' IDENTIFIED BY 'inge2429';


GRANT SELECT, INSERT, UPDATE, DELETE ON parqueNatural.proyecto_investigacion TO 'investigador'@'localhost';

GRANT SELECT, INSERT, UPDATE, DELETE ON parqueNatural.especie TO 'investigador'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON parqueNatural.area_especie  TO 'investigador'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON parqueNatural.personal_proyecto  TO 'investigador'@'localhost';


FLUSH PRIVILEGES;


-- rol auditor
CREATE USER 'auditor'@'localhost' IDENTIFIED BY 'dito2345';

GRANT SELECT on  parqueNatural.personal  TO 'auditor'@'localhost';
GRANT SELECT on  parqueNatural.personal_proyecto  TO 'auditor'@'localhost';
GRANT SELECT on  parqueNatural.proyecto_investigacion  TO 'auditor'@'localhost';



-- rol encargado visitantes

CREATE USER 'encargado_visitas'@'localhost' IDENTIFIED BY 'visitas9087';
GRANT SELECT, INSERT, UPDATE, DELETE ON parqueNatural.visitante  TO 'encargado_visitas'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON parqueNatural.alojamiento  TO 'encargado_visitas'@'localhost';

