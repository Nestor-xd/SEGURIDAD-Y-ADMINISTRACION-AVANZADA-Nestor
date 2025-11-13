
-- Script de configuración de base de datos y usuarios

-- Crear la base de datos
CREATE DATABASE empresa_segura;

-- Crear usuario 'admin_rrhh'
CREATE USER 'admin_rrhh'@'localhost' IDENTIFIED BY 'password123';
GRANT ALL PRIVILEGES ON empresa_segura.empleados TO 'admin_rrhh'@'localhost';

-- Crear usuario 'analista_bi'
CREATE USER 'analista_bi'@'localhost' IDENTIFIED BY 'password123';
GRANT SELECT ON empresa_segura.* TO 'analista_bi'@'localhost';

-- Crear usuario 'desarrollador'
CREATE USER 'desarrollador'@'localhost' IDENTIFIED BY 'password123';
GRANT SELECT, INSERT, UPDATE ON empresa_segura.* TO 'desarrollador'@'localhost';

-- Configurar expiración de contraseñas
ALTER USER 'admin_rrhh'@'localhost' PASSWORD EXPIRE INTERVAL 90 DAY;
ALTER USER 'analista_bi'@'localhost' PASSWORD EXPIRE INTERVAL 90 DAY;
ALTER USER 'desarrollador'@'localhost' PASSWORD EXPIRE INTERVAL 90 DAY;

-- Crear vistas de seguridad
CREATE VIEW empleados_publico AS
SELECT id, nombre, apellido FROM empleados;

CREATE VIEW resumen_departamental AS
SELECT departamento, COUNT(*) AS num_empleados FROM empleados GROUP BY departamento;

CREATE VIEW empleados_activos AS
SELECT * FROM empleados WHERE estado = 'activo';

-- Crear tabla de auditoría
CREATE TABLE audit_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tabla VARCHAR(255),
    operacion VARCHAR(255),
    usuario VARCHAR(255),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    datos_json JSON
);

-- Triggers para auditoría
DELIMITER $$

CREATE TRIGGER after_insert_empleados
AFTER INSERT ON empleados
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (tabla, operacion, usuario, datos_json)
    VALUES ('empleados', 'INSERT', USER(), JSON_OBJECT('id', NEW.id, 'nombre', NEW.nombre));
END $$

CREATE TRIGGER after_update_empleados
AFTER UPDATE ON empleados
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (tabla, operacion, usuario, datos_json)
    VALUES ('empleados', 'UPDATE', USER(), JSON_OBJECT('id', OLD.id, 'old_nombre', OLD.nombre, 'new_nombre', NEW.nombre));
END $$

CREATE TRIGGER after_delete_empleados
AFTER DELETE ON empleados
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (tabla, operacion, usuario, datos_json)
    VALUES ('empleados', 'DELETE', USER(), JSON_OBJECT('id', OLD.id, 'nombre', OLD.nombre));
END $$

DELIMITER ;
