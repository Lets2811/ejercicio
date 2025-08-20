USE ejercicio;
DROP TABLE IF EXISTS employee;
CREATE TABLE employee (
  employee_id   INT PRIMARY KEY,
  last_name     VARCHAR(30)      NOT NULL,
  first_name    VARCHAR(20)      NOT NULL,
  birth_date    DATE,
  hire_date     DATE,
  address       VARCHAR(128),
  city          VARCHAR(30),
  country       VARCHAR(30),
  reports_to    INT NULL,
  CONSTRAINT fk_employee_manager
    FOREIGN KEY (reports_to) REFERENCES employee(employee_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
) ENGINE=InnoDB;


DROP TABLE IF EXISTS employee;
CREATE TABLE employee (
  employee_id   INT PRIMARY KEY,
  last_name     VARCHAR(30)      NOT NULL,
  first_name    VARCHAR(20)      NOT NULL,
  birth_date    DATE,
  hire_date     DATE,
  address       VARCHAR(128),
  city          VARCHAR(30),
  country       VARCHAR(30),
  reports_to    INT NULL,
  CONSTRAINT fk_employee_manager
    FOREIGN KEY (reports_to) REFERENCES employee(employee_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
) ENGINE=InnoDB;


DROP TABLE IF EXISTS customer;
CREATE TABLE customer (
  customer_id   INT PRIMARY KEY,
  contact_name  VARCHAR(30)  NOT NULL,
  company_name  VARCHAR(40),
  contact_email VARCHAR(128),
  address       VARCHAR(120),
  city          VARCHAR(30),
  country       VARCHAR(30)
) ENGINE=InnoDB;



DROP TABLE IF EXISTS category;
CREATE TABLE category (
  category_id         INT PRIMARY KEY,
  name                VARCHAR(60) NOT NULL,
  description         TEXT,
  parent_category_id  INT NULL,
  CONSTRAINT fk_category_parent
    FOREIGN KEY (parent_category_id) REFERENCES category(category_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
) ENGINE=InnoDB;



DROP TABLE IF EXISTS product;
CREATE TABLE product (
  product_id       INT PRIMARY KEY,
  product_name     VARCHAR(40)  NOT NULL,
  category_id      INT          NOT NULL,
  quantity_per_unit VARCHAR(60),
  unit_price       DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0),
  units_in_stock   INT           NOT NULL DEFAULT 0 CHECK (units_in_stock >= 0),
  discontinued     BOOLEAN       NOT NULL DEFAULT FALSE,
  CONSTRAINT fk_product_category
    FOREIGN KEY (category_id) REFERENCES category(category_id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;


DROP TABLE IF EXISTS purchase;
CREATE TABLE purchase (
  purchase_id    INT PRIMARY KEY,
  customer_id    INT NOT NULL,
  employee_id    INT NOT NULL,
  total_price    DECIMAL(10,2) NOT NULL DEFAULT 0.00 CHECK (total_price >= 0),
  purchase_date  TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  shipped_date   TIMESTAMP NULL,
  ship_address   VARCHAR(160),
  ship_city      VARCHAR(60),
  ship_country   VARCHAR(60),
  CONSTRAINT fk_purchase_customer
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT fk_purchase_employee
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;


DROP TABLE IF EXISTS purchase_item;
CREATE TABLE purchase_item (
  purchase_id  INT NOT NULL,
  product_id   INT NOT NULL,
  unit_price   DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0),
  quantity     INT NOT NULL CHECK (quantity > 0),
  PRIMARY KEY (purchase_id, product_id),
  CONSTRAINT fk_item_purchase
    FOREIGN KEY (purchase_id) REFERENCES purchase(purchase_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk_item_product
    FOREIGN KEY (product_id) REFERENCES product(product_id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;


CREATE INDEX idx_customer_city ON customer(city);
CREATE INDEX idx_product_category ON product(category_id);
CREATE INDEX idx_purchase_customer ON purchase(customer_id);
CREATE INDEX idx_purchase_employee ON purchase(employee_id);
CREATE INDEX idx_item_product ON purchase_item(product_id);


INSERT INTO employee (employee_id, last_name, first_name, birth_date, hire_date, address, city, country, reports_to) VALUES
(1,'Smith','John','1990-01-15','2012-05-01','100 Main St','Seattle','USA',NULL),
(2,'Doe','Jane','1985-09-01','2010-03-12','200 Pine St','Austin','USA',1),
(3,'Lee','Kevin','1998-06-30','2019-07-15','300 Oak Ave','Miami','USA',1),
(4,'Brown','Emily','1975-12-05','2005-11-20','400 Elm Rd','Denver','USA',2),
(5,'Garcia','Lucia','2000-03-20','2022-02-01','500 Maple Ln','Phoenix','USA',3);

-- Clientes 
INSERT INTO customer (customer_id, contact_name, company_name, contact_email, address, city, country) VALUES
(1,'Alice Wilson','FreshFoods','alice@fresh.com','123 Apple Rd','Knoxville','USA'),
(2,'Bob Johnson','Verdant','bob@verdant.com','456 Market St','Stockton','USA'),
(3,'Carlos Ruiz','TechMart','carlos@techmart.com','789 1st Ave','Seattle','USA'),
(4,'Diana Prince','Daily Planet','diana@planet.com','111 Hero St','Metropolis','USA'),
(5,'Ethan Hunt','IMF Supplies','ethan@imf.com','222 Spy Blvd','Austin','USA'),
(6,'Fiona Glenanne','Boom Retail','fiona@boom.com','333 Ocean Dr','Miami','USA'),
(7,'George Bluth','Banana Stand','george@banana.com','444 Stand St','Newport Beach','USA'),
(8,'Hannah Baker','Riverdale Shop','hannah@river.com','555 River Rd','Denver','USA'),
(9,'Ian Malcolm','Jurassic Co','ian@jurassic.com','666 Dino Way','San Diego','USA'),
(10,'Julia Meier','EuroShop','julia@euro.com','777 Desert Ave','Phoenix','USA');
-- Categorías 
INSERT INTO category (category_id, name, description, parent_category_id) VALUES
(1, 'Alimentos',           'Comida y abarrotes',         NULL),
(2, 'Bebidas',             'Bebidas y refrescos',        NULL),
(3, 'Lácteos',             'Productos lácteos',          NULL),
(4, 'Hogar',               'Limpieza y hogar',           NULL),
(5, 'Frutas y Verduras',   'Productos frescos',          NULL);

-- Productos
INSERT INTO product (product_id, product_name, category_id, quantity_per_unit, unit_price, units_in_stock, discontinued) VALUES
-- Cat 1: Alimentos
(101,'Arroz integral 1kg',          1,'Bolsa 1kg',        4.20,100,0),
(102,'Pasta fusilli 500g',          1,'Bolsa 500g',       3.60,150,0),
(103,'Harina de maíz 1kg',          1,'Bolsa 1kg',        2.90,200,0),
(104,'Aceite de oliva 500ml',       1,'Botella 500ml',    7.50, 80,0),
(105,'Sal marina 1kg',              1,'Bolsa 1kg',        1.80,300,0),
-- Cat 5: Frutas y Verduras
(201,'Manzana roja kg',             5,'Kg',               4.00,120,0),
(202,'Banano kg',                   5,'Kg',               2.50,150,0),
(203,'Aguacate unidad',             5,'Unidad',           3.80,100,0),
(204,'Zanahoria kg',                5,'Kg',               2.20,140,0),
(205,'Uvas verdes kg',              5,'Kg',               5.90, 60,0),
-- Cat 2: Bebidas 
(301,'Soda cola lata',              2,'Lata 350ml',       1.00,500,1),
(302,'Jugo naranja 1L',             2,'Botella 1L',       2.30,200,1),
(303,'Té verde botella',            2,'Botella 500ml',    1.50,300,1),
(304,'Agua mineral 600ml',          2,'Botella 600ml',    1.10,400,0),
-- Cat 4: Hogar 
(401,'Detergente polvo 1kg',        4,'Bolsa 1kg',        6.50, 70,1),
(402,'Suavizante 1L',               4,'Botella 1L',       5.20, 90,1),
(403,'Esponjas x3',                 4,'Paquete 3',        2.00,120,1),
(404,'Toallas cocina x2',           4,'Paquete 2',        3.80,110,0),
(405,'Bolsas basura x50',           4,'Rollo 50',         4.10, 80,1),
-- Cat 3: Lácteos
(501,'Leche entera 1L',             3,'Caja 1L',          1.20,200,0),
(502,'Yogur natural 1L',            3,'Botella 1L',       2.40,180,0),
(503,'Queso cheddar 200g',          3,'Paquete 200g',     3.90, 90,0);

-- Compras (purchase) - totales se fijan luego
INSERT INTO purchase (purchase_id, customer_id, employee_id, total_price, purchase_date, shipped_date, ship_address, ship_city, ship_country) VALUES
(1001, 3, 1, 0.00, '2025-08-01 10:00:00','2025-08-02 09:00:00','789 1st Ave','Seattle','USA'),
(1002, 1, 2, 0.00, '2025-08-02 11:30:00','2025-08-03 10:30:00','123 Apple Rd','Knoxville','USA'),
(1003, 6, 3, 0.00, '2025-08-03 15:45:00','2025-08-04 12:10:00','333 Ocean Dr','Miami','USA'),
(1004, 8, 4, 0.00, '2025-08-04 09:25:00','2025-08-04 17:00:00','555 River Rd','Denver','USA'),
(1005, 2, 5, 0.00, '2025-08-05 14:05:00','2025-08-06 08:40:00','456 Market St','Stockton','USA'),
(1006, 9, 2, 0.00, '2025-08-06 16:20:00','2025-08-07 10:15:00','666 Dino Way','San Diego','USA'),
(1007, 4, 1, 0.00, '2025-08-07 10:10:00','2025-08-08 09:50:00','111 Hero St','Metropolis','USA'),
(1008,10, 3, 0.00, '2025-08-08 18:30:00', NULL,                 '777 Desert Ave','Phoenix','USA');

-- Detalles por compra (varias categorías por pedido)
INSERT INTO purchase_item (purchase_id, product_id, unit_price, quantity) VALUES
-- 1001 (categorías 1,5,2)
(1001,101, 4.20, 5),
(1001,201, 4.00, 3),
(1001,301, 1.00, 6),
-- 1002 (categorías 1 y 5)
(1002,104, 7.50, 2),
(1002,205, 5.90, 1),
-- 1003 (categoría 4)
(1003,401, 6.50, 2),
(1003,404, 3.80, 5),
-- 1004 (categorías 3,2,5)
(1004,503, 3.90, 4),
(1004,302, 2.30,10),
(1004,202, 2.50, 8),
-- 1005 (categorías 5 y 4)
(1005,203, 3.80, 6),
(1005,402, 5.20, 1),
-- 1006 (categorías 2 y 1)
(1006,304, 1.10,20),
(1006,101, 4.20, 2),
-- 1007 (categorías 5 y 1)
(1007,204, 2.20, 7),
(1007,105, 1.80, 3),
-- 1008 (categorías 4 y 2)
(1008,401, 6.50, 1),
(1008,405, 4.10, 4),
(1008,303, 1.50,12);



-- 1) Productos de categorías 1 (Alimentos) o 5 (Frutas y Verduras)
--    con precio unitario > 3.5
SELECT *
FROM product
WHERE category_id IN (1, 5)
  AND unit_price > 3.5;
  
  -- 2) Nombres de productos con precio unitario >= 3.5
SELECT product_name
FROM product
WHERE unit_price >= 3.5;

-- 3) Nombres de productos junto con sus categorías
--    (dos columnas: product_name, category_name)
SELECT p.product_name AS nombre_producto,
       c.name         AS nombre_categoria
FROM product p
JOIN category c ON c.category_id = p.category_id;

-- 4) Por compra: id de compra, nombre del producto, precio unitario al comprar y cantidad
SELECT i.purchase_id,
       pr.product_name,
       i.unit_price,
       i.quantity
FROM purchase_item i
JOIN product pr ON pr.product_id = i.product_id
ORDER BY i.purchase_id, pr.product_name;

-- 5) Por compra: categorías de productos comprados (una vez por compra)
SELECT
       i.purchase_id,
       c.name AS category_name
FROM purchase_item i
JOIN product  p ON p.product_id = i.product_id
JOIN category c ON c.category_id = p.category_id
ORDER BY i.purchase_id, category_name;

-- 6) Empleados: apellidos, nombres y fecha de nacimiento.
--    Orden por edad ASC (más jóvenes primero).
SELECT last_name,
       first_name,
       birth_date,
       TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) AS age_years
FROM employee
ORDER BY age_years ASC;

-- 7) # de clientes por ciudad, excluyendo Knoxville y Stockton.
--    Dos columnas: city, customers_quantity. Orden por city ASC.
SELECT city,
       COUNT(*) AS customers_quantity
FROM customer
WHERE city IS NOT NULL
  AND city NOT IN ('Knoxville', 'Stockton')
GROUP BY city
ORDER BY city ASC;


-- 8) Por categoría: número de productos descontinuados (>= 3).
--    Dos columnas: name, discontinued_products_number.
--    Orden por cantidad DESC.
SELECT c.name AS name,
       COUNT(*) AS discontinued_products_number
FROM category c
JOIN product  p ON p.category_id = c.category_id
WHERE p.discontinued = TRUE
GROUP BY c.category_id, c.name
HAVING COUNT(*) >= 3
ORDER BY discontinued_products_number DESC;




