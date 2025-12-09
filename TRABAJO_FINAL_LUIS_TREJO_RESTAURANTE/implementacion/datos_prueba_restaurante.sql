SET TIMEZONE TO 'UTC';

INSERT INTO Categorias (nombre, descripcion) VALUES
('Entradas', 'Aperitivos y platos ligeros.'),
('Platos Fuertes', 'Carnes, aves, pescados y platos principales.'),
('Bebidas', 'Refrescos, jugos, café y cervezas.'),
('Postres', 'Opciones dulces para finalizar.');

INSERT INTO Meseros (nombre, apellido, telefono) VALUES
('Ana', 'Gómez', '555112233'),
('Javier', 'Rojas', '555998877');

INSERT INTO Mesas (numero, capacidad, estado) VALUES
('1', 4, 'Ocupada'),
('10A', 2, 'Disponible'),
('5', 6, 'Ocupada');

INSERT INTO Ingredientes (nombre, unidad_medida, stock_actual, costo_unidad) VALUES
('Carne Molida', 'kg', 50.00, 8.50),
('Queso Cheddar', 'kg', 20.00, 12.00),
('Pan Brioche', 'unidad', 100.00, 0.50),
('Lechuga', 'unidad', 30.00, 0.25),
('Tomate', 'unidad', 40.00, 0.30),
('Coca Cola', 'litro', 20.00, 1.50);

INSERT INTO Productos (nombre, precio, id_categoria) VALUES
('Hamburguesa Clásica', 12.50, 2),
('Ensalada César', 8.00, 1),
('Refresco Cola', 3.00, 3),
('Tiramisú', 6.50, 4);

-- Recetas
INSERT INTO Recetas (id_producto, id_ingrediente, cantidad_necesaria) VALUES
(1, 1, 0.20),
(1, 2, 0.05),
(1, 3, 1.00),
(1, 4, 0.50),
(1, 5, 0.30);

INSERT INTO Recetas (id_producto, id_ingrediente, cantidad_necesaria) VALUES
(3, 6, 0.35);

-- Comandas
INSERT INTO Comandas (id_mesa, id_mesero, fecha_hora_apertura, estado) VALUES
(1, 1, NOW() - INTERVAL '3 hours', 'Pagada');

INSERT INTO Comandas (id_mesa, id_mesero, fecha_hora_apertura, estado) VALUES
(3, 2, NOW() - INTERVAL '1 hour', 'Cerrada');

INSERT INTO Comandas (id_mesa, id_mesero, fecha_hora_apertura, estado) VALUES
(1, 1, NOW(), 'Abierta');

-- Detalle_Comanda
INSERT INTO Detalle_Comanda (id_comanda, id_producto, cantidad, precio_unidad, notas) VALUES
(1, 1, 2, 12.50, 'Sin tomate'),
(1, 3, 2, 3.00, NULL);

INSERT INTO Detalle_Comanda (id_comanda, id_producto, cantidad, precio_unidad) VALUES
(2, 2, 1, 8.00);

INSERT INTO Detalle_Comanda (id_comanda, id_producto, cantidad, precio_unidad) VALUES
(3, 1, 1, 12.50),
(3, 4, 1, 6.50);

-- Pagos
INSERT INTO Pagos (id_comanda, metodo_pago, monto_total, propina) VALUES
(1, 'Tarjeta', 31.00, 3.00);