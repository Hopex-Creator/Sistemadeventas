
CREATE TABLE categoria (
    id          INTEGER NOT NULL,
    nombre      VARCHAR2(45 CHAR) NOT NULL,
    descripcion VARCHAR2(45 CHAR)
);

ALTER TABLE categoria ADD CONSTRAINT categoria_pk PRIMARY KEY (id);

CREATE TABLE producto (
    id_producto   INTEGER NOT NULL,
    nombre        VARCHAR2(45 CHAR) NOT NULL,
    precio        NUMBER(10, 2) NOT NULL,
    stock         INTEGER NOT NULL,
    categoria_id  INTEGER NOT NULL,
    proveedor_rut INTEGER NOT NULL
);

ALTER TABLE producto ADD CONSTRAINT producto_pk PRIMARY KEY (id_producto);

CREATE TABLE proveedor (
    rut        INTEGER NOT NULL,
    nombre     VARCHAR2(45 CHAR) NOT NULL,
    telefono   VARCHAR2(45 CHAR),
    pagina_web VARCHAR2(45 CHAR)
);

ALTER TABLE proveedor ADD CONSTRAINT proveedor_pk PRIMARY KEY (rut);

CREATE TABLE direccion_proveedor (
    proveedor_rut INTEGER NOT NULL,
    calle         VARCHAR2(45 CHAR) NOT NULL,
    numero        VARCHAR2(45 CHAR),
    ciudad        VARCHAR2(45 CHAR),
    comuna        VARCHAR2(45 CHAR)
);

ALTER TABLE direccion_proveedor ADD CONSTRAINT direccion_proveedor_pk PRIMARY KEY (proveedor_rut);

CREATE TABLE ventas (
    id_ventas   INTEGER NOT NULL,
    fecha       DATE NOT NULL,
    descuento   NUMBER(10, 2),
    cliente_rut INTEGER NOT NULL
);

ALTER TABLE ventas ADD CONSTRAINT ventas_pk PRIMARY KEY ( id_ventas );

CREATE TABLE detalle (
    producto_id     INTEGER NOT NULL,
    ventas_id       INTEGER NOT NULL,
    precio          NUMBER(10, 2) NOT NULL,
    cantidad        INTEGER NOT NULL,
    monto           NUMBER(10, 2) GENERATED ALWAYS AS (cantidad * precio) VIRTUAL,
    CONSTRAINT detalle_pk PRIMARY KEY (producto_id, ventas_id),
    CONSTRAINT detalle_producto_fk FOREIGN KEY (producto_id) REFERENCES producto (id_producto),
    CONSTRAINT detalle_ventas_fk FOREIGN KEY (ventas_id) REFERENCES ventas (id_ventas)
);

CREATE TABLE cliente (
    rut    INTEGER NOT NULL,
    nombre VARCHAR2(45 CHAR) NOT NULL
);

ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( rut );

CREATE TABLE direccion_cliente (
    cliente_rut INTEGER NOT NULL,
    calle       VARCHAR2(45 CHAR) NOT NULL,
    numero      VARCHAR2(45 CHAR),
    ciudad      VARCHAR2(45 CHAR),
    comuna      VARCHAR2(45 CHAR)
);

ALTER TABLE direccion_cliente ADD CONSTRAINT direccion_cliente_pk PRIMARY KEY ( cliente_rut );

CREATE TABLE telefono (
    id          INTEGER NOT NULL,
    numero      VARCHAR2(45) NOT NULL,
    cliente_rut INTEGER NOT NULL
);

ALTER TABLE telefono ADD CONSTRAINT telefono_pk PRIMARY KEY ( id );


ALTER TABLE producto
    ADD CONSTRAINT producto_categoria_fk FOREIGN KEY (categoria_id)
        REFERENCES categoria (id);
ALTER TABLE direccion_proveedor
    ADD CONSTRAINT direccion_prov_prov_fk FOREIGN KEY (proveedor_rut)
        REFERENCES proveedor (rut);
