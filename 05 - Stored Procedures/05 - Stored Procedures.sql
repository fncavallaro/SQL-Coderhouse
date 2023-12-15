-- Stored Procedures --

-- Stored Procedure que me permite actualizar las cantidades de un determinado item --
DELIMITER //
CREATE PROCEDURE Actualizarcantidad(
    IN item_id VARCHAR(10),
    IN new_quantity INT
)
BEGIN
    UPDATE Inventory
    SET quantity = new_quantity
    WHERE item_id = item_id;
END;
//
DELIMITER ;

CALL Actualizarcantidad('ING001',70);

-- Stored Procedure que me permite consultar aquellos productos cuya cantidad es menor a la indicada --
DELIMITER //
CREATE PROCEDURE Menoscantidad(
    IN min_quantity INT
)
BEGIN
    SELECT inv_id, item_id, quantity
    FROM Inventory
    WHERE quantity < min_quantity;
END;
//
DELIMITER ;

CALL Menoscantidad(80);

-- Stored Procedure que me permite ordenar los datos de la tabla customers en orden ASC/DESC --
DELIMITER //
CREATE PROCEDURE OrdenarTabla (
  IN CampoOrdenamiento VARCHAR(128), -- Campo por el que se va a ordenar
  IN Orden VARCHAR(4) -- Orden ASC o DESC
)
BEGIN
  SET @SQL = CONCAT('SELECT * FROM customers ORDER BY ', CampoOrdenamiento, ' ', Orden, ';');
  PREPARE stmt FROM @SQL;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
END;
//
DELIMITER ;

CALL OrdenarTabla('cust_firstname','ASC')

-- Stored Procedure que me permite eliminar un cliente de la tabla customers --
DELIMITER //
CREATE PROCEDURE EliminarCliente (
  IN ClienteID INT
)
BEGIN
  DELETE FROM customers WHERE cust_id = ClienteID;
END;
//
DELIMITER ;

CALL EliminarCliente(1); -- Eliminar el cliente con ID 1 (ajusta el ID según tus necesidades)