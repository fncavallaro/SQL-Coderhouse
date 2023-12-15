-- USUARIO FRANCO --
-- Crear el usuario con permisos de solo lectura
CREATE USER 'Franco@localhost' IDENTIFIED BY 'coderhouse1';

-- Otorgar permisos de solo lectura sobre todas las tablas en la base de datos
GRANT SELECT ON *.* TO 'Franco@localhost';

-- No permitir permisos para eliminar registros de ninguna tabla
REVOKE DELETE ON *.* FROM 'Franco@localhost';

-- Mostrar permisos --
SHOW GRANTS FOR 'Franco@localhost';

-- Eliminar usuario --
DROP USER 'Franco@localhost';

-- USUARIO NICOLAS --
-- Crear el usuario con permisos de inserción, lectura y modificación
CREATE USER 'Nicolas@localhost' IDENTIFIED BY 'coderhouse2';

-- Otorgar permisos de inserción, lectura y modificación sobre todas las tablas en la base de datos
GRANT INSERT, SELECT, UPDATE ON *.* TO 'Nicolas@localhost';

-- No permitir permisos para eliminar registros de ninguna tabla
REVOKE DELETE ON *.* FROM 'Nicolas@localhost';

-- Mostrar permisos --
SHOW GRANTS FOR 'Nicolas@localhost';

-- Eliminar usuario --
DROP USER 'Nicolas@localhost';