ALTER TABLE producto
    ADD CONSTRAINT producto_proveedor_fk FOREIGN KEY (proveedor_rut)
        REFERENCES proveedor (rut);
ALTER TABLE ventas
    ADD CONSTRAINT ventas_cliente_fk FOREIGN KEY ( cliente_rut )
        REFERENCES cliente ( rut );   
ALTER TABLE direccion_cliente
    ADD CONSTRAINT direccion_clie_clie_fk FOREIGN KEY ( cliente_rut )
        REFERENCES cliente ( rut );        
ALTER TABLE telefono
    ADD CONSTRAINT telefono_cliente_fk FOREIGN KEY ( cliente_rut )
        REFERENCES cliente ( rut );
        

--Insertar datos en tablas:

-- Insertar datos en la tabla "categoria"
INSERT INTO categoria (id, nombre, descripcion)
VALUES (1, 'Electronica', 'Productos electrónicos');
INSERT INTO categoria (id, nombre, descripcion)
VALUES (2, 'Ropa', 'Prendas de vestir');
INSERT INTO categoria (id, nombre, descripcion)
VALUES (3, 'Hogar', 'Artículos para el hogar');
INSERT INTO categoria (id, nombre, descripcion)
VALUES (4, 'Deportes', 'Artículos deportivos');
INSERT INTO categoria (id, nombre)
VALUES (5, 'Juguetes');

-- Insertar datos en la tabla "proveedor"
INSERT INTO proveedor (rut, nombre, telefono, pagina_web)
VALUES (1001, 'ProveedorA', '123456789', 'www.proveedora.com');
INSERT INTO proveedor (rut, nombre, telefono, pagina_web)
VALUES (2002, 'ProveedorB', '987654321', 'www.proveedorb.com');
INSERT INTO proveedor (rut, nombre, telefono, pagina_web)
VALUES (3003, 'ProveedorC', '456789123', 'www.proveedorc.com');
INSERT INTO proveedor (rut, nombre, telefono, pagina_web)
VALUES (4004, 'ProveedorD', '321654987', 'www.proveedord.com');
INSERT INTO proveedor (rut, nombre, telefono, pagina_web)
VALUES (5005, 'Proveedor E', '789123456', 'www.proveedore.com');

-- Insertar datos en la tabla "direccion_proveedor"
INSERT INTO direccion_proveedor (proveedor_rut, calle, numero, ciudad, comuna)
VALUES (1001, 'Av. Industrial', '111', 'Santiago', 'Maipa');
INSERT INTO direccion_proveedor (proveedor_rut, calle, numero, ciudad, comuna)
VALUES (2002, 'Calle Comercial', '222', 'Valparaiso', 'Viña del Mar');
INSERT INTO direccion_proveedor (proveedor_rut, calle, numero, ciudad, comuna)
VALUES (3003, 'Av. del Progreso', '333', 'Concepción', 'Talcahuano');
INSERT INTO direccion_proveedor (proveedor_rut, calle, numero, ciudad, comuna)
VALUES (4004, 'Calle del Sur', '444', 'Antofagasta', 'Calama');
INSERT INTO direccion_proveedor (proveedor_rut, calle, numero, ciudad, comuna)
VALUES (5005, 'Av. del Sol', '555', 'La Serena', 'Coquimbo');

-- Insertar datos en la tabla "Cliente"
INSERT INTO cliente (rut, nombre)
VALUES (1001, 'Juan Pérez');
INSERT INTO cliente (rut, nombre)
VALUES (2002, 'María Gómez');
INSERT INTO cliente (rut, nombre)
VALUES (3003, 'Carlos Rodriguez');
INSERT INTO cliente (rut, nombre)
VALUES (4004, 'Laura Fernandez');
INSERT INTO cliente (rut, nombre)
VALUES (5005, 'Pedro Sanchez');

