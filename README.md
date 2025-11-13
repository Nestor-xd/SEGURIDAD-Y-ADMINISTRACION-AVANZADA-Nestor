# SEGURIDAD-Y-ADMINISTRACION-AVANZADA-Nestor

Este proyecto implementa un sistema completo de seguridad y administración para una base de datos de una empresa ficticia llamada `empresa_segura`. El objetivo es aplicar todos los conceptos aprendidos relacionados con la gestión de usuarios, seguridad de contraseñas, auditoría, vistas de seguridad, y respaldo/restauración de bases de datos.

## Objetivo

Implementar medidas de seguridad completas para una base de datos de empresa ficticia, aplicando los siguientes conceptos:
- **Gestión de Usuarios**
- **Vistas de Seguridad**
- **Auditoría de Cambios**
- **Backup y Restauración**

## Recursos Necesarios

- **Software**: MySQL 8.0+ (instalado localmente o en Docker)
- **Herramienta**: MySQL Workbench 8.0+
- **Editor**: VS Code o cualquier editor de texto para scripts SQL
- **Terminal**: Acceso a línea de comandos (CMD, PowerShell, Terminal)

## Estructura del Proyecto

1. **Base de Datos**: `empresa_segura`
   - Contiene las tablas: `empleados`, `departamentos`, `salarios`, y más.
   
2. **Usuarios y Permisos**:
   - **admin_rrhh**: Acceso total a la tabla `empleados`.
   - **analista_bi**: Solo acceso `SELECT` en todas las tablas.
   - **desarrollador**: Acceso `SELECT`, `INSERT`, `UPDATE` en todas las tablas.

3. **Vistas de Seguridad**:
   - `empleados_publico`: Oculta salarios y datos personales.
   - `resumen_departamental`: Proporciona estadísticas agregadas por departamento.
   - `empleados_activos`: Filtra a los empleados activos.

4. **Auditoría**:
   - Implementación de `triggers` para registrar todas las operaciones (`INSERT`, `UPDATE`, `DELETE`) en la tabla de auditoría `audit_log`.

5. **Respaldo y Restauración**:
   - Backup completo y backup incremental utilizando logs binarios.
   - Simulación de pérdida de datos y restauración de la tabla `empleados`.

## Instrucciones de Uso

### Paso 1: Preparación del Ambiente
1. Conectar a MySQL Workbench y crear la base de datos:
   ```sql
   CREATE DATABASE empresa_segura;
   ```

2. Importar estructura base desde `test_db` o crear las tablas necesarias.

3. Verificar la conexión y permisos con:
   ```sql
   SHOW GRANTS FOR CURRENT_USER();
   ```

### Paso 2: Implementación de Usuarios y Permisos
Crear los usuarios y asignar permisos con los siguientes comandos:

```sql
-- Crear usuarios y asignar permisos
CREATE USER 'admin_rrhh'@'localhost' IDENTIFIED BY 'password123';
GRANT ALL PRIVILEGES ON empresa_segura.empleados TO 'admin_rrhh'@'localhost';
-- Repetir para otros usuarios...
```

### Paso 3: Creación de Vistas de Seguridad
Implementar vistas para filtrar datos sensibles:

```sql
-- Vista para mostrar solo información pública
CREATE VIEW empleados_publico AS
SELECT id, nombre, apellido FROM empleados;
```

### Paso 4: Auditoría de Cambios
Crear la tabla de auditoría y los triggers correspondientes para registrar cambios en las tablas.

```sql
-- Crear tabla de auditoría
CREATE TABLE audit_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tabla VARCHAR(255),
    operacion VARCHAR(255),
    usuario VARCHAR(255),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    datos_json JSON
);
```

### Paso 5: Backup y Restauración
Realizar un backup completo de la base de datos y configuraciones para respaldos incrementales.

```bash
mysqldump -u root -p empresa_segura > backup_inicial.sql
```

### Reporte

En el archivo `reporte_seguridad_bd_[nombre_estudiante].txt`, se describen las decisiones de seguridad tomadas y los pasos realizados durante la implementación.

## Archivos

- **seguridad_bd_Nestor.sql**: Script con todas las configuraciones de la base de datos, usuarios, vistas, triggers, y auditoría.

## 👨‍💻 Autor
**Nestor Ivan Granados Valenzuela**  
Estudiante de Ingeniería de Software  
📅 Año: 2025
