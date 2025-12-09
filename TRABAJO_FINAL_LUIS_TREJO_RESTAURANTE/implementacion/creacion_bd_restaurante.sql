CREATE TABLE Categorias (
    id_categoria SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL,
    descripcion VARCHAR(255),
    CHECK (LENGTH(nombre) > 3),
    CHECK (nombre = INITCAP(nombre)),
    CHECK (descripcion IS NOT NULL)
);

CREATE TABLE Meseros (
    id_mesero SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(15) UNIQUE,
    CHECK (LENGTH(apellido) > 2),
    CHECK (nombre = INITCAP(nombre)),
    CHECK (telefono ~ '^[0-9]{8,15}$')
);

CREATE TABLE Mesas (
    id_mesa SERIAL PRIMARY KEY,
    numero VARCHAR(10) UNIQUE NOT NULL,
    capacidad INT NOT NULL,
    estado VARCHAR(50) DEFAULT 'Disponible',
    CHECK (capacidad >= 1 AND capacidad <= 12),
    CHECK (estado IN ('Disponible', 'Ocupada', 'Reservada', 'Limpieza')),
    CHECK (numero ~ '^[0-9]+[A-Z]*$') 
);

-- 2. Tablas de Inventario y Recetas

CREATE TABLE Ingredientes (
    id_ingrediente SERIAL PRIMARY KEY,
    nombre VARCHAR(100) UNIQUE NOT NULL,
    unidad_medida VARCHAR(20) NOT NULL, -- ej. kg, litro, unidad
    stock_actual NUMERIC(10, 2) DEFAULT 0,
    costo_unidad NUMERIC(10, 2) NOT NULL,
    CHECK (stock_actual >= 0),
    CHECK (costo_unidad > 0),
    CHECK (unidad_medida IN ('gr', 'kg', 'ml', 'litro', 'unidad'))
);

CREATE TABLE Productos (
    id_producto SERIAL PRIMARY KEY,
    nombre VARCHAR(100) UNIQUE NOT NULL,
    precio NUMERIC(10, 2) NOT NULL,
    id_categoria INT REFERENCES Categorias(id_categoria) ON DELETE RESTRICT ON UPDATE CASCADE,
    CHECK (precio > 0.50),
    CHECK (nombre IS NOT NULL),
    CHECK (precio <= 1000) 
);

CREATE TABLE Recetas (
    id_producto INT REFERENCES Productos(id_producto) ON DELETE CASCADE ON UPDATE CASCADE,
    id_ingrediente INT REFERENCES Ingredientes(id_ingrediente) ON DELETE RESTRICT ON UPDATE CASCADE,
    cantidad_necesaria NUMERIC(10, 2) NOT NULL,
    PRIMARY KEY (id_producto, id_ingrediente),
    CHECK (cantidad_necesaria > 0),
    CHECK (cantidad_necesaria IS NOT NULL)
);

CREATE TABLE Comandas (
    id_comanda SERIAL PRIMARY KEY,
    id_mesa INT REFERENCES Mesas(id_mesa) ON DELETE RESTRICT ON UPDATE CASCADE,
    id_mesero INT REFERENCES Meseros(id_mesero) ON DELETE RESTRICT ON UPDATE CASCADE,
    fecha_hora_apertura TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    estado VARCHAR(50) DEFAULT 'Abierta',
    CHECK (estado IN ('Abierta', 'En Preparacion', 'Lista', 'Cerrada', 'Pagada', 'Cancelada')),
    CHECK (fecha_hora_apertura <= NOW() + INTERVAL '1 minute'),
    CHECK (id_mesa IS NOT NULL)
);

CREATE TABLE Detalle_Comanda (
    id_comanda INT REFERENCES Comandas(id_comanda) ON DELETE CASCADE ON UPDATE CASCADE,
    id_producto INT REFERENCES Productos(id_producto) ON DELETE RESTRICT ON UPDATE CASCADE,
    cantidad INT NOT NULL,
    precio_unidad NUMERIC(10, 2) NOT NULL, 
    notas TEXT,
    PRIMARY KEY (id_comanda, id_producto),
    CHECK (cantidad >= 1),
    CHECK (precio_unidad > 0),
    CHECK (cantidad < 100)
);

CREATE TABLE Pagos (
    id_pago SERIAL PRIMARY KEY,
    id_comanda INT UNIQUE REFERENCES Comandas(id_comanda) ON DELETE RESTRICT ON UPDATE CASCADE,
    metodo_pago VARCHAR(50) NOT NULL,
    monto_total NUMERIC(10, 2) NOT NULL,
    propina NUMERIC(10, 2) DEFAULT 0,
    fecha_pago TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    CHECK (metodo_pago IN ('Efectivo', 'Tarjeta', 'Transferencia', 'QR')),
    CHECK (monto_total > 0),
    CHECK (propina >= 0)
);