-- Insertar datos en la tabla "producto"
INSERT INTO producto (id_producto, nombre, precio, stock, categoria_id, proveedor_rut)
VALUES (1, 'Televisor', 499.99, 10, 1, 1001);
INSERT INTO producto (id_producto, nombre, precio, stock, categoria_id, proveedor_rut)
VALUES (2, 'Camiseta', 19.99, 50, 2, 2002);
INSERT INTO producto (id_producto, nombre, precio, stock, categoria_id, proveedor_rut)
VALUES (3, 'Sarten', 29.99, 20, 3, 3003);
INSERT INTO producto (id_producto, nombre, precio, stock, categoria_id, proveedor_rut)
VALUES (4, 'Raqueta de tenis', 89.99, 5, 4, 4004);
INSERT INTO producto (id_producto, nombre, precio, stock, categoria_id, proveedor_rut)
VALUES (5, 'Pelota de futbol', 14.99, 30, 5, 5005);

-- Insertar datos en la tabla "ventas"
INSERT INTO ventas (id_ventas, fecha, descuento, cliente_rut)
VALUES (1, TO_DATE('2023-06-01', 'YYYY-MM-DD'), 10.00, 1001);
INSERT INTO ventas (id_ventas, fecha, descuento, cliente_rut)
VALUES (2, TO_DATE('2023-06-05', 'YYYY-MM-DD'), NULL, 2002);
INSERT INTO ventas (id_ventas, fecha, descuento, cliente_rut)
VALUES (3, TO_DATE('2023-06-10', 'YYYY-MM-DD'), 5.00, 3003);
INSERT INTO ventas (id_ventas, fecha, descuento, cliente_rut)
VALUES (4, TO_DATE('2023-06-15', 'YYYY-MM-DD'), 20.00, 4004);
INSERT INTO ventas (id_ventas, fecha, descuento, cliente_rut)
VALUES (5, TO_DATE('2023-06-20', 'YYYY-MM-DD'), NULL, 5005);

-- Insertar datos en la tabla "Detalle"
INSERT INTO detalle (producto_id, ventas_id, precio, cantidad)
VALUES (1, 1, 99.99, 2);
INSERT INTO detalle (producto_id, ventas_id, precio, cantidad)
VALUES (2, 1, 49.99, 1);
INSERT INTO detalle (producto_id, ventas_id, precio, cantidad)
VALUES (3, 2, 149.99, 3);
INSERT INTO detalle (producto_id, ventas_id, precio, cantidad)
VALUES (4, 2, 199.99, 1);
INSERT INTO detalle (producto_id, ventas_id, precio, cantidad)
VALUES (5, 3, 29.99, 4);

-- Insertar datos en la tabla "direccion_cliente"
INSERT INTO direccion_cliente (cliente_rut, calle, numero, ciudad, comuna)
VALUES (1001, 'Av. Principal', '123', 'Santiago', 'Providencia');
INSERT INTO direccion_cliente (cliente_rut, calle, numero, ciudad, comuna)
VALUES (2002, 'Calle Central', '456', 'Valparaiso', 'Vinia del Mar');
INSERT INTO direccion_cliente (cliente_rut, calle, numero, ciudad, comuna)
VALUES (3003, 'Av. Norte', '789', 'Concepcion', 'Talcahuano');
INSERT INTO direccion_cliente (cliente_rut, calle, numero, ciudad, comuna)
VALUES (4004, 'Calle Sur', '321', 'Antofagasta', 'Calama');
INSERT INTO direccion_cliente (cliente_rut, calle, numero, ciudad, comuna)
VALUES (5005, 'Av. Poniente', '654', 'La Serena', 'Coquimbo');

