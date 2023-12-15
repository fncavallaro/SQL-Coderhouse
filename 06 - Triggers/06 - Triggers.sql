-- TRIGGERS CUSTOMERS --
-- Trigger para auditar actualización de clientes. Guarda el viejo nombre de cliente, cuando este es modificado --
DELIMITER //
CREATE TRIGGER trigger_auditoria_actualizacion
AFTER UPDATE ON customers
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_clientes (cust_id, cust_firstname, cust_lastname, fecha_actualizacion, hora_actualizacion, usuario_modificacion)
    VALUES (OLD.cust_id, OLD.cust_firstname, OLD.cust_lastname, CURRENT_DATE(), CURRENT_TIME(), CURRENT_USER());
END;
//
DELIMITER ;

DROP TRIGGER trigger_auditoria_actualizacion;

-- Trigger para que cada vez que se actualice un registro, lo haga en mayúsculas --
DELIMITER //
CREATE TRIGGER trigger_mayusculas
BEFORE UPDATE ON customers
FOR EACH ROW
BEGIN
    SET NEW.cust_firstname = UPPER(NEW.cust_firstname);
    SET NEW.cust_lastname = UPPER(NEW.cust_lastname);
END;
//
DELIMITER //

-- TRIGGERS INVENTORY --
-- Trigger para registro de cantidades de inventario. Permite registrar los cambios en el inventario y la fecha en que se produjeron --
DELIMITER //
CREATE TRIGGER trigger_registro_transacciones_inventario
AFTER UPDATE ON inventory
FOR EACH ROW
BEGIN
    INSERT INTO registro_transacciones_inventario (item_id, cantidad_anterior, cantidad_nueva, fecha_actualizacion, hora_actualizacion, usuario_modificacion)
    VALUES (OLD.item_id, OLD.quantity, NEW.quantity, CURRENT_DATE(), CURRENT_TIME(), CURRENT_USER());
END;
//
DELIMITER ;

-- TRIGGERS ITEM --
-- Trigger para registrar los cambios de precio y saber si aumentó o disminuyó --
DELIMITER //
CREATE TRIGGER trigger_registro_precio_productos
BEFORE UPDATE ON item
FOR EACH ROW
BEGIN
    -- Calcula si el precio subió o bajó
    IF NEW.item_price > OLD.item_price THEN
        SET @cambio_precio = 'Subió';
    ELSE
        SET @cambio_precio = 'Bajó';
    END IF;

    -- Inserta la fila en la tabla de registro
    INSERT INTO registro_precio_productos (item_id, precio_anterior, precio_nuevo, fecha_modificacion, hora_modificacion, usuario_modificacion, cambio_precio)
    VALUES (NEW.item_id, OLD.item_price, NEW.item_price, CURRENT_DATE(), CURRENT_TIME(), CURRENT_USER(), @cambio_precio);
END;
//
DELIMITER ;


-- Prueba de Trigger de auditoría de clientes --
UPDATE customers
SET cust_firstname = 'Roger',
    cust_lastname = 'Federer'
WHERE cust_id = 1;

UPDATE customers
SET cust_firstname = 'Lionel',
    cust_lastname = 'Messi'
WHERE cust_id = 2;

UPDATE customers
SET cust_firstname = 'Rafael',
    cust_lastname = 'Nadal'
WHERE cust_id = 3;

-- Prueba de Trigger para registro de cantidades de inventario --
UPDATE inventory
SET quantity = 30
WHERE item_id = 'ING001';

UPDATE inventory
SET quantity = 50
WHERE item_id = 'ING002';

-- Prueba de Trigger para registro de precios --
UPDATE item
SET item_price = 30
WHERE item_id = 'it_001';