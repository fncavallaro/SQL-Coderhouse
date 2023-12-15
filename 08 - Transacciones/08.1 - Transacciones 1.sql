-- Transacción --
START TRANSACTION;

-- Insertar 8 registros --
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_id, delivery, add_id) VALUES (101, 200, '10/08/2022 22:29', 'it_001', 1, 50, 1, 50);
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_id, delivery, add_id) VALUES (102, 200, '10/08/2022 22:29', 'it_003', 2, 50, 1, 50);
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_id, delivery, add_id) VALUES (103, 201, '10/08/2022 22:29', 'it_005', 1, 51, 1, 51);
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_id, delivery, add_id) VALUES (104, 201, '10/08/2022 22:29', 'it_007', 2, 51, 1, 51);
SAVEPOINT savepoint_after_4;
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_id, delivery, add_id) VALUES (105, 202, '10/08/2022 22:29', 'it_009', 1, 52, 1, 52);
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_id, delivery, add_id) VALUES (106, 202, '10/08/2022 22:29', 'it_011', 3, 52, 1, 52);
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_id, delivery, add_id) VALUES (107, 203, '10/08/2022 22:29', 'it_013', 2, 53, 1, 53);
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_id, delivery, add_id) VALUES (108, 203, '10/08/2022 22:29', 'it_015', 1, 53, 1, 53);
SAVEPOINT savepoint_after_8;

-- Rollback a puntos de guardado --
-- ROLLBACK TO savepoint_after_4;
-- ROLLBACK TO savepoint_after_8;

-- Eliminación de savepoint --
-- RELEASE SAVEPOINT savepoint_after_4; --
-- RELEASE SAVEPOINT savepoint_after_8; --

-- Volver al inicio --
-- ROLLBACK; --

-- Confirmar la transacción --
COMMIT;