-- Insertar datos en la tabla "telefono"
INSERT INTO telefono (id, numero, cliente_rut)
VALUES (1, '987654321', 1001);
INSERT INTO telefono (id, numero, cliente_rut)
VALUES (2, '123456789', 2002);
INSERT INTO telefono (id, numero, cliente_rut)
VALUES (3, '321654987', 3003);
INSERT INTO telefono (id, numero, cliente_rut)
VALUES (4, '789123456', 4004);
INSERT INTO telefono (id, numero, cliente_rut)
VALUES (5, '456789123', 5005);

-- UPDATE en la tabla "categoria"
UPDATE categoria
SET nombre = 'Electrónica',
    descripcion = 'Productos electrónicos de última generación'
WHERE id = 1;

UPDATE categoria
SET nombre = 'Ropa y Accesorios'
WHERE id = 2;


-- UPDATE en la tabla "producto"
UPDATE producto
SET precio = 549.99,
    stock = 15
WHERE id_producto = 1;

UPDATE producto
SET proveedor_rut = 3003
WHERE id_producto = 2;


-- UPDATE en la tabla "proveedor"
UPDATE proveedor
SET telefono = '9876543210'
WHERE rut = 1001;

UPDATE proveedor
SET pagina_web = 'www.nuevapaginaweb.com'
WHERE rut = 3003;


-- UPDATE en la tabla "direccion_proveedor"
UPDATE direccion_proveedor
SET calle = 'Calle Nueva',
    ciudad = 'Santiago'
WHERE proveedor_rut = 1001;

UPDATE direccion_proveedor
SET numero = '333'
WHERE proveedor_rut = 2002;


-- UPDATE en la tabla "ventas"
UPDATE ventas
SET fecha = TO_DATE('2023-06-02', 'YYYY-MM-DD')
WHERE id_ventas = 1;

UPDATE ventas
SET descuento = 8.00
WHERE id_ventas = 3;


-- UPDATE en la tabla "cliente"
UPDATE cliente
SET nombre = 'Juan Pérez'
WHERE rut = 1001;

UPDATE cliente
SET nombre = 'María Gómez'
WHERE rut = 2002;


-- UPDATE en la tabla "direccion_cliente"
UPDATE direccion_cliente
SET calle = 'Av. Central',
    numero = '456'
WHERE cliente_rut = 1001;

UPDATE direccion_cliente
SET ciudad = 'Valparaíso'
WHERE cliente_rut = 2002;


-- UPDATE en la tabla "telefono"
UPDATE telefono
SET numero = '9876543210'
WHERE id = 1;

UPDATE telefono
SET numero = '1234567890'
WHERE id = 2;

SELECT * FROM categoria;
SELECT * FROM producto;
SELECT * FROM proveedor;
SELECT * FROM direccion_proveedor;
SELECT * FROM ventas;                                     
SELECT * FROM detalle; 
SELECT * FROM cliente; 
SELECT * FROM direccion_cliente;
SELECT * FROM telefono; 

/*
-- Desactivar las restricciones de clave foranea
ALTER TABLE producto
    DROP CONSTRAINT producto_categoria_fk;
ALTER TABLE direccion_proveedor
    DROP CONSTRAINT direccion_prov_prov_fk;
ALTER TABLE producto
    DROP CONSTRAINT producto_proveedor_fk;   
ALTER TABLE detalle
    DROP CONSTRAINT detalle_producto_fk;
ALTER TABLE detalle
    DROP CONSTRAINT detalle_ventas_fk;    
ALTER TABLE ventas
    DROP CONSTRAINT ventas_cliente_fk;
 ALTER TABLE direccion_cliente
    DROP CONSTRAINT direccion_clie_clie_fk;   
ALTER TABLE telefono
    DROP CONSTRAINT telefono_cliente_fk;

-- Eliminar las tablas

DROP TABLE categoria;
DROP TABLE producto;
DROP TABLE proveedor;
DROP TABLE direccion_proveedor;  
DROP TABLE ventas;
DROP TABLE detalle;
DROP TABLE cliente;
DROP TABLE direccion_cliente;  
DROP TABLE telefono;
*/
