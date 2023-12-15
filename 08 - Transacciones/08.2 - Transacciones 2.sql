-- Transacción --
START TRANSACTION;

-- Eliminar registro --
DELETE FROM inventory WHERE inv_id = 10;

-- Volver al inicio --
-- ROLLBACK; --

-- Confirmar la transacción --
-- COMMIT; --