CREATE DATABASE pizzeria1;
USE pizzeria1;

-- Creación de Tablas --
CREATE TABLE `orders` (
    `row_id` int  NOT NULL ,
    `order_id` varchar(10)  NOT NULL ,
    `created_at` datetime  NOT NULL ,
    `item_id` varchar(10)  NOT NULL ,
    `quantity` int  NOT NULL ,
    `cust_id` int  NOT NULL ,
    `delivery` boolean  NOT NULL ,
    `add_id` int  NOT NULL ,
    PRIMARY KEY (
        `row_id`
    )
);

CREATE TABLE `customers` (
    `cust_id` int  NOT NULL ,
    `cust_firstname` varchar(50)  NOT NULL ,
    `cust_lastname` varchar(50)  NOT NULL ,
    PRIMARY KEY (
        `cust_id`
    )
);

CREATE TABLE `address` (
    `add_id` int  NOT NULL ,
    `delivery_address1` varchar(200)  NOT NULL ,
    `delivery_address2` varchar(200)  NULL ,
    `delivery_city` varchar(50)  NOT NULL ,
    `delivery_zipcode` varchar(20)  NOT NULL ,
    PRIMARY KEY (
        `add_id`
    )
);

CREATE TABLE `item` (
    `item_id` varchar(10)  NOT NULL ,
    `sku` varchar(20)  NOT NULL ,
    `item_name` varchar(100)  NOT NULL ,
    `item_cat` varchar(100)  NOT NULL ,
    `item_size` varchar(10)  NOT NULL ,
    `item_price` decimal(10,2)  NOT NULL ,
    PRIMARY KEY (
        `item_id`
    )
);

CREATE TABLE `ingredient` (
    `ing_id` varchar(10)  NOT NULL ,
    `ing_name` varchar(200)  NOT NULL ,
    `ing_weight` int  NOT NULL ,
    `ing_meas` varchar(20)  NOT NULL ,
    `ing_price` decimal(5,2)  NOT NULL ,
    PRIMARY KEY (
        `ing_id`
    )
);

CREATE TABLE `recipe` (
    `row_id` int  NOT NULL ,
    `recipe_id` varchar(20)  NOT NULL ,
    `ing_id` varchar(10)  NOT NULL ,
    `quantity` int  NOT NULL ,
    PRIMARY KEY (
        `row_id`
    )
);

CREATE TABLE `inventory` (
    `inv_id` int  NOT NULL ,
    `item_id` varchar(10)  NOT NULL ,
    `quantity` int  NOT NULL ,
    PRIMARY KEY (
        `inv_id`
    )
);

CREATE TABLE `staff` (
    `staff_id` varchar(20)  NOT NULL ,
    `first_name` varchar(50)  NOT NULL ,
    `last_name` varchar(50)  NOT NULL ,
    `position` varchar(100)  NOT NULL ,
    `hourly_rate` decimal(5,2)  NOT NULL ,
    PRIMARY KEY (
        `staff_id`
    )
);

CREATE TABLE `shift` (
    `shift_id` varchar(20)  NOT NULL ,
    `day_of_week` varchar(10)  NOT NULL ,
    `start_time` time  NOT NULL ,
    `end_time` time  NOT NULL ,
    PRIMARY KEY (
        `shift_id`
    )
);

CREATE TABLE `rota` (
    `row_id` int  NOT NULL ,
    `rota_id` varchar(20)  NOT NULL ,
    `date` datetime  NOT NULL ,
    `shift_id` varchar(20)  NOT NULL ,
    `staff_id` varchar(20)  NOT NULL ,
    PRIMARY KEY (
        `row_id`
    )
);

ALTER TABLE `orders`
ADD CONSTRAINT fk_orders_item
FOREIGN KEY (`item_id`)
REFERENCES `item` (`item_id`);

ALTER TABLE `orders`
ADD CONSTRAINT fk_orders_customer
FOREIGN KEY (`cust_id`)
REFERENCES `customers` (`cust_id`);

CREATE INDEX idx_rota_date ON rota(date);

ALTER TABLE `orders`
ADD CONSTRAINT fk_orders_date
FOREIGN KEY (`created_at`)
REFERENCES `rota` (`date`);

ALTER TABLE `orders`
ADD CONSTRAINT fk_orders_add
FOREIGN KEY (`add_id`)
REFERENCES `address` (`add_id`);

CREATE INDEX idx_item_sku ON item(sku);

ALTER TABLE `recipe`
ADD CONSTRAINT fk__recipe_sku
FOREIGN KEY (`recipe_id`)
REFERENCES `item` (`sku`);

ALTER TABLE `recipe`
ADD CONSTRAINT fk_recipe_ing
FOREIGN KEY (`ing_id`)
REFERENCES `ingredient` (`ing_id`);

CREATE INDEX idx_inventory_item_id ON inventory(item_id);

ALTER TABLE `recipe`
ADD CONSTRAINT fk_recipe_ing2
FOREIGN KEY (`ing_id`)
REFERENCES `inventory` (`item_id`);

ALTER TABLE `rota`
ADD CONSTRAINT fk_rota_shift
FOREIGN KEY (`shift_id`)
REFERENCES `shift` (`shift_id`);

ALTER TABLE `rota`
ADD CONSTRAINT fk_rota_staff
FOREIGN KEY (`staff_id`)
REFERENCES `staff` (`staff_id`);


-- Creación de tablas Triggers --
CREATE TABLE auditoria_clientes (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    cust_id INT,
    cust_firstname VARCHAR(255),
    cust_lastname VARCHAR(255),
    fecha_actualizacion DATE,
    hora_actualizacion DATETIME,
    usuario_modificacion VARCHAR(255));
    
CREATE TABLE registro_transacciones_inventario (
    id_transaccion INT AUTO_INCREMENT PRIMARY KEY,
    item_id VARCHAR(255),
    cantidad_anterior INT,
    cantidad_nueva INT,
    fecha_actualizacion DATE,
    hora_actualizacion DATETIME,
    usuario_modificacion VARCHAR(255)
);

CREATE TABLE registro_precio_productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    item_id VARCHAR(255),
    precio_anterior DECIMAL(10, 2),
    precio_nuevo DECIMAL(10, 2),
    fecha_modificacion DATE,
    hora_modificacion TIME,
    usuario_modificacion VARCHAR(255),
    cambio_precio VARCHAR(10)
);
