-- Funciones --

-- Función para saber el promedio de la cantidad de inventario. Nos permitirá conocer el promedio de existencias de nuestro inventario --
DELIMITER //
CREATE FUNCTION Promediocantidad()
RETURNS DECIMAL(10, 2)
READS SQL DATA
BEGIN
    DECLARE avg_quantity DECIMAL(10, 2);
    SELECT AVG(quantity)
    INTO avg_quantity
    FROM Inventory;
    RETURN avg_quantity;
END;
//
DELIMITER ;

SELECT Promediocantidad();

DELIMITER //

-- Crear una función para calcular el total del valor de las órdenes. En este caso, dado el número de pedidos que hemos tenido, vamos a hacer una función que permita saber cuanto es el valor total de los pedidos recibidos--
CREATE FUNCTION calcularTotalOrdenes()
RETURNS DECIMAL(10, 2)
READS SQL DATA
BEGIN
    DECLARE total DECIMAL(10, 2);
    
    -- Inicializar el total en 0
    SET total = 0;
    
    -- Calcular el total sumando el producto de cantidad y precio de cada ítem en la tabla de órdenes
    SELECT SUM(orders.quantity * item.item_price)
    INTO total
    FROM orders
    JOIN item ON orders.item_id = item.item_id;
    
    RETURN total;
END;

//
DELIMITER ;

-- Llamar a la función para obtener el total del valor de las órdenes
SELECT calcularTotalOrdenes() AS total_valor_ordenes;

-- Consultar Funciones --
SELECT Promediocantidad();
SELECT calcularTotalOrdenes() AS total_valor_ordenes;