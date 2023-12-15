-- VISTA PARA CONOCER EL LISTADO DE CLIENTES POR ORDEN ALFABETICO DEL APELLIDO --
CREATE OR REPLACE VIEW Clientes AS
SELECT cust_lastname AS apellido, cust_firstname AS nombre
FROM customers
ORDER BY apellido, nombre;

SELECT * FROM Clientes;

-- VISTA SOBRE PEDIDOS --
CREATE OR REPLACE VIEW Pedidos AS
SELECT
	o.order_id,
	i.item_price,
	o.quantity,
	i.item_cat,
	i.item_name,
	o.created_at,
	a.delivery_address1,
	a.delivery_address2,
	a.delivery_city,
	a.delivery_zipcode,
	o.delivery 
FROM
	orders o
	LEFT JOIN item i ON o.item_id = i.item_id
	LEFT JOIN address a ON o.add_id = a.add_id;
    
SELECT * FROM Pedidos;
       
-- VISTA DE COSTO DEL STAFF --
CREATE OR REPLACE VIEW Vista_Staff AS
SELECT
	r.date,
	s.first_name,
	s.last_name,
	s.hourly_rate,
	sh.start_time,
	sh.end_time,
	((
			HOUR (
			timediff( sh.end_time, sh.start_time ))* 60 
			)+(
			MINUTE (
			timediff( sh.end_time, sh.start_time ))))/ 60 AS hours_in_shift,
	((
			HOUR (
			timediff( sh.end_time, sh.start_time ))* 60 
			)+(
			MINUTE (
			timediff( sh.end_time, sh.start_time ))))/ 60 * s.hourly_rate AS staff_cost 
FROM
	rota r
	LEFT JOIN staff s ON r.staff_id = s.staff_id
	LEFT JOIN shift sh ON r.shift_id = sh.shift_id;
    
SELECT * FROM Vista_Staff;
    
-- STOCK DE INGREDIENTES --
CREATE OR REPLACE VIEW Vista_Stock AS
SELECT i.ing_name, inv.quantity
FROM ingredient i
JOIN inventory inv ON i.ing_id = inv.item_id;

SELECT * FROM Vista_Stock;

-- CANTIDAD DE DELIVERY --
CREATE OR REPLACE VIEW Delivery AS
SELECT COUNT(*) AS delivery_count
FROM orders
WHERE delivery = 1;

SELECT * FROM Delivery;

-- Consultar Vistas --
SELECT * FROM clientes;
SELECT * FROM delivery;
SELECT * FROM pedidos;
SELECT * FROM vista_staff;
SELECT * FROM vista_